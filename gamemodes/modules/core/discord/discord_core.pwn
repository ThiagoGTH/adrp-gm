#include <YSI_Coding\y_hooks>

forward ServerStatus(type);
public ServerStatus(type){
    new title[32],
        text[512],
        forum1[256],
        forum2[256],
        ucp1[256],
        ucp2[256],
        server1[256],
        server2[256],
        footer[128],
        rcon[128];

    new DCC_Channel:channel;
    channel = DCC_FindChannelById("989747574367997982");
    
    if(type == 1){ // TUDO FUNCIONANDO
        // SERVIDOR
        if(Server_Instability){
            Server_Instability = 0;
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay | advanced-roleplay.com.br");
            SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password 0");
            SendRconCommand(rcon);
        }

        // DISCORD
        format(title, 32, "STATUS DE SERVIÇOS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 512, "Nenhum problema ou ocorrência recente.", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Operante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "Fórum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Operante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Operante\nÚltima atualização: %s\nVersão: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/orGtntq.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
        DCC_SendChannelEmbedMessage(channel, embed);
    }
    if(type == 2){ // FÓRUM COM PROBLEMA
        // SERVIDOR
        if(Server_Instability){
            Server_Instability = 0;
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay | advanced-roleplay.com.br");
            SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password 0");
            SendRconCommand(rcon);
        }

        // DISCORD
        format(title, 32, "STATUS DE SERVIÇOS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 512, "Um problema foi encontrado no fórum. Os desenvolvedores trabalhando em uma solução.\n", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Inoperante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "Fórum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Operante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Operante\nÚltima atualização: %s\nVersão: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/fFacF9o.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
        DCC_SendChannelEmbedMessage(channel, embed);
    }
    if(type == 3){ // UCP COM PROBLEMA
        // SERVIDOR
        if(Server_Instability){
            Server_Instability = 0;
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay | advanced-roleplay.com.br");
            SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password 0");
            SendRconCommand(rcon);
        }

        // DISCORD
        format(title, 32, "STATUS DE SERVIÇOS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 512, "Um problema foi encontrado no User Control Panel. Os desenvolvedores trabalhando em uma solução.\n", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Operante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "Fórum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Inoperante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Operante\nÚltima atualização: %s\nVersão: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/fFacF9o.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
        DCC_SendChannelEmbedMessage(channel, embed);
    }
    if(type == 4){ // SA-MP COM PROBLEMA
        // SERVER:
        Server_Instability = 1;
        format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Acesso ao jogo suspenso!");
        SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password 9291z2");
        SendRconCommand(rcon);

        // DISCORD:
        format(title, 32, "STATUS DE SERVIÇOS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 512, "Um problema foi encontrado no serviço SA-MP e o acesso aos jogadores foi suspenso para evitar danos.\nOs desenvolvedores trabalhando em uma solução.", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Operante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "Fórum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Operante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Inoperante\nÚltima atualização: %s\nVersão: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/fFacF9o.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
        DCC_SendChannelEmbedMessage(channel, embed);
    }
    if(type == 5){ // TUDO COM PROBLEMA (smyle sistemas)
        // SERVER:
        Server_Instability = 1;
        format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Acesso ao jogo suspenso!");
        SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password 9291z2");
        SendRconCommand(rcon);

        // DISCORD:
        format(title, 32, "STATUS DE SERVIÇOS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 512, "Um problema foi encontrado em todos os serviços. Os desenvolvedores trabalhando em uma solução o mais rápido possível.\n", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Inoperante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "Fórum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Inoperante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Inoperante\nÚltima atualização: %s\nVersão: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);
        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/5jVAWdx.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
        DCC_SendChannelEmbedMessage(channel, embed);
    }
}

public DCC_OnMessageCreate(DCC_Message:message)
{
    new channel_name[32];
    new DCC_Channel:channel;
    DCC_GetMessageChannel(message, channel);
    DCC_GetChannelName(channel, channel_name);
    new user_name[32 + 1], discriminator[8];
    new DCC_User:author;
    DCC_GetMessageAuthor(message, author);
    DCC_GetUserName(author, user_name);
    DCC_GetUserDiscriminator(author, discriminator);
    new string[128];
    DCC_GetMessageContent(message, string);

    new bool:is_bot;
    if(!DCC_IsUserBot(author, is_bot))
        return false;

    if(is_bot)
        return false;

    if(!strcmp(channel_name, "admin-chat", true) && channel == DCC_FindChannelById("989306920517136464")){
        new dest[255], nameee[255];
        utf8decode(dest, string);
        utf8decode(nameee, user_name);
        
        if (strlen(string) > 64){
            SendAdminAlert(COLOR_ADMINCHAT, "[STAFF] %s (Discord): %.64s", nameee, dest);
            SendAdminAlert(COLOR_ADMINCHAT, "...%s **", dest[64]);
        }
        else SendAdminAlert(COLOR_ADMINCHAT, "[STAFF] %s (Discord): %s", nameee, dest);
        return true;
    }

    if(!strcmp(channel_name, "bot-talk", true) && channel == DCC_FindChannelById("989306578199003197")){
        DCC_SendChannelMessage(DCC_FindChannelById("989305002952622110"), string);
        return true;
    }

    if(!strcmp(channel_name, "comandos", true) && channel == DCC_FindChannelById("989305002952622110")) //#comandos
    {
        if(strfind(string, "!", true) == 0)//Comando identificado
        {
            new authorid[DCC_ID_SIZE];
            DCC_GetUserId(author, authorid, sizeof(authorid));

            new command[32];
            new parameters[64];
            sscanf(string, "s[32]S()[64]", command, parameters);

            if(!strcmp(command, "!ajuda", true)){
                new text[1024],
                    title[32],
                    footer[128],
                    title_field[128], 
                    text_field[1024];

                format(title, 32, "Comandos disponíveis");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                format(text, 1024, "Bip-bip-bop-bip-bop-bip. Eis o que posso fazer:\n", text);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(title_field, 128, "!staff");
                format(text_field, 1024, "Exibe os membros da equipe online e seus respectivos status.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!personagens");
                format(text_field, 1024, "Exibe os personagens do usuário especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!usuario");
                format(text_field, 1024, "Exibe o usuário do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!checarban");
                format(text_field, 1024, "Exibe as informações do banimento do usuário especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!historico");
                format(text_field, 1024, "Exibe o histórico do usuário especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(channel, embed);

            }
            else if(!strcmp(command, "!staff", true)){
                new count_aduty=0, count_offduty=0;
                new aduty[1024], offduty[1024];

                foreach (new i : Player) if (uInfo[i][uAdmin] > 0){
                    new nomeadmin[128];
                    nomeadmin = AdminRankName(i);

                    if(pInfo[i][pAdminDuty]){
                        count_aduty++;
                        format(aduty, 1024, "%s%s %s (%s) (ID: %d)\n", aduty, nomeadmin, pNome(i), GetPlayerUserEx(i), i);
                    }else{
                        count_offduty++;
                        format(offduty, 1024, "%s%s %s (%s) (ID: %d)\n", offduty, nomeadmin, pNome(i), GetPlayerUserEx(i), i);
                    }
                }               

                new text[256];
                if (count_aduty == 0 && count_offduty == 0){
                    new title[32];
                    format(title, 32, "Equipe administrativa online");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                                        
                    format(text, 256, "Nenhum membro da equipe online neste momento.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);

                    DCC_SetEmbedColor(embed, 0x5964F4);
                    new footer[128];
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);

                    return true;
                }

                new title[32];
                format(title, 32, "Equipe administrativa online");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                                
                utf8encode(aduty, aduty);
                utf8encode(offduty, offduty);

                if(count_aduty > 0)
                    DCC_AddEmbedField(embed, "Membros da equipe em modo admin:", aduty, false);
                else
                    DCC_AddEmbedField(embed, "Membros da equipe em modo admin:", "Nenhum membro da equipe", false);

                if(count_offduty > 0)
                    DCC_AddEmbedField(embed, "Membros da equipe em modo roleplay:", offduty, false);
                else
                    DCC_AddEmbedField(embed, "Membros da equipe em modo roleplay:", "Nenhum membro da equipe", false);

                DCC_SetEmbedColor(embed, 0x5964F4);
                new footer[128];
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");

                DCC_SendChannelEmbedMessage(channel, embed);
            }
            else if(!strcmp(command, "!historico", true)){
            
                new text[256],
                    footer[128],
                    title[64],
                    timeValue[24],
                    timestamp,
                    log[512],
                    logValue[512];

                if(isnull(parameters)){
                    format(text, 256, "**USE:** !historico [usuário]");
                    utf8encode(text, text);
                    format(title, 64, "Histórico de usuário");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }
                new Cache:result;
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", parameters);
                result = mysql_query(DBConn, query);

                // Verificar existência do usuário
                if(!cache_num_rows()) {
                    format(text, 256, "Não foi possível encontrar um usuário com o nome digitado.");
                    utf8encode(text, text);
                    format(title, 64, "Usuário não encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }

                format(title, 64, "Punições de %s", parameters);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0x5964F4);
                cache_delete(result);

                mysql_format(DBConn, query, sizeof query, "SELECT * FROM serverlogs WHERE `user` = '%s' AND `type` = '11';", parameters);
                result = mysql_query(DBConn, query);
                // Verifica se existe algum dado na tabela, ou seja, conta quantas punições o usuário tem. Se não possuir nenhum dado, o comando se encerra aqui.
                if(!cache_num_rows()) {
                    format(text, 256, "Este usuário não possui nenhuma punição.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                // Puxa os personagens que constam na tabela através do nome do usuário.
                for(new i; i < cache_num_rows(); i++) {
                    
                    cache_get_value_name(i, "log", log);
                    cache_get_value_name_int(i, "timestamp", timestamp);

                    format(logValue, 512, "%s", log);
                    utf8encode(logValue, logValue);
                    format(timeValue, 128, "Em: %s", GetFullDate(timestamp));
                    utf8encode(timeValue, timeValue);
                    DCC_AddEmbedField(embed, logValue, timeValue, false);
                }
                cache_delete(result);
                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                return true;
            }
            else if(!strcmp(command, "!personagens", true)){
            
                new text[256],
                    footer[128],
                    title[64],
                    characterValue[24],
                    lastLogin,
                    userID,
                    character[128],
                    lastL[128];

                if(isnull(parameters)){
                    format(text, 256, "**USE:** !personagens [usuario]");
                    utf8encode(text, text);
                    format(title, 64, "Personagens");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }
                
                // Pegar os personagens que pertencem àquele usuário
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", parameters);
                new Cache:result = mysql_query(DBConn, query);

                // Verificar existência do usuário
                if(!cache_num_rows()) {
                    format(text, 256, "Não foi possível encontrar um usuário com o nome digitado.");
                    utf8encode(text, text);
                    format(title, 64, "Personagem não encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }
 
                format(title, 64, "Personagens de %s", parameters);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0x5964F4);

                cache_get_value_name_int(0, "ID", userID);
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user_id` = '%d';", userID);
                result = mysql_query(DBConn, query);
                // Verifica se existe algum dado na tabela, ou seja, conta quantos personagens o usuário tem. Se não possuir nenhum dado, o comando se encerra aqui.
                if(!cache_num_rows()) {
                    format(text, 256, "Este usuário não possui nenhum personagem.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                // Puxa os personagens que constam na tabela através do nome do usuário.
                for(new i; i < cache_num_rows(); i++) {
                    cache_get_value_name(i, "name", characterValue);
                    cache_get_value_name_int(i, "last_login", lastLogin);

                    format(character, 128, "%s", characterValue);
                    utf8encode(character, character);
                    format(lastL, 128, "%s %s", GetFullDate(lastLogin, 1), GetPlayerByName(characterValue) == -1 ? ("") : ("- **ONLINE**"));
                    utf8encode(lastL, lastL);
                    DCC_AddEmbedField(embed, character, lastL, false);
                }
                cache_delete(result);
                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                return true;
            }
            else if(!strcmp(command, "!usuario", true)){
            
                new text[256],
                    footer[128],
                    userID,
                    title[64],
                    userValue[24];

                if(isnull(parameters)){
                    format(text, 256, "**USE:** !usuario [personagem]");
                    utf8encode(text, text);
                    format(title, 64, "Usuário");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                // Consultar a tabela players com o nome digitado e informar se o nome não existe ou, se sim, o seu usuário.
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s';", parameters);
                new Cache:result = mysql_query(DBConn, query);

                if(!cache_num_rows()){
                    format(text, 256, "Não foi possível encontrar um usuário através do personagem digitado.");
                    utf8encode(text, text);
                    format(title, 64, "Usuário não encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }
                format(title, 64, "Usuário de %s", parameters);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0x5964F4);

                cache_get_value_name_int(0, "user_id", userID);
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `ID` = '%d';", userID);
                mysql_query(DBConn, query);
                cache_get_value_name(0, "username", userValue);

                format(text, 256, "O usuário de %s é: **%s**", parameters, userValue);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                cache_delete(result);
                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                return true;
            }
            else if(!strcmp(command, "!checarban", true)){
            
                new text[1024],
                    title[32],
                    footer[128],
                    userID,
                    title_field[128], 
                    text_field[1024];

                if(isnull(parameters)){
                    format(text, 1024, "**USE:** !checarban [usuário]");
                    utf8encode(text, text);
                    format(title, 32, "Checar Banimento");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }
                
                // Pegar os personagens que pertencem àquele usuário
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", parameters);
                new Cache:result = mysql_query(DBConn, query);

                // Verificar existência do usuário
                if(!cache_num_rows()) {
                    format(text, 256, "Não foi possível encontrar um usuário com o nome digitado.");
                    utf8encode(text, text);
                    format(title, 64, "Banimento não encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }
                cache_get_value_name_int(0, "ID", userID);
                cache_delete(result); // Limpar o cachê do MySQL

                // Pegar os dados referente ao banimento
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM ban WHERE `banned_id` = '%d';", userID);
                result = mysql_query(DBConn, query);

                // Verificar existência do banimento
                if(!cache_num_rows()) {
                    format(text, 1024, "O usuário especificado não está banido.\n");
                    utf8encode(text, text);
                    format(title, 64, "Banimento não encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                format(title, 64, "Banimento(s) de %s", parameters);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0x5964F4);

                for(new i; i < cache_num_rows(); i++) {
                    new adminName[24], reason[128], ban_date, unban_date, unban_admin[24], banned;
                    cache_get_value_name(i, "admin_name", adminName);
                    cache_get_value_name(i, "reason", reason);
                    cache_get_value_name_int(i, "ban_date", ban_date);
                    cache_get_value_name_int(i, "unban_date", unban_date);
                    cache_get_value_name(i, "unban_admin", unban_admin);
                    cache_get_value_name_int(i, "banned", banned);

                    format(text, 1024, "O usuário '%s' esta, atualmente, **%s**.\n", parameters, banned > 0 ? ("banido") : ("desbanido"));
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);

                    format(title_field, 128, "Banimento %d", i);
                    utf8encode(title_field, title_field);
                    format(text_field, 1024, "**Banido por:** %s\n**Motivo:** %s\n**Data do banimento:** %s\n**Data do desbanimento:** %s %s\n**Desbanido por:** %s", adminName, reason, GetFullDate(ban_date), 
                        unban_date > 0 ? (GetFullDate(unban_date)) : ("Permanente"), banned > 0 ? ("- **Cumprindo**") : (" "), unban_admin);

                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                }

                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                cache_delete(result); // Limpar o cachê do MySQL
                return true;
            }

            else{ // Caso o comando não exista
                new title[32];
                format(title, 32, "Comando inválido");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[512];
                format(text, 512, "Digite **!ajuda** para obter a lista de comandos completa.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                DCC_SetEmbedColor(embed, 0x5964F4);
                new footer[128];
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(channel, embed);
            }
        }
        return true;
    }

    if(!strcmp(channel_name, "manager-bot", true) && channel == DCC_FindChannelById("989305233299624007")){ // #manager-bot
        if(strfind(string, "!", true) == 0)//Comando identificado
        {
            new authorid[DCC_ID_SIZE];
            DCC_GetUserId(author, authorid, sizeof(authorid));

            new command[32];
            new parameters[64];
            sscanf(string, "s[32]S()[64]", command, parameters);

            if(!strcmp(command, "!status", true)){
                new text[1024],
                    title[32],
                    footer[128],
                    type;

                if(sscanf(parameters, "d", type)){
                    format(title, 32, "Alterar Status de Serviço");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    format(text, 1024, "**USE:** !status [1 à 5]\n`1` = Todos os serviços operantes\n`2` = Fórum inoperante\n`3` = UCP inoperante\n`4` = Serviço SA-MP inoperante\n`5` = Todos os serviços inoperantes");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }
                if(type < 1 || type > 5){
                    format(title, 32, "Alterar Status de Serviço");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    format(text, 1024, "**ERRO:** O valor inserido deve estar entre 1 e 5.\n\n**USE:** !status [1 à 5]\n`1` = Todos os serviços operantes\n`2` = Fórum inoperante\n`3` = UCP inoperante\n`4` = Serviço SA-MP inoperante\n`5` = Todos os serviços inoperantes");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }
                ServerStatus(type);
                new whattype[256];
                switch(type){
                    case 1: whattype = "todos os serviços operantes";
                    case 2: whattype = "fórum inoperante";
                    case 3: whattype = "User Control Panel inoperante";
                    case 4: whattype = "serviço SA-MP inoperante";
                    case 5: whattype = "todos os serviços inoperantes";
                    default: whattype = "ERRO";
                }
                format(title, 32, "Alterar Status de Serviço");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                format(text, 1024, "Você definiu o status de serviço como %s.", whattype);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
            }

            else{
                new title[32];
                format(title, 32, "Comando inválido");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[512];
                format(text, 512, "Digite **!ajuda** para obter a lista de comandos completa.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                DCC_SetEmbedColor(embed, 0x5964F4);
                new footer[128];
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(channel, embed);
            }
        }
        return true;
    }
    
    return true;
}
