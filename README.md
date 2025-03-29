# Criando e Executando um Aplicativo Flask com Docker

Neste exercício, vamos entender passo a passo a estrutura de um aplicativo Flask simples e como configurá-lo para rodar em um container Docker.

---

## 1. Estrutura do Projeto
Nosso projeto contém os seguintes arquivos:

```
DockerFile_HelloWorld/
├── app.py
├── Dockerfile
├── requirements.txt
```

Cada um desses arquivos tem uma função específica que vamos detalhar a seguir.

---

## 2. Aplicativo Flask (app.py)
O arquivo **app.py** é um aplicativo Flask simples que exibe "Hello World!" ao ser acessado.

### **Código do app.py:**

```python
# Importação das bibliotecas necessárias
from flask import Flask
import os

# Inicialização do aplicativo Flask
app = Flask(__name__)

# Rota principal que retorna "Hello World!"
@app.route('/', methods=['GET'])
def home():
    return "Hello World!"

# Configura o servidor para rodar na porta 5000
if __name__ == '__main__':
    app.run(debug=True, host="0.0.0.0", port=5000)
```

### **Explicação do código:**
1. **Importação das bibliotecas**:
   - `Flask`: Framework para criação de aplicativos web em Python.
   - `os`: Biblioteca do sistema operacional (embora não seja usada aqui, pode ser útil em projetos maiores).

2. **Inicialização do Flask**:
   - `app = Flask(__name__)` cria uma instância do Flask para gerenciar o servidor web.

3. **Definição de rota**:
   - `@app.route('/')`: Define o caminho `/`, que será acessado via requisição HTTP GET.
   - `def home()`: Função que retorna "Hello World!" quando a rota é acessada.

4. **Execução do aplicativo**:
   - `app.run(debug=True, host="0.0.0.0", port=5000)`:
     - `debug=True`: Ativa o modo de depuração.
     - `host="0.0.0.0"`: Permite conexões externas ao container.
     - `port=5000`: Define a porta do servidor.

---

## 3. Criando o Dockerfile
O **Dockerfile** define a imagem Docker para o nosso aplicativo Flask.

### **Código do Dockerfile:**

```dockerfile
# Usa a imagem base do Python 3.8 com Alpine Linux
FROM python:3.8-alpine

# Copia os arquivos do diretório atual para o container
COPY . /app

# Define o diretório de trabalho dentro do container
WORKDIR /app

# Instala as dependências listadas em requirements.txt
RUN pip install -r requirements.txt

# Expõe a porta 5000 para conexões externas
EXPOSE 5000

# Comando para iniciar o aplicativo Flask
CMD python app.py
```

### **Explicação do Dockerfile:**
1. `FROM python:3.8-alpine`:
   - Usa uma imagem leve do Python 3.8 baseada no Alpine Linux.
2. `COPY . /app`:
   - Copia todos os arquivos do diretório local para o container.
3. `WORKDIR /app`:
   - Define `/app` como o diretório de trabalho dentro do container.
4. `RUN pip install -r requirements.txt`:
   - Instala as dependências especificadas em `requirements.txt`.
5. `EXPOSE 5000`:
   - Declara que o container usará a porta **5000**.
6. `CMD python app.py`:
   - Define o comando padrão para rodar o aplicativo Flask.

---

## 4. Construindo e Rodando o Container
Agora vamos construir a imagem Docker e rodar o container.

### **4.1 Construir a imagem**
Execute o seguinte comando no terminal dentro do diretório do projeto:

```sh
docker build -t welcome-app .
```

- `-t welcome-app`: Define o nome da imagem como `welcome-app`.
- `.`: Indica que o Dockerfile está no diretório atual.

### **4.2 Rodar o container**

```sh
docker run -p 5000:5000 welcome-app
```

- `-p 5000:5000`: Mapeia a porta do container para a máquina host.
- `welcome-app`: Nome da imagem.

Agora, você pode acessar `http://localhost:5000/` no navegador e ver a mensagem **"Hello World!"**.

---

## 5. Possíveis Erros e Soluções

### **Erro: Porta 5000 já está em uso**
#### Mensagem de erro:
```
docker: Error response from daemon: driver failed programming external connectivity on endpoint ... Bind for 0.0.0.0:5000 failed: port is already allocated.
```
#### Solução:
1. Verifique qual processo está usando a porta 5000:
   ```sh
   netstat -ano | findstr :5000
   ```
2. Mate o processo:
   ```sh
   taskkill /PID <PID> /F
   ```
3. Ou rode o container em outra porta:
   ```sh
   docker run -p 5001:5000 welcome-app
   ```

### **Erro: Dependência incompatível no requirements.txt**
#### Mensagem de erro:
```
ERROR: Could not find a version that satisfies the requirement blinker==1.9.0
```
#### Solução:
1. Use uma versão do `blinker` compatível com o Python 3.8:
   ```sh
   blinker==1.8.2
   ```
2. Ou altere o Dockerfile para usar Python 3.9:
   ```dockerfile
   FROM python:3.9-alpine
   ```


