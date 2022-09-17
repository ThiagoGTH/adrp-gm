/*
	Script Version: v1
	This FilterScript was created by Dennis12
	LEAKS.RO  -> leaks.ro/profile/411-dennis12/
	SA-MP.RO  -> www.sa-mp.ro/profile/20571-dennis12/
	SA-MP.COM -> forum.sa-mp.com/member.php?u=305443
*/

#define FILTERSCRIPT

#include <a_samp>
#include <zcmd>

#if defined FILTERSCRIPT

#define D12_MESSAGE SendClientMessage
#define COLOR_YELLOW 0xFFFF00AA

public OnFilterScriptInit()
{
	for(new i = 0, x = 50; i < x; i++) SendClientMessageToAll(-1,"");
	print("This FilterScript was created by Dennis12( D12 ).");
	print("For help, type the [/help] command in the game.");
	print("Or read this topic: https ...");
	return 1;
}
public OnFilterScriptExit()
{
	print("Thanks for using 'D12 ATTACHMENTS OBJECT EDITOR'!");
	return 1;
}
public OnPlayerSpawn(playerid) {
	SetPlayerPos(playerid, 112.6015,-162.6049,1.5781);
	D12_MESSAGE(playerid,0xFF0000FF,"[D12 ATTACHMENTS OBJECT EDITOR]");
	D12_MESSAGE(playerid,0xFF0000FF,"This FilterScript was created by Dennis12.");
	D12_MESSAGE(playerid,0xFF0000FF,"For help, type the [/help] command.");
	return 1;
}


// Enums
enum D12_ATTACHED_OBJECT {
	objectID,
	objectSlot,
	objectBone,
	Float: objectPos[3],
	Float: objectRot[3],
	Float: objectScale[3]
};
new D12_AO[MAX_PLAYERS][MAX_PLAYER_ATTACHED_OBJECTS][D12_ATTACHED_OBJECT];

enum { D_EDITOBJECT, D_CLEARSLOT, D_EDITSLOT };

// Commmands
COMMAND:attach(playerid) {
	new szStr[256];
	format(szStr, 256, "Slot 0[objectid: %d]\nSlot 1[objectid: %d]\nSlot 2[objectid: %d]\nSlot 3[objectid: %d]\nSlot 4[objectid: %d]\nSlot 5[objectid: %d]\nSlot 6[objectid: %d]\nSlot 7[objectid: %d]\nSlot 8[objectid: %d]\nSlot 9[objectid: %d]",
	D12_AO[playerid][0][objectID], D12_AO[playerid][1][objectID],D12_AO[playerid][2][objectID],D12_AO[playerid][3][objectID],D12_AO[playerid][4][objectID],D12_AO[playerid][5][objectID],D12_AO[playerid][6][objectID],D12_AO[playerid][7][objectID],D12_AO[playerid][8][objectID],D12_AO[playerid][9][objectID]);
	ShowPlayerDialog(playerid, D_EDITSLOT, DIALOG_STYLE_LIST, "[D12] Attach Object:",szStr,"Edit","Cancel");
	return true;
}
COMMAND:saveattach(playerid, params[]) {
	new
		File: attach,
	    writeAttach[ 512 ],
		writeObjects;

	if(!fexist("attach.pwn")) {
		attach = fopen("attach.pwn", io_write);
		fclose(attach);
	} attach = fopen("attach.pwn", io_append);

	if(isnull(params)) return D12_MESSAGE(playerid,0xFF0000FF,"You need to write a project name to save your project."), D12_MESSAGE(playerid,COLOR_YELLOW,"/saveattach <project name>");

	for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
		if(D12_AO[playerid][i][objectID] != 0) {
			format(writeAttach, 512, "\nDENNIS12 ATTACHED OBJECT CREATOR\n\n//Slot %d | Project Name: %s\nSetPlayerAttachedObject(playerid, %d, %d, %d, %f, %f, %f, %f, %f, %f, %f, %f, %f);\r\n",
			      D12_AO[playerid][i][objectSlot], params, D12_AO[playerid][i][objectSlot], D12_AO[playerid][i][objectID],D12_AO[playerid][i][objectBone],D12_AO[playerid][i][objectPos][0],D12_AO[playerid][i][objectPos][1],D12_AO[playerid][i][objectPos][2],D12_AO[playerid][i][objectRot][0],D12_AO[playerid][i][objectRot][1],D12_AO[playerid][i][objectRot][2],
			      D12_AO[playerid][i][objectScale][0],D12_AO[playerid][i][objectScale][1],D12_AO[playerid][i][objectScale][2]);

			fwrite(attach, writeAttach);
			writeObjects ++;
		}
	}
	if(!writeObjects) return D12_MESSAGE(playerid,0xFF0000FF,"There is nothing you can export.");

	fclose(attach);
	D12_MESSAGE(playerid, -1, writeAttach),D12_MESSAGE(playerid, COLOR_YELLOW, "[D12 Attached Object Editor]"),D12_MESSAGE(playerid, COLOR_YELLOW, "Attached objects were saved in the file attach.pwn."),D12_MESSAGE(playerid, COLOR_YELLOW, "The file 'attach' can be found in scriptfiles -> attach.pwn.");
	return true;
}
COMMAND:clearattach(playerid) {
	new szStr[ 256 ];
	format(szStr,256,"Clear Slots\nSlot 0[objectid: %d]\nSlot 1[objectid: %d]\nSlot 2[objectid: %d]\nSlot 3[objectid: %d]\nSlot 4[objectid: %d]\nSlot 5[objectid: %d]\nSlot 6[objectid: %d]\nSlot 7[objectid: %d]\nSlot 8[objectid: %d]\nSlot 9[objectid: %d]",
	D12_AO[playerid][0][objectID], D12_AO[playerid][1][objectID],D12_AO[playerid][2][objectID],D12_AO[playerid][3][objectID],D12_AO[playerid][4][objectID],D12_AO[playerid][5][objectID],D12_AO[playerid][6][objectID],D12_AO[playerid][7][objectID],D12_AO[playerid][8][objectID],D12_AO[playerid][9][objectID]);
	ShowPlayerDialog(playerid, D_CLEARSLOT, DIALOG_STYLE_LIST, "[D12] Clear Slots:",szStr,"Clear","Cancel");
	return true;
}
COMMAND:editattach(playerid) {
	new szStr[ 256 ];
	format(szStr,256,"Slot 0[objectid: %d]\nSlot 1[objectid: %d]\nSlot 2[objectid: %d]\nSlot 3[objectid: %d]\nSlot 4[objectid: %d]\nSlot 5[objectid: %d]\nSlot 6[objectid: %d]\nSlot 7[objectid: %d]\nSlot 8[objectid: %d]\nSlot 9[objectid: %d]",
	D12_AO[playerid][0][objectID], D12_AO[playerid][1][objectID],D12_AO[playerid][2][objectID],D12_AO[playerid][3][objectID],D12_AO[playerid][4][objectID],D12_AO[playerid][5][objectID],D12_AO[playerid][6][objectID],D12_AO[playerid][7][objectID],D12_AO[playerid][8][objectID],D12_AO[playerid][9][objectID]);
	ShowPlayerDialog(playerid, D_EDITOBJECT, DIALOG_STYLE_LIST, "[D12] Edit Slots:",szStr,"Edit","Cancel");
	return true;
}
COMMAND:clearfile(playerid) {
	new File: attach;

	if(fexist("attach.pwn")) {
		attach = fopen("attach.pwn", io_write);
		fwrite(attach,"");
		fclose(attach);
		D12_MESSAGE(playerid,COLOR_YELLOW,"The attach.pwn has been cleared.");
	} else D12_MESSAGE(playerid, 0xFF0000FF, "The attach.pwn file could not be found in the scriptfiles folder.");
	return true;
}
COMMAND:help(playerid) {
	new dialog[1024];
	dialog[0] = EOS;
	strcat(dialog,"{FFFFFF}D12 Attachments Object Editor\n\n");
	strcat(dialog,"{FFFFFF}/attach      -> To attach an object to one of the 9 slots.\n");
	strcat(dialog,"{FFFFFF}/editattach  -> To edit an attached object.\n");
	strcat(dialog,"{FFFFFF}/clearattach -> To delete the object on one of the 9 slots.\n");
	strcat(dialog,"{FFFFFF}/saveattach  -> To save your progress into [scriptfiles/attach.pwn].\n");
	strcat(dialog,"{FFFFFF}/clearfile   -> To delete the contents of the attach.pwn file.");
	ShowPlayerDialog(playerid, 69, DIALOG_STYLE_MSGBOX,"D12 Attachments Editor Help",dialog,"Thanks","");
	return true;
}

public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[]) {
	switch(dialogid) {
		case D_EDITOBJECT: {
			if(!response) return true;
			switch(listitem) {
				case 0 .. 9: {
					if(D12_AO[playerid][listitem][objectID] == 0) return D12_MESSAGE(playerid,0xFF0000FF,"You have no object attached to this slot.");
					EditAttachedObject(playerid, listitem);
					new string[ 64 ];
					format(string, 64, "You are now editing attached object in the slot %d.", listitem);
					D12_MESSAGE(playerid,COLOR_YELLOW,string);
				}
			}
		}
		case D_CLEARSLOT: {
			if(!response) return true;
			switch(listitem) {
				case 0: {
					for(new i = 0; i < MAX_PLAYER_ATTACHED_OBJECTS; i++) {
						if(D12_AO[playerid][i][objectID] != 0) RemovePlayerAttachedObject(playerid, i);
						D12_AO[playerid][i][objectID] = 0;
					}
					D12_MESSAGE(playerid,COLOR_YELLOW,"All attachments have been deleted.");
				}
				case 1 .. 10: {
					if(D12_AO[playerid][listitem-1][objectID] == 0) return D12_MESSAGE(playerid,0xFF0000FF,"You have no object attached to this slot.");
					D12_AO[playerid][listitem-1][objectID] = 0;

					if(IsPlayerAttachedObjectSlotUsed(playerid, listitem-1))
						RemovePlayerAttachedObject(playerid, listitem-1);

					new string[64];
					format(string, 64, "You deleted the attached object in the slot %d.",listitem-1);
					D12_MESSAGE(playerid,0xFF0000FF,string);
				}
			}
		}
		case D_EDITSLOT: {
			if(!response) return true;
			switch(listitem) {
				case 0 .. 9: {
					if(D12_AO[playerid][listitem][objectID] != 0) return D12_MESSAGE(playerid,-1,"You already have an object attached to this slot. Use [/clearattach].");
					new szTitle[20], szString[64];
					SetPVarInt(playerid,"selectedSlot", listitem);
					format(szTitle, 20,"Editing Slot: %d", GetPVarInt(playerid,"selectedSlot"));
					format(szString,64,"Type the object ID you want to attach for slot %d", GetPVarInt(playerid,"selectedSlot"));
					ShowPlayerDialog(playerid,D_EDITSLOT+1,DIALOG_STYLE_INPUT,szTitle,szString,"Done","Cancel");
					SetPVarInt(playerid,"editSlotStep",0);
				}
			}
		}
		case D_EDITSLOT+1: {
			if(!response) return DeletePVar(playerid,"objectID"), DeletePVar(playerid,"objectBone");
			switch(GetPVarInt(playerid,"editSlotStep")) {
				case 0: {
					if(isnull(inputtext)) return D12_MESSAGE(playerid,0xFF0000FF,"Invalid objectid");
					SetPVarInt(playerid,"objectID", strval(inputtext));
					SetPVarInt(playerid,"editSlotStep", 1);
					ShowPlayerDialog(playerid,D_EDITSLOT+1,DIALOG_STYLE_LIST,"[D12 OC] Select Bone","Spine\nHead\nLeft Upper Arm\nRight Upper Arm\nLeft Hand\nRight Hand\nLeft Tigh\nRight Tigh\nLeft Foot\nRight Foot\nRight Calf\nLeft Calf\nLeft forearm\nRight forearm\nLeft clavicle (shoulder)\nRight clavicle (shoulder)\nNeck\nJaw","Select","Close");
				}
				case 1: {
					switch(listitem) {
						case 0 .. 17: {
							SetPVarInt(playerid, "objectBone", listitem+1);
							SetPVarInt(playerid, "editSlotStep", 2);
							ShowPlayerDialog(playerid,D_EDITSLOT+1,DIALOG_STYLE_MSGBOX,"[D12 OC] Save Settings","You want to create your object by your settings?","Yes","No");
						}
					}
				}
				case 2: {
				    new slot = GetPVarInt(playerid,"selectedSlot");
                    D12_AO[playerid][slot][objectID] 	 = GetPVarInt(playerid,"objectID");
					D12_AO[playerid][slot][objectSlot]   = GetPVarInt(playerid,"selectedSlot");
					D12_AO[playerid][slot][objectBone]   = GetPVarInt(playerid,"objectBone");
					D12_AO[playerid][slot][objectPos][0] = 0.0;
					D12_AO[playerid][slot][objectPos][1] = 0.0;
					D12_AO[playerid][slot][objectPos][2] = 0.0;
					D12_AO[playerid][slot][objectRot][0] = 0.0;
					D12_AO[playerid][slot][objectRot][1] = 0.0;
					D12_AO[playerid][slot][objectRot][2] = 0.0;
					D12_AO[playerid][slot][objectScale][0] = 1.0;
					D12_AO[playerid][slot][objectScale][1] = 1.0;
					D12_AO[playerid][slot][objectScale][2] = 1.0;

					SetPlayerAttachedObject(playerid,D12_AO[playerid][slot][objectSlot],D12_AO[playerid][slot][objectID],D12_AO[playerid][slot][objectBone],D12_AO[playerid][slot][objectPos][0],D12_AO[playerid][slot][objectPos][1],D12_AO[playerid][slot][objectPos][2],D12_AO[playerid][slot][objectRot][0],D12_AO[playerid][slot][objectRot][1],D12_AO[playerid][slot][objectRot][2],D12_AO[playerid][slot][objectScale][0],D12_AO[playerid][slot][objectScale][1],D12_AO[playerid][slot][objectScale][2]);
					EditAttachedObject(playerid, D12_AO[playerid][slot][objectSlot]);
				}
			}
		}
	}
	return true;
}

public OnPlayerEditAttachedObject(playerid, response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	switch(response) {
		case 0: {
			D12_AO[playerid][index][objectID]   = 0;
			D12_AO[playerid][index][objectBone] = 0;
			D12_AO[playerid][index][objectSlot] = 0;

			if(IsPlayerAttachedObjectSlotUsed(playerid, index)) RemovePlayerAttachedObject(playerid, index);

			D12_MESSAGE(playerid,COLOR_YELLOW,"Object not saved.");
		}
		case 1: {
			D12_AO[playerid][index][objectPos][0]   = fOffsetX;
			D12_AO[playerid][index][objectPos][1]   = fOffsetY;
			D12_AO[playerid][index][objectPos][2]   = fOffsetZ;
            D12_AO[playerid][index][objectRot][0]   = fRotX;
            D12_AO[playerid][index][objectRot][1]   = fRotY;
            D12_AO[playerid][index][objectRot][2]   = fRotZ;
            D12_AO[playerid][index][objectScale][0] = fScaleX;
            D12_AO[playerid][index][objectScale][1] = fScaleY;
            D12_AO[playerid][index][objectScale][2] = fScaleZ;

			if(IsPlayerAttachedObjectSlotUsed(playerid, index)) RemovePlayerAttachedObject(playerid, index);

            SetPlayerAttachedObject(playerid,D12_AO[playerid][index][objectSlot],D12_AO[playerid][index][objectID],D12_AO[playerid][index][objectBone],D12_AO[playerid][index][objectPos][0],D12_AO[playerid][index][objectPos][1],D12_AO[playerid][index][objectPos][2],D12_AO[playerid][index][objectRot][0],D12_AO[playerid][index][objectRot][1],D12_AO[playerid][index][objectRot][2],D12_AO[playerid][index][objectScale][0],D12_AO[playerid][index][objectScale][1],D12_AO[playerid][index][objectScale][2]);

			D12_MESSAGE(playerid,COLOR_YELLOW,"Object saved.");
		}
	}
	return true;
}
#endif
