clear
read -e -p "
icnsOptimize script version 1.0 by MaxPower85 (https://github.com/MaxPower85). 
Copyright 2018. GPLv3.

To run this script, make sure that you have installed createicns (https://github.com/avl7771/createicns), pngquant (https://github.com/kornelski/pngquant) and zopflipng (https://github.com/google/zopfli) and that you can use them without having to type the full path (you can place them in /usr/local/bin for that). If you don't have these installed, you can press Ctrl+C to quit this script.


Drag & drop a folder containing your .iconset folders here and press Return.

If you have just one .iconset folder, drag & drop it's parent directory here, not the .iconset folder itself.

If you have only the .png files without an .iconset folder, create a folder with an .iconset extension and place your .png files for all different sizes you want inside (16x16, 16x16@2x, 32x32, 32x32@2x, 128x128, 128x128@2x, 256x256, 256x256@2x, 512x512, 512x512@2x)... then, drag & drop it's parent directory here.

Your path is: " path
cd "$path"

clear

for icns_png_folder in *.iconset

do
	echo -e "\nStarting pngquant\n"
	for png in "$icns_png_folder"/*.png
	do
		pngquant -v --speed 1 --quality 95-100 -f "$png" -o "$png"
	done

	echo -e "\nStarting zopflipng\n"
	for png in "$icns_png_folder"/*.png
	do
		zopflipng -y -m "$png" "$png"
	done
done

echo -e "\nDone optimizing. Creating the .icns files in a new icnsOptimize folder\n"

mkdir icnsOptimize

cd icnsOptimize
 
for icns_png_folder in "$path"/*.iconset
do
	createicns "$icns_png_folder"
done
