#include <YSI_Coding\y_hooks>

#define     LASTEST_RELEASE     "06/08/2022"
#define     VERSIONING          "0.0.1a - Alpha"
#define     SERVERIP            "198.27.95.178:7777"
#define     SERVERUCP           "https://ucp.advanced-roleplay.com.br"
#define     SERVERFORUM         "https://forum.advanced-roleplay.com.br"

new Server_Instability = 0;
// 0 = Acesso normal
// 1 = Acesso suspenso

new Server_Type = 0;
// 0 - localhost
// 1 - closed alpha
// 2 - sandbox
// 3 - normal

new SERVER_MAINTENANCE = 0;
// 0 = fora de manutenção
// 1 = em manutenção

new query[2048];