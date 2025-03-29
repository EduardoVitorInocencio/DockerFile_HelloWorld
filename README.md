# Capítulo 02: Introdução ao Docker e Flask

## Visão Geral
Este capítulo explica como criar e executar um aplicativo Flask dentro de um contêiner Docker. O código utiliza Flask para criar uma API simples e usa Docker para facilitar a implantação.

---

## Código Flask (Versão 2)

### Explicação
A segunda versão do código Flask inclui integração com Redis para contar quantas vezes a página foi acessada.

#### Importação de Módulos
```python
from flask import Flask
import os
import time
import redis
```
Aqui, importamos o Flask para criar a aplicação web, os módulos `os` e `time` para operações do sistema e manipulação de tempo, e `redis` para conexão com o Redis.

#### Inicialização do Aplicativo
```python
app = Flask(__name__)
cache = redis.Redis(host='redis', port=6379)
```
Criamos a aplicação Flask e conectamos ao Redis rodando na rede Docker no serviço `redis`, porta 6379.

#### Função de Contagem de Acessos
```python
def get_hit_count():
    retries = 5
    while True:
        try:
            cache.reset_retry_count()
            return cache.incr('hits')
        except redis.exceptions.ConnectionError as exc:
            if retries == 0:
                raise exc
            retries -= 1
            time.sleep(0.5)
```
Esta função tenta conectar ao Redis e incrementar um contador chamado `hits`. Se houver erro de conexão, ele tenta novamente até 5 vezes, aguardando 0,5s entre as tentativas.

#### Rota Principal
```python
@app.route('/', methods=['GET'])
def hello():
    count = get_hit_count()
    return "Hello! I've been seen {} times.\n".format(count)
```
Aqui definimos uma rota que retorna uma mensagem contendo o número de vezes que a página foi acessada.

---

## Docker Compose

O `docker-compose.yml` define um ambiente com três serviços: a aplicação web, Redis e MySQL.

```yaml
version: "3.8"
services:
  web:
    image: web-app
    build: .
    ports:
      - "8000:5000"
  redis:
    image: redis
  mysql:
    image: mysql
```
- O serviço `web` constrói a aplicação e expõe a porta 8000 para acesso.
- O serviço `redis` usa a imagem oficial do Redis.
- O serviço `mysql` usa a imagem oficial do MySQL.

---

## Dockerfile

O `Dockerfile` define a imagem do contêiner Flask.

```dockerfile
# Use Python 3.9 como base
FROM python:3.9-alpine

# Define o diretório de trabalho
WORKDIR /code

# Define variáveis de ambiente
ENV FLAKS_APP=app.py 
ENV FLAKS_RUN_HOST=0.0.0.0 

# Copia o código para o contêiner
COPY . . 

# Instala as dependências
RUN pip install -r requirements.txt 

# Expõe a porta 5000
EXPOSE 5000

# Comando para rodar o Flask
CMD ["flask","run"] 
```
- Define Python 3.9 como base.
- Define diretório de trabalho e variáveis de ambiente.
- Copia os arquivos da aplicação.
- Instala dependências.
- Expõe a porta 5000.
- Executa o Flask ao iniciar o contêiner.

---

## Conclusão
Agora temos um ambiente Flask com Redis e MySQL rodando em contêineres. O Redis mantém um contador de acessos, demonstrando como armazenar dados temporários na memória. No próximo capítulo, abordaremos testes e deploy desse ambiente.

