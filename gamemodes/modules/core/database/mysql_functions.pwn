forward SaveSQLVarchar(sqlid, table[], row[], str[]);
public SaveSQLVarchar(sqlid, table[], row[], str[]) {
    mysql_format(DBConn, query, sizeof(query), "UPDATE %e SET %e = '%e' WHERE id = %i", table, row, str, sqlid);
    mysql_pquery(DBConn, query);
    return true;
}

forward SaveSQLInt(sqlid, const table[], const row[], value);
public SaveSQLInt(sqlid, const table[], const row[], value) {
    mysql_format(DBConn, query, sizeof(query), "UPDATE %e SET %e = %i WHERE id = %i", table, row, value, sqlid);
    mysql_pquery(DBConn, query);
    return true;
}

forward SaveSQLFloat(sqlid, table[], row[], Float:value);
public SaveSQLFloat(sqlid, table[], row[], Float:value) {
    mysql_format(DBConn, query, sizeof(query), "UPDATE %e SET %e = %f WHERE id = %i", table, row, value, sqlid);
    mysql_pquery(DBConn, query);
    return true;
}