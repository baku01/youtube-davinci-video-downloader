require 'open3'
require 'shellwords'

class YoutubeVideoDownloader
  def self.download_video(video_url)
    download_command = "youtube-dl -f 'best[ext=mp4]' -o '%(title)s.%(ext)s' #{Shellwords.escape(video_url)}"
    execute_command(download_command)
  end

  def self.execute_command(command)
    Open3.popen3(command) do |stdin, stdout, stderr, wait_thr|
      puts stdout.read
      puts stderr.read
    end
  end
end

puts "Insira a URL do vídeo:"
video_url = gets.chomp

YoutubeVideoDownloader.download_video(video_url)
