#include <YSI_Coding\y_hooks>

stock discord(DCC_Channel:channelid, text[], {Float, _}:...)
{
    new out[1024];
    va_format(out, sizeof out, text, va_start<2>), utf8encode(text, out, 1024);
    DCC_SendChannelMessage(channelid, out);
    return 1;
}

public OnDiscordCommandPerformed(DCC_User:user, DCC_Channel:channel, cmdtext[], success) {

    if(!success) {
        new 
            DCC_User:author,
            DCC_Message:message,
            DCC_Guild:guild,
            bool:IsBot,
            string[256],
            authorName[DCC_NICKNAME_SIZE];

        DCC_GetMessageChannel(message, channel);
        DCC_GetMessageAuthor(message, author);
        DCC_IsUserBot(author, IsBot);
        DCC_GetGuildMemberNickname(guild, user, authorName, sizeof(authorName));
        DCC_GetUserName(user, authorName, sizeof(authorName));


        if(channel == DC_BotChannel && !IsBot)
        {
            new DCC_Embed:embed = DCC_CreateEmbed("Comando invalido!", "Digite **!ajuda** para receber a lista de comandos.");
            DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
            DCC_SetEmbedColor(embed, 15548997);
            format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
            DCC_SetEmbedFooter(embed, string);
            DCC_SendChannelEmbedMessage(channel, embed);
        }
    }
    return 1;
}

DCMD:teste(user, channel, params[]) {
	DCC_SendChannelMessage(channel, "Olá!");
    new authorName[DCC_NICKNAME_SIZE];
    new DCC_Guild:guild;
    new string[256];
    DCC_GetGuildMemberNickname(guild, user, authorName, sizeof(authorName));
    DCC_GetUserName(user, authorName, sizeof(authorName));
    format(string, sizeof(string), "oi %s", authorName);
	DCC_SendChannelMessage(channel, string);

	return 1;
}

DCMD:ooc(user, channel, params[]) {
    new string[256], authorName[DCC_NICKNAME_SIZE];
    new 
        DCC_User:author,
        DCC_Message:message,
        DCC_Guild:guild;

    DCC_GetMessageChannel(message, channel);
    DCC_GetMessageAuthor(message, author);
    DCC_GetGuildMemberNickname(guild, user, authorName, sizeof(authorName));
    DCC_GetUserName(user, authorName, sizeof(authorName));
    
    if(channel != DC_BotChannel){
        new DCC_Embed:embed = DCC_CreateEmbed("Acesso negado!", "Realize o comando no <#894436274298060831>.");
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
        DCC_SetEmbedColor(embed, 15548997);
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed); 
        return 1;
    }

    if(isnull(params)) {
        new DCC_Embed:embed = DCC_CreateEmbed("Mensagem OOC", "Uso invalido. USE: !ooc Texto");
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
        DCC_SetEmbedColor(embed, 15548997);
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed);
        return 1;
    } 

	format(string, sizeof string, "(( [OOC] %s: %s ))", authorName, params);
    SendClientMessageToAll(0xB1C8FBAA, string);

    new DCC_Embed:embed = DCC_CreateEmbed("Mensagem enviada com sucesso!");
    DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352075188752484.png");
    DCC_SetEmbedColor(embed, 5793266);
    format(string, sizeof string, "A mensagem ''**%s**'' foi enviada aos jogadores onlines.", params);
    DCC_SetEmbedDescription(embed, string);
    format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
    DCC_SetEmbedFooter(embed, string);
    DCC_SendChannelEmbedMessage(channel, embed); 


    format(string, sizeof string, "`DISCORD-OOC:` [%s] Mensagem OOC enviada pelo Discord por %s: %s.", ReturnDate(), authorName, params);
    DCC_SendChannelMessage(DC_AdminCMD, string);
    return 1;
}

DCMD:gmx(user, channel, args) {
    new string[256], authorName[DCC_NICKNAME_SIZE];
    new 
        DCC_User:author,
        DCC_Message:message,
        DCC_Guild:guild;
        
    DCC_GetMessageChannel(message, channel);
    DCC_GetMessageAuthor(message, author);
    DCC_GetGuildMemberNickname(guild, user, authorName, sizeof(authorName));
    DCC_GetUserName(user, authorName, sizeof(authorName));
    
    if(channel != DC_BotChannelHead){
        new DCC_Embed:embed = DCC_CreateEmbed("Acesso negado!", "Comando privado para Head+.");
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
        DCC_SetEmbedColor(embed, 15548997);
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed); 
        return 1;
    }

    new DCC_Embed:embed = DCC_CreateEmbed("Comando realizado com sucesso!", "Servidor sera reiniciado em cinco minutos.");
    DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352075188752484.png");
    DCC_SetEmbedColor(embed, 5793266);
    format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
    DCC_SetEmbedFooter(embed, string);
    DCC_SendChannelEmbedMessage(channel, embed); 

    GiveGMX();
    return 1;
}
/*
DCMD:kick(user, channel, params[]) {
{
    new targetid, reason[128], string[512];
    if(sscanf(args, "us[128]", targetid, reason)) return SendDC(CHANNEL_ID, "**USE:** `!kick [playerid] [motivo]`");
    if(!IsPlayerConnected(targetid)) return SendDC(CHANNEL_ID, "**ERRO:** Jogador desconectado.");

    SendDC(CHANNEL_ID, "%s, o jogador %s foi kickado do servidor.", user, pNome(targetid));

    format(string, sizeof(string), "DiscordCmd: %s kickou %s, motivo: %s.", user, pNome(targetid), reason);
	SendClientMessageToAll(COLOR_LIGHTRED, string);

    SetTimerEx("Kick_Ex", 400, false, "i", targetid);
    return 1;
}*/

DCMD:onlines(user, channel, args){
    new count = 0;
	new name[24], string[256], string2[256], authorName[DCC_NICKNAME_SIZE];

    new 
        DCC_User:author,
        DCC_Message:message,
        DCC_Guild:guild;

    DCC_GetMessageChannel(message, channel);
    DCC_GetMessageAuthor(message, author);
    DCC_GetGuildMemberNickname(guild, user, authorName, sizeof(authorName));
    DCC_GetUserName(user, authorName, sizeof(authorName));
    
    if(channel != DC_BotChannel){
        new DCC_Embed:embed = DCC_CreateEmbed("Acesso negado!", "Realize o comando no <#894436274298060831>.");
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
        DCC_SetEmbedColor(embed, 15548997);
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed); 
        return 1;
    }
    new DCC_Embed:embed2 = DCC_CreateEmbed("Jogadores online:");
    DCC_SetEmbedThumbnail(embed2, "https://cdn.discordapp.com/emojis/894352074698018887.png");
    DCC_SetEmbedColor(embed2, 5793266);
	for(new i=0; i < MAX_PLAYERS; i++) {
	if(!IsPlayerConnected(i)) continue;
	GetPlayerName(i, name, MAX_PLAYER_NAME);
	{
        format(string, sizeof string, "**%s** [ID: %d]", pNome(i), i);
        format(string2, sizeof string2, "IP: %s", PlayerIP(i));
        DCC_AddEmbedField(embed2, string, string2, false);
	    count++; }
	}
    format(string, sizeof string, "Total de jogadores online: %d", count);
    DCC_SetEmbedDescription(embed2, string);  
	if (count == 0) {
        new DCC_Embed:embed = DCC_CreateEmbed("JOGADORES ONLINE", "Nao possui nenhum jogador online no momento.");
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
        DCC_SetEmbedColor(embed, 15548997);
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed);
        return 1;
    }
    format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
    DCC_SetEmbedFooter(embed2, string);
    DCC_SendChannelEmbedMessage(channel, embed2);
	return 1;
}

DCMD:usuario(user, channel, params[]) {
    new userValue[24], string[256], authorName[DCC_NICKNAME_SIZE];

    new 
        DCC_User:author,
        DCC_Message:message,
        DCC_Guild:guild;

    DCC_GetMessageChannel(message, channel);
    DCC_GetMessageAuthor(message, author);
    DCC_GetGuildMemberNickname(guild, user, authorName, sizeof(authorName));
    DCC_GetUserName(user, authorName, sizeof(authorName));

    if(channel != DC_BotChannel){
        new DCC_Embed:embed = DCC_CreateEmbed("Acesso negado!", "Realize o comando no <#894436274298060831>.");
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
        DCC_SetEmbedColor(embed, 15548997);
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed); 
        return 1;
    }
    if(isnull(params)) {
        new DCC_Embed:embed = DCC_CreateEmbed("Usuario do personagem", "Uso invalido. USE: !usuario [Nome_Sobrenome]");
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
        DCC_SetEmbedColor(embed, 15548997);
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed);
        return 1;
    } 

    mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `name` = '%s';", params);
    mysql_query(DBConn, query);
 
    if(!cache_num_rows()){
        new DCC_Embed:embed = DCC_CreateEmbed("Usuario do personagem", "Nao foi possivel encontrar um personagem com o nome digitado.");
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
        DCC_SetEmbedColor(embed, 15548997);
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed);
        return 1;
    }
        
    cache_get_value_name(0, "user", userValue);

    format(string, sizeof string, "Usuario de %s:", params);
    new DCC_Embed:embed = DCC_CreateEmbed(string);
    DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352075188752484.png");
    DCC_SetEmbedColor(embed, 5793266);
    format(string, sizeof string, "%s", userValue);
    DCC_AddEmbedField(embed, "Usuario", string, true);
    DCC_AddEmbedField(embed, "Personagem", params, true);
    format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
    DCC_SetEmbedFooter(embed, string);
    DCC_SendChannelEmbedMessage(channel, embed); 
    return 1;
}


DCMD:personagens(user, channel, params[]) {
    new characterValue[24], lastLogin, string[256], string2[256], authorName[DCC_NICKNAME_SIZE];

    new 
        DCC_User:author,
        DCC_Message:message,
        bool:IsBot,
        DCC_Guild:guild;

    DCC_GetMessageChannel(message, channel);
    DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);
    DCC_GetGuildMemberNickname(guild, user, authorName, sizeof(authorName));
    DCC_GetUserName(user, authorName, sizeof(authorName));

    if(channel == DC_BotChannel && !IsBot){
        if(isnull(params)) {
            new DCC_Embed:embed = DCC_CreateEmbed("Personagens do usuario", "Uso invalido. USE: !personagens [usuario]");
            DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
            DCC_SetEmbedColor(embed, 15548997);
            format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
            DCC_SetEmbedFooter(embed, string);
            DCC_SendChannelEmbedMessage(channel, embed);
            return 1;
        } 

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM users WHERE `username` = '%s';", params);
        mysql_query(DBConn, query);

        if(!cache_num_rows()){
            new DCC_Embed:embed = DCC_CreateEmbed("Personagens do usuario", "O usuario especificado nao existe.");
            DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352160601571349.png");
            DCC_SetEmbedColor(embed, 15548997);
            format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
            DCC_SetEmbedFooter(embed, string);
            DCC_SendChannelEmbedMessage(channel, embed);
            return 1;
        }

        mysql_format(DBConn, query, sizeof query, "SELECT * FROM players WHERE `user` = '%s';", params);
        mysql_query(DBConn, query);

        if(!cache_num_rows()){
            new DCC_Embed:embed = DCC_CreateEmbed("Personagens do usuario", "Este usuario nao tem nenhum personagem ainda.");
            DCC_SetEmbedColor(embed, 5793266);
            DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352075188752484.png");
            format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
            DCC_SetEmbedFooter(embed, string);
            DCC_SendChannelEmbedMessage(channel, embed);
            return 1;
        }
        format(string, sizeof string, "Personagens de %s:", params);
        new DCC_Embed:embed = DCC_CreateEmbed(string);
        DCC_SetEmbedThumbnail(embed, "https://cdn.discordapp.com/emojis/894352075188752484.png");
        DCC_SetEmbedColor(embed, 5793266);
        for(new i; i < cache_num_rows(); i++) {
            cache_get_value_name(i, "name", characterValue);
            cache_get_value_name_int(i, "last_login", lastLogin);

            format(string, sizeof string, "**%s** (%s)", characterValue, GetPlayerByName(characterValue) == -1 ? ("OFFLINE") : ("ONLINE"));
            format(string2, sizeof string2, "UL: %s", GetFullDate(lastLogin, 1));
            DCC_AddEmbedField(embed, string, string2, false);
        }
        format(string, sizeof(string), "Comando realizado por %s as %s", authorName, ReturnDate());
        DCC_SetEmbedFooter(embed, string);
        DCC_SendChannelEmbedMessage(channel, embed);
    }
    return 1;
}

forward DCC_OnMessageCreate(DCC_Message:message);
public DCC_OnMessageCreate(DCC_Message:message)
{
    new DCC_Channel:channel;
    new bool:IsBot;
    DCC_GetMessageChannel(message, channel);
    new DCC_User:author;
    DCC_GetMessageAuthor(message, author);
    DCC_IsUserBot(author, IsBot);
    if(channel == DC_ChatAdmin && !IsBot) 
    {
        new realMsg[100];
        DCC_GetMessageContent(message, realMsg, 100);
        new user_name[32 + 1], str[152];
        DCC_GetUserName(author, user_name, 32);
        format(str, sizeof(str), "[Discord] %s: %s", user_name, realMsg);
		admin_chat(COR_ADMINCHAT , str, 1);
    }
    return 1;
} 

hook OnPlayerConnect(playerid)
{
	new string[128];
    format(string, sizeof string, "`CONNECT:` [%s] **%s** *(%s)* conectou no servidor.", ReturnDate(), GetPlayerNameEx(playerid), PlayerIP(playerid));
    DCC_SendChannelMessage(DC_EntrouSaiu, string);
    return true;
}

hook OnPlayerDisconnect(playerid)
{
    new string[128];
    format(string, sizeof string, "`DISCONNECT:` [%s] **%s** *(%s)* saiu do servidor.", ReturnDate(), GetPlayerNameEx(playerid), PlayerIP(playerid));
    DCC_SendChannelMessage(DC_EntrouSaiu, string);
    return true;
}