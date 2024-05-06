# YouTube Video Downloader para DaVinci Resolve

Este projeto oferece um script Ruby simples para baixar vídeos do YouTube em um formato compatível com o DaVinci Resolve (MP4), facilitando a edição de vídeos do YouTube. Além do script, o projeto também inclui um Dockerfile para criar um ambiente isolado e replicável para a execução do script.

## Funcionalidades:

- Baixa vídeos do YouTube em formato MP4.
- Utiliza o youtube-dl para lidar com o download.
- Oferece um ambiente Docker para execução independente de sistema.

## Requisitos:

- Docker instalado e em execução.

## Instruções:

1. Clone o repositório:

```bash
git clone https://github.com/baku01/youtube-davinci-video-downloader.git
cd youtube-davinci-video-downloader
```

2. Construa a imagem Docker:

```bash
docker build -t youtube-downloader .
```

3. Execute o container:

```bash
docker run -it youtube-downloader
```

4. Siga as instruções no terminal e insira a URL do vídeo que deseja baixar.

## Como funciona:

O script utiliza duas classes principais:

### YoutubeVideoDownloader:

Define o método `download_video(video_url)` que recebe a URL do vídeo como entrada.
Constrói o comando youtube-dl com a opção `-f 'best[ext=mp4]'` para selecionar o melhor formato MP4 disponível e a opção `-o '%(title)s.%(ext)s'` para nomear o arquivo baixado com o título do vídeo.
Chama o método `execute_command(command)` para executar o comando construído.

```ruby
def self.download_video(video_url)
  download_command = "youtube-dl -f 'best[ext=mp4]' -o '%(title)s.%(ext)s' #{Shellwords.escape(video_url)}"
  execute_command(download_command)
end
```

### execute_command(command):

Utiliza a biblioteca Open3 para executar o comando passado como argumento.
Imprime a saída padrão (stdout) e a saída de erro (stderr) do comando.

```ruby
def self.execute_command(command)
  Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
    puts stdout.read
    puts stderr.read
  end
end
```

## Dockerfile:

O Dockerfile cria um ambiente isolado com todas as dependências necessárias para executar o script. Ele:

- Utiliza a imagem base do Debian.
- Instala as dependências: git, make, ffmpeg, ruby-full e youtube-dl.
- Define o diretório de trabalho como `/app`.
- Copia os arquivos do projeto para o container.


