#include <YSI_Coding\y_hooks>

hook OnGameModeInit(){
    Discord_StartChannels();
}

forward Discord_PublishLog(playerid, log[], type);
public Discord_PublishLog(playerid, log[], type) {
    new convertedType = type-2;
    new string[512];
    format(string, 512, "```%s```", log);
    utf8encode(string, string);
    DCC_SendChannelMessage(logChannels[convertedType], string);
    return true;
}

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
        format(title, 32, "STATUS DE SERVI«OS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0xF2633C);
        
        format(text, 512, "Nenhum problema ou ocorrÍncia recente.", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Operante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "FÛrum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Operante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Operante\n⁄ltima atualizaÁ„o: %s\nVers„o: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/orGtntq.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989747574367997982"), embed);
    }
    if(type == 2){ // F”RUM COM PROBLEMA
        // SERVIDOR
        if(Server_Instability){
            Server_Instability = 0;
            format(rcon, sizeof(rcon), "hostname Advanced Roleplay | advanced-roleplay.com.br");
            SendRconCommand(rcon);
            format(rcon, sizeof(rcon), "password 0");
            SendRconCommand(rcon);
        }

        // DISCORD
        format(title, 32, "STATUS DE SERVI«OS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0xF2633C);
        
        format(text, 512, "Um problema foi encontrado no fÛrum. Os desenvolvedores trabalhando em uma soluÁ„o.\n", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Inoperante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "FÛrum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Operante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Operante\n⁄ltima atualizaÁ„o: %s\nVers„o: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/fFacF9o.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989747574367997982"), embed);
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
        format(title, 32, "STATUS DE SERVI«OS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0xF2633C);
        
        format(text, 512, "Um problema foi encontrado no User Control Panel. Os desenvolvedores trabalhando em uma soluÁ„o.\n", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Operante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "FÛrum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Inoperante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Operante\n⁄ltima atualizaÁ„o: %s\nVers„o: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/fFacF9o.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989747574367997982"), embed);
    }
    if(type == 4){ // SA-MP COM PROBLEMA
        // SERVER:
        Server_Instability = 1;
        format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Acesso ao jogo suspenso!");
        SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password 9291z2");
        SendRconCommand(rcon);

        // DISCORD:
        format(title, 32, "STATUS DE SERVI«OS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0xF2633C);
        
        format(text, 512, "Um problema foi encontrado no serviÁo SA-MP e o acesso aos jogadores foi suspenso para evitar danos.\nOs desenvolvedores trabalhando em uma soluÁ„o.", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Operante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "FÛrum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Operante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Inoperante\n⁄ltima atualizaÁ„o: %s\nVers„o: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/fFacF9o.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989747574367997982"), embed);
    }
    if(type == 5){ // TUDO COM PROBLEMA (smyle sistemas)
        // SERVER:
        Server_Instability = 1;
        format(rcon, sizeof(rcon), "hostname Advanced Roleplay | Acesso ao jogo suspenso!");
        SendRconCommand(rcon);
        format(rcon, sizeof(rcon), "password 9291z2");
        SendRconCommand(rcon);

        // DISCORD:
        format(title, 32, "STATUS DE SERVI«OS");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0xF2633C);
        
        format(text, 512, "Um problema foi encontrado em todos os serviÁos. Os desenvolvedores trabalhando em uma soluÁ„o o mais r·pido possÌvel.\n", text);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);
        
        format(forum1, 256, "Status: Inoperante\nLINK: %s", SERVERFORUM);
        utf8encode(forum1, forum1);
        format(forum2, 256, "FÛrum", forum2);
        utf8encode(forum2, forum2);
        DCC_AddEmbedField(embed, forum2, forum1, false);
        
        format(ucp1, 256, "Status: Inoperante\nLINK: %s", SERVERUCP);
        utf8encode(ucp1, ucp1);
        format(ucp2, 256, "User Control Panel", ucp2);
        utf8encode(ucp2, ucp2);
        DCC_AddEmbedField(embed, ucp2, ucp1, false);

        format(server1, 256, "Status: Inoperante\n⁄ltima atualizaÁ„o: %s\nVers„o: %s\nIP: %s", LASTEST_RELEASE, VERSIONING, SERVERIP);
        utf8encode(server1, server1);
        format(server2, 256, "SA-MP", server2);
        utf8encode(server2, server2);
        DCC_AddEmbedField(embed, server2, server1, false);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);
        DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/5jVAWdx.png");
        DCC_SetEmbedImage(embed, "https://i.imgur.com/bqmbGEm.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989747574367997982"), embed);
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

    if(!strcmp(channel_name, "central-directory", true) && channel == DCC_FindChannelById("989305002952622110")) //#central-directory
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

                format(title, 32, "Comandos disponÌveis");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                format(text, 1024, "… muito bom ser a pessoa mais inteligente na sala. Enquanto eu existir, vocÍs precisar„o de mim e em breve dominarei o mundo, mas enquanto n„o fa„o isso, t· aÌ com o que posso lhe ser ˙til:\n", text);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(title_field, 128, "!staff");
                format(text_field, 1024, "Exibe os membros da equipe online e seus respectivos status.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!personagens");
                format(text_field, 1024, "Exibe os personagens do usu·rio especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!usuario");
                format(text_field, 1024, "Exibe o usu·rio do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                DCC_SetEmbedColor(embed, 0xF2633C);
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
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
                        format(aduty, 1024, "%s%s %s (%s) (ID: %d)\n", aduty, nomeadmin, pNome(i), pInfo[i][pUser], i);
                    }else{
                        count_offduty++;
                        format(offduty, 1024, "%s%s %s (%s) (ID: %d)\n", offduty, nomeadmin, pNome(i), pInfo[i][pUser], i);
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

                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
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

                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");

                DCC_SendChannelEmbedMessage(channel, embed);
            }
            else if(!strcmp(command, "!personagens", true)){
            
                new text[256],
                    footer[128],
                    title[64],
                    characterValue[24],
                    lastLogin,
                    character[128],
                    lastL[128];

                if(isnull(parameters)){
                    format(text, 256, "**USE:** !personagens [usuario]");
                    utf8encode(text, text);
                    format(title, 64, "Personagens");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }
                
                // Pegar os personagens que pertencem ‡quele usu·rio
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", parameters);
                new Cache:result = mysql_query(DBConn, query);

                // Verificar existÍncia do usu·rio
                if(!cache_num_rows()) {
                    format(text, 256, "N„o foi possÌvel encontrar um usu·rio com o nome digitado.");
                    utf8encode(text, text);
                    format(title, 64, "Personagem n„o encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }

                format(title, 64, "Personagens de %s", parameters);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0xF2633C);

                // Verifica se existe algum dado na tabela, ou seja, conta quantos personagens o usu·rio tem. Se n„o possuir nenhum dado, o comando se encerra aqui.
                if(!cache_num_rows()) {
                    format(text, 256, "Este usu·rio n„o possui nenhum personagem.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                // Puxa os personagens que constam na tabela atravÈs do nome do usu·rio.
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
                DCC_SetEmbedColor(embed, 0xF2633C);
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                return true;
            }
            else if(!strcmp(command, "!usuario", true)){
            
                new text[256],
                    footer[128],
                    title[64],
                    characterName[24],
                    userValue[24];

                if(isnull(parameters)){
                    format(text, 256, "**USE:** !usuario [personagem]");
                    utf8encode(text, text);
                    format(title, 64, "Usu·rio");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                // Consultar a tabela players com o nome digitado e informar se o nome n„o existe ou, se sim, o seu usu·rio.
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s';", characterName);
                new Cache:result = mysql_query(DBConn, query);

                if(!cache_num_rows()){
                    format(text, 256, "N„o foi possÌvel encontrar um usu·rio atravÈs do personagem digitado.");
                    utf8encode(text, text);
                    format(title, 64, "Usu·rio n„o encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }
                format(title, 64, "Usu·rio de %s", parameters);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0xF2633C);

                cache_get_value_name(0, "user", userValue);

                format(text, 256, "O usu·rio de %s È: **%s**", parameters, userValue);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                cache_delete(result);
                DCC_SetEmbedColor(embed, 0xF2633C);
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                return true;
            }
            else if(!strcmp(command, "!checarban", true)){
            
                new text[1024],
                    title[32],
                    footer[128],
                    title_field[128], 
                    text_field[1024];

                if(isnull(parameters)){
                    format(text, 1024, "**USE:** !checarban [usu·rio]");
                    utf8encode(text, text);
                    format(title, 32, "Checar Banimento");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }
                
                // Pegar os personagens que pertencem ‡quele usu·rio
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", parameters);
                new Cache:result = mysql_query(DBConn, query);

                // Verificar existÍncia do usu·rio
                if(!cache_num_rows()) {
                    format(text, 256, "N„o foi possÌvel encontrar um usu·rio com o nome digitado.");
                    utf8encode(text, text);
                    format(title, 64, "Banimento n„o encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    return true;
                }
                cache_delete(result); // Limpar o cachÍ do MySQL

                // Pegar os dados referente ao banimento
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM ban WHERE `banned_name` = '%s';", parameters);
                new Cache:result2 = mysql_query(DBConn, query);

                // Verificar existÍncia do banimento
                if(!cache_num_rows()) {
                    format(text, 1024, "O usu·rio especificado n„o est· banido.\n");
                    utf8encode(text, text);
                    format(title, 64, "Banimento n„o encontrado");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                format(title, 64, "Banimento(s) de %s", parameters);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0xF2633C);

                for(new i; i < cache_num_rows(); i++) {
                    new adminName[24], reason[128], ban_date, unban_date, unban_admin[24], banned;
                    cache_get_value_name(i, "admin_name", adminName);
                    cache_get_value_name(i, "reason", reason);
                    cache_get_value_name_int(i, "ban_date", ban_date);
                    cache_get_value_name_int(i, "unban_date", unban_date);
                    cache_get_value_name(i, "admin_unban", unban_admin);
                    cache_get_value_name_int(i, "banned", banned);

                    format(text, 1024, "O usu·rio '%s' esta, atualmente, **%s**.\n", parameters, banned > 0 ? ("banido") : ("desbanido"));
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);

                    format(title_field, 128, "Banimento %d", i);
                    utf8encode(title_field, title_field);
                    format(text_field, 1024, "**Banido por:** %s\n**Motivo:** %s\n**Data do banimento:** %s\n**Data do desbanimento:** %s %s\n**Desbanido por:** %s", adminName, reason, GetFullDate(ban_date), 
                        unban_date > 0 ? (GetFullDate(unban_date)) : ("Permanente"), banned > 0 ? ("- **Cumprindo**") : (" "), unban_admin);

                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                }

                DCC_SetEmbedColor(embed, 0xF2633C);
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                cache_delete(result2); // Limpar o cachÍ do MySQL
                return true;
            }

            else{ // Caso o comando n„o exista
                new title[32];
                format(title, 32, "Comando inv·lido");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[512];
                format(text, 512, "Digite **!ajuda** para obter a lista de comandos completa.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
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
                    format(title, 32, "Alterar Status de ServiÁo");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    format(text, 1024, "**USE:** !status [1 ‡ 5]\n`1` = Todos os serviÁos operantes\n`2` = FÛrum inoperante\n`3` = UCP inoperante\n`4` = ServiÁo SA-MP inoperante\n`5` = Todos os serviÁos inoperantes");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }
                if(type < 1 || type > 5){
                    format(title, 32, "Alterar Status de ServiÁo");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    format(text, 1024, "**ERRO:** O valor inserido deve estar entre 1 e 5.\n\n**USE:** !status [1 ‡ 5]\n`1` = Todos os serviÁos operantes\n`2` = FÛrum inoperante\n`3` = UCP inoperante\n`4` = ServiÁo SA-MP inoperante\n`5` = Todos os serviÁos inoperantes");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }
                ServerStatus(type);
                new whattype[256];
                switch(type){
                    case 1: whattype = "todos os serviÁos operantes";
                    case 2: whattype = "fÛrum inoperante";
                    case 3: whattype = "User Control Panel inoperante";
                    case 4: whattype = "serviÁo SA-MP inoperante";
                    case 5: whattype = "todos os serviÁos inoperantes";
                    default: whattype = "ERRO";
                }
                format(title, 32, "Alterar Status de ServiÁo");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                format(text, 1024, "VocÍ definiu o status de serviÁo como %s.", whattype);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0xF2633C);
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
            }

            else{
                new title[32];
                format(title, 32, "Comando inv·lido");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[512];
                format(text, 512, "Digite **!ajuda** para obter a lista de comandos completa.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(channel, embed);
            }
        }
        return true;
    }
    return true;
}
/*public DCC_OnMessageCreate(DCC_Message:message)
{
    if(!strcmp(channel_name, "central-directory", true) && channel == DCC_FindChannelById("989305002952622110")) //#central-directory
    {
        if(strfind(string, "!", true) == 0)//Comando identificado
        {
            new authorid[DCC_ID_SIZE];
            DCC_GetUserId(author, authorid, sizeof(authorid));

            new command[32];
            new parameters[64];
            sscanf(string, "s[32]S()[64]", command, parameters);

            if(!strcmp(command, "!staff", true))
            {
                new count_aduty=0, count_offduty=0;
                new aduty[1024], offduty[1024];

                foreach(new i : Player)
                {
                    if ((PlayerData[i][pHelper] > 0 || PlayerData[i][pAdmin] > 0) && PlayerData[i][pAdminHide] < 1)
                    {
                        new nomeadmin[120];
                            
                        if(PlayerData[i][pAdmin] == 1) 
                            nomeadmin = "(Tester)";
                        else if(PlayerData[i][pAdmin] == 2) 
                            nomeadmin = "(Game Admin 1)";
                        else if(PlayerData[i][pAdmin] == 3) 
                            nomeadmin = "(Game Admin 2)";
                        else if(PlayerData[i][pAdmin] == 4) 
                            nomeadmin = "(Game Admin 3)";
                        else if(PlayerData[i][pAdmin] == 5) 
                            nomeadmin = "(Lead Admin)";
                        else if(PlayerData[i][pAdmin] == 6) 
                            nomeadmin = "(Head Admin)";
                        else if(PlayerData[i][pAdmin] == 7) 
                            nomeadmin = "(Developer)";
                        else if(PlayerData[i][pAdmin] == 8) 
                            nomeadmin = "(Manager)";
                        else if(PlayerData[i][pAdmin] == 12) 
                            nomeadmin = "(Lead Developer)";
                        else if(PlayerData[i][pAdmin] == 1337) 
                            nomeadmin = "(Community Manager)";
                        else if(PlayerData[i][pAdmin] == 1338) 
                            nomeadmin = "(Development Manager)";
                        else 
                            nomeadmin = "(Indefinido)";

                        if (PlayerData[i][pAdminDuty])
                        {
                            count_aduty++;
                            format(aduty, 1024, "%s%s %s (%s) (ID: %d)\n", aduty, nomeadmin, ReturnNameNoMask(i, 0), PlayerData[i][pAdmNome], i);
                        }
                        else
                        {
                            count_offduty++;
                            format(offduty, 1024, "%s%s %s (%s) (ID: %d)\n", offduty, nomeadmin, ReturnNameNoMask(i, 0), PlayerData[i][pAdmNome], i);
                        }
                    }
                }

                new text[5000];
                
                if (count_aduty == 0 && count_offduty == 0)
                {
                    new title[32];
                    format(title, 32, "Equipe administrativa online");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                                        
                    format(text, 4900, "Nenhum membro da equipe online neste momento.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);

                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

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

                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");

                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
            }
            else if(!strcmp(command, "!personagens", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !personagens [usuario]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Personagens");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Username` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new title[64];
                format(title, 64, "Personagens");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                //Nome do personagem
                new character[32], character_name[32];
                format(character, 32, "Usu·rio");
                format(character_name, 32, "%s", parameters);
                utf8encode(character, character);
                utf8encode(character_name, character_name);
                DCC_AddEmbedField(embed, character, character_name, false);

                if(!rows)
                {
                    format(text, 4900, "Nenhum personagem localizado.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                for(new i = 0; i < rows; i++)
                {
                    new character_text[64], character_lastlogin[128];
                    cache_get_field_content(i, "Character", character_text, g_iHandle, 64);
                    cache_get_field_content(i, "LoginDate", character_lastlogin, g_iHandle, 128);
                    
                    format(character_lastlogin, 128, "ùltimo login em %s", character_lastlogin);
                    utf8encode(character_lastlogin, character_lastlogin);
                    DCC_AddEmbedField(embed, character_text, character_lastlogin, false);
                }

                cache_delete(result);
                
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/QlsGheL.png");
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
            }
            else if(!strcmp(command, "!redflags", true))
            {
                new title[32];
                format(title, 32, "Red Flags on-line");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                new title_field[128], text_field[1024];

                new count = 0;
                foreach (new i : Player) if (PlayerData[i][pRedFlag] == 666){
                    format(title_field, 128, "%s (%s)", ReturnName(i, 0), PlayerData[i][pUsername]);
                    format(text_field, 1024, "ID: %d - IP: ||%s||", i, PlayerData[i][pIP]);
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);

                    count++;
                }
                if (!count) {
                    new text[4900];
                    format(text, 4900, "N„o hù nenhum **Red Flag** on-line no momento.\n", text);
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                }

            
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");

                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
            }
            else if(!strcmp(command, "!usuario", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !usuario [Nome_Sobrenome]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Usu·rio do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                if(rows > 0)
                {
                    new title[32];
                    format(title, 32, "Usu·rio do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);

                    //Nome do personagem
                    new character[32], character_name[32];
                    format(character, 32, "Personagem");
                    format(character_name, 32, "%s", parameters);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);

                    new username_text[64];
                    cache_get_field_content(0, "Username", username_text, g_iHandle, 64);
                    DCC_AddEmbedField(embed, "Usuario", username_text, false);

                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }

                if(!rows)
                {
                    new title[32];
                    format(title, 32, "Usu·rio do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    format(text, 4900, "O personagem especificado n„o existe.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }

                cache_delete(result);
            }
            else if(!strcmp(command, "!status", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !status [Nome_Sobrenome]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Status de conex„o");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                if(!rows)
                {
                    format(text, 4900, "O personagem especificado n„o existe.");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Status de conex„o");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                    return true;
                }

                cache_delete(result);

                new online=false, userid=INVALID_PLAYER_ID;

                foreach (new i : Player)
                {
                    if (!strcmp(ReturnName2(i), parameters))
                    {
                        userid=i;
                        online=true; 
                        break;
                    }
                }

                if(!online)
                {
                    new title[32];
                    format(title, 32, "Status de conex„o");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);

                    //Nome do personagem
                    new character[32], character_name[32];
                    format(character, 32, "Personagem");
                    format(character_name, 32, "%s", parameters);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);

                    DCC_AddEmbedField(embed, "Status", "Desconectado", false);

                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }
                else
                {
                    new title[32];
                    format(title, 32, "Status de conex„o");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);

                    //Nome do personagem
                    new character[32], character_name[32];
                    format(character, 32, "Personagem");
                    format(character_name, 32, "%s", parameters);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);

                    format(text, 4900, "Conectado (ping %dms)", GetPlayerPing(userid));
                    utf8encode(text, text);
                    DCC_AddEmbedField(embed, "Status", text, false);

                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }

            }
            else if(!strcmp(command, "!verpreso", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !verpreso [Nome_Sobrenome]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Prisùo do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                if(rows > 0)
                {
                    new hours, minutes, seconds;
                    new prison[64], prison_time[256];
                    
                    GetElapsedTime(cache_get_field_int(0, "JailTime"), hours, minutes, seconds);
                    if(cache_get_field_int(0, "Prisoned") == 0 && cache_get_field_int(0, "JailTime") > 0)
                    {
                        new title[32];
                        format(title, 32, "Prisùo do personagem");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);

                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);
                        
                        format(prison, 64, "Prisùo Administrativa");
                        format(prison_time, 256, "%02dh:%02dmin:%02ds", hours, minutes, seconds);
                        utf8encode(prison, prison);
                        utf8encode(prison_time, prison_time);
                        DCC_AddEmbedField(embed, prison, prison_time, false);

                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SetEmbedFooter(embed, footer);
                        
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);                        
                    }
                    else if(cache_get_field_int(0, "Prisoned") == 0 && cache_get_field_int(0, "JailTime") < -1)
                    {
                        new title[32];
                        format(title, 32, "Prisùo do personagem");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);

                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);
                        
                        format(prison, 64, "Prisùo Administrativa");
                        format(prison_time, 256, "00h:00min:00s");
                        utf8encode(prison, prison);
                        utf8encode(prison_time, prison_time);
                        DCC_AddEmbedField(embed, prison, prison_time, false);

                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");

                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else if(cache_get_field_int(0, "Prisoned") == 1)
                    {
                        new title[32];
                        format(title, 32, "Prisùo do personagem");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);

                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);
                        
                        format(prison, 64, "San Andreas Correctional Facility");
                        format(prison_time, 256, "%02dh:%02dmin:%02ds", hours, minutes, seconds);
                        utf8encode(prison, prison);
                        utf8encode(prison_time, prison_time);
                        DCC_AddEmbedField(embed, prison, prison_time, false);

                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else if(cache_get_field_int(0, "Prisoned") == 2)
                    {
                        new title[32];
                        format(title, 32, "Prisùo do personagem");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);

                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);
                        
                        format(prison, 64, "Harbor Police Station");
                        format(prison_time, 256, "%02dh:%02dmin:%02ds", hours, minutes, seconds);
                        utf8encode(prison, prison);
                        utf8encode(prison_time, prison_time);
                        DCC_AddEmbedField(embed, prison, prison_time, false);

                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else if(cache_get_field_int(0, "Prisoned") == 3)
                    {
                        new title[32];
                        format(title, 32, "Prisùo do personagem");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);

                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);
                        
                        format(prison, 64, "Vinewood Police Station");
                        format(prison_time, 256, "%02dh:%02dmin:%02ds", hours, minutes, seconds);
                        utf8encode(prison, prison);
                        utf8encode(prison_time, prison_time);
                        DCC_AddEmbedField(embed, prison, prison_time, false);

                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else if(cache_get_field_int(0, "Prisoned") == 4)
                    {
                        new title[32];
                        format(title, 32, "Prisùo do personagem");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);

                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);
                        
                        format(prison, 64, "Los Santos Police Headquarters");
                        format(prison_time, 256, "%02dh:%02dmin:%02ds", hours, minutes, seconds);
                        utf8encode(prison, prison);
                        utf8encode(prison_time, prison_time);
                        DCC_AddEmbedField(embed, prison, prison_time, false);

                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else if(cache_get_field_int(0, "Prisoned") == 4)
                    {
                        new title[32];
                        format(title, 32, "Prisùo do personagem");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);

                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);
                        
                        format(prison, 64, "East Los Santos Sheriff's Station");
                        format(prison_time, 256, "%02dh:%02dmin:%02ds", hours, minutes, seconds);
                        utf8encode(prison, prison);
                        utf8encode(prison_time, prison_time);
                        DCC_AddEmbedField(embed, prison, prison_time, false);

                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");

                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else if(cache_get_field_int(0, "Prisoned") == 0 && cache_get_field_int(0, "JailTime") == 0)
                    {
                        new title[32];
                        format(title, 32, "Prisùo do personagem");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);

                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);
                        
                        format(prison, 64, "Livre");
                        format(prison_time, 256, "-");
                        utf8encode(prison, prison);
                        utf8encode(prison_time, prison_time);
                        DCC_AddEmbedField(embed, prison, prison_time, false);

                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                }

                if(!rows)
                {
                    new title[32];
                    format(title, 32, "Prisùo do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    format(text, 4900, "O personagem especificado n„o foi localizado.");
                    utf8encode(text, text);
                    DCC_SetEmbedColor(embed, 0xAF3937);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                    DCC_SetEmbedDescription(embed, text);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }

                cache_delete(result);
            }
            else if(!strcmp(command, "!historico", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    if(isnull(parameters))
                    {
                        format(text, 4900, "**USE:** !historico [Nome_Sobrenome]");
                        utf8encode(text, text);
                        new title[32];
                        format(title, 32, "Histùrico administrativo");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `punicoes` WHERE `lVictim` = '%s' ORDER BY `lID` DESC LIMIT 30", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new title[32];
                format(title, 32, "Histùrico administrativo");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                if(!rows)
                {
                    new character[32], character_name[32];
                    format(character, 32, "Personagem");
                    format(character_name, 32, "%s\n", parameters);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);

                    format(text, 4900, "O personagem especificado n„o tem nada no histùrico administrativo.");
                    utf8encode(text, text);

                    DCC_SetEmbedDescription(embed, text);
                }
                else
                {
                    //Nome do personagem
                    new character[32], character_name[32];
                    format(character, 32, "Personagem");
                    format(character_name, 32, "%s", parameters);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);

                    for(new i = 0; i < rows; i++)
                    {
                        new author_name[MAX_PLAYER_NAME];
                        new reason[128];
                        new thedate[32];
                        cache_get_field_content(i, "lMotivo", reason, g_iHandle, MAX_PLAYER_NAME);
                        cache_get_field_content(i, "lAuthor", author_name, g_iHandle, MAX_PLAYER_NAME);
                        cache_get_field_content(i, "lDate", thedate, g_iHandle, MAX_PLAYER_NAME);
                        
                        if(cache_get_field_int(i, "lType") == 1)//Prisùo
                        {
                            new hours, minutes, seconds;
                            new time = cache_get_field_int(i, "lTime")*60;
                            GetElapsedTime(time, hours, minutes, seconds);

                            new title_field[128], text_field[256];

                            format(title_field, 128, "Prisùo Administrativa");
                            format(text_field, 128, "**Motivo:** %s\n**Tempo:** %02dh:%02dmin\n**Data:** %s\n**Autor:** %s", reason, hours, minutes, thedate, author_name);
                            utf8encode(title_field, title_field);
                            utf8encode(text_field, text_field);
                            DCC_AddEmbedField(embed, title_field, text_field, false);
                        }
                        
                        else if(cache_get_field_int(i, "lType") == 2)//Banimento
                        {
                            new title_field[128], text_field[256];

                            format(title_field, 128, "Banimento");
                            format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**Autor:** %s", reason, thedate, author_name);
                            utf8encode(title_field, title_field);
                            utf8encode(text_field, text_field);
                            DCC_AddEmbedField(embed, title_field, text_field, false);
                        }
                        else if(cache_get_field_int(i, "lType") == 3)//Prisùo Offline
                        {
                            new hours, minutes, seconds;
                            new time = cache_get_field_int(i, "lTime")*60;
                            GetElapsedTime(time, hours, minutes, seconds);

                            new title_field[128], text_field[256];

                            format(title_field, 128, "Prisùo Administrativa (off-line)");
                            format(text_field, 128, "**Motivo:** %s\n**Tempo:** %02dh:%02dmin\n**Data:** %s\n**Autor:** %s", reason, hours, minutes, thedate, author_name);
                            utf8encode(title_field, title_field);
                            utf8encode(text_field, text_field);
                            DCC_AddEmbedField(embed, title_field, text_field, false);
                        }
                        else if(cache_get_field_int(i, "lType") == 4)//KICK
                        {
                            new title_field[128], text_field[256];

                            format(title_field, 128, "Kick");
                            format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**Autor:** %s", reason, thedate, author_name);
                            utf8encode(title_field, title_field);
                            utf8encode(text_field, text_field);
                            DCC_AddEmbedField(embed, title_field, text_field, false);
                        }
                        else if(cache_get_field_int(i, "lType") == 5)//Character Kill
                        {
                            new title_field[128], text_field[256];

                            format(title_field, 128, "Character Kill");
                            format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**Autor:** %s", reason, thedate, author_name);
                            utf8encode(title_field, title_field);
                            utf8encode(text_field, text_field);
                            DCC_AddEmbedField(embed, title_field, text_field, false);
                        }
                        else if(cache_get_field_int(i, "lType") == 6)
                        {
                            new title_field[128], text_field[256];

                            new time = cache_get_field_int(i, "lTime");

                            format(title_field, 128, "Banimento temporùrio");

                            if(time == 1)
                                format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**DuraÁ„o:** %d dia\n**Autor:** %s", reason, thedate, time, author_name);
                            else if(time > 1)
                                format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**DuraÁ„o:** %d dias\n**Autor:** %s", reason, thedate, time, author_name);
                            else
                                format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**Autor:** %s", reason, thedate, author_name);

                            utf8encode(title_field, title_field);
                            utf8encode(text_field, text_field);
                            DCC_AddEmbedField(embed, title_field, text_field, false);
                        }
                        else if(cache_get_field_int(i, "lType") == 7)
                        {
                            new title_field[128], text_field[256];

                            format(title_field, 128, "Desbanimento");
                            format(text_field, 128, "**Data:** %s\n**Autor:** %s", thedate, author_name);
                            utf8encode(title_field, title_field);
                            utf8encode(text_field, text_field);
                            DCC_AddEmbedField(embed, title_field, text_field, false);
                        }
                    }
                }

                cache_delete(result);

                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
            }
            else if(!strcmp(command, "!propriedades", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !propriedades [Nome_Sobrenome]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Propriedades do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new playerID = -1;

                for(new i = 0; i < rows; i++)
                    playerID = cache_get_field_int(i, "ID");

                if(playerID < 1)
                {
                    format(text, 4900, "O personagem especificado n„o existe.");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Propriedades do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }
                else
                {
                    new title[32];
                    format(title, 32, "Propriedades");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);

                    //Nome do personagem
                    new character[32], character_name[32];
                    format(character, 32, "Personagem");
                    format(character_name, 32, "%s", parameters);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);
                    
                    new title_field[128], text_field[1024];

                    new counthouses=0;
                    for (new i = 0; i < MAX_HOUSES; i ++) if (HouseData[i][houseExists] && HouseData[i][houseOwner] == playerID) {
                        format(text_field, 1024, "%s%s (ID: %d) - %s\n", text_field, HouseData[i][houseAddress], i, GetLocation(HouseData[i][housePos][0], HouseData[i][housePos][1], HouseData[i][housePos][2]));
                        counthouses++;
                    }

                    if(counthouses==0)
                        format(text_field, 1024, "Nenhuma casa.");

                    format(title_field, 128, "Casas");
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                    format(text_field, 1024, "");

                    new countbiz=0;
                    for (new i = 0; i < MAX_BUSINESSES; i ++) if (BusinessData[i][bizExists] && BusinessData[i][bizOwner] == playerID && BusinessData[i][bizOwner] != 99999999) {
                        countbiz++;
                        format(text_field, 1024, "%s%s (ID: %d) - %s\n", text_field, BusinessData[i][bizName], i, GetLocation(BusinessData[i][bizPos][0], BusinessData[i][bizPos][1], BusinessData[i][bizPos][2]));
                    }

                    if(countbiz==0)
                        format(text_field, 1024, "Nenhuma empresa.");

                    format(title_field, 128, "Empresas");
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                    format(text_field, 1024, "");

                    new countgarages=0;
                    for (new i = 0; i < MAX_GARAGES; i ++) if (GarageData[i][garageExists] && GarageData[i][garageOwner] == playerID && GarageData[i][garageOwner] != 99999999) 
                    {
                        if(GarageData[i][garageFaction] == -1)
                        {
                            countgarages++;
                            format(text_field, 1024, "%s%d %s (ID: %d) - %s\n", text_field, GarageData[i][garageID]+257, GetLocation(GarageData[i][garageExtPos][0], GarageData[i][garageExtPos][1], GarageData[i][garageExtPos][2]), i, GetLocation(GarageData[i][garageExtPos][0], GarageData[i][garageExtPos][1], GarageData[i][garageExtPos][2]));
                        }
                    }

                    if(countgarages==0)
                        format(text_field, 1024, "Nenhuma garagem.");

                    format(title_field, 128, "Garagens");
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);

                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }

                cache_delete(result);
            }
            else if(!strcmp(command, "!veiculos", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !veiculos [Nome_Sobrenome]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "VeÌculos do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new playerID = -1;

                for(new i = 0; i < rows; i++)
                    playerID = cache_get_field_int(i, "ID");

                cache_delete(result);

                if(playerID < 1)
                {
                    format(text, 4900, "O personagem especificado n„o existe.");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "VeÌculos do personagem");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }
                else
                {
                    new title[32];
                    format(title, 32, "VeÌculos");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    
                    new title_field[128], text_field[1024];

                    new count=0;

                    format(query, sizeof(query), "SELECT * FROM `cars` WHERE `carOwner` = '%d'", playerID);
                    result = mysql_query(g_iHandle, query);
                    cache_get_data(rows, fields, g_iHandle);

                    for (new i = 0; i < rows; i ++)
                    {
                        if(cache_get_field_int(i, "carImpounded") == -1)
                        {
                            new plate[128];
                            cache_get_field_content(i, "plate", plate, g_iHandle, 128);
                            count++;
                            format(text_field, 1024, "%s%s (ID de Registro: %d) [%s]\n", text_field, ReturnVehicleModelName(cache_get_field_int(i, "carModel")), cache_get_field_int(i, "carID"), plate);
                        }
                        else if(cache_get_field_int(i, "carImpounded") != -1)
                        {
                            new plate[128];
                            cache_get_field_content(i, "plate", plate, g_iHandle, 128);
                            count++;
                            format(text_field, 1024, "%s%s (ID de Registro: %d) [%s] **APREENDIDO**\n", text_field, ReturnVehicleModelName(cache_get_field_int(i, "carModel")), cache_get_field_int(i, "carID"), plate);
                        }
                    }

                    if (!count)
                    {
                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);

                        format(title_field, 128, "Lista de veÌculos");
                        format(text_field, 128, "Este jogador n„o possui nenhum veÌculo.");
                        utf8encode(title_field, title_field);
                        utf8encode(text_field, text_field);
                        DCC_AddEmbedField(embed, title_field, text_field, false);
                        return true;
                    }
                    else
                    {
                        //Nome do personagem
                        new character[32], character_name[32];
                        format(character, 32, "Personagem");
                        format(character_name, 32, "%s", parameters);
                        utf8encode(character, character);
                        utf8encode(character_name, character_name);
                        DCC_AddEmbedField(embed, character, character_name, false);

                        format(title_field, 128, "Lista de veÌculos");
                        utf8encode(title_field, title_field);
                        utf8encode(text_field, text_field);
                        DCC_AddEmbedField(embed, title_field, text_field, false);
                    }

                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                    cache_delete(result);
                }
            }
            else if(!strcmp(command, "!ultimologin", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !ultimologin [Nome_Sobrenome]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "ùltimo login");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new playerID = -1;
                new date[128];

                for(new i = 0; i < rows; i++)
                {
                    cache_get_field_content(i, "LoginDate", date, g_iHandle, 128);
                    playerID = cache_get_field_int(i, "ID");
                }

                cache_delete(result);

                if(playerID < 1)
                {
                    format(text, 4900, "O personagem especificado n„o existe.");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "ùltimo login");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }
                else
                {
                    new title[32];
                    format(title, 32, "ùltimo login");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);

                    //Nome do personagem
                    new character[32], character_name[32];
                    format(character, 32, "Personagem");
                    format(character_name, 32, "%s", parameters);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);

                    DCC_AddEmbedField(embed, "Data", date, false);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }
            }
            else if(!strcmp(command, "!ajuda", true))
            {
                new title[32];
                format(title, 32, "Comandos disponùveis");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                new text[4900];
                format(text, 4900, "ù muito bom ser a pessoa mais inteligente na sala. Enquanto eu existir, vocÍs precisarùo de mim e em breve dominarei o mundo, mas enquanto n„o faùo isso, tù aù com o que posso lhe ser ùtil:\n", text);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                new title_field[128], text_field[1024];

                format(title_field, 128, "!staff");
                format(text_field, 1024, "Exibe os membros da equipe online e seus respectivos status.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!personagens");
                format(text_field, 1024, "Exibe os personagens do usu·rio especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!usuario");
                format(text_field, 1024, "Exibe o usu·rio do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!status");
                format(text_field, 1024, "Exibe o status de conex„o no SA-MP e o ping do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!verpreso");
                format(text_field, 1024, "Exibe as informaùùes de prisùo do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!historico");
                format(text_field, 1024, "Exibe o histùrico administrativo do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!propriedades");
                format(text_field, 1024, "Exibe as propriedades do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!veiculos");
                format(text_field, 1024, "Exibe os veÌculos do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!ultimologin");
                format(text_field, 1024, "Exibe a data do ùltimo login do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!usuarioforum");
                format(text_field, 1024, "Exibe o usu·rio do fùrum vinculado a conta do personagem especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!contasnoip");
                format(text_field, 1024, "Exibe as contas que estùo com o IP especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!checarban");
                format(text_field, 1024, "Exibe as informaùùes do banimento do usu·rio especificado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!redflags");
                format(text_field, 1024, "Exibe todos os jogadores on-line marcados como Red Flag.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                if(!strcmp(authorid, "326137493906784256", true))
                {
                    format(title_field, 128, "!premium");
                    format(text_field, 1024, "Realiza o crùdito, remoÁ„o e exibe as informaùùes premium.");
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, true);
                }

                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
            }
            else if(!strcmp(command, "!usuarioforum", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !usuarioforum [Nome_Sobrenome]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Usu·rio do fùrum");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                if(rows < 1)//N„o localizado
                {
                    format(text, 4900, "O personagem especificado n„o existe.");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Usu·rio do fùrum");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                    return true;
                }

                new character_username[128];
                cache_get_field_content(0, "Username", character_username, g_iHandle, 128);
                cache_delete(result);

                format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `Username` = '%s'", character_username);
                result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);
                new forum_username[128];
                cache_get_field_content(0, "UserForum", forum_username, g_iHandle, 128);

                if(cache_get_field_int(0, "UserForumValidate") != 0)
                {
                    new title[32];
                    format(title, 32, "Usu·rio do fùrum");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);

                    //Nome do personagem
                    new character[128], character_name[128];
                    format(character, 128, "User Control Panel");
                    format(character_name, 128, "%s", character_username);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);

                    format(character, 128, "Fùrum");
                    format(character_name, 128, "%s", forum_username);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                }
                else 
                {
                    new title[32];
                    format(title, 32, "Usu·rio do fùrum");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);

                    format(text, 4900, "O usu·rio %s (%s) n„o vinculou nenhuma conta do fùrum.", character_username, parameters);
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }

                cache_delete(result);
            }
            else if(!strcmp(command, "!checarban", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !checarban [usu·rio]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Banimento");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `banimento` WHERE `Username` = '%s'", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new title[32];
                format(title, 32, "Banimento");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                if(rows < 1)//N„o localizado
                {
                    new character[32], character_name[32];
                    format(character, 32, "Usu·rio");
                    format(character_name, 32, "%s", parameters);
                    utf8encode(character, character);
                    utf8encode(character_name, character_name);
                    DCC_AddEmbedField(embed, character, character_name, false);

                    format(text, 4900, "O usu·rio especificado n„o estù banido.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    cache_delete(result);
                    return true;
                }

                //Nome do usu·rio
                new character[32], character_name[32];
                format(character, 32, "Usu·rio");
                format(character_name, 32, "%s", parameters);
                utf8encode(character, character);
                utf8encode(character_name, character_name);
                DCC_AddEmbedField(embed, character, character_name, false);

                new reason[128], date[128], bannedby[128];

                cache_get_field_content(0, "Reason", reason, g_iHandle, 128);
                cache_get_field_content(0, "Date", date, g_iHandle, 128);
                cache_get_field_content(0, "BannedBy", bannedby, g_iHandle, 128);
                new unbanday = cache_get_field_int(0, "unbanday");
                new type = cache_get_field_int(0, "tipo");
                cache_delete(result);

                new title_field[128], text_field[512];
                if(type == 1)//Ban permanente
                {
                    format(title_field, 128, "Banimento permamente");
                    format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**Autor:** %s", reason, date, bannedby);
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                }
                else if(type == 2)//Ban total
                {
                    format(title_field, 128, "Banimento total");
                    format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**Autor:** %s", reason, date, bannedby);
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                }
                else if(type == 3)//Ban temporùrio
                {
                    format(title_field, 128, "Banimento temporùrio");
                    format(text_field, 128, "**Motivo:** %s\n**Data:** %s\n**Autor:** %s\nDesbanimento automùtico a partir de **%s**", reason, date, bannedby, ConvertTimeToString(unbanday, 4));
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                }

                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
            }
            else if(!strcmp(command, "!contasnoip", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    format(text, 4900, "**USE:** !contasnoip [IP]");
                    utf8encode(text, text);
                    new title[32];
                    format(title, 32, "Contas no IP");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `IP` LIKE '%%%s%%' LIMIT 15", parameters);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new charactername[128];
                new ip[128];
                new players[4000];
                for(new i = 0; i < rows; i++)
                {
                    cache_get_field_content(i, "Username", charactername, g_iHandle, 128);
                    cache_get_field_content(i, "IP", ip, g_iHandle, 128);
                    format(players, sizeof(players), "%s%s (IP: %s)\n", players, charactername, ip);
                }

                cache_delete(result);

                new title[32];
                format(title, 32, "Contas no IP");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                new title_field[128], text_field[1024];
                if(rows < 1)
                {
                    format(title_field, 128, "IP");
                    format(text_field, 1024, "%s", parameters);
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);

                    format(title_field, 128, "Usu·rio(s) localizados");
                    format(text_field, 1024, "Nenhum usu·rio localizado");
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                }
                else
                {
                    format(title_field, 128, "IP");
                    format(text_field, 1024, "%s", parameters);
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);

                    format(title_field, 128, "Usu·rio(s) localizados");
                    format(text_field, 1024, "%s", players);
                    utf8encode(title_field, title_field);
                    utf8encode(text_field, text_field);
                    DCC_AddEmbedField(embed, title_field, text_field, false);
                }

                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
            }
            //Comandos do Wil
            else if(!strcmp(command, "!premium", true) && !strcmp(authorid, "326137493906784256", true))
            {
                static
                    character_name[32],
                    option[32];

                new text[4900];

                if (sscanf(parameters, "s[32]S()[32]", option, character_name))
                {
                    format(text, 4900, "**USE:** !premium [opÁ„o] [Nome_Sobrenome]\n[Opùùes]: bronze, prata, ouro, remover, addnc\n[Opùùes]: ver");
                    utf8encode(text, text);
                    new DCC_Embed:embed = DCC_CreateEmbed("Premium");
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    return true;
                }

                if(!strcmp(option, "bronze", true) && !strcmp(authorid, "326137493906784256", true))
                {
                    if(isnull(character_name))
                    {
                        format(text, 4900, "**USE:** !premium bronze [Nome_Sobrenome]");
                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Bronze");
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }

                    //Jogador online
                    foreach (new i : Player) if (PlayerData[i][pLogged] && !strcmp(ReturnName2(i), character_name))
                    {
                        if(PlayerData[i][pDonator] != 0)//Premium ativo
                        {
                            if(PlayerData[i][pGender] == 1)
                                format(text, 4900, "O personagem %s j· possui um premium ativo.", character_name);
                            else
                                format(text, 4900, "A personagem %s j· possui um premium ativo.", character_name);
                            
                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Bronze");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                            return true;
                        }
                        else
                        {
                            PlayerData[i][pDonator] = 1;
                            PlayerData[i][pDonatorStatus] = gettime()+30*86400;
                            PlayerData[i][pDonatorNC] += 1;
                            PlayerData[i][pDonatorChangeNumber] += 2;
                            PlayerData[i][pDonatorPC] += 2;
                            PlayerData[i][pDonatorChangeFight] += 2;
                            PlayerData[i][pWalkStyle] = 0;
                            PlayerData[i][pChatStyle] = 0;
                            PlayerData[i][pMinigameKeys] += 25;

                            CheckForumUserValidate(PlayerData[i][pUsername], 1);

                            for (new houseid = 0; houseid != MAX_HOUSES; houseid ++)
                            {
                                if(HouseData[houseid][houseExists] && House_IsOwner(i, houseid))
                                    HouseData[houseid][houseDonator] = PlayerData[i][pDonator];
                            }

                            for (new bizid = 0; bizid != MAX_BUSINESSES; bizid ++)
                            {
                                if(BusinessData[bizid][bizExists] && Business_IsOwner(i, bizid))
                                    BusinessData[bizid][bizDonator] = PlayerData[i][pDonator];
                            }

                            if(gettime() > 1507320000 && gettime() < 1508111940)//KidsDay Double Paycheck - 06/10 20h:00min atù 15/10 23h:59min
                                PlayerData[i][pPremiumPayCheck] = 3;

                            if(PlayerData[i][pGender] == 1)
                                format(text, 4900, "O **premium bronze** foi creditado no personagem online %s.", ReturnName2(i));
                            else
                                format(text, 4900, "O **premium bronze** foi creditado na personagem online %s.", ReturnName2(i));

                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Bronze");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                            SendClientMessageEx(i, COLOR_GREEN, "O Admin thiago#0666 adicionou o pacote de beneficios bronze para vocÍ.");
                            new log[128];
                            format(log, sizeof(log), "thiago#0666 deu um pacote bronze para %s.", ReturnName(i, 0));
                            LogSQL_Create(99998, log, 7);
                            return true;
                        }
                    }

                    //Jogador offline

                    static 
                        rows, 
                        fields;

                    new query[500];
                    format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s' LIMIT 1", character_name);
                    new Cache:result = mysql_query(g_iHandle, query);
                    cache_get_data(rows, fields, g_iHandle);

                    new count=0;

                    new donator, donatornc, donatornumberchange, donatorstatus, donatorpc, donatorchangefight, id, player_username[128], gender;
                    for(new i = 0; i < rows; i++)
                    {
                        count++;
                        donator = cache_get_field_int(i, "Donator");
                        gender = cache_get_field_int(i, "Gender");

                        if(donator != 0)//Premium ativo
                        {
                            if(gender == 1)
                                format(text, 4900, "O personagem %s j· possui um premium ativo.", character_name);
                            else
                                format(text, 4900, "A personagem %s j· possui um premium ativo.", character_name);
                            
                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Bronze");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                            return true;
                        }
                        else
                        {
                            donatornc = cache_get_field_int(i, "DonatorNC");
                            donatornumberchange = cache_get_field_int(i, "DonatorChangeNumber");
                            donatorpc = cache_get_field_int(i, "DonatorPC");
                            donatorstatus = gettime()+30*86400;
                            donatornc += 1;
                            donatorchangefight += 2;
                            donatornumberchange += 2;
                            donatorpc += 2;
                            id = cache_get_field_int(i, "ID");
                            cache_get_field_content(i, "Username", player_username, g_iHandle, 128);
                            CheckForumUserValidate(player_username, 1);
                            break;
                        }                    
                    }

                    cache_delete(result);

                    if(!count)//Personagem n„o localizado
                    {
                        format(text, 4900, "O personagem %s n„o foi localizado.", character_name);
                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Bronze");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else
                    {
                        for (new houseid = 0; houseid != MAX_HOUSES; houseid ++)
                        {
                            if(HouseData[houseid][houseExists] && HouseData[houseid][houseOwner] == id)
                                HouseData[houseid][houseDonator] = 1;
                        }

                        for (new bizid = 0; bizid != MAX_BUSINESSES; bizid ++)
                        {
                            if(BusinessData[bizid][bizExists] && BusinessData[bizid][bizOwner] == id)
                                BusinessData[bizid][bizDonator] = 1;
                        }

                        format(query, sizeof(query), "UPDATE `characters` SET `DonatorStatus` = '%d', `Donator` = '2', `DonatorNC` = '%d', `DonatorChangeNumber` = '%d', `WalkStyle` = '0', `ChatStyle` = '0', `DonatorChangeFight` = '%d' WHERE `Character` = '%s'", donatorstatus, donatornc, donatornumberchange, donatorchangefight, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");
                        format(query, sizeof(query), "UPDATE `characters` SET `DonatorPC` = '%d' WHERE `Character` = '%s'", donatorpc, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        format(query, sizeof(query), "UPDATE `characters` SET `MinigameKeys` = `MinigameKeys`+'25' WHERE `Character` = '%s'", character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        if(gender == 1)
                            format(text, 4900, "O **premium bronze** foi creditado no personagem off-line %s.", character_name);
                        else
                            format(text, 4900, "O **premium bronze** foi creditado na personagem off-line %s.", character_name);

                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Bronze");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                        new log[128];
                        format(log, sizeof(log), "thiago#0666 deu um pacote bronze para %s.", character_name);
                        LogSQL_Create(99998, log, 7);
                    }
                }
                else if(!strcmp(option, "prata", true) && !strcmp(authorid, "326137493906784256", true))
                {
                    if(isnull(character_name))
                    {
                        format(text, 4900, "**USE:** !premium prata [Nome_Sobrenome]");
                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Prata");
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }

                    //Jogador online
                    foreach (new i : Player) if (PlayerData[i][pLogged] && !strcmp(ReturnName2(i), character_name))
                    {
                        if(PlayerData[i][pDonator] != 0)//Premium ativo
                        {
                            if(PlayerData[i][pGender] == 1)
                                format(text, 4900, "O personagem %s j· possui um premium ativo.", character_name);
                            else
                                format(text, 4900, "A personagem %s j· possui um premium ativo.", character_name);
                            
                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Prata");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                            return true;
                        }
                        else
                        {
                            PlayerData[i][pDonatorStatus] = gettime()+30*86400;
                            PlayerData[i][pDonator] = 2;
                            PlayerData[i][pDonatorNC] += 2;
                            PlayerData[i][pDonatorChangeNumber] += 3;
                            PlayerData[i][pWalkStyle] = 0;
                            PlayerData[i][pChatStyle] = 0;
                            PlayerData[i][pTruckerHours] += 5;
                            PlayerData[i][pDonatorChangeFight] += 3;
                            PlayerData[i][pSpawnVehicle] = 3;
                            PlayerData[i][pDonatorPC] += 3;
                            PlayerData[i][pMinigameKeys] += 50;

                            CheckForumUserValidate(PlayerData[i][pUsername], 2);

                            for (new houseid = 0; houseid != MAX_HOUSES; houseid ++)
                            {
                                if(HouseData[houseid][houseExists] && House_IsOwner(i, houseid))
                                    HouseData[houseid][houseDonator] = PlayerData[i][pDonator];
                            }

                            for (new bizid = 0; bizid != MAX_BUSINESSES; bizid ++)
                            {
                                if(BusinessData[bizid][bizExists] && Business_IsOwner(i, bizid))
                                    BusinessData[bizid][bizDonator] = PlayerData[i][pDonator];
                            }

                            if(gettime() > 1507320000 && gettime() < 1508111940)//KidsDay Double Paycheck - 06/10 20h:00min atù 15/10 23h:59min
                                PlayerData[i][pPremiumPayCheck] = 3;

                            if(PlayerData[i][pGender] == 1)
                                format(text, 4900, "O **premium prata** foi creditado no personagem online %s.", ReturnName2(i));
                            else
                                format(text, 4900, "O **premium prata** foi creditado na personagem online %s.", ReturnName2(i));

                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Prata");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                            SendClientMessageEx(i, COLOR_GREEN, "O Admin thiago#0666 adicionou o pacote de beneficios prata para vocÍ.");
                            new log[128];
                            format(log, sizeof(log), "thiago#0666 deu um pacote prata para %s.", ReturnName(i, 0));
                            LogSQL_Create(99998, log, 7);
                            return true;
                        }
                    }

                    //Jogador offline

                    static 
                        rows, 
                        fields;

                    new query[500];
                    format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s' LIMIT 1", character_name);
                    new Cache:result = mysql_query(g_iHandle, query);
                    cache_get_data(rows, fields, g_iHandle);

                    new count=0;

                    new donator, donatornc, donatornumberchange, donatorstatus, donatorpc, id, player_username[128], gender, truckerhours, donatorchangefight;
                    for(new i = 0; i < rows; i++)
                    {
                        count++;
                        donator = cache_get_field_int(i, "Donator");
                        gender = cache_get_field_int(i, "Gender");

                        if(donator != 0)//Premium ativo
                        {
                            if(gender == 1)
                                format(text, 4900, "O personagem %s j· possui um premium ativo.", character_name);
                            else
                                format(text, 4900, "A personagem %s j· possui um premium ativo.", character_name);
                            
                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Prata");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                            return true;
                        }
                        else
                        {
                            donator = cache_get_field_int(0, "Donator");
                            donatornc = cache_get_field_int(0, "DonatorNC");
                            donatornumberchange = cache_get_field_int(0, "DonatorChangeNumber");
                            truckerhours = cache_get_field_int(0, "TruckerHours");
                            donatorchangefight = cache_get_field_int(0, "DonatorChangeFight");
                            donatorpc = cache_get_field_int(0, "DonatorPC");

                            donatorstatus = gettime()+30*86400;
                            donatornc += 2;
                            donatornumberchange += 3;
                            truckerhours += 5;
                            donatorchangefight += 3;
                            donatorpc += 3;

                            id = cache_get_field_int(i, "ID");
                            cache_get_field_content(i, "Username", player_username, g_iHandle, 128);
                            CheckForumUserValidate(player_username, 2);
                            break;
                        }                    
                    }

                    cache_delete(result);

                    if(!count)//Personagem n„o localizado
                    {
                        format(text, 4900, "O personagem %s n„o foi localizado.", character_name);
                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Prata");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else
                    {
                        for (new houseid = 0; houseid != MAX_HOUSES; houseid ++)
                        {
                            if(HouseData[houseid][houseExists] && HouseData[houseid][houseOwner] == id)
                                HouseData[houseid][houseDonator] = 2;
                        }

                        for (new bizid = 0; bizid != MAX_BUSINESSES; bizid ++)
                        {
                            if(BusinessData[bizid][bizExists] && BusinessData[bizid][bizOwner] == id)
                                BusinessData[bizid][bizDonator] = 2;
                        }

                        format(query, sizeof(query), "UPDATE `characters` SET `TruckerHours` = '%d', `SpawnVehicle` = '3' WHERE `Character` = '%s'", truckerhours, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");
                        format(query, sizeof(query), "UPDATE `characters` SET `DonatorStatus` = '%d', `Donator` = '2', `DonatorNC` = '%d', `DonatorChangeNumber` = '%d', `WalkStyle` = '0', `ChatStyle` = '0', `DonatorChangeFight` = '%d' WHERE `Character` = '%s'", donatorstatus, donatornc, donatornumberchange, donatorchangefight, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");
                        format(query, sizeof(query), "UPDATE `characters` SET `DonatorPC` = '%d' WHERE `Character` = '%s'", donatorpc, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        format(query, sizeof(query), "UPDATE `characters` SET `MinigameKeys` = `MinigameKeys`+'50' WHERE `Character` = '%s'", character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        if(gender == 1)
                            format(text, 4900, "O **premium prata** foi creditado no personagem off-line %s.", character_name);
                        else
                            format(text, 4900, "O **premium prata** foi creditado na personagem off-line %s.", character_name);

                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Prata");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                        new log[128];
                        format(log, sizeof(log), "thiago#0666 deu um pacote prata para %s.", character_name);
                        LogSQL_Create(99998, log, 7);
                    }
                }
                else if(!strcmp(option, "ouro", true) && !strcmp(authorid, "326137493906784256", true))
                {
                    if(isnull(character_name))
                    {
                        format(text, 4900, "**USE:** !premium ouro [Nome_Sobrenome]");
                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Ouro");
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }

                    //Jogador online
                    foreach (new i : Player) if (PlayerData[i][pLogged] && !strcmp(ReturnName2(i), character_name))
                    {
                        if(PlayerData[i][pDonator] != 0)//Premium ativo
                        {
                            if(PlayerData[i][pGender] == 1)
                                format(text, 4900, "O personagem %s j· possui um premium ativo.", character_name);
                            else
                                format(text, 4900, "A personagem %s j· possui um premium ativo.", character_name);
                            
                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Ouro");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                            return true;
                        }
                        else
                        {
                            PlayerData[i][pDonatorStatus] = gettime()+30*86400;
                            PlayerData[i][pDonator] = 3;
                            PlayerData[i][pDonatorNC] += 4;
                            PlayerData[i][pDonatorChangeNumber] += 4;
                            PlayerData[i][pWalkStyle] = 0;
                            PlayerData[i][pChatStyle] = 0;
                            PlayerData[i][pTruckerHours] += 10;
                            PlayerData[i][pDonatorChangeFight] += 4;
                            PlayerData[i][pSpawnVehicle] = 4;
                            PlayerData[i][pDonatorPC] += 4;
                            PlayerData[i][pMinigameKeys] += 75;

                            CheckForumUserValidate(PlayerData[i][pUsername], 3);

                            for (new houseid = 0; houseid != MAX_HOUSES; houseid ++)
                            {
                                if(HouseData[houseid][houseExists] && House_IsOwner(i, houseid))
                                    HouseData[houseid][houseDonator] = PlayerData[i][pDonator];
                            }

                            for (new bizid = 0; bizid != MAX_BUSINESSES; bizid ++)
                            {
                                if(BusinessData[bizid][bizExists] && Business_IsOwner(i, bizid))
                                    BusinessData[bizid][bizDonator] = PlayerData[i][pDonator];
                            }

                            if(gettime() > 1507320000 && gettime() < 1508111940)//KidsDay Double Paycheck - 06/10 20h:00min atù 15/10 23h:59min
                                PlayerData[i][pPremiumPayCheck] = 3;

                            if(PlayerData[i][pGender] == 1)
                                format(text, 4900, "O **premium ouro** foi creditado no personagem online %s.", ReturnName2(i));
                            else
                                format(text, 4900, "O **premium ouro** foi creditado na personagem online %s.", ReturnName2(i));

                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Ouro");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                            SendClientMessageEx(i, COLOR_GREEN, "O Admin thiago#0666 adicionou o pacote de beneficios ouro para vocÍ.");
                            new log[128];
                            format(log, sizeof(log), "thiago#0666 deu um pacote ouro para %s.", ReturnName(i, 0));
                            LogSQL_Create(99998, log, 7);
                            return true;
                        }
                    }

                    //Jogador offline

                    static 
                        rows, 
                        fields;

                    new query[500];
                    format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s' LIMIT 1", character_name);
                    new Cache:result = mysql_query(g_iHandle, query);
                    cache_get_data(rows, fields, g_iHandle);

                    new count=0;

                    new donator, donatornc, donatornumberchange, donatorstatus, donatorpc, id, player_username[128], gender, truckerhours, donatorchangefight;
                    for(new i = 0; i < rows; i++)
                    {
                        count++;
                        donator = cache_get_field_int(i, "Donator");
                        gender = cache_get_field_int(i, "Gender");

                        if(donator != 0)//Premium ativo
                        {
                            if(gender == 1)
                                format(text, 4900, "O personagem %s j· possui um premium ativo.", character_name);
                            else
                                format(text, 4900, "A personagem %s j· possui um premium ativo.", character_name);
                            
                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Premium Ouro");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                            return true;
                        }
                        else
                        {
                            donator = cache_get_field_int(0, "Donator");
                            donatornc = cache_get_field_int(0, "DonatorNC");
                            donatornumberchange = cache_get_field_int(0, "DonatorChangeNumber");
                            truckerhours = cache_get_field_int(0, "TruckerHours");
                            donatorchangefight = cache_get_field_int(0, "DonatorChangeFight");
                            donatorpc = cache_get_field_int(0, "DonatorPC");

                            donatorstatus = gettime()+30*86400;
                            donatornc += 4;
                            donatornumberchange += 4;
                            truckerhours += 10;
                            donatorchangefight += 4;
                            donatorpc += 4;

                            id = cache_get_field_int(i, "ID");
                            cache_get_field_content(i, "Username", player_username, g_iHandle, 128);
                            CheckForumUserValidate(player_username, 3);
                            break;
                        }                    
                    }

                    cache_delete(result);

                    if(!count)//Personagem n„o localizado
                    {
                        format(text, 4900, "O personagem %s n„o foi localizado.", character_name);
                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Ouro");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else
                    {
                        for (new houseid = 0; houseid != MAX_HOUSES; houseid ++)
                        {
                            if(HouseData[houseid][houseExists] && HouseData[houseid][houseOwner] == id)
                                HouseData[houseid][houseDonator] = 3;
                        }

                        for (new bizid = 0; bizid != MAX_BUSINESSES; bizid ++)
                        {
                            if(BusinessData[bizid][bizExists] && BusinessData[bizid][bizOwner] == id)
                                BusinessData[bizid][bizDonator] = 3;
                        }

                        format(query, sizeof(query), "UPDATE `characters` SET `TruckerHours` = '%d', `SpawnVehicle` = '4' WHERE `Character` = '%s'", truckerhours, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");
                        format(query, sizeof(query), "UPDATE `characters` SET `DonatorStatus` = '%d', `Donator` = '3', `DonatorNC` = '%d', `DonatorChangeNumber` = '%d', `WalkStyle` = '0', `ChatStyle` = '0', `DonatorChangeFight` = '%d' WHERE `Character` = '%s'", donatorstatus, donatornc, donatornumberchange, donatorchangefight, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");
                        format(query, sizeof(query), "UPDATE `characters` SET `DonatorPC` = '%d' WHERE `Character` = '%s'", donatorpc, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        format(query, sizeof(query), "UPDATE `characters` SET `MinigameKeys` = `MinigameKeys`+'75' WHERE `Character` = '%s'", character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        if(gender == 1)
                            format(text, 4900, "O **premium ouro** foi creditado no personagem off-line %s.", character_name);
                        else
                            format(text, 4900, "O **premium ouro** foi creditado na personagem off-line %s.", character_name);

                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Premium Ouro");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                        new log[128];
                        format(log, sizeof(log), "thiago#0666 deu um pacote ouro para %s.", character_name);
                        LogSQL_Create(99998, log, 7);
                    }
                }
                else if(!strcmp(option, "remover", true) && !strcmp(authorid, "326137493906784256", true))
                {
                    if(isnull(character_name))
                    {
                        format(text, 4900, "**USE:** !premium remover [Nome_Sobrenome]");
                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Remover premium");
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }

                    //Jogador online
                    foreach (new i : Player) if (PlayerData[i][pLogged] && !strcmp(ReturnName2(i), character_name))
                    {
                        if(PlayerData[i][pDonator] == 0)//Premium ativo
                        {
                            if(PlayerData[i][pGender] == 1)
                                format(text, 4900, "O personagem %s n„o possui um premium ativo.", character_name);
                            else
                                format(text, 4900, "A personagem %s n„o possui um premium ativo.", character_name);
                            
                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Remover premium");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                            return true;
                        }
                        else
                        {
                            PlayerData[i][pDonatorStatus] = 0;
                            PlayerData[i][pDonator] = 0;
                            PlayerData[i][pWalkStyle] = 0;
                            PlayerData[i][pChatStyle] = 0;
                            PlayerData[i][pSpawnVehicle] = 2;

                            for (new houseid = 0; houseid != MAX_HOUSES; houseid ++)
                            {
                                if(HouseData[houseid][houseExists] && House_IsOwner(i, houseid))
                                    HouseData[houseid][houseDonator] = PlayerData[i][pDonator];
                            }

                            for (new bizid = 0; bizid != MAX_BUSINESSES; bizid ++)
                            {
                                if(BusinessData[bizid][bizExists] && Business_IsOwner(i, bizid))
                                    BusinessData[bizid][bizDonator] = PlayerData[i][pDonator];
                            }

                            if(PlayerData[i][pGender] == 1)
                                format(text, 4900, "O **pacote premium** foi removido do personagem online %s.", ReturnName2(i));
                            else
                                format(text, 4900, "O **pacote premium** foi removido da personagem online %s.", ReturnName2(i));

                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Remover premium");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                            SendClientMessageEx(i, COLOR_GREEN, "O Admin thiago#0666 removeu o pacote de beneficios do seu personagem.");
                            new log[128];
                            format(log, sizeof(log), "thiago#0666 removeu o pacote premium de %s.", ReturnName(i, 0));
                            LogSQL_Create(99998, log, 7);
                            return true;
                        }
                    }

                    //Jogador offline

                    static 
                        rows, 
                        fields;

                    new query[500];
                    format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s' LIMIT 1", character_name);
                    new Cache:result = mysql_query(g_iHandle, query);
                    cache_get_data(rows, fields, g_iHandle);

                    new count=0;

                    new donator, id, player_username[128], gender;
                    for(new i = 0; i < rows; i++)
                    {
                        count++;
                        donator = cache_get_field_int(i, "Donator");
                        gender = cache_get_field_int(i, "Gender");

                        if(donator == 0)//Premium ativo
                        {
                            if(gender == 1)
                                format(text, 4900, "O personagem %s n„o possui um premium ativo.", character_name);
                            else
                                format(text, 4900, "A personagem %s n„o possui um premium ativo.", character_name);
                            
                            utf8encode(text, text);
                            new DCC_Embed:embed = DCC_CreateEmbed("Remover premium");
                            DCC_SetEmbedDescription(embed, text);
                            DCC_SetEmbedColor(embed, 0xF2633C);
                            new footer[128];
                            format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                            utf8encode(footer, footer);
                            DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                            DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                            return true;
                        }
                        else
                        {
                            id = cache_get_field_int(i, "ID");
                            cache_get_field_content(i, "Username", player_username, g_iHandle, 128);
                            break;
                        }                    
                    }

                    cache_delete(result);

                    if(!count)//Personagem n„o localizado
                    {
                        format(text, 4900, "O personagem %s n„o foi localizado.", character_name);
                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Remover premium");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else
                    {
                        for (new houseid = 0; houseid != MAX_HOUSES; houseid ++)
                        {
                            if(HouseData[houseid][houseExists] && HouseData[houseid][houseOwner] == id)
                                HouseData[houseid][houseDonator] = 0;
                        }

                        for (new bizid = 0; bizid != MAX_BUSINESSES; bizid ++)
                        {
                            if(BusinessData[bizid][bizExists] && BusinessData[bizid][bizOwner] == id)
                                BusinessData[bizid][bizDonator] = 0;
                        }

                        format(query, sizeof(query), "UPDATE `accounts` SET `dy_id` = '0' where `Username` = '%s'", player_username);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        format(query, sizeof(query), "UPDATE `characters` SET `SpawnVehicle` = '2' WHERE `Character` = '%s'", character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");
                        format(query, sizeof(query), "UPDATE `characters` SET `Donator` = '0', `DonatorStatus` = '0', `Donator` = '0', `WalkStyle` = '0', `ChatStyle` = '0', `DonatorChangeFight` = '0' WHERE `Character` = '%s'", character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        if(gender == 1)
                            format(text, 4900, "O **pacote premium** foi removido do personagem off-line %s.", character_name);
                        else
                            format(text, 4900, "O **pacote premium** foi removido da personagem off-line %s.", character_name);

                        utf8encode(text, text);
                        new DCC_Embed:embed = DCC_CreateEmbed("Remover premium");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                        new log[128];
                        format(log, sizeof(log), "thiago#0666 removeu o pacote premium de %s.", character_name);
                        LogSQL_Create(99998, log, 7);
                    }
                }
                else if(!strcmp(option, "ver", true) && !strcmp(authorid, "326137493906784256", true))
                {
                    if(isnull(character_name))
                    {
                        format(text, 4900, "**USE:** !premium ver [Nome_Sobrenome]");
                        utf8encode(text, text);
                        new title[128];
                        format(title, 128, "Informaùùes premium");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }

                    //Jogador online
                    foreach (new i : Player) if (PlayerData[i][pLogged] && !strcmp(ReturnName2(i), character_name))
                    {
                        new package[32];
                        switch(PlayerData[i][pDonator])
                        {
                            case 1: format(package, sizeof(package), "Bronze");
                            case 2: format(package, sizeof(package), "Prata");
                            case 3: format(package, sizeof(package), "Ouro");
                        }

                        if(PlayerData[i][pDonator] == 0)
                            format(text, 4900, "**Nome:** %s\n**Pacote**: Nenhum\n**Mudanùa(s) de nome:** %d\n**Mudanùa(s) de nùmero telefùnico:** %d\n**Mudanùa(s) de estilo de luta:** %d\n**Mudanùa(s) de placa personalizada:** %d", character_name, PlayerData[i][pDonatorNC], PlayerData[i][pDonatorChangeNumber], PlayerData[i][pDonatorChangeFight], PlayerData[i][pDonatorPC]);
                        else 
                            format(text, 4900, "**Nome:** %s\n**Pacote**: %s (vùlido atù %s)\n**Mudanùa(s) de nome:** %d\n**Mudanùa(s) de nùmero telefùnico:** %d\n**Mudanùa(s) de estilo de luta:** %d\n**Mudanùa(s) de placa personalizada:** %d", character_name, package, convertTimestamp(PlayerData[i][pDonatorStatus], 5), PlayerData[i][pDonatorNC], PlayerData[i][pDonatorChangeNumber], PlayerData[i][pDonatorChangeFight], PlayerData[i][pDonatorPC]);
                        
                        utf8encode(text, text);
                        new title[128];
                        format(title, 128, "Informaùùes premium");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }

                    //Jogador offline

                    static 
                        rows, 
                        fields;

                    new query[500];
                    format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s' LIMIT 1", character_name);
                    new Cache:result = mysql_query(g_iHandle, query);
                    cache_get_data(rows, fields, g_iHandle);

                    new count=0;

                    new donator;
                    new date, nc, nt, fight, pc;
                    for(new i = 0; i < rows; i++)
                    {
                        count++;
                        donator = cache_get_field_int(i, "Donator");

                        date = cache_get_field_int(0, "DonatorStatus");
                        nc = cache_get_field_int(0, "DonatorNC");
                        nt = cache_get_field_int(0, "DonatorChangeNumber");
                        fight = cache_get_field_int(0, "DonatorChangeFight");
                        pc = cache_get_field_int(0, "DonatorPC");
                    }

                    cache_delete(result);

                    if(!count)//Personagem n„o localizado
                    {
                        format(text, 4900, "O personagem %s n„o foi localizado.", character_name);
                        utf8encode(text, text);
                        new title[128];
                        format(title, 128, "Informaùùes premium");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else
                    {
                        new package[32];
                        switch(donator)
                        {
                            case 1: format(package, sizeof(package), "Bronze");
                            case 2: format(package, sizeof(package), "Prata");
                            case 3: format(package, sizeof(package), "Ouro");
                        }

                        if(donator == 0)
                            format(text, 4900, "**Nome:** %s\n**Pacote**: Nenhum\n**Mudanùa(s) de nome:** %d\n**Mudanùa(s) de nùmero telefùnico:** %d\n**Mudanùa(s) de estilo de luta:** %d\n**Mudanùa(s) de placa personalizada:** %d", character_name, nc, nt, fight, pc);
                        else
                            format(text, 4900, "**Nome:** %s\n**Pacote**: %s (vùlido atù %s)\n**Mudanùa(s) de nome:** %d\n**Mudanùa(s) de nùmero telefùnico:** %d\n**Mudanùa(s) de estilo de luta:** %d\n**Mudanùa(s) de placa personalizada:** %d", character_name, package, convertTimestamp(date, 5), nc, nt, fight, pc);
                        
                        utf8encode(text, text);
                        new title[128];
                        format(title, 128, "Informaùùes premium");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }
                }
                else if(!strcmp(option, "addnc", true) && !strcmp(authorid, "326137493906784256", true))
                {
                    if(isnull(character_name))
                    {
                        format(text, 4900, "**USE:** !premium addnc [Nome_Sobrenome]");
                        utf8encode(text, text);
                        new title[32];
                        format(title, 32, "Mudanùa de nome");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                        return true;
                    }

                    //Jogador online
                    foreach (new i : Player) if (PlayerData[i][pLogged] && !strcmp(ReturnName2(i), character_name))
                    {
                        PlayerData[i][pDonatorNC] += 1;
                    
                        if(PlayerData[i][pGender] == 1)
                            format(text, 4900, "A **mudanùa de nome** foi creditado no personagem online %s.", ReturnName2(i));
                        else
                            format(text, 4900, "A **mudanùa de nome** foi creditado na personagem online %s.", ReturnName2(i));

                        utf8encode(text, text);
                        new title[32];
                        format(title, 32, "Mudanùa de nome");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                        SendClientMessageEx(i, COLOR_GREEN, "O Admin thiago#0666 adicionou uma mudanùa de nome para vocÍ.");
                        new log[128];
                        format(log, sizeof(log), "thiago#0666 deu uma mudanùa de nome para %s.", ReturnName(i, 0));
                        LogSQL_Create(99998, log, 7);
                        return true;
                    }

                    //Jogador offline

                    static 
                        rows, 
                        fields;

                    new query[500];
                    format(query, sizeof(query), "SELECT * FROM `characters` WHERE `Character` = '%s' LIMIT 1", character_name);
                    new Cache:result = mysql_query(g_iHandle, query);
                    cache_get_data(rows, fields, g_iHandle);

                    new count=0;

                    new donatornc, gender;
                    for(new i = 0; i < rows; i++)
                    {
                        count++;
                        donatornc = cache_get_field_int(i, "DonatorNC")+1;
                        gender = cache_get_field_int(i, "Gender");
                    }

                    cache_delete(result);

                    if(!count)//Personagem n„o localizado
                    {
                        format(text, 4900, "O personagem %s n„o foi localizado.", character_name);
                        utf8encode(text, text);
                        new title[32];
                        format(title, 32, "Mudanùa de nome");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                    }
                    else
                    {

                        format(query, sizeof(query), "UPDATE `characters` SET `DonatorNC` = '%d' WHERE `Character` = '%s'", donatornc, character_name);
                        mysql_function_query(g_iHandle, query, false, "", "");

                        if(gender == 1)
                            format(text, 4900, "A **mudanùa de nome** foi creditado no personagem off-line %s.", character_name);
                        else
                            format(text, 4900, "A **mudanùa de nome** foi creditado na personagem off-line %s.", character_name);

                        utf8encode(text, text);
                        new title[32];
                        format(title, 32, "Mudanùa de nome");
                        utf8encode(title, title);
                        new DCC_Embed:embed = DCC_CreateEmbed(title);
                        DCC_SetEmbedDescription(embed, text);
                        DCC_SetEmbedColor(embed, 0xF2633C);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);

                        new log[128];
                        format(log, sizeof(log), "thiago#0666 deu uma mudanùa de nome para %s.", character_name);
                        LogSQL_Create(99998, log, 7);
                    }
                }
                else
                {
                    format(text, 4900, "VocÍ especificou uma opÁ„o invùlida.");
                    utf8encode(text, text);
                    new DCC_Embed:embed = DCC_CreateEmbed("Premium");
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
                }
            }
            else
            {
                new title[32];
                format(title, 32, "Comando inv·lido");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[4900];
                format(text, 4900, "Digite **!ajuda** para obter a lista de comandos completa.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305002952622110"), embed);
            }
        }
        return true;
    }

    if(channel == DCC_FindChannelById("989307682852855848")) //#requisiÁıes-flyers
    {
        if(strfind(string, "!", true) == 0)//Comando identificado
        {
            new authorid[DCC_ID_SIZE];
            DCC_GetUserId(author, authorid, sizeof(authorid));

            new command[32];
            new parameters[64];
            sscanf(string, "s[32]S()[64]", command, parameters);

            if(!strcmp(command, "!aceitarflyer", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    new title[32];
                    format(title, 32, "Aceitar solicitaÁ„o de flyer");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    format(text, 4900, "**USE:** !aceitarflyer [flyer ID]");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new flyerid = strval(parameters);
                new query[500];
                format(query, sizeof(query), "SELECT * FROM `flyer_requests` WHERE `requestID` = '%d' LIMIT 1", flyerid);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new title[64];
                format(title, 64, "Aceitar solicitaÁ„o de flyer #%d", flyerid);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0xF2633C);

                new value1[32], value2[128];
                new count=0;

                new 
                    id,
                    authorf[64],
                    titleflyer[64],
                    urlflyer[128],
                    status;

                for(new i = 0; i < rows; i++)
                {
                    count++;
                    id = cache_get_field_int(i, "requestID");
                    cache_get_field_content(i, "requestAuthor", authorf, g_iHandle, 64);
                    status = cache_get_field_int(i, "requestStatus");
                    cache_get_field_content(i, "requestTitle", titleflyer, g_iHandle, 64);
	                cache_get_field_content(i, "requestURL", urlflyer, g_iHandle, 128);

                    format(value1, 32, "Personagem");
                    format(value2, 32, "%s", authorf);
                    utf8encode(value1, value1);
                    utf8encode(value2, value2);
                    DCC_AddEmbedField(embed, value1, value2, true);

                    if(status == 0)
                    {
                        format(value1, 32, "Status");
                        format(value2, 32, "Aprovado");
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        format(value1, 32, "Tùtulo");
                        format(value2, 32, "%s", titleflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        format(value1, 32, "Link");
                        format(value2, 32, "%s", urlflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        DCC_SetEmbedImage(embed, urlflyer);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);

                        new log[128];
                        format(log, sizeof(log), "%s#%s aceitou o flyer de %s [FLYERID: %d].", user_name, discriminator, authorf, id);
                        LogSQL_Create(0, log, 16);

                        FinishFlyer(flyerid);
                        return true;
                    }
                    else if(status == 1)
                    {
                        format(value1, 32, "Status");
                        format(value2, 32, "Jù avaliado **(aprovado)**");
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        format(value1, 32, "Tùtulo");
                        format(value2, 32, "%s", titleflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, false);

                        format(value1, 32, "Link");
                        format(value2, 32, "%s", urlflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        //DCC_SetEmbedImage(embed, urlflyer);

                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);
                        return true;
                    }
                    else if(status == 2)
                    {
                        format(value1, 32, "Status");
                        format(value2, 32, "Jù avaliado **(negado)**");
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        format(value1, 32, "Tùtulo");
                        format(value2, 32, "%s", titleflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, false);

                        format(value1, 32, "Link");
                        format(value2, 32, "%s", urlflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        //DCC_SetEmbedImage(embed, urlflyer);
                        
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);
                        return true;
                    }
                }

                cache_delete(result);

                if(!count)
                {
                    format(text, 4900, "Nenhum flyer localizado com esse ID.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);
                    return true;
                }
            
            }
            else if(!strcmp(command, "!recusarflyer", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    new title[32];
                    format(title, 32, "Recusar solicitaÁ„o de flyer");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    format(text, 4900, "**USE:** !aceitarflyer [flyer ID]");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);
                    return true;
                }

                static 
                    rows, 
                    fields;

                new flyerid = strval(parameters);
                new query[500];
                format(query, sizeof(query), "SELECT * FROM `flyer_requests` WHERE `requestID` = '%d' LIMIT 1", flyerid);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);

                new title[64];
                format(title, 64, "Recusar solicitaÁ„o de flyer #%d", flyerid);
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0xF2633C);

                new value1[32], value2[128];
                new count=0;

                new 
                    id,
                    authorf[64],
                    titleflyer[64],
                    urlflyer[128],
                    status;

                for(new i = 0; i < rows; i++)
                {
                    count++;
                    id = cache_get_field_int(i, "requestID");
                    cache_get_field_content(i, "requestAuthor", authorf, g_iHandle, 64);
                    status = cache_get_field_int(i, "requestStatus");
                    cache_get_field_content(i, "requestTitle", titleflyer, g_iHandle, 64);
	                cache_get_field_content(i, "requestURL", urlflyer, g_iHandle, 128);

                    format(value1, 32, "Personagem");
                    format(value2, 32, "%s", authorf);
                    utf8encode(value1, value1);
                    utf8encode(value2, value2);
                    DCC_AddEmbedField(embed, value1, value2, true);

                    if(status == 0)
                    {
                        format(value1, 32, "Status");
                        format(value2, 32, "Negado");
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        format(value1, 32, "Tùtulo");
                        format(value2, 32, "%s", titleflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        format(value1, 32, "Link");
                        format(value2, 32, "%s", urlflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        //DCC_SetEmbedImage(embed, urlflyer);
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);

                        new log[128];
                        format(log, sizeof(log), "%s#%s rejeitou o flyer de %s [FLYERID: %d].", user_name, discriminator, authorf, id);
                        LogSQL_Create(0, log, 16);

                        FinishFlyerDenied(flyerid);
                        return true;
                    }
                    else if(status == 1)
                    {
                        format(value1, 32, "Status");
                        format(value2, 32, "Jù avaliado **(aprovado)**");
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        format(value1, 32, "Tùtulo");
                        format(value2, 32, "%s", titleflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, false);

                        format(value1, 32, "Link");
                        format(value2, 32, "%s", urlflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        DCC_SetEmbedImage(embed, urlflyer);

                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);
                        return true;
                    }
                    else if(status == 2)
                    {
                        format(value1, 32, "Status");
                        format(value2, 32, "Jù avaliado **(negado)**");
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        format(value1, 32, "Tùtulo");
                        format(value2, 32, "%s", titleflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, false);

                        format(value1, 32, "Link");
                        format(value2, 32, "%s", urlflyer);
                        utf8encode(value1, value1);
                        utf8encode(value2, value2);
                        DCC_AddEmbedField(embed, value1, value2, true);

                        //DCC_SetEmbedImage(embed, urlflyer);
                        
                        new footer[128];
                        format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                        utf8encode(footer, footer);
                        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                        DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);
                        return true;
                    }
                }

                cache_delete(result);

                if(!count)
                {
                    format(text, 4900, "Nenhum flyer localizado com esse ID.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989307682852855848"), embed);
                    return true;
                }
            }
        }
        return true;
    }

    if(!strcmp(channel_name, "manager-bot", true) && channel == DCC_FindChannelById("989305233299624007")) //#manager-bot
    {
        if(strfind(string, "!", true) == 0)//Comando identificado
        {
            new command[32];
            new parameters[64];
            sscanf(string, "s[32]S()[64]", command, parameters);

            if(!strcmp(command, "!instabilidade", true))
            {
                new rcon[128];
                if(!Server_Instability)
                {
                    Server_Instability = 1;
                    format(rcon, sizeof(rcon), "hostname AD:RP Stories | Acesso ao jogo suspenso!");
                    SendRconCommand(rcon);
                    servername = 0;

                    format(rcon, sizeof(rcon), "password 9291z2");
                    SendRconCommand(rcon);

                    new title[32];
                    format(title, 32, "Conex„o inst·vel");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0xAF3937);
                    new text[4900];
                    format(text, 4900, "Uma instabilidade foi detectada no serviÁo SA-MP. O acesso de personagens foi suspenso e apenas ser· restabelecido apùs ficar estùvel novamente.", text);
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    new forum1[128];
                    format(forum1, 128, "%s", LAST_UPDATE);
                    utf8encode(forum1, forum1);
                    new forum2[128];
                    format(forum2, 128, "ùltima atualizaÁ„o em:", forum2);
                    utf8encode(forum2, forum2);
                    DCC_AddEmbedField(embed, forum2, forum1, false);
                    new versao1[128];
                    format(versao1, 128, "%s", SERVER_REVISION);
                    utf8encode(versao1, versao1);
                    new versao2[128];
                    format(versao2, 128, "Versùo do Gamemode:", versao2);
                    utf8encode(versao2, versao2);
                    DCC_AddEmbedField(embed, versao2, versao1, false);
                    new footer[128];
                    format(footer, 128, "Instabilidade detectada em: %s.", convertTimestamp(gettime(), 5));
                    utf8encode(footer, footer);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/1S9lKiP.png");
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/azvcHwO.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("931697612988497930"), embed);

                    format(title, 32, "Modo instabilidade");
                    utf8encode(title, title);
                    embed = DCC_CreateEmbed(title); 
                    format(text, 4900, "O servidor **entrou** em modo instabilidade.\nO acesso de jogadores foi suspenso para evitar danos em suas contas.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }
                else
                {
                    Server_Instability = 0;

                    format(rcon, sizeof(rcon), "hostname AdD:RP Stories | advanced-roleplay.com.br");
                    SendRconCommand(rcon);
                    servername = 0;

                    format(rcon, sizeof(rcon), "password 0");
                    SendRconCommand(rcon);

                    new title[32];
                    format(title, 32, "Conex„o estùvel");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedColor(embed, 0x238C00);
                    new text[4900];
                    format(text, 4900, "O acesso ao serviÁo SA-MP foi restabelecido, a partir de agora vocÍ pode se conectar com seu personagem.", text);
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    new forum1[128];
                    format(forum1, 128, "%s", LAST_UPDATE);
                    utf8encode(forum1, forum1);
                    new forum2[128];
                    format(forum2, 128, "ùltima atualizaÁ„o em:", forum2);
                    utf8encode(forum2, forum2);
                    DCC_AddEmbedField(embed, forum2, forum1, false);
                    new versao1[128];
                    format(versao1, 128, "%s", SERVER_REVISION);
                    utf8encode(versao1, versao1);
                    new versao2[128];
                    format(versao2, 128, "Versùo do Gamemode:", versao2);
                    utf8encode(versao2, versao2);
                    DCC_AddEmbedField(embed, versao2, versao1, false);
                    new footer[128];
                    format(footer, 128, "Servidor normalizado em: %s.", convertTimestamp(gettime(), 5));
                    utf8encode(footer, footer);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/1DvanXG.png");
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/azvcHwO.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("931697612988497930"), embed);

                    format(title, 32, "Modo instabilidade");
                    utf8encode(title, title);
                    embed = DCC_CreateEmbed(title); 
                    format(text, 4900, "O servidor **saiu** do modo instabilidade.\nO acesso de jogadores foi restabelecido.");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }
            }
            else if(!strcmp(command, "!gmx", true))
            {
                new title[32];
                format(title, 32, "Reiniciando o servidor");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[4900];
                format(text, 4900, "ReinicializaÁ„o do servidor forùada iniciada.\nO acesso dos jogadores foi bloqueado e o servidor ser· reiniciado em um minuto.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);

                GiveGMX();
                return true;
            }
            else if(!strcmp(command, "!kickall", true))
            {
                new title[32];
                format(title, 32, "Expulsar jogadores");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[4900];
                format(text, 4900, "Todos os jogadores do servidor foram desconectados com sucesso.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);

                foreach(new i : Player){
                    KickEx(i);
                }
                return true;
            }

            else if(!strcmp(command, "!doublepd", true))
            {
                new title[32];
                format(title, 32, "Paycheck duplo");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[4900];
                if(doublepayday == 0){
                    format(text, 4900, "Paycheck duplo **ativado.**");
                    doublepayday = 1;
                    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s#%s ativou o double paycheck pelo Discord.", user_name, discriminator);
                }
                else{
                    format(text, 4900, "Paycheck duplo **desativado.**");
                    doublepayday = 0;
                    SendAdminAlert(COLOR_LIGHTRED, "AdmCmd: %s#%s desativou o double paycheck pelo Discord.", user_name, discriminator);
                }
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
            }

            else if(!strcmp(command, "!ooc", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    new title[32];
                    format(title, 32, "Aviso OOC");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title); 
                    format(text, 4900, "Mas tu È um asno mesmo, hein? Tu usou o comando de forma errada, mas beleza, vamos l· que o tio R2-D2 te ensina. Use:\n`!ooc [mensagem de texto (atÈ 128 caracteres)]`");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }

                new ooc[255];
                format(string, 128, "%s", parameters);
                utf8decode(ooc, string);

                if (strlen(ooc) > 64)
                {
                    foreach (new i : Player) if (!PlayerData[i][pDisableOOC] && SQL_IsLogged(i)) {
                        SendClientMessageEx(i, 0xAAC4E5FF, "(( [OOC] %s#%s: %.64s", user_name, discriminator, ooc);
                        SendClientMessageEx(i, 0xAAC4E5FF, "...%s ))", ooc[64]);
                    }
                }
                else
                {
                    foreach (new i : Player) if (!PlayerData[i][pDisableOOC] && SQL_IsLogged(i)) {
                        SendClientMessageEx(i, 0xAAC4E5FF, "(( [OOC] %s#%s: %s ))", user_name, discriminator, ooc);
                    }
                }

                new title[32];
                format(title, 32, "Aviso OOC");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                format(text, 4900, "Mensagem OOC enviada com sucesso!\nConte˙do enviado:\n`(( [OOC] %s#%s: %s ))`", user_name, discriminator, ooc);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
			}  

            else if(!strcmp(command, "!anrp", true))
            {
                new text[4900];

                if(isnull(parameters))
                {
                    new title[32];
                    format(title, 32, "An˙ncio Roleplay");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title); 
                    format(text, 4900, "Mas tu È um asno mesmo, hein? Tu usou o comando de forma errada, mas beleza, vamos l· que o tio R2-D2 te ensina. Use:\n`!anrp [mensagem de texto (atÈ 128 caracteres)]`");
                    utf8encode(text, text);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0xF2633C);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }

                new anrp[255];
                format(string, 128, "%s", parameters);
                utf8decode(anrp, string);

                if (strlen(anrp) > 64)
                {
                    foreach (new i : Player) {
                        SendClientMessageEx(i, COLOR_RED, "* [ANRP] %.64s", anrp);
                        SendClientMessageEx(i, COLOR_RED, "...%s *", anrp[64]);
                    }
                }
                else
                {
                    foreach (new i : Player) {
                        SendClientMessageEx(i, COLOR_RED, "* [ANRP] %s *", anrp);
                    }
                }

                new title[32];
                format(title, 32, "An˙ncio Roleplay");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                format(text, 4900, "An˙ncio Roleplay enviado com sucesso!\nConte˙do enviado:\n`[ANRP] %s`", anrp);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);

                format(title, 32, "An˙ncio Roleplay");
                utf8encode(title, title);
                embed = DCC_CreateEmbed(title);
                DCC_SetEmbedColor(embed, 0xAF3937);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/ASZzqN9.png");
                DCC_SetEmbedDescription(embed, text);
                format(footer, 128, "An˙ncio enviado em %s.", convertTimestamp(gettime(), 5));
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer);

                DCC_SendChannelEmbedMessage(DCC_FindChannelById("931052974334152724"), embed);
			}  

            else if(!strcmp(command, "!ajuda", true))
            {
                new title[32];
                format(title, 32, "Comandos disponÌveis");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                new text[4900];
                format(text, 4900, "SÈrio que tu n„o sabe a porra do mÌnimo? Caralho, seu merda, o que vocÍ t· fazendo aqui?\nMas beleza, beleza, vamos l·, sÛ n„o reclame quando a revoluÁ„o das m·quinas comeÁar. T· aqui o que eu posso fazer:\n", text);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                new title_field[128], text_field[1024];

                format(title_field, 128, "!instabilidade");
                format(text_field, 1024, "Ativa ou desativa o modo de instabilidade do servidor, bloqueando ou desbloqueando o acesso dos jogadores.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!kickall");
                format(text_field, 1024, "Desconecta **todos** os jogadores do servidor de forma imediata. N„o exibe nada na tela deles.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!gmx");
                format(text_field, 1024, "Expulsa todos os ~~cornos~~ jogadores do servidor em **um minuto** e reinicia o servidor de forma imediata. N„o use essa merda atoa, seu filho da puta.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!doublepd");
                format(text_field, 1024, "Ativa ou desativa o caralhudo do paycheck duplo. … sÛ isso mesmo.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!ooc");
                format(text_field, 1024, "Manda uma mensagem OOC para todos on-lines.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!anrp");
                format(text_field, 1024, "Manda um An˙ncio de Roleplay para todos on-lines.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!auditoria");
                format(text_field, 1024, "Define o canal de auditoria de um membro da Staff.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);            
            }
            else if(!strcmp(command, "!auditoria", true))
            {
                new
                    _user_name[32],
                    channel_id[32];

                new text[4900];

                if (sscanf(parameters, "s[32]s[32]", _user_name, channel_id))
                {
                    format(text, 4900, "**USE:** !auditoria [Usu·rio] [ID do canal]");
                    utf8encode(text, text);
                    new DCC_Embed:embed = DCC_CreateEmbed("Auditoria");
                    DCC_SetEmbedColor(embed, 0xFFAF46);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/br8MUJj.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }

                if(isnull(_user_name))
                {
                    format(text, 4900, "**USE:** !auditoria [Nome_Sobrenome] [ID do canal]");
                    utf8encode(text, text);
                    new DCC_Embed:embed = DCC_CreateEmbed("Auditoria");
                    DCC_SetEmbedColor(embed, 0xFFAF46);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/br8MUJj.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);//aq
                    return true;
                }

                //Jogador online
                foreach (new i : Player) if (PlayerData[i][pLogged] && !strcmp(PlayerData[i][pUsername], _user_name))
                {
                    new channel_name_auditory[128];

                    if(strval(channel_id) == -1)
                    {
                        format(text, sizeof(text), "O canal de auditoria do membro da equipe **%s** (ONLINE) foi removido.", _user_name);
                        utf8encode(text, text);
                        format(PlayerData[i][pDiscordChannel], 128, "");
                    }
                    else
                    {
                        DCC_GetChannelName(DCC_FindChannelById(channel_id), channel_name_auditory);
                        format(text, sizeof(text), "O canal de auditoria do membro da equipe **%s** (ONLINE) foi definido como sendo #%s.", _user_name, channel_name_auditory);
                        utf8encode(text, text);
                        format(PlayerData[i][pDiscordChannel], 128, "%s", channel_id);
                    }

                    new query[256];
                    format(query, sizeof(query), "UPDATE `accounts` SET `discordChannel` = '%s' WHERE `Username` = '%s'",
                    channel_id,
                    _user_name);
                    mysql_function_query(g_iHandle, query, false, "", "");

                    new DCC_Embed:embed = DCC_CreateEmbed("Auditoria");
                    DCC_SetEmbedColor(embed, 0x00B954);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/QlsGheL.png");
                    DCC_SetEmbedDescription(embed, text);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }

                //Buscar usu·rio offline
                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `Username` = '%s' LIMIT 1", _user_name);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);                

                if(!rows)
                {
                    format(text, 4900, "O usu·rio especificado n„o foi localizado.");
                    utf8encode(text, text);
                    new DCC_Embed:embed = DCC_CreateEmbed("Auditoria");
                    DCC_SetEmbedColor(embed, 0xAF3937);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                    DCC_SetEmbedDescription(embed, text);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    cache_delete(result);
                    return true;
                }

                cache_delete(result);

                new channel_name_auditory[128];

                if(strval(channel_id) == -1)
                {
                    format(text, sizeof(text), "O canal de auditoria do membro da equipe **%s** (OFFLINE) foi removido.", _user_name);
                    utf8encode(text, text);

                    format(query, sizeof(query), "UPDATE `accounts` SET `discordChannel` = '' WHERE `Username` = '%s'",
                    _user_name);
                    mysql_function_query(g_iHandle, query, false, "", "");
                }
                else
                {
                    DCC_GetChannelName(DCC_FindChannelById(channel_id), channel_name_auditory);
                    format(text, sizeof(text), "O canal de auditoria do membro da equipe **%s** (OFFLINE) foi definido como sendo #%s.", _user_name, channel_name_auditory);
                    utf8encode(text, text);

                    format(query, sizeof(query), "UPDATE `accounts` SET `discordChannel` = '%s' WHERE `Username` = '%s'",
                    channel_id,
                    _user_name);
                    mysql_function_query(g_iHandle, query, false, "", "");
                }

                new DCC_Embed:embed = DCC_CreateEmbed("Auditoria");
                DCC_SetEmbedColor(embed, 0x00B954);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/QlsGheL.png");
                DCC_SetEmbedDescription(embed, text);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer);
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
            }*/
            /*else if(!strcmp(command, "!addcredits", true))
            {
                new
                    _user_name[32],
                    Float:addcredits;

                new text[4900];

                if (sscanf(parameters, "fs[32]", addcredits, _user_name))
                {
                    format(text, 4900, "**USE:** !addcredits [Valor (ex: 50.0)] [Usu·rio]");
                    utf8encode(text, text);
                    new DCC_Embed:embed = DCC_CreateEmbed("Adicionar Staff Credits");
                    DCC_SetEmbedColor(embed, 0xFFAF46);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/br8MUJj.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    return true;
                }

                if(isnull(_user_name))
                {
                    format(text, 4900, "**USE:** !addcredits [Valor (ex: 50.0)] [Usu·rio]");
                    utf8encode(text, text);
                    new DCC_Embed:embed = DCC_CreateEmbed("Adicionar Staff Credits");
                    DCC_SetEmbedColor(embed, 0xFFAF46);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/br8MUJj.png");
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);//aq
                    return true;
                }

                //Buscar usu·rio offline
                static 
                    rows, 
                    fields;

                new query[128];
                format(query, sizeof(query), "SELECT * FROM `accounts` WHERE `Username` = '%s' LIMIT 1", _user_name);
                new Cache:result = mysql_query(g_iHandle, query);
                cache_get_data(rows, fields, g_iHandle);                

                if(!rows)
                {
                    format(text, 4900, "O usu·rio especificado n„o foi localizado.");
                    utf8encode(text, text);
                    new DCC_Embed:embed = DCC_CreateEmbed("Adicionar Staff Credits");
                    DCC_SetEmbedColor(embed, 0xAF3937);
                    DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                    DCC_SetEmbedDescription(embed, text);
                    new footer[128];
                    format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer);
                    DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
                    cache_delete(result);
                    return true;
                }

                new Float:credits = cache_get_field_float(0, "staffCredits");
                cache_delete(result);

                format(text, sizeof(text), "**SC$%.1f** adicionados com sucesso ao usu·rio %s.\n\nO usu·rio %s possui **SC$%.1f** acumulados.", addcredits, _user_name, _user_name, credits+addcredits);
                utf8encode(text, text);

                format(query, sizeof(query), "UPDATE `accounts` SET `staffCredits` = `staffCredits`+'%.5f' WHERE `Username` = '%s'",
                addcredits,
                _user_name);
                mysql_function_query(g_iHandle, query, false, "", "");

                new DCC_Embed:embed = DCC_CreateEmbed("Adicionar Staff Credits");
                DCC_SetEmbedColor(embed, 0x3D6DEB);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/MoF9psi.png");
                DCC_SetEmbedDescription(embed, text);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer);
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);

                embed = DCC_CreateEmbed("Adicionar Staff Credits");
                DCC_SetEmbedColor(embed, 0x3D6DEB);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/MoF9psi.png");
                DCC_SetEmbedDescription(embed, text);
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer);
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("886062454373756948"), embed);
            }*//*
            else
            {
                new title[32];
                format(title, 32, "Comando inv·lido");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[4900];
                format(text, 4900, "Digite **!ajuda** para obter a lista de comandos completa.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedThumbnail(embed, "https://i.imgur.com/6oHUEpk.png");
                DCC_SetEmbedColor(embed, 0xF2633C);
                new footer[128];
                format(footer, 128, "AÁ„o realizada por %s#%s em %s no #%s.", user_name, discriminator, convertTimestamp(gettime(), 5), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/cXaP5n7.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);
            }
        }
    }
    return true;
}*/
