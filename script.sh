#!/bin/bash


# Q3(a)
# Part 1/2
while [ true ]; do
	read -p "Please enter a folder name in the current directory: " folder_name

	# Keep asking user for input if folder name does not exists in current directory
	if [ ! -d $folder_name ]; then
		echo "Folder '$folder_name' does not exists in the current directory"
	else
		echo "Folder '$folder_name' found"
		break
	fi
done

# Part 3
while [ true ]; do
	read -p "Please enter a USERNAME: " username

	# Q3(c)
	# Keep asking user for input if username does not exists in system
	if ! id -u "$username" >/dev/null 2>&1; then
  		echo "User '$username' does not exists"
	else
  		echo "User '$username' found"
		break
	fi
done

# Part 4
new_folder_name=$username-$(date +'%d%m%Y')

# Remove existing folder with the same folder name
if [ -d $new_folder_name ]; then
	rm -r $new_folder_name
	echo  "Deleted existing folder '$new_folder_name'"
fi

mv $folder_name $new_folder_name
echo "Changed folder name '$folder_name' to '$new_folder_name'"

echo ""
echo "============================================"
echo "TOTAL SIZE OF FOLDER (INCLUDING SUB-FOLDERS)"
echo "============================================"
du -h $new_folder_name

# Part 5
echo ""
echo "==================="
echo "IMAGE FILES DETAILS"
echo "==================="
# List all image files with .png and .gif
cd $new_folder_name
find -type f \( -iname \*.png -o -iname \*.gif \) | xargs du -h

# Q3(b)
# Part 1
# Count total number of image files with .png and .gif
total_image_files=$(find -type f \( -iname \*.png -o -iname \*.gif \) | wc -l)
echo "Total number of image files: $total_image_files"

# Get total size of image files with .png and .gif
total_size=$(find -type f \( -iname \*.png -o -iname \*.gif \) | xargs du -ck | grep total$ | awk '{print $1}')

if [ $total_size -le 200 ]; then 
	echo "Total image size is small"
else
	echo "Total image size is NOT small"
fi

cd ..

# Part 2
echo ""
echo "============================================"
echo "BEFORE CHANGE OF OWNER/GROUP AND PERMISSIONS"
echo "============================================"
ls -l -R $new_folder_name
# Change ownership and group
chown -R $username:$username $new_folder_name

# Part 3
# Change permissions
chmod -R 764 $new_folder_name
echo ""
echo "==========================================="
echo "AFTER CHANGE OF OWNER/GROUP AND PERMISSIONS"
echo "==========================================="
ls -l -R $new_folder_name
