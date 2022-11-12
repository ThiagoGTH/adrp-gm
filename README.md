# Advanced Roleplay
#### SA-MP SERVER (0.0.1a - BETA)

## Como fazer o setup do projeto local?
Passo � passo:
1. [Fazendo setup do banco de dados](setup-do-banco-de-dados)
2. [Fazendo setup de ferramentas e arquivos necess�rios](setup-de-ferramentas-e-necessarios)
3. [Por fim, fazendo setup do gamemode](setup-do-gamemode)
## Setup do banco de dados
Antes do setup do banco de dados em si, voc� precisa criar uma c�pia do `example.env` e renomear para `.env` apenas. 

O setup do banco de dados � simples. Tudo o que voc�s precisam fazer � iniciar um banco de dados MySQL vazio, e o `sampctl` aqui e o pr�prio plugin que utilizamos no [`mysql_core.pwn`](gamemodes/modules/core/database/mysql_core.pwn) vai criar as tabelas e iniciar o banco em si. Preencha os valores das vari�veis no `.env` com os dados do banco que voc� criou.

## Setup de ferramentas e necessarios
Por enquanto, a �nica ferramenta que utilizamos aqui � o `sampctl`. Voc�s podem seguir o [guia de instala��o dele aqui](docs/TOOLS.md), e tamb�m tem um mini guia de utiliza��o dos comandos.

Voc� vai precisar de alguns arquivos tamb�m para que a build possa ocorrer sem problemas;

- [download dos arquivos de servidor OMP](https://github.com/openmultiplayer/server-beta/releases/tag/build10), colocar na pasta raiz do projeto
- [download do .dll do Pawn.CMD](https://github.com/katursis/Pawn.CMD/releases), colocar na pasta `components`

Antes de voc� poder utilizar o `sampctl` para instala��o e atualiza��o dos pacotes, voc� vai ter que gerar um `token` no Github para poder utilizar a instala��o de pacotes sem limita��es. 
Segue abaixo o passo-a-passo:

- Acesse [`configura��es`](https://github.com/settings/profile) do Github;
- No menu lateral esquerdo, v� at� o �ltimo item, `configura��es de desenvolvedor`;
- Em Configura��es do Desenvolvedor, clique em `token de acesso pessoal` e selecione o `tokens(cl�ssico)`;
- Clique em `gerar novo token` e nomeie como voc� quiser. Selecione a op��o de permiss�es para `write:packages` (com a sub-op��o escolhida)
- � interessante voc� setar o token sem tempo para expirar, ou vai ter que fazer isso todo m�s.
- Copie seu token.
  
Agora que possui seu token, voc� precisa dar acesso a ele para o `sampctl`;
- Aperte `Bot�o do Windows + r` e digite `%AppData%`;
- Acesse a pasta do `sampctl` e abra o arquivo `config.json`
- Preencha o campo "github_token": `seu_token`, caso n�o tenha o campo, adicione ele;
- Feito. 


Ap�s fazer toda a instala��o do necess�rio, voc� pode partir pro setup do gamemode.

## Setup do Gamemode

Antes de tudo, agora, voc� vai fazer a instala��o das depend�ncias do projeto, os pacotes. Voc� vai rodar `sampctl p ensure`, e ele te dar� a certeza de que os pacotes foram instalados corretamente. O resultado deve ser `INFO: ensured dependencies for package`.

Logo ap�s, voc� vai buildar o projeto, rodando `sampctl p build`. Agora, tenha certeza que os arquivos `libmariadb.dll`, `log-core.dll`, `log-core2.dll` foram gerados.


Seguindo todos os passoas acima (corretamente), você conseguirá executar o servidor sem nenhum problema. 
Além do mais, todos os problemas, dúvidas ou questões que sejam acerca do **Advanced Roleplay** deverão serem enviadas ao [Thiago](https://github.com/ThiagoGTH/).

## Erros comuns & Possiveis Solucoes

```
CConnection::CConnection - establishing connection to MySQL database failed: #2019 'Can't initialize character set unknown (path: compiled_in)'
```
**Poss�vel Solu��o**: Comentar a linha `mysql_set_charset("latin1");` no mysql_core.pwn


```
servidor rodando 0.3.7-R2
```
**Poss�vel Solu��o**: `windows + r` -> `%AppData%` -> joga [isso](https://cdn.discordapp.com/attachments/932385744083882074/1012906340382953583/samp03DL_svr_R1_win32.zip) na pasta do sampctl l�. 
Checa `pawn.json` na pasta raiz do gamemode se t� a vers�o 0.3DL, e lembre-se de rodar `sampctl p ensure`.

NOTA: 
Lembre-se de que sempre que voc� passar por um erro no setup, venha at� aqui e adicione ele com a sua solu��o como **Poss�vel Solu��o** para o pr�ximo desenvolvedor que lidar com ele.