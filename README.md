# Configuração do servidor

## Recursos necessários

- Servidor Ubuntu/Debian com acesso root.
- Domínio registrado.

## Configurações iniciais

1. Liberar as seguintes portas no servidor: 22 (ssh), 80 (http), 443 (https) e 1883 (mqtt).

2. No provedor do domínio, criar os seguintes registros de DNS:

- Hosts: `server`, `storage` e `mqtt`.

    Todos os hosts devem ser do tipo **A** e apontar para o IP do servidor.

## Passo a passo

1. Acessar o servidor via ssh:

    `ssh usuario@ip`

2. Clonar esse repositório e navegar para a pasta: 

    `git clone https://github.com/scoreboard-tcc/infraestrutura`

    `cd infraestrutura`

3. Modificar o arquivo `conf/reverse-proxy.conf`, substituindo todas as ocorrências do domínio `scoreboard-tcc.xyz` pelo domínio registrado.

4. Modificar a variável `DOMAIN` no arquivo `scripts/nginx.sh`, substituindo o domínio `scoreboard-tcc.xyz` pelo domínio registrado. Também substituir a variável `EMAIL`, que é utilizado para avisos relacionados com os certificados SSL.

5. Modificar o arquivo `.env`. Recomenda-se não alterar as portas, se não será necessário modificar também os outros arquivos. O importante é trocar os usuários, senhas, e o `JWT_SECRET`. Lembrar de modificar também as variáveis referentes às URLs de conexão com os bancos, com os mesmos usuários/senhas definidos nas outras variáveis.

6. Executar o script `setup.sh`. O script instalará os pacotes e aplicará as configurações necessárias:

    `./setup.sh`