#include <YSI_Coding\y_hooks>

#define     TYPE                (1)
#define     LASTEST_RELEASE     "06/08/2022"
#define     VERSIONING          "0.0.1a - BETA"
#define     SERVERIP            "localhost"
#define     SERVERUCP           "https://ucp.advanced-roleplay.com.br"
#define     SERVERFORUM         "https://forum.advanced-roleplay.com.br"

new Server_Instability  = 0;            // 0 = Acesso normal | 1 = Acesso suspenso
new Server_Type         = TYPE;         // 0 = localhost | 1  = Oficial | 2  = Sandbox	
new SERVER_MAINTENANCE  = 0;            // 0 = fora de manutenção | 1 = em manutenção

new query[2048];

#define public2:%0(%1) forward %0(%1); public %0(%1)