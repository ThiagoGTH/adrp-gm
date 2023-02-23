# Advanced Roleplay
#### SA-MP SERVER (0.0.1a - BETA)

REGRA √öNICA REFOR√áADA: UTILIZEM A BRANCH `development`, TANTO PARA PULL REQUEST, QUANTO PARA HOTFIXES, WHATEVER. N√ÉO FA√áAM NENHUMA ALTERA√á√ÉO DIRETA OU INDIRETA √Ä BRANCH `main`. 

## Como fazer o setup do projeto local?
Passo √† passo:
1. [Clonando o Projeto](#clonando-o-projeto)
1. [Fazendo setup do banco de dados](#setup-do-banco-de-dados)
2. [Fazendo setup de ferramentas e arquivos necess√°rios](#setup-de-ferramentas-e-necessarios)
3. [Por fim, fazendo setup do gamemode](#setup-do-gamemode)

## Clonando o Projeto
Voc√™ vai ter rodar o b√°sico mesmo pra clonar o projeto, apenas. 
`git clone git@github.com:advanced-roleplay/gamemode.git`

## Setup do banco de dados
Antes do setup do banco de dados em si, voc√™ precisa criar uma cÛpia do `example.env` e renomear para `.env` apenas. 

O setup do banco de dados √© simples. Tudo o que voc√™s precisam fazer √© iniciar um banco de dados MySQL vazio, e o `sampctl` aqui e o prÛprio plugin que utilizamos no [`mysql_core.pwn`](gamemodes/modules/core/database/mysql_core.pwn) vai criar as tabelas e iniciar o banco em si. Preencha os valores das vari√°veis no `.env` com os dados do banco que voc√™ criou.

## Setup de ferramentas e necessarios
Por enquanto, a √∫nica ferramenta que utilizamos aqui √© o `sampctl`. Voc√™s podem seguir o [guia de instalaÁ„o dele aqui](docs/TOOLS.md), e tamb√©m tem um mini guia de utilizaÁ„o dos comandos.

Voc√™ vai precisar de alguns arquivos tamb√©m para que a build possa ocorrer sem problemas;

- [download dos arquivos de servidor OMP](https://github.com/openmultiplayer/server-beta/releases/tag/build10), colocar na pasta raiz do projeto
- [download do .dll do Pawn.CMD](https://github.com/katursis/Pawn.CMD/releases), colocar na pasta `components`

Antes de voc√™ poder utilizar o `sampctl` para instalaÁ„o e atualizaÁ„o dos pacotes, voc√™ vai ter que gerar um `token` no Github para poder utilizar a instalaÁ„o de pacotes sem limitaÁıes. 
Segue abaixo o passo-a-passo:

- Acesse [`configuraÁıes`](https://github.com/settings/profile) do Github;
- No menu lateral esquerdo, v√° at√© o √∫ltimo item, `configuraÁıes de desenvolvedor`;
- Em ConfiguraÁıes do Desenvolvedor, clique em `token de acesso pessoal` e selecione o `tokens(cl√°ssico)`;
- Clique em `gerar novo token` e nomeie como voc√™ quiser. Selecione a opÁ„o de permissıes para `write:packages` (com a sub-opÁ„o escolhida)
- √â interessante voc√™ setar o token sem tempo para expirar, ou vai ter que fazer isso todo m√™s.
- Copie seu token.
  
Agora que possui seu token, voc√™ precisa dar acesso a ele para o `sampctl`;
- Aperte `Bot„o do Windows + r` e digite `%AppData%`;
- Acesse a pasta do `sampctl` e abra o arquivo `config.json`
- Preencha o campo "github_token": `seu_token`, caso n„o tenha o campo, adicione ele;
- Feito. 


ApÛs fazer toda a instalaÁ„o do necess√°rio, voc√™ pode partir pro setup do gamemode.

## Setup do Gamemode

Antes de tudo, agora, voc√™ vai fazer a instalaÁ„o das depend√™ncias do projeto, os pacotes. Voc√™ vai rodar `sampctl p ensure`, e ele te dar√° a certeza de que os pacotes foram instalados corretamente. O resultado deve ser `INFO: ensured dependencies for package`.

Logo apÛs, voc√™ vai buildar o projeto, rodando `sampctl p build`. Agora, tenha certeza que os arquivos `libmariadb.dll`, `log-core.dll`, `log-core2.dll` foram gerados.

E ent„o, √© sÛ voc√™ rodar `sampctl p run` e o gamemode vai rodar.

Qualquer outra d√∫vida, entrem em contato com Philipe ou Thiago.

## Erros comuns & Possiveis Solucoes

```
CConnection::CConnection - establishing connection to MySQL database failed: #2019 'Can't initialize character set unknown (path: compiled_in)'
```
**Poss√≠vel SoluÁ„o**: Comentar a linha `mysql_set_charset("latin1");` no mysql_core.pwn


```
servidor rodando 0.3.7-R2
```
**Poss√≠vel SoluÁ„o**: `windows + r` -> `%AppData%` -> joga [isso](https://cdn.discordapp.com/attachments/932385744083882074/1012906340382953583/samp03DL_svr_R1_win32.zip) na pasta do sampctl l√°. 
Checa `pawn.json` na pasta raiz do gamemode se t√° a vers„o 0.3DL, e lembre-se de rodar `sampctl p ensure`.

NOTA: 
Lembre-se de que sempre que voc√™ passar por um erro no setup, venha at√© aqui e adicione ele com a sua solu√ß√£o como **Poss√≠vel Solu√ß√£o** para o pr√≥ximo desenvolvedor que lidar com ele.

```
runtime version bugando
```
**Solu√ß√£o:** `windows + r` -> `%AppData%` -> `/sampctl/` -> apaga todos os arquivos .zip da pasta ra√≠z e tenta iniciar o servidor novamente

