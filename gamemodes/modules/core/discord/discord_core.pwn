#include <YSI_Coding\y_hooks>

forward PrivateMessageRegister(username[128], password[128]);

forward ServerStatus(type);
public ServerStatus(type){
    new title[32],
        text[1024],
        footer[128],
        rcon[128];

    new DCC_Channel:channel;
    channel = DCC_FindChannelById("1018291621722341447");
    
    if(type == 1){ // TUDO FUNCIONANDO
        // DISCORD
        format(title, 32, "Status do Servidor");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 1024, "<:announce:1066021926486679692> Nenhum problema ou ocorrência recente.\n\n\
        > <:point:1066021935185657876> **Serviço Open.MP:** Operante\n\
        > <:point:1066021935185657876> **User Control Panel:** Operante\n\
        > <:point:1066021935185657876> **Fórum:** Operante\n\n\
        **<:all:1066021931842805941> INFORMAÇÕES ÚTEIS:**\n\
        <:point:1066021935185657876> Endereço de IP: %s\n\
        <:point:1066021935185657876> Senha de acesso: closedbeta023\n\
        <:point:1066021935185657876> User Control Panel: %s\n\
        <:point:1066021935185657876> Fórum: %s\n\n\
        ", SERVERIP, SERVERUCP, SERVERFORUM);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedImage(embed, "https://advanced-roleplay.com.br/archives/logo.png");
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

        format(title, 32, "Status do Servidor");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 1024, "<:announce:1066021926486679692> Foi detectado um problema em nosso fórum nas últimas horas. Nossa equipe de suporte está trabalhando para resolvê-lo o quanto antes.\n\n\
        > <:point:1066021935185657876> **Serviço Open.MP:** Operante\n\
        > <:point:1066021935185657876> **User Control Panel:** Operante\n\
        > <:point:1066021935185657876> **Fórum:** __Inoperante__\n\n\
        **<:all:1066021931842805941> INFORMAÇÕES ÚTEIS:**\n\
        <:point:1066021935185657876> Endereço de IP: %s\n\
        <:point:1066021935185657876> User Control Panel: %s\n\
        <:point:1066021935185657876> Fórum: %s\n\n\
        ", SERVERIP, SERVERUCP, SERVERFORUM);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedImage(embed, "https://advanced-roleplay.com.br/archives/logo.png");
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
        format(title, 32, "Status do Servidor");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 1024, "<:announce:1066021926486679692> Foi detectado um problema em nosso User Control Panel nas últimas horas. Nossa equipe de suporte está trabalhando para resolvê-lo o quanto antes.\n\n\
        > <:point:1066021935185657876> **Serviço Open.MP:** Operante\n\
        > <:point:1066021935185657876> **User Control Panel:** __Inoperante__\n\
        > <:point:1066021935185657876> **Fórum:** Operante\n\n\
        **<:all:1066021931842805941> INFORMAÇÕES ÚTEIS:**\n\
        <:point:1066021935185657876> Endereço de IP: %s\n\
        <:point:1066021935185657876> User Control Panel: %s\n\
        <:point:1066021935185657876> Fórum: %s\n\n\
        ", SERVERIP, SERVERUCP, SERVERFORUM);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedImage(embed, "https://advanced-roleplay.com.br/archives/logo.png");
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
        format(title, 32, "Status do Servidor");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 1024, "<:announce:1066021926486679692> Foi detectado um problema em nosso Serviço Open.MP nas últimas horas. Nossa equipe de suporte está trabalhando para resolvê-lo o quanto antes.\n\n\
        > <:point:1066021935185657876> **Serviço Open.MP:** __Inoperante__\n\
        > <:point:1066021935185657876> **User Control Panel:** Operante\n\
        > <:point:1066021935185657876> **Fórum:** Operante\n\n\
        **<:all:1066021931842805941> INFORMAÇÕES ÚTEIS:**\n\
        <:point:1066021935185657876> Endereço de IP: %s\n\
        <:point:1066021935185657876> User Control Panel: %s\n\
        <:point:1066021935185657876> Fórum: %s\n\n\
        ", SERVERIP, SERVERUCP, SERVERFORUM);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedImage(embed, "https://advanced-roleplay.com.br/archives/logo.png");
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
        format(title, 32, "Status do Servidor");
        utf8encode(title, title);
        new DCC_Embed:embed = DCC_CreateEmbed(title);
        DCC_SetEmbedColor(embed, 0x5964F4);
        
        format(text, 1024, "<:announce:1066021926486679692> Foi detectado um problema em todas as nossas plataformas nas últimas horas. Nossa equipe de suporte está trabalhando para resolvê-lo o quanto antes.\n\n\
        > <:point:1066021935185657876> **Serviço Open.MP:** __Inoperante__\n\
        > <:point:1066021935185657876> **User Control Panel:** __Inoperante__\n\
        > <:point:1066021935185657876> **Fórum:** __Inoperante__\n\n\
        **<:all:1066021931842805941> INFORMAÇÕES ÚTEIS:**\n\
        <:point:1066021935185657876> Endereço de IP: %s\n\
        <:point:1066021935185657876> User Control Panel: %s\n\
        <:point:1066021935185657876> Fórum: %s\n\n\
        ", SERVERIP, SERVERUCP, SERVERFORUM);
        utf8encode(text, text);
        DCC_SetEmbedDescription(embed, text);

        format(footer, 128, "© 2022 Advanced Roleplay");
        utf8encode(footer, footer);

        DCC_SetEmbedImage(embed, "https://advanced-roleplay.com.br/archives/logo.png");
        DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
        DCC_SendChannelEmbedMessage(channel, embed);
    }
}

forward SendInfoClosedAlpha();
public SendInfoClosedAlpha(){

    new 
        title[32],
        text[2048],
        footer[128];

    new DCC_Channel:channel;
    channel = DCC_FindChannelById("1000930434747740271");
    
    // DISCORD
    format(title, 32, "Informações — Closed Beta");
    utf8encode(title, title);
    new DCC_Embed:embed = DCC_CreateEmbed(title);
    DCC_SetEmbedColor(embed, 0x5964F4);
        
    format(text, 2048, "<:announce:1066021926486679692> **Informações pertinentes sobre o Closed Beta:**\n\n\
    > <:point:1066021935185657876> A criação das contas serão realizadas através do canal #registro e cada conta no Discord terá direito a apenas um usuário;\n\
    > <:point:1066021935185657876> Nenhum dado de jogador será salvo durante todo o período de testes;\n\
    > <:point:1066021935185657876> O servidor ficará on-line 24/7, ou seja, não haverá problemas com horários e coisas do gênero, sintam-se livres para logarem no momento em que sentirem vontade;\n\
    > <:point:1066021935185657876> O endereço de IP e a senha do servidor só serão liberados no dia em que ele for aberto para os testes, o que provavelmente ocorrerá na segunda semana de setembro;\n\
    > <:point:1066021935185657876> O compartilhamento do endereço de IP, senha ou qualquer informação que permita algum jogador não autorizado a entrar no servidor acarretará em banimento permanente de todas as versões de teste do servidor, podendo retomar, apenas, na versão de lançamento;\n\
    > <:point:1066021935185657876> O servidor não é para fazer roleplay, apenas testar os sistemas feitos até então;\n\
    > <:point:1066021935185657876> Para pegar administrador no servidor, utilize o comando `/pegaradmin` e, para pegar premium ouro, `/pegarpremium`;\n\
    > <:point:1066021935185657876> Quando você se registrar, receberá uma série de canais onde poderá reportar bugs, lags, deixar sugestões e dar seu feedback. Você também receberá um cargo de **registrado** no Discord público do Advanced Rolelay. Esse cargo não será setado novamente caso você saia do servidor.\n");
    utf8encode(text, text);
    DCC_SetEmbedDescription(embed, text);

    format(footer, 128, "© 2023 Advanced Roleplay — Closed Beta");
    utf8encode(footer, footer);

    DCC_SetEmbedImage(embed, "https://advanced-roleplay.com.br/archives/logo.png");
    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
    DCC_SendChannelEmbedMessage(channel, embed);
     
}

public DCC_OnMessageCreate(DCC_Message:message) {
    new channel_name[32];
    new DCC_Channel:channel;
    DCC_GetMessageChannel(message, channel);
    DCC_GetChannelName(channel, channel_name);
    new user_name[32 + 1], discriminator[8];
    new DCC_User:author;
    DCC_GetMessageAuthor(message, author);
    DCC_GetUserName(author, user_name);
    DCC_GetUserDiscriminator(author, discriminator);
    new string[1024];
    DCC_GetMessageContent(message, string);
    new DCC_Guild:guild = DCC_FindGuildById("277264357824528397");
    new DCC_Guild:guildCA = DCC_FindGuildById("1000929204164112386");

    new bool:is_bot;
    if(!DCC_IsUserBot(author, is_bot))
        return false;

    if(is_bot)
        return false;

    ////////////////////////////////////////////////////////////////////////
    // DISCORD CLOSED ALPHA
    if(!strcmp(channel_name, "registro", true) && channel == DCC_FindChannelById("1013482041595146352")){
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

                format(text, 1024, "Bip-bip-bop-bip-bop-bip. Eis o que posso fazer:\n");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(title_field, 128, "!registrar");
                format(text_field, 1024, "Registrar um usuário no banco de dados do Advanced Roleplay. Uma senha será enviada em seu privado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!criarpersonagem");
                format(text_field, 1024, "Cria um personagem no seu usuário.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!deletarconta");
                format(text_field, 1024, "Deleta seu usuário permanentemente.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(channel, embed);
                return true;
            }
            else if(!strcmp(command, "!pegar", true)){
                new text[256], footer[128], title[64];
                new DCC_Role:role1 = DCC_FindRoleById("1070220594479640586");
                new DCC_Role:role2 = DCC_FindRoleById("1070390636060098692");
                DCC_AddGuildMemberRole(guildCA, author, role1);
                DCC_AddGuildMemberRole(guild, author, role2);

                format(title, 64, "Você pegou seu cargo!");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                format(text, 256, "Bip-bip-bop-bip-bop-bip.\n%s, você adquiriu seu cargo de beta tester no Discord do Advanced Roleplay!\n", user_name);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");

                DCC_SetEmbedColor(embed, 0x5964F4);
                DCC_SendChannelEmbedMessage(channel, embed);               
                return true;
            } 
            else if(!strcmp(command, "!registrar", true)){
                new text[256], footer[128], title[64], Cache:result;
                if(isnull(parameters)){
                    format(text, 256, "**USE:** !registrar [nome do usuário]");
                    utf8encode(text, text);
                    format(title, 64, "Registrar UCP");
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

                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `discord_id` = '%s';", authorid);
                result = mysql_query(DBConn, query);
        
                // Verificar se já foi registrado pelo Discord
                if(cache_num_rows()) {
                    format(text, 256, "Foi encontrado um usuário vinculado ao seu Discord.");
                    utf8encode(text, text);
                    format(title, 64, "Ops...");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    cache_delete(result);
                    return true;
                }

                cache_delete(result);
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", parameters);
                result = mysql_query(DBConn, query);

                // Verificar existência do usuário
                if(cache_num_rows()) {
                    format(text, 256, "Foi encontrado um usuário com este nome.");
                    utf8encode(text, text);
                    format(title, 64, "Ops...");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    cache_delete(result);
                    return true;
                }

                static const Letter[27][] = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"};
                static const Number[10] = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9};

                new password[128], Caracter1, Caracter2, Caracter3, Caracter4, Caracter5, Caracter6, Caracter7, Caracter8, Caracter9;
                Caracter1 = randomEx(0, 9);     //Numero
                Caracter2 = randomEx(0, 26);    //Letra
                Caracter3 = randomEx(0, 26);    //Letra
                Caracter4 = randomEx(0, 26);    //Letra
                Caracter5 = randomEx(0, 9);     //Numero
                Caracter6 = randomEx(0, 9);     //Numero
                Caracter7 = randomEx(0, 9);     //Numero
                Caracter8 = randomEx(0, 26);    //Letra
                Caracter9 = randomEx(0, 26);    //Letra
                format(password, sizeof(password), "%d%s%s%s%d%d%d%s%s", Number[Caracter1], Letter[Caracter2], Letter[Caracter3], Letter[Caracter4], Number[Caracter5], Number[Caracter6], Number[Caracter7], Letter[Caracter8], Letter[Caracter9]);

                bcrypt_hash(password, BCRYPT_COST, "OnPasswordHashed", "s[128]s[128]", authorid, parameters);
                DCC_CreatePrivateChannel(author, "PrivateMessageRegister", "ss", parameters, password);
                new DCC_Role:role1 = DCC_FindRoleById("1070220594479640586");
                new DCC_Role:role2 = DCC_FindRoleById("1070390636060098692");
                DCC_AddGuildMemberRole(guildCA, author, role1);
                DCC_AddGuildMemberRole(guild, author, role2);

                format(title, 64, "Registro concluído!");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                format(text, 256, "Bip-bip-bop-bip-bop-bip.\n%s, seu registro foi concluído e enviado no privado!\n", user_name);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");

                DCC_SetEmbedColor(embed, 0x5964F4);
                DCC_SendChannelEmbedMessage(channel, embed);               
                return true;
            } 
            else if(!strcmp(command, "!criarpersonagem", true)){
                new text[256], footer[128], title[64], user_id, username[24], Cache:result;
                
                if(isnull(parameters)){
                    format(text, 256, "**USE:** !criarpersonagem [nome do personagem]\n:warning: Não esqueça de inserir o nome no formato **Nome_Sobrenome**!");
                    utf8encode(text, text);
                    format(title, 64, "Criar Personagem");
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

                mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s';", parameters);
                result = mysql_query(DBConn, query);
        
                // Verificar se já existe o personagem
                if(cache_num_rows()) {
                    format(text, 256, "Foi encontrado um personagem com este nome.");
                    utf8encode(text, text);
                    format(title, 64, "Ops...");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    cache_delete(result);
                    return true;
                }

                cache_delete(result);
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `discord_id` = '%s';", authorid);
                result = mysql_query(DBConn, query);
        
                // Verificar se já foi registrado pelo Discord
                if(!cache_num_rows()) {
                    format(text, 256, "Não foi encontrado um usuário vinculado ao seu Discord. :/\nRegistre-se utilizando o **!registrar**!");
                    utf8encode(text, text);
                    format(title, 64, "Ops...");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    cache_delete(result);
                    return true;
                }

                cache_get_value_name_int(0, "ID", user_id);
                cache_get_value_name(0, "username", username);
                CreateCharacter(parameters, user_id);
                format(title, 64, "Personagem criado!");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                format(text, 256, "Bip-bip-bop-bip-bop-bip.\n%s, seu personagem foi criado com o nome **%s**!\nLogue no servidor utilizando seu nome de usuário: %s.", user_name, parameters, username);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");

                DCC_SetEmbedColor(embed, 0x5964F4);
                DCC_SendChannelEmbedMessage(channel, embed);
                cache_delete(result);       
                return true;
            } else if(!strcmp(command, "!deletarconta", true)) {
                new text[256], footer[128], title[64], user_id, username[24], Cache:result;

                cache_delete(result);
                mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `discord_id` = '%s';", authorid);
                result = mysql_query(DBConn, query);
        
                // Verificar se já foi registrado pelo Discord
                if(!cache_num_rows()) {
                    format(text, 256, "Não foi encontrado um usuário vinculado ao seu Discord. :/\nRegistre-se utilizando o **!registrar**!");
                    utf8encode(text, text);
                    format(title, 64, "Ops...");
                    utf8encode(title, title);
                    new DCC_Embed:embed = DCC_CreateEmbed(title);
                    DCC_SetEmbedDescription(embed, text);
                    DCC_SetEmbedColor(embed, 0x5964F4);
                    format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                    utf8encode(footer, footer);
                    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                    DCC_SendChannelEmbedMessage(channel, embed);
                    cache_delete(result);
                    return true;
                }

                cache_get_value_name_int(0, "ID", user_id);
                cache_get_value_name(0, "username", username);
               
                UserDelete(user_id);
                format(title, 64, "Usuário deletado!");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                format(text, 256, "Bip-bip-bop-bip-bop-bip.\n%s, o registro do usuário **%s** foi deletado com sucesso!", user_name, username);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");

                DCC_SetEmbedColor(embed, 0x5964F4);
                DCC_SendChannelEmbedMessage(channel, embed);
                cache_delete(result);       
                return true;
            }
            else {
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

    if(!strcmp(channel_name, "comandos", true) && channel == DCC_FindChannelById("1070707243856699393")){
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

                format(text, 1024, "Bip-bip-bop-bip-bop-bip. Eis o que posso fazer:\n");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(title_field, 128, "!registrar [desativado]");
                format(text_field, 1024, "Registrar um usuário no banco de dados do Advanced Roleplay. Uma senha será enviada em seu privado.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!criarpersonagem [desativado]");
                format(text_field, 1024, "Cria um personagem no seu usuário.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!deletarconta [desativado]");
                format(text_field, 1024, "Deleta seu usuário permanentemente.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                format(title_field, 128, "!pegar");
                format(text_field, 1024, "Pega o cargo de Beta Tester no Discord Público do Advanced Roleplay.");
                utf8encode(title_field, title_field);
                utf8encode(text_field, text_field);
                DCC_AddEmbedField(embed, title_field, text_field, true);

                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(channel, embed);
                return true;
            }
            else if(!strcmp(command, "!pegar", true)){
                new text[256], footer[128], title[64];
                new DCC_Role:role1 = DCC_FindRoleById("1070220594479640586");
                new DCC_Role:role2 = DCC_FindRoleById("1070390636060098692");
                DCC_AddGuildMemberRole(guildCA, author, role1);
                DCC_AddGuildMemberRole(guild, author, role2);

                format(title, 64, "Você pegou seu cargo!");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title);

                format(text, 256, "Bip-bip-bop-bip-bop-bip.\n%s, você adquiriu seu cargo de beta tester no Discord do Advanced Roleplay!\n", user_name);
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);

                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");

                DCC_SetEmbedColor(embed, 0x5964F4);
                DCC_SendChannelEmbedMessage(channel, embed);               
                return true;
            } else {
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

    if(!strcmp(channel_name, "bot-talk", true) && channel == DCC_FindChannelById("1013483397903024228")){
        DCC_SendChannelMessage(DCC_FindChannelById("1070218860202045442"), string);
        return true;
    }

    if(!strcmp(channel_name, "informações", true) && channel == DCC_FindChannelById("1000930434747740271")){
        if(strfind(string, "!", true) == 0)//Comando identificado
        {
            new authorid[DCC_ID_SIZE];
            DCC_GetUserId(author, authorid, sizeof(authorid));

            new command[32];
            new parameters[64];
            sscanf(string, "s[32]S()[64]", command, parameters);

            if(!strcmp(command, "!info", true)) {
                SendInfoClosedAlpha();
                return true;
            }
        }
        return true;
    }
    ////////////////////////////////////////////////////////////////////////
    // DISCORD STAFF
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

    if(!strcmp(channel_name, "bot-talk", true) && channel == DCC_FindChannelById("1066434521395892315")){
        DCC_SendChannelMessage(DCC_FindChannelById("989305002952622110"), string);
        return true;
    }

    if(!strcmp(channel_name, "bot-talk-staff", true) && channel == DCC_FindChannelById("1070712406470299648")){
        DCC_SendChannelMessage(DCC_FindChannelById("992260559984672768"), string);
        return true;
    }

    if(!strcmp(channel_name, "comandos", true) && channel == DCC_FindChannelById("989305002952622110")){
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

                format(text, 1024, "Bip-bip-bop-bip-bop-bip. Eis o que posso fazer:\n");
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
                    DCC_SendChannelEmbedMessage(channel, embed);
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
                DCC_SendChannelEmbedMessage(channel, embed);
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
                    DCC_SendChannelEmbedMessage(channel, embed);
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
                DCC_SendChannelEmbedMessage(channel, embed);
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
                    DCC_SendChannelEmbedMessage(channel, embed);
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
                    DCC_SendChannelEmbedMessage(channel, embed);
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
                DCC_SendChannelEmbedMessage(channel, embed);
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
                    DCC_SendChannelEmbedMessage(channel, embed);
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
                DCC_SendChannelEmbedMessage(channel, embed);
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

    if(!strcmp(channel_name, "manager-bot", true) && channel == DCC_FindChannelById("989305233299624007")){
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
                    format(text, 1024, "**USE:** !status [1 à 5]\n`1` = Todos os serviços operantes\n`2` = Fórum inoperante\n`3` = UCP inoperante\n`4` = Serviço Open.MP inoperante\n`5` = Todos os serviços inoperantes");
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
                    format(text, 1024, "**ERRO:** O valor inserido deve estar entre 1 e 5.\n\n**USE:** !status [1 à 5]\n`1` = Todos os serviços operantes\n`2` = Fórum inoperante\n`3` = UCP inoperante\n`4` = Serviço Open.MP inoperante\n`5` = Todos os serviços inoperantes");
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
                    case 4: whattype = "Serviço Open.MP inoperante";
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
            } else if(!strcmp(command, "!gmx", true)) {
                new title[32];
                format(title, 32, "Reiniciando o servidor");
                utf8encode(title, title);
                new DCC_Embed:embed = DCC_CreateEmbed(title); 
                new text[1024];
                new footer[128];
                format(text, 1024, "Reinicialização do servidor forçada iniciada.\nO acesso dos jogadores foi bloqueado e o servidor será reiniciado em um minuto.");
                utf8encode(text, text);
                DCC_SetEmbedDescription(embed, text);
                DCC_SetEmbedColor(embed, 0x5964F4);
                format(footer, 128, "Ação realizada por %s#%s em %s no #%s.", user_name, discriminator, GetFullDate(gettime()), channel_name);
                utf8encode(footer, footer);
                DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");
                DCC_SendChannelEmbedMessage(DCC_FindChannelById("989305233299624007"), embed);

                GiveGMX();
                return true;
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
    ////////////////////////////////////////////////////////////////////////
    // DISCORD PÚBLICO
    if(!strcmp(channel_name, "bot-talk", true) && channel == DCC_FindChannelById("1070070693724700763")){
        DCC_SendChannelMessage(DCC_FindChannelById("1065815145151995966"), string);
        return true;
    }
    return true;
}

public PrivateMessageRegister(username[128], password[128]) {
    new text[256], footer[128], title[64], title_field[128], text_field[256];
    format(title, 64, "Registro concluído!");
    utf8encode(title, title);
    new DCC_Embed:embed = DCC_CreateEmbed(title);

    format(text, 256, "Bip-bip-bop-bip-bop-bip. Eis o seu registro para o **Closed Alpha**:\n");
    utf8encode(text, text);
    DCC_SetEmbedDescription(embed, text);

    format(title_field, 128, "Usuário registrado:");
    format(text_field, 256, "%s", username);
    utf8encode(title_field, title_field);
    utf8encode(text_field, text_field);
    DCC_AddEmbedField(embed, title_field, text_field, true);

    format(title_field, 128, "Senha registrada:");
    format(text_field, 256, "%s", password);
    utf8encode(title_field, title_field);
    utf8encode(text_field, text_field);
    DCC_AddEmbedField(embed, title_field, text_field, true);

    format(footer, 128, "Ação realizada em %s.", GetFullDate(gettime()));
    utf8encode(footer, footer);
    DCC_SetEmbedFooter(embed, footer, "https://i.imgur.com/Ijeje8z.png");

    DCC_SetEmbedColor(embed, 0x5964F4);
    DCC_SendChannelEmbedMessage(DCC_GetCreatedPrivateChannel(), embed);
    return true;
}