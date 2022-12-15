# Advanced Roleplay
#### SA-MP SERVER (0.0.1a - BETA)

REGRA ÃšNICA REFORÃ‡ADA: UTILIZEM A BRANCH `development`, TANTO PARA PULL REQUEST, QUANTO PARA HOTFIXES, WHATEVER. NÃƒO FAÃ‡AM NENHUMA ALTERAÃ‡ÃƒO DIRETA OU INDIRETA Ã€ BRANCH `main`. 

## Como fazer o setup do projeto local?
Passo Ã  passo:
1. [Clonando o Projeto](#clonando-o-projeto)
1. [Fazendo setup do banco de dados](#setup-do-banco-de-dados)
2. [Fazendo setup de ferramentas e arquivos necessÃ¡rios](#setup-de-ferramentas-e-necessarios)
3. [Por fim, fazendo setup do gamemode](#setup-do-gamemode)

## Clonando o Projeto
VocÃª vai ter rodar o bÃ¡sico mesmo pra clonar o projeto, apenas. 
`git clone git@github.com:advanced-roleplay/gamemode.git`

## Setup do banco de dados
Antes do setup do banco de dados em si, vocÃª precisa criar uma cópia do `example.env` e renomear para `.env` apenas. 

O setup do banco de dados Ã© simples. Tudo o que vocÃªs precisam fazer Ã© iniciar um banco de dados MySQL vazio, e o `sampctl` aqui e o próprio plugin que utilizamos no [`mysql_core.pwn`](gamemodes/modules/core/database/mysql_core.pwn) vai criar as tabelas e iniciar o banco em si. Preencha os valores das variÃ¡veis no `.env` com os dados do banco que vocÃª criou.

## Setup de ferramentas e necessarios
Por enquanto, a Ãºnica ferramenta que utilizamos aqui Ã© o `sampctl`. VocÃªs podem seguir o [guia de instalação dele aqui](docs/TOOLS.md), e tambÃ©m tem um mini guia de utilização dos comandos.

VocÃª vai precisar de alguns arquivos tambÃ©m para que a build possa ocorrer sem problemas;

- [download dos arquivos de servidor OMP](https://github.com/openmultiplayer/server-beta/releases/tag/build10), colocar na pasta raiz do projeto
- [download do .dll do Pawn.CMD](https://github.com/katursis/Pawn.CMD/releases), colocar na pasta `components`

Antes de vocÃª poder utilizar o `sampctl` para instalação e atualização dos pacotes, vocÃª vai ter que gerar um `token` no Github para poder utilizar a instalação de pacotes sem limitações. 
Segue abaixo o passo-a-passo:

- Acesse [`configurações`](https://github.com/settings/profile) do Github;
- No menu lateral esquerdo, vÃ¡ atÃ© o Ãºltimo item, `configurações de desenvolvedor`;
- Em Configurações do Desenvolvedor, clique em `token de acesso pessoal` e selecione o `tokens(clÃ¡ssico)`;
- Clique em `gerar novo token` e nomeie como vocÃª quiser. Selecione a opção de permissões para `write:packages` (com a sub-opção escolhida)
- Ã‰ interessante vocÃª setar o token sem tempo para expirar, ou vai ter que fazer isso todo mÃªs.
- Copie seu token.
  
Agora que possui seu token, vocÃª precisa dar acesso a ele para o `sampctl`;
- Aperte `Botão do Windows + r` e digite `%AppData%`;
- Acesse a pasta do `sampctl` e abra o arquivo `config.json`
- Preencha o campo "github_token": `seu_token`, caso não tenha o campo, adicione ele;
- Feito. 


Após fazer toda a instalação do necessÃ¡rio, vocÃª pode partir pro setup do gamemode.

## Setup do Gamemode

Antes de tudo, agora, vocÃª vai fazer a instalação das dependÃªncias do projeto, os pacotes. VocÃª vai rodar `sampctl p ensure`, e ele te darÃ¡ a certeza de que os pacotes foram instalados corretamente. O resultado deve ser `INFO: ensured dependencies for package`.

Logo após, vocÃª vai buildar o projeto, rodando `sampctl p build`. Agora, tenha certeza que os arquivos `libmariadb.dll`, `log-core.dll`, `log-core2.dll` foram gerados.

E então, Ã© só vocÃª rodar `sampctl p run` e o gamemode vai rodar.

Qualquer outra dÃºvida, entrem em contato com o Philipe ou o Thiago.

## Erros comuns & Possiveis Solucoes

```
CConnection::CConnection - establishing connection to MySQL database failed: #2019 'Can't initialize character set unknown (path: compiled_in)'
```
**PossÃ­vel Solução**: Comentar a linha `mysql_set_charset("latin1");` no mysql_core.pwn


```
servidor rodando 0.3.7-R2
```
**PossÃ­vel Solução**: `windows + r` -> `%AppData%` -> joga [isso](https://cdn.discordapp.com/attachments/932385744083882074/1012906340382953583/samp03DL_svr_R1_win32.zip) na pasta do sampctl lÃ¡. 
Checa `pawn.json` na pasta raiz do gamemode se tÃ¡ a versão 0.3DL, e lembre-se de rodar `sampctl p ensure`.

NOTA: 
Lembre-se de que sempre que vocÃª passar por um erro no setup, venha atÃ© aqui e adicione ele com a sua solução como **PossÃ­vel Solução** para o próximo desenvolvedor que lidar com ele.
