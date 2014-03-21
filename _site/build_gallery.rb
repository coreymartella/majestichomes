require 'fileutils'
Dir["img/gallery/input/**/*.*"].each do |f|
  FileUtils.mv f, "img/gallery/original/#{f.split("/")[-2]}_#{File.ctime(f).strftime("%Y%m%d%H%M%S")}.jpg"
end
#resize all originals to regular image
FileUtils.mkdir_p "img/gallery/large/"
FileUtils.mkdir_p "img/gallery/thumb/"
File.open("_portfolio.html", "w") do |html|
  Dir["img/gallery/original/*.*"].sort_by{rand}.each do |f|
    `convert #{f} -resize 1024x1024 img/gallery/large/#{f.split("/").last}` if !File.exists?("img/gallery/large/#{f.split("/").last}")
    `convert #{f} -resize 300x300 img/gallery/thumb/#{f.split("/").last}`
    tag = f.split("/").last.split("_").first
    img = File.basename(f)
    html.puts <<-HTML
      <div class="boxportfolio3 item #{tag}">
        <div class="boxcontainer">
          <img src="/img/gallery/thumb/#{img}" alt="">
          <div class="roll">
            <div class="wrapcaption">
              <a data-gal="prettyPhoto[gallery1]" href="/img/gallery/large/#{img}"><i class="icon-zoom-in captionicons"></i></a>
            </div>
          </div>
        </div>
      </div>
    HTML
  end
end


