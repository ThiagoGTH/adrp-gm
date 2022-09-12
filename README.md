# Advanced Roleplay
#### SA-MP SERVER (0.0.1a - BETA)
 
Todas as tabelas serão criadas automaticamente graças ao [mysql_core.pwn](https://github.com/ThiagoGTH/advanced-roleplay-gm/blob/main/gamemodes/modules/core/database/mysql_core.pwn), então isso definitivamente não é uma preocupação. No entanto, o sampctl é uma obrigação, assim como o MySQL.

## Como instalar o Sampctl?

1. Abra o PowerShell;
2. Digite `set-executionpolicy remotesigned -scope currentuser`;
3. Installe o **Scoop** digitando `iex (new-object net.webclient).downloadstring('https://get.scoop.sh')`;
4. Instale o **SampCTL** digitando `scoop bucket add southclaws https://github.com/Southclaws/scoops.git; scoop install sampctl`.

## Como utilizar o Sampctl? (little guide by: Dobby)

sampctl p init - inits sampctl. lets you set up pawn.json/yml.
sampctl p install <username:version> - Installs a package. EG: sampctl p install pawn-lang/samp-stdlib
sampctl p uninstall <package name> - What it says on the tin. 
sampctl p build builds the mode. 
sampctl p run runs the mode
sampctl p run --container runs it in a container if you use docker. 
sampctl p ensure - Downloads all the packages again from your dependencies: section in pawn.json.
sampctl p autocomplete - Generates an autocomplete file for your shell (bash for me). 

You can append --verbose to any of the commands for verbose output.
You can append --help to any command for help on that specific command. Just sampctl --help for the main one. 

It gets the packages based on your operating system. So if your servers on Linux, it'll grab the Linux binaries. Same with Windows. You can automatically do this via sampctl p ensure --platform linux.

Caso queira saber mais sobre o Sampctl, acesse o [repositório deles](https://github.com/Southclaws/sampctl).

Seguindo todos os passoas acima (corretamente), você conseguirá executar o servidor sem nenhum problema. 
Além do mais, todos os problemas, dúvidas ou questões que sejam acerca do **Advanced Roleplay** deverão serem enviadas ao [Thiago](https://github.com/ThiagoGTH/).
