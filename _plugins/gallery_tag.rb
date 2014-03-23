module Jekyll
  class GalleryTag < Liquid::Tag
    def render(context)
      require 'fileutils'
      Dir["img/gallery/input/**/*.*"].each do |f|
        FileUtils.mv f, "img/gallery/original/#{f.split("/")[-2]}_#{File.ctime(f).strftime("%Y%m%d%H%M%S")}.jpg"
      end
      #resize all originals to regular image
      FileUtils.mkdir_p "img/gallery/large/"
      FileUtils.mkdir_p "img/gallery/thumb/"
      # FileUtils.mkdir_p "_includes"
      widths = [1,1,1,1,1,1,1,1,2,2]
      gallery = []
      # File.open("_includes/gallery.html", "w") do |html|
        Dir["img/gallery/original/*.*"].sort_by{|f| -f.split("_").last.to_i}.each_with_index do |f,i|
          `convert #{f} -resize 1024x1024 img/gallery/large/#{f.split("/").last}` if !File.exists?("img/gallery/large/#{f.split("/").last}")
          `convert #{f} -thumbnail 200x200^ -gravity center -extent 200x200 img/gallery/thumb/#{f.split("/").last}` if !File.exists?("img/gallery/thumb/#{f.split("/").last}")
          tag = f.split("/").last.split("_").first
          img = File.basename(f)
          width = widths[rand(widths.size)]
          width = 1 if i == 0
          gallery << "<div class=\"item #{tag} photo#{width}\"><a data-gal=\"prettyPhoto[gallery]\" href=\"/img/gallery/large/#{img}\"><img src=\"/img/gallery/thumb/#{img}\" alt=\"\"></a></div>"
        end
      # end
      gallery.join("\n")
    end
  end
end

Liquid::Template.register_tag('gallery', Jekyll::GalleryTag)
