# Use a imagem oficial do Python como base
FROM python:3.9-alpine

# Define o diretório de trabalho
WORKDIR /code

# Configura as variáveis de ambiente corretamente
ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

# Copia os arquivos para o contêiner
COPY . .

# Instala as dependências
RUN pip install -r requirements.txt

# Expõe a porta 5000
EXPOSE 5000

# Executa o Flask na porta correta
CMD ["flask", "run", "--host=0.0.0.0", "--port=5000"]
