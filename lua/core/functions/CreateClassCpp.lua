local assets = {}

function assets.claseOrtodoxaC(name)

	local uname = name:upper()
	local lineas ={
		"#ifndef " .. uname .. "_HPP",
		"# define " .. uname ..  "_HPP",
		"",
		"class " .. name,
		"{",
		"	private:",
		"	",
		"	protected: ",
		"	",
		"	public:",
		"		" .. name .. "();",
		"		" .. name .. "(const ".. name .."& other);",
		"		" .. name .. "& operator=(const " .. name .. "& other);",
		"		~" .. name .. "();",
		"",
		"};",
		"",
		"#endif",
	}
	vim.api.nvim_buf_set_lines(0, -1, -1, false, lineas)
end

vim.api.nvim_create_user_command("ClassC", function(opts)
	assets.claseOrtodoxaC(opts.args)
end, {nargs = 1})

function assets.getterSetters()
	local buffer = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local type = {}
	local menbers = {}
	local en_seccion = false

	for _, linea in ipairs(buffer) do
		if linea:match("private:") or linea:match("protected:") then
			en_seccion = true
		elseif linea:match("public:") or linea:match("^}") then
			en_seccion = false
		end

		if en_seccion then
			local tipo, nombre = linea:match("^%s+([%w%s:]+)%s+_([%w]+)%s*;")
			if tipo and nombre then
				table.insert(type, tipo:match("^%s*(.-)%s*$"))
				table.insert(menbers, nombre)
			end
		end
	end

	local lineas = {}
	local getters = {}
	local setters = {}

	for i, nombre in ipairs(menbers) do
		local tipo = type[i]
		local NOMBRE = nombre:sub(1,1):upper() .. nombre:sub(2)
		table.insert(setters, "		void set" .. NOMBRE .. "(" .. tipo .. " " .. nombre .. ");")
		table.insert(getters, "		" .. tipo .. " get" .. NOMBRE .. "() const;")
	end

	for _, l in ipairs(setters) do table.insert(lineas, l) end
	table.insert(lineas, "")
	for _, l in ipairs(getters) do table.insert(lineas, l) end

	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, row, row, false, lineas)
end

vim.api.nvim_create_user_command("GetSet", function()
	assets.getterSetters()
end, {nargs = 0})

function assets.hppToCpp(ruta)
	-- Leer el archivo .hpp desde disco
	local file = io.open(ruta, "r")
	if not file then
		vim.notify("No se pudo abrir: " .. ruta, vim.log.levels.ERROR)
		return
	end
	local buffer = {}
	for linea in file:lines() do table.insert(buffer, linea) end
	file:close()

	-- Extraer nombre de clase
	local classname = nil
	for _, linea in ipairs(buffer) do
		local name = linea:match("^class%s+([%w_]+)")
		if name then classname = name; break end
	end
	if not classname then
		vim.notify("No se encontró ninguna clase en el archivo", vim.log.levels.ERROR)
		return
	end

	-- Extraer atributos de private/protected para inicializadores
	local attr_nombres = {}
	local en_seccion = false
	for _, linea in ipairs(buffer) do
		if linea:match("private:") or linea:match("protected:") then
			en_seccion = true
		elseif linea:match("public:") or linea:match("^};") then
			en_seccion = false
		end
		if en_seccion then
			local _, nombre = linea:match("^%s+([%w%s:*&]+)%s+_([%w_]+)%s*;")
			if nombre then table.insert(attr_nombres, nombre) end
		end
	end

	-- Extraer declaraciones de public
	local declaraciones = {}
	local en_public = false
	for _, linea in ipairs(buffer) do
		if linea:match("public:") then
			en_public = true
		elseif linea:match("private:") or linea:match("protected:") or linea:match("^};") then
			en_public = false
		end
		if en_public then
			local decl = linea:match("^%s+(.+);%s*$")
			if decl and decl:match("%(") then
				table.insert(declaraciones, decl)
			end
		end
	end

	-- Generar implementaciones
	local lineas = {}
	table.insert(lineas, '#include "' .. classname .. '.hpp"')
	table.insert(lineas, "")

	for _, decl in ipairs(declaraciones) do
		local impl = {}

		-- Destructor
		if decl:match("^~" .. classname) then
			table.insert(impl, classname .. "::~" .. classname .. "()")
			table.insert(impl, "{")
			table.insert(impl, "}")

		-- Constructor copia
		elseif decl:match("^" .. classname .. "%(const " .. classname) then
			table.insert(impl, classname .. "::" .. classname .. "(const " .. classname .. "& other)")
			table.insert(impl, "{")
			table.insert(impl, "\t*this = other;")
			table.insert(impl, "}")

		-- Constructor por defecto
		elseif decl:match("^" .. classname .. "%(%s*%)") then
			local inits = {}
			for _, nombre in ipairs(attr_nombres) do
				table.insert(inits, "_" .. nombre .. "()")
			end
			local header = classname .. "::" .. classname .. "()"
			if #inits > 0 then
				header = header .. " : " .. table.concat(inits, ", ")
			end
			table.insert(impl, header)
			table.insert(impl, "{")
			table.insert(impl, "}")

		-- operator=
		elseif decl:match("operator=") then
			table.insert(impl, classname .. "& " .. classname .. "::operator=(const " .. classname .. "& other)")
			table.insert(impl, "{")
			table.insert(impl, "\tif (this != &other)")
			table.insert(impl, "\t{")
			table.insert(impl, "\t}")
			table.insert(impl, "\treturn *this;")
			table.insert(impl, "}")

		-- Setter
		elseif decl:match("^void%s+set") then
			local fname = decl:match("(set[%w_]+)%(")
			local params = decl:match("%((.-)%)")
			local param_name = params and params:match("%s([%w_]+)$")
			table.insert(impl, "void " .. classname .. "::" .. fname .. "(" .. (params or "") .. ")")
			table.insert(impl, "{")
			if param_name then
				table.insert(impl, "\t_" .. param_name .. " = " .. param_name .. ";")
			end
			table.insert(impl, "}")

		-- Getter
		elseif decl:match("get[%w_]+%(%)%s*const") then
			local tipo = decl:match("^([%w%s:*&_]+)%s+get"):match("^%s*(.-)%s*$")
			local fname = decl:match("(get[%w_]+)%(")
			local attr = fname:sub(4,4):lower() .. fname:sub(5)
			table.insert(impl, tipo .. " " .. classname .. "::" .. fname .. "() const")
			table.insert(impl, "{")
			table.insert(impl, "\treturn _" .. attr .. ";")
			table.insert(impl, "}")

		-- Otras funciones: cuerpo vacío
		else
			local new_decl = decl:gsub("([%w_]+)(%()", classname .. "::%1%2", 1)
			table.insert(impl, new_decl)
			table.insert(impl, "{")
			table.insert(impl, "}")
		end

		for _, l in ipairs(impl) do table.insert(lineas, l) end
		table.insert(lineas, "")
	end

	local row = vim.api.nvim_win_get_cursor(0)[1]
	vim.api.nvim_buf_set_lines(0, row, row, false, lineas)
end

vim.api.nvim_create_user_command("HppToCpp", function(opts)
	assets.hppToCpp(opts.args)
end, { nargs = 1, complete = "file" })

return assets
