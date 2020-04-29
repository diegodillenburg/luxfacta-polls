# Luxfacta Polls Readme

## Pré-requisitos:
- PostgreSQL 11.5 ( ambiente de produção apenas)
- Docker 19.03+
- Docker Compose 1.25+

## Ambiente de Desenvolvimento

### Instruções básicas para executar o ambiente de desenvolvimento:
- Executar docker-compose, opcionalmente com a flag -d (detach) para executar os containers em segundo plano
  - `docker-compose up --build`
  ![alt text][docker-dev-build-start]
  ![alt text][docker-dev-build-end]
  - a aplicação é exposta em http://localhost:3000/
- Executando comandos no container de desenvolvimento
  - `docker-compose exec luxfacta-polls [comando]`
  ![alt text][docker-dev-command-execution]

### Comandos úteis:
- `bundle exec rails c[onsole]`
- `bundle exec rspec spec/`
  - executa a suite de testes

### Observações:
- o banco local de desenvolvimento e testes é recriado a cada build do docker-compose, remover a instrução `bundle exec rails db:drop` no arquivo **docker-compose.yml** para desabilitar este comportamento

## Ambiente de Produção

### Instruções Básicas para executar o ambiente de produção:
- Habilitar tráfego de entrada para a porta 80
  - Para manter a simplicidade do teste foram omitidas diretivas para tratamento de protocolo HTTPS
- Criar banco de dados e conceder privilégios ao usuário da aplicação
  ![alt text][database-creation]
- Clonar repositório na instância
- Alterar as seguintes entradas em **.env_production** com as credenciais de acesso ao banco de dados:
  - LUXFACTA_POLLS_DATABASE_PRODUCTION_HOST
  - LUXFACTA_POLLS_DATABASE_PRODUCTION_PORT
  - LUXFACTA_POLLS_DATABASE_PRODUCTION_USERNAME
  - LUXFACTA_POLLS_DATABASE_PRODUCTION_PASSWORD
- Dentro do diretório raiz da aplicação, executar docker-compose, opcionalmente com a flag -d (detach) para executar os containers em segundo plano
  - `docker-compose -f docker-compose.production.yml -f docker-compose.production.override.yml up --build`
  ![docker prod build][docker-prod-build-start]
  ![docker prod build][docker-prod-build-end]
  - a aplicação é exposta na porta 80 do host

[docker-dev-build-start]: docs/docker-dev-build-start.png "starting development build"
[docker-dev-build-end]: docs/docker-dev-build-end.png "end of development build"
[docker-prod-build-start]: docs/docker-prod-build-start.png "starting production build"
[docker-prod-build-end]: docs/docker-prod-build-end.png "end of production build"
[database-creation]: docs/database-creation.png "creating the database"
[docker-dev-command-execution]: docs/docker-dev-command-execution.png "executing commands in docker"

## Instruções Complementares

### Conectando a instância disponível com o arquivo .pem fornecido:
- `chmod 400 path/to/luxfacta.pem`
- `ssh -i path/to/luxfacta.pem ubuntu@34.204.19.153`
