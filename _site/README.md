## Image Generation/gallery

Take original image and resize it to max of 1024x1024:

	convert img/original/image.jpg -resize "1024x1024>" img/large/image.jpg

Take resized image and create 200x200 thumbnail:

	convert img/large/image.jpg -gravity Center -thumbnail 200x200^ -extent 200x200 img/thumb/image.jpg


update `_includes/gallery.html` with new image.