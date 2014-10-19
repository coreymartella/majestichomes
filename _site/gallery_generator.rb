require 'fileutils'
FileUtils.mkdir_p "img/gallery/original"
FileUtils.mkdir_p "img/gallery/large"
FileUtils.mkdir_p "img/gallery/thumb"
require 'mini_exiftool'
Dir["img/gallery/input/**/*.*"].each do |f|
  exif = MiniExiftool.new f
  ts = (exif.createdate || File.ctime(f)).strftime("%Y%m%d%H%M%S#{'%02d' % rand(100)}") 
  new_f = "img/gallery/original/#{f.split("/")[-2]}_#{ts}.jpg"
  FileUtils.cp f, new_f
  f = new_f
  #resize all originals to regular image  
  `convert #{f} -resize 1024x1024 img/gallery/large/#{f.split("/").last}` if !File.exists?("img/gallery/large/#{f.split("/").last}")
  `convert #{f} -thumbnail 200x200^ -gravity center -extent 200x200 img/gallery/thumb/#{f.split("/").last}` if !File.exists?("img/gallery/thumb/#{f.split("/").last}")
  tag = f.split("/").last.split("_").first
  img = File.basename(f)
  puts "<div class=\"item #{tag}\"><a data-gal=\"prettyPhoto[gallery]\" href=\"/img/gallery/large/#{img}\"><img src=\"/img/gallery/thumb/#{img}\" alt=\"\"></a></div>"
end
