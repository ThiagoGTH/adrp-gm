# Advanced Roleplay
#### SA-MP SERVER (0.0.1a - BETA)

REGRA ÚNICA REFORÇADA: UTILIZEM A BRANCH `development`, TANTO PARA PULL REQUEST, QUANTO PARA HOTFIXES, WHATEVER. NÃO FAÇAM NENHUMA ALTERAÇÃO DIRETA OU INDIRETA À BRANCH `main`. 

## Como fazer o setup do projeto local?
Passo à passo:
1. [Clonando o Projeto](#clonando-o-projeto)
1. [Fazendo setup do banco de dados](#setup-do-banco-de-dados)
2. [Fazendo setup de ferramentas e arquivos necessários](#setup-de-ferramentas-e-necessarios)
3. [Por fim, fazendo setup do gamemode](#setup-do-gamemode)

## Clonando o Projeto
Você vai ter rodar o básico mesmo pra clonar o projeto, apenas. 
`git clone git@github.com:advanced-roleplay/gamemode.git`

## Setup do banco de dados
Antes do setup do banco de dados em si, você precisa criar uma c�pia do `example.env` e renomear para `.env` apenas. 

O setup do banco de dados é simples. Tudo o que vocês precisam fazer é iniciar um banco de dados MySQL vazio, e o `sampctl` aqui e o pr�prio plugin que utilizamos no [`mysql_core.pwn`](gamemodes/modules/core/database/mysql_core.pwn) vai criar as tabelas e iniciar o banco em si. Preencha os valores das variáveis no `.env` com os dados do banco que você criou.

## Setup de ferramentas e necessarios
Por enquanto, a única ferramenta que utilizamos aqui é o `sampctl`. Vocês podem seguir o [guia de instala��o dele aqui](docs/TOOLS.md), e também tem um mini guia de utiliza��o dos comandos.

Você vai precisar de alguns arquivos também para que a build possa ocorrer sem problemas;

- [download dos arquivos de servidor OMP](https://github.com/openmultiplayer/server-beta/releases/tag/build10), colocar na pasta raiz do projeto
- [download do .dll do Pawn.CMD](https://github.com/katursis/Pawn.CMD/releases), colocar na pasta `components`

Antes de você poder utilizar o `sampctl` para instala��o e atualiza��o dos pacotes, você vai ter que gerar um `token` no Github para poder utilizar a instala��o de pacotes sem limita��es. 
Segue abaixo o passo-a-passo:

- Acesse [`configura��es`](https://github.com/settings/profile) do Github;
- No menu lateral esquerdo, vá até o último item, `configura��es de desenvolvedor`;
- Em Configura��es do Desenvolvedor, clique em `token de acesso pessoal` e selecione o `tokens(clássico)`;
- Clique em `gerar novo token` e nomeie como você quiser. Selecione a op��o de permiss�es para `write:packages` (com a sub-op��o escolhida)
- É interessante você setar o token sem tempo para expirar, ou vai ter que fazer isso todo mês.
- Copie seu token.
  
Agora que possui seu token, você precisa dar acesso a ele para o `sampctl`;
- Aperte `Bot�o do Windows + r` e digite `%AppData%`;
- Acesse a pasta do `sampctl` e abra o arquivo `config.json`
- Preencha o campo "github_token": `seu_token`, caso n�o tenha o campo, adicione ele;
- Feito. 


Ap�s fazer toda a instala��o do necessário, você pode partir pro setup do gamemode.

## Setup do Gamemode

Antes de tudo, agora, você vai fazer a instala��o das dependências do projeto, os pacotes. Você vai rodar `sampctl p ensure`, e ele te dará a certeza de que os pacotes foram instalados corretamente. O resultado deve ser `INFO: ensured dependencies for package`.

Logo ap�s, você vai buildar o projeto, rodando `sampctl p build`. Agora, tenha certeza que os arquivos `libmariadb.dll`, `log-core.dll`, `log-core2.dll` foram gerados.

E ent�o, é s� você rodar `sampctl p run` e o gamemode vai rodar.

Qualquer outra dúvida, entrem em contato com o Philipe ou o Thiago.

## Erros comuns & Possiveis Solucoes

```
CConnection::CConnection - establishing connection to MySQL database failed: #2019 'Can't initialize character set unknown (path: compiled_in)'
```
**Possível Solu��o**: Comentar a linha `mysql_set_charset("latin1");` no mysql_core.pwn


```
servidor rodando 0.3.7-R2
```
**Possível Solu��o**: `windows + r` -> `%AppData%` -> joga [isso](https://cdn.discordapp.com/attachments/932385744083882074/1012906340382953583/samp03DL_svr_R1_win32.zip) na pasta do sampctl lá. 
Checa `pawn.json` na pasta raiz do gamemode se tá a vers�o 0.3DL, e lembre-se de rodar `sampctl p ensure`.

NOTA: 
Lembre-se de que sempre que você passar por um erro no setup, venha até aqui e adicione ele com a sua solu��o como **Possível Solu��o** para o pr�ximo desenvolvedor que lidar com ele.
