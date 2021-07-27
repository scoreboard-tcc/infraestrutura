# Configuração do servidor

## Recursos necessários

- Servidor Ubuntu/Debian com acesso root.
- Domínio registrado.

## Configurações iniciais

1. Liberar as seguintes portas no servidor: 22 (ssh), 80 (http), 443 (https) e 1883 (mqtt).

2. No Vercel, criar os seguintes registros de DNS:

- Hosts: `server`, `storage` e `mqtt`.

    Todos os hosts devem ser do tipo **A** e apontar para o IP do servidor.

## Passo a passo

1. Criar um "Personal access token" no Github, com a seguinte permissão: `read:packages`

2. **Importante:** salvar esse token em algum lugar, pois não será possível visualizar novamente.

3. Entrar na seguinte URL: https://github.com/scoreboard-tcc/backend/settings/secrets/actions

4. Criar os seguintes "Repository secrets":

    - `HOST` - com o IP do servidor
    - `GH_USERNAME` - com o nome de usuário do Github
    - `USERNAME` - com o nome de usuário do servidor
    - `PASSWORD` - com a senha do servidor
    - `PORT` - com a porta SSH (padrão é 22)

5. Acessar o servidor via ssh:

    `ssh usuario@ip`

6. Clonar esse repositório e navegar para a pasta: 

    `git clone https://github.com/scoreboard-tcc/infraestrutura`

    `cd infraestrutura`

7. Modificar o arquivo `.env`. Recomenda-se não alterar as portas, se não será necessário modificar também os outros arquivos. O importante é trocar os usuários, senhas, e o `JWT_SECRET`. Lembrar de modificar também as variáveis referentes às URLs de conexão com os bancos, com os mesmos usuários/senhas definidos nas outras variáveis.

8. Executar o arquivo `setup.sh`. O script instalará os pacotes e aplicará as configurações necessárias. Será necessário informar um domínio e um e-mail durante a execução do script.

    `./setup.sh`