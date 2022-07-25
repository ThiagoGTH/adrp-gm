#include <YSI_Coding\y_hooks>

/* ================================ MACROS ================================ */
#define GetServerVariableInt		GetGVarInt
#define GetServerVariableFloat		GetGVarFloat
#define GetServerVariableString 	GetGVarString

#define GLOBAL_VARTYPE_NONE     (0)
#define GLOBAL_VARTYPE_INT      (1)
#define GLOBAL_VARTYPE_STRING   (2)
#define GLOBAL_VARTYPE_FLOAT    (3)

#define UpdateServerVariableString(%0,%1) \
	(UpdateServerVariable(%0, .string_value = (%1), .type = GLOBAL_VARTYPE_STRING))

#define UpdateServerVariableInt(%0,%1) \
	(UpdateServerVariable(%0, .int_value = (%1), .type = GLOBAL_VARTYPE_INT))

#define UpdateServerVariableFloat(%0,%1) \
	(UpdateServerVariable(%0, .float_value = (%1), .type = GLOBAL_VARTYPE_FLOAT))

#define IsValidServerVariable(%0) \
	(GetGVarType(%0) != GLOBAL_VARTYPE_NONE)

/* ================================ NATIVES ================================ */
native SetGVarInt(const name[], value, id = 0);
native GetGVarInt(const name[], id = 0);
native SetGVarString(const name[], const value[], id = 0);
native GetGVarString(const name[], dest[], maxlength = sizeof dest, id = 0);
native SetGVarFloat(const name[], Float:value, id = 0);
native Float:GetGVarFloat(const name[], id = 0);
native DeleteGVar(const name[], id = 0);
native GetGVarsUpperIndex(id = 0);
native GetGVarNameAtIndex(index, dest[], maxlength = sizeof dest, id = 0);
native GetGVarType(const name[], id = 0);

/* ================================ HOOKS ================================ */
hook OnGameModeInit() {
    mysql_format(DBConn, query, sizeof(query), "SELECT * FROM `SERVER`");
	mysql_tquery(DBConn, query, "OnLoadServerVariables", "");

	return true;
}

/* ================================ FUNÇÕES ================================ */
OnLoadServerVariables() {
    if(!cache_num_rows()) return false;

	new 
        variable_type,
        variable_name[64],
        string_value[256];

    for(new i = 0; i < cache_num_rows(); i++) {
		
        cache_get_value_name_int(i, "TYPE", variable_type);
        cache_get_value_name(i, "NAME", variable_name);

		switch (variable_type) {
			case GLOBAL_VARTYPE_INT: SetGVarInt(variable_name, cache_get_value_name_int(i, "INT_VAL"));
            
			case GLOBAL_VARTYPE_STRING: cache_get_value_name(i, "STRING_VAL", string_value), SetGVarString(variable_name, string_value);
            
			case GLOBAL_VARTYPE_FLOAT: SetGVarFloat(variable_name, cache_get_value_name_float(i, "FLOAT_VAL"));
		}
	}

	return printf("[SERVER]: %d variaveis foram carregadas.", cache_num_rows()), 1;
}

UpdateServerVariable(const variable_name[64], int_value = 0, Float:float_value = 0.0, string_value[128] = '\0', type = GLOBAL_VARTYPE_NONE) {
	switch (type) {
		case GLOBAL_VARTYPE_INT: {
            mysql_format(DBConn, query, sizeof query, "UPDATE SERVER SET `INT_VAL`= '%d' WHERE `NAME`= '%e';", int_value, variable_name);
			SetGVarInt(variable_name, int_value);
		}
		case GLOBAL_VARTYPE_STRING: {
            mysql_format(DBConn, query, sizeof query, "UPDATE SERVER SET `STRING_VAL`= '%e' WHERE `NAME`= '%e';", string_value, variable_name);
			SetGVarString(variable_name, string_value);
		}
		case GLOBAL_VARTYPE_FLOAT: {
            mysql_format(DBConn, query, sizeof query, "UPDATE SERVER SET `FLOAT_VAL`= '%f' WHERE `NAME`= '%e';", float_value, variable_name);
			SetGVarFloat(variable_name, float_value);
		}
		default: {
			return; 
		}
	}
	mysql_query(DBConn, query);
}

AddServerVariable(const variable_name[64], const value[128], type) {
	switch (type){
		case GLOBAL_VARTYPE_INT: {
            mysql_format(DBConn, query, sizeof query, "INSERT IGNORE INTO SERVER (`NAME`, `INT_VAL`, `TYPE`) VALUES ('%e', '%d', %d);", variable_name, strval(value), type);
		}
		case GLOBAL_VARTYPE_STRING: {
            mysql_format(DBConn, query, sizeof query, "INSERT IGNORE INTO SERVER (`NAME`, `STRING_VAL`, `TYPE`) VALUES ('%e', '%e', %d);", variable_name, value, type);
		}
		case GLOBAL_VARTYPE_FLOAT: {
            mysql_format(DBConn, query, sizeof query, "INSERT IGNORE INTO SERVER (`NAME`, `FLOAT_VAL`, `TYPE`) VALUES ('%e', '%f', %d);", variable_name, floatstr(value), type);
		}
		default: {
			return; 
		}
	}
	mysql_query(DBConn, query);
}
