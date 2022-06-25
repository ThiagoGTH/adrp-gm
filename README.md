# Advanced Roleplay
#### SA-MP SERVER (0.0.1a - BETA)
 
Todas as tabelas serão criadas automaticamente graças ao [mysql_core.pwn](https://github.com/ThiagoGTH/advanced-roleplay-gm/blob/main/gamemodes/modules/core/database/mysql_core.pwn), então isso definitivamente não é uma preocupação. No entanto, o sampctl é uma obrigação, assim como o MySQL.

## Como instalar o Sampctl?

1. Abra o PowerShell em modo administrador;
2. Digite `set-executionpolicy remotesigned -scope currentuser`;
3. Installe o **Scoop** digitando `iex (new-object net.webclient).downloadstring('https://get.scoop.sh')`;
4. Instale o **SampCTL** digitando `scoop bucket add southclaws https://github.com/Southclaws/scoops.git; scoop install sampctl`.

## Como utilizar o Sampctl?

- `sampctl p(ackage) init` - inicializa um pacote do sampctl, isso é, o pawn.json e outros arquivos opcionais. Mas o pawn.json tem que ser sempre o mesmo pra todos nós, pra não dar conflito;
- `sampctl p(ackage) build` - compila o pacote com as informações dadas no pawn.json. Normalmente, você já pode usar esse comando automaticamente com a task gerada automaticamente pelo init. CTRL + SHIFT + B (você pode compilar mesmo com o GM aberto ou rodando no server;
- `sampctl p(ackage) run` - vai rodar o servidor no terminal, simplesmente isso;
- `sampctl p(ackage) ensure` - vai ter a certeza de que todas includes, dependência, subdependências e plugins estejam 100% atualizados.

Caso queira saber mais sobre o Sampctl, acesse o [repositório deles](https://github.com/Southclaws/sampctl).

Seguindo todos os passoas acima (corretamente), você conseguirá executar o servidor sem nenhum problema. 
Além do mais, todos os problemas, dúvidas ou questões que sejam acerca do **Paradise Roleplay** deverão serem enviadas ao [Raayzeck](https://github.com/Raayzeck/).
