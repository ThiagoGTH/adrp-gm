# Advanced Roleplay
#### SA-MP SERVER (0.0.1a - BETA)

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
Antes do setup do banco de dados em si, você precisa criar uma cópia do `example.env` e renomear para `.env` apenas. 

O setup do banco de dados é simples. Tudo o que vocês precisam fazer é iniciar um banco de dados MySQL vazio, e o `sampctl` aqui e o próprio plugin que utilizamos no [`mysql_core.pwn`](gamemodes/modules/core/database/mysql_core.pwn) vai criar as tabelas e iniciar o banco em si. Preencha os valores das variáveis no `.env` com os dados do banco que você criou.

## Setup de ferramentas e necessarios
Por enquanto, a única ferramenta que utilizamos aqui é o `sampctl`. Vocês podem seguir o [guia de instalação dele aqui](docs/TOOLS.md), e também tem um mini guia de utilização dos comandos.

Você vai precisar de alguns arquivos também para que a build possa ocorrer sem problemas;

- [download dos arquivos de servidor OMP](https://github.com/openmultiplayer/server-beta/releases/tag/build10), colocar na pasta raiz do projeto
- [download do .dll do Pawn.CMD](https://github.com/katursis/Pawn.CMD/releases), colocar na pasta `components`

Antes de você poder utilizar o `sampctl` para instalação e atualização dos pacotes, você vai ter que gerar um `token` no Github para poder utilizar a instalação de pacotes sem limitações. 
Segue abaixo o passo-a-passo:

- Acesse [`configurações`](https://github.com/settings/profile) do Github;
- No menu lateral esquerdo, vá até o último item, `configurações de desenvolvedor`;
- Em Configurações do Desenvolvedor, clique em `token de acesso pessoal` e selecione o `tokens(clássico)`;
- Clique em `gerar novo token` e nomeie como você quiser. Selecione a opção de permissões para `write:packages` (com a sub-opção escolhida)
- É interessante você setar o token sem tempo para expirar, ou vai ter que fazer isso todo mês.
- Copie seu token.
  
Agora que possui seu token, você precisa dar acesso a ele para o `sampctl`;
- Aperte `Botão do Windows + r` e digite `%AppData%`;
- Acesse a pasta do `sampctl` e abra o arquivo `config.json`
- Preencha o campo "github_token": `seu_token`, caso não tenha o campo, adicione ele;
- Feito. 


Após fazer toda a instalação do necessário, você pode partir pro setup do gamemode.

## Setup do Gamemode

Antes de tudo, agora, você vai fazer a instalação das dependências do projeto, os pacotes. Você vai rodar `sampctl p ensure`, e ele te dará a certeza de que os pacotes foram instalados corretamente. O resultado deve ser `INFO: ensured dependencies for package`.

Logo após, você vai buildar o projeto, rodando `sampctl p build`. Agora, tenha certeza que os arquivos `libmariadb.dll`, `log-core.dll`, `log-core2.dll` foram gerados.

E então, é só você rodar `sampctl p run` e o gamemode vai rodar.

Qualquer outra dúvida, entrem em contato com o Philipe ou o Thiago.

## Erros comuns & Possiveis Solucoes

```
CConnection::CConnection - establishing connection to MySQL database failed: #2019 'Can't initialize character set unknown (path: compiled_in)'
```
**Possível Solução**: Comentar a linha `mysql_set_charset("latin1");` no mysql_core.pwn


```
servidor rodando 0.3.7-R2
```
**Possível Solução**: `windows + r` -> `%AppData%` -> joga [isso](https://cdn.discordapp.com/attachments/932385744083882074/1012906340382953583/samp03DL_svr_R1_win32.zip) na pasta do sampctl lá. 
Checa `pawn.json` na pasta raiz do gamemode se tá a versão 0.3DL, e lembre-se de rodar `sampctl p ensure`.

NOTA: 
Lembre-se de que sempre que você passar por um erro no setup, venha até aqui e adicione ele com a sua solução como **Possível Solução** para o próximo desenvolvedor que lidar com ele.
