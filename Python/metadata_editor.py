import os
import piexif
import sys
from tinytag import TinyTag

def read_metadata(filename):
    try:
        exif_data = piexif.load(filename)
        if exif_data is not None:
            print("|=" * 30)
            print("Metadata for File '{}':".format(filename))
            for ifd in exif_data:
                for tag in exif_data[ifd]:
                    print(piexif.TAGS[ifd][tag]['name'], exif_data[ifd][tag])
            print("|=" * 30)
            print("\n")
        else:
            print("The file '{}' does not contain Metadata.\n".format(filename))
    except piexif._exceptions.InvalidImageDataError:
        print("The file '{}' does not contain Metadata or is not a valid file.\n".format(filename))
    except Exception as e:
        print("Error while reading Metadata '{}': {}\n".format(filename, str(e)))

def delete_metadata(filename):
    try:
        exif_data = piexif.load(filename)
        exif_data.clear()
        exif_bytes = piexif.dump(exif_data)
        piexif.insert(exif_bytes, filename)
        print("Metadata for file: '{}' deleted.\n".format(filename))
    except piexif._exceptions.InvalidImageDataError:
        print("The file '{}' does not contain Metadata or is not a valid file.\n".format(filename))
    except Exception as e:
        print("Error while deleting Metadata for file '{}': {}\n".format(filename, str(e)))

def replace_metadata(filename, old_value, new_value):
    try:
        with open(filename, 'rb') as f:
            data = f.read()
            if filename.endswith(".mp4"):
                if old_value in data:
                    data = data.replace(old_value.encode(), new_value.encode())
                    with open(filename, 'wb') as f:
                        f.write(data)
                    print(f"Metadata for file {filename} replaced.")
                else:
                    print(f"Metadata with value '{old_value}' not found in file {filename}.")
            elif filename.endswith((".jpeg", ".jpg", ".png")):
                exif_data = piexif.load(data)
                if old_value in exif_data:
                    exif_data[old_value] = new_value
                    exif_bytes = piexif.dump(exif_data)
                    piexif.insert(exif_bytes, filename)
                    print(f"Metadata in file {filename} replaced.")
                else:
                    print(f"Metadata with value '{old_value}' not found in file {filename}.")
            else:
                print(f"File {filename} is not support. Only MP4 or Pictureformats.")
    except FileNotFoundError:
        print(f"File {filename} not found.")

def delete_metadata_recursively(folder_path):
    for dirpath, dirnames, filenames in os.walk(folder_path):
        for filename in filenames:
            file_path = os.path.join(dirpath, filename)
            if filename.lower().endswith(('.mp4', '.jpg', '.jpeg', '.png')):
                delete_metadata(file_path)

        for dirname in dirnames:
            subdir_path = os.path.join(dirpath, dirname)
            print("Do you want to proccess", subdir_path, "to delete metadatas from files too? (Y/N)")
            choice = input().lower()
            if choice == 'y':
                delete_metadata_recursively(subdir_path)
            else:
                print("Subfolder", subdir_path, "skipped.")

def read_metadata_recursively(folder_path):
    for dirpath, dirnames, filenames in os.walk(folder_path):
        for filename in filenames:
            file_path = os.path.join(dirpath, filename)
            if filename.lower().endswith(('.mp4', '.jpg', '.jpeg', '.png')):
                read_metadata(file_path)

        for dirname in dirnames:
            subdir_path = os.path.join(dirpath, dirname)
            print("Do you want to proccess", subdir_path, "to read metadatas from files too? (Y/N)")
            choice = input().lower()
            if choice == 'y':
                read_metadata_recursively(subdir_path)
            else:
                print("Subfolder", subdir_path, "skipped.")


def main():
    core = "ENTER YOUR PATH IN SCRIPT LINE 96"
    while True:
        print("Choose a option:")
        print("1. Read single Metadata")
        print("2. Delete single Metadata")
        print("3. Replace single Metadata")
        print("4. Delete multiple Metadata")
        print("5. Read multiple Metadata")
        print("6. EXIT")
        choice = input("Choice: ")

        if choice == '1':
            filename = core + input(f"Enter filename: {core}")
            read_metadata(filename)
        elif choice == '2':
            filename = core + input(f"Enter filename: {core}")
            delete_metadata(filename)
        elif choice == '3':
            filename = core + input(f"Enter filename: {core}")
            old_value = input("Enter old value: ")
            new_value = input("Enter new value: ")
            replace_metadata(filename, old_value, new_value)
        elif choice == '4':
            filename = core + input(f"Enter folderpath: {core}")
            delete_metadata_recursively(filename)
        elif choice == '5':
            filename = core + input(f"Enter filename: {core}")
            read_metadata_recursively(filename)
        elif choice == '5':
            print("Bye.")
            sys.exit(0)
        else:
            print("Input not valid, try again.\n")

if __name__ == "__main__":
    main()
