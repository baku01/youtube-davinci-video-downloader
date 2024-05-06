# Usando a imagem oficial do Debian como base
FROM debian:latest

# Atualizando o repositório de pacotes e instalando as dependências necessárias
RUN apt-get update && \
    apt-get install -y \
    git \
    make \
    ffmpeg \
    ruby-full \
    && rm -rf /var/lib/apt/lists/*

# Baixando e instalando o youtube-dl
# Usei o make pois estava com problemas com wget e curl XD
RUN git clone https://github.com/ytdl-org/youtube-dl.git youtube-dl && \
    cd youtube-dl && \
    make youtube-dl && \
    cp youtube-dl /usr/local/bin && \
    cp /bin/python3 /bin/python


# Definindo o diretório de trabalho dentro do container
WORKDIR /app

# Copiar os arquivos do host para o diretório de trabalho no container
COPY . /app

