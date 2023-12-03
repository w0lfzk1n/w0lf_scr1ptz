#!/bin/python

from subprocess import call
import os
import datetime
import random
import json
import string
import time
import glob
from Crypto.Cipher import AES
import base64
import sys

logo = "\n██╗   ██╗████████╗██████╗ \n╚██╗ ██╔╝╚══██╔══╝██╔══██╗\n ╚████╔╝    ██║   ██║  ██║\n  ╚██╔╝     ██║   ██║  ██║\n   ██║      ██║   ██████╔╝\n   ╚═╝      ╚═╝   ╚═════╝ "
bar = "[==================================================]"

cnt_success = 0
cnt_failed = 0
cnt_retry_suc = 0
cnt_retry_fail = 0
enc_saved = 0
cleaner_yeet = 0

SCRIPT_PATH = os.path.dirname(os.path.abspath(__file__))
def format_path(path, redirect_to_source=False):
    if redirect_to_source:
        return os.path.join(SCRIPT_PATH, path).replace("\\", "/")
    else:
        return path.replace("\\", "/")
CONF_PATH = format_path("python_data/core_python_conf.json", True)

def read_json_file(file_path):
    try:
        with open(file_path, 'r') as file:
            return json.load(file)
    except FileNotFoundError:
        print(f"Datei nicht gefunden: {file_path}")
        return None
    except json.JSONDecodeError:
        print(f"Fehler beim Parsen der JSON-Datei: {file_path}")
        return None

# Wordlist und Config einlesen
config = read_json_file(CONF_PATH)

if config:
    base_path = config["base_path"]
    SECRET_KEY = config["secret_phrase"]
    ENC_TAG = config["enc_tag"]
    paths = [base_path + path for path in config["ytd_save_paths"]]

    LINK_PATH = config["ytd_linkpath"]
    link_path = format_path(LINK_PATH, True)

    WORDLIST_PATH = config["wordlist_path"]
    wordlist = read_json_file(format_path(WORDLIST_PATH, True))

    wl_adj = wordlist["adj"]
    wl_nom = wordlist["nom"]
    wl_nature_nom = wordlist["nature_nom"]
    wl_nature_adj = wordlist["nature_adj"]
    wl_tec_nom = wordlist["tec_nom"]
    wl_tec_adj = wordlist["tec_adj"]
    wl_myth_nom = wordlist["myth_nom"]
    wl_myth_adj = wordlist["myth_adj"]
    wl_space_nom = wordlist["space_nom"]
    wl_space_adj = wordlist["space_adj"]

    failed_downloads = []
    download_details = []
else:
    print("Error while loading configfile.")
    sys.exit(1)

# ===========================================
# Config Editing & Functions
def write_config(config):
    with open(CONF_PATH, 'w') as file:
        json.dump(config, file, indent=4)

def display_paths(paths):
    for index, path in enumerate(paths):
        print(f"{index}: {path}")

def add_path(config):
    new_path = input(f"Enter a path:\n{base_path}")
    config["paths"].append(new_path)
    write_config(config)
    print(f"{bar}\nSavepath {new_path} saved.")

def create_folder(config):
    folder_path = input(f"Enter a path for the new folder:\n{base_path}")
    full_path = os.path.join(config["base_path"], folder_path)
    if not os.path.exists(full_path):
        os.makedirs(full_path)
        print(f"{bar}\nFolder {full_path} created succsessfully.\n{bar}")
    else:
        print(f"{bar}\nFolder exist already.")

def edit_path(config):
    display_paths(config["paths"])
    index = int(input("Choose the number for editing the path: "))
    new_path = input("Enter new path: ")
    config["paths"][index] = new_path
    write_config(config)
    print(f"{bar}\nPath {new_path} saved.")

def delete_path(config):
    display_paths(config["paths"])
    index = int(input("Choose the number for deleting the path:"))
    del config["paths"][index]
    write_config(config)
    print(f"{bar}\nPath deleted successfull.")

def generate_random_key(length=32):
    return ''.join(random.choices(string.ascii_letters + string.digits, k=length))

def update_secret_phrase(config):
    config["secret_phrase"] = generate_random_key()
    write_config(config)
    print(f"{bar}\nSecret phrase in config file updated.")

def add_encr_link(config):
    link = input("Enter link: ")
    if not is_valid_url(link):
        print(f"{bar}\nInvalid link.\n{bar}")
        return
    print(">> Link is valid.")
    save_encrypted_link(link, link_path)
    print(f"{bar}\n>> Encrypted link saved.")

def manage_paths():
    while True:
        try:
            options = {
                "1": add_path,
                "2": create_folder,
                "3": edit_path,
                "4": delete_path,
                "5": update_secret_phrase,
                "6": add_encr_link,
                "7": open_txtfile,
                "8": exit
            }
            print(f"{bar}\n# CONFIG #\n")
            print("Options:")
            print("1: Add new save path")
            print("2: Create a folder")
            print("3: Edit a save path")
            print("4: Delete a save path")
            print("5: Secret phrase refresh")
            print("6: Add a Single Encrypted Link")
            print("7: Open Link File")
            print("8: Back")
            choice = input("Choose your option: ")
            if choice in options:
                if choice == "8":
                    break
                options[choice](config)
            else:
                print("Invalid Option.")
        except KeyboardInterrupt:
            break

# ===========================================
# Encryption
def pad(s):
    return s + (AES.block_size - len(s) % AES.block_size) * chr(AES.block_size - len(s) % AES.block_size)

def unpad(s):
    return s[:-ord(s[len(s) - 1:])]

def encrypt_link(link):
    try:
        cipher = AES.new(SECRET_KEY.encode(), AES.MODE_ECB)
        padded_link = pad(link)
        encrypted = cipher.encrypt(padded_link.encode())
        return ENC_TAG + base64.b64encode(encrypted).decode()
    except Exception as e:
        print(f">>> ENCRYPT Error while encrypting a link. Please generate a new one under # CONFIG #\nErr:\n{e}")
        sys.exit(1)

def decrypt_link(encrypted_link):
    try:
        cipher = AES.new(SECRET_KEY.encode(), AES.MODE_ECB)
        encrypted_link = encrypted_link[len(ENC_TAG):]
        decoded_encrypted_link = base64.b64decode(encrypted_link)
        decrypted = cipher.decrypt(decoded_encrypted_link)
        return unpad(decrypted.decode())
    except Exception as e:
        print(f">>> DECRYPT Error while decrypting a link. Please generate a new one under # CONFIG #\nErr:\n{e}")
        sys.exit(1)

def save_encrypted_link(link, link_path):
    encrypted_link = encrypt_link(link)
    with open(link_path, "a") as file:
        file.write(encrypted_link + "\n")

def is_hashed_link(link):
    return link.startswith(ENC_TAG)
    
def is_valid_url(link):
    return link.startswith("http://") or link.startswith("https://")

# ===========================================
#   GEN NAME
def gen_name(mode, save_path):
    max_attempts = 20
    for _ in range(max_attempts):
        if mode == "full":
            random_word1 = random.choice(wl_adj)
            random_word2 = random.choice(wl_nom)
            
        elif mode == "nature":
            random_word1 = random.choice(wl_nature_adj)
            random_word2 = random.choice(wl_nature_nom)
            
        elif mode == "tec":
            random_word1 = random.choice(wl_tec_adj)
            random_word2 = random.choice(wl_tec_nom)
            
        elif mode == "myth":
            random_word1 = random.choice(wl_myth_adj)
            random_word2 = random.choice(wl_myth_nom)
            
        elif mode == "space":
            random_word1 = random.choice(wl_space_adj)
            random_word2 = random.choice(wl_space_nom)
            
        else:
            random_word1 = random.choice(wl_adj)
            random_word2 = random.choice(wl_nom)

        random_word = random_word1 + "-" + random_word2
        file_pattern = os.path.join(save_path, random_word + ".*")

        # Überprüfe, ob ein Dateiname mit diesem Muster bereits existiert
        if not glob.glob(file_pattern):
            return random_word
        print(f">>> {random_word} already exists. Trying again. {_ - max_attempts} until panic!")
    print(f"\n{bar}\nFATAL PANIC EXIT: Too many name generations.\n{bar}")
    sys.exit(1)

def cleanerf():
    print(f"{bar}\n     CLEANER STARTED")
    for path in paths:
        if os.path.exists(path):
            print(f"\n{bar}\n   # Running command on {os.path.basename(os.path.normpath(path))}")

            # Verwende glob, um alle *.part und *.ytdl Dateien im aktuellen Pfad zu finden
            part_files = glob.glob(os.path.join(path, "*.part")) + glob.glob(os.path.join(path, "*.ytdl"))

            if part_files:
                print("     #> Detected *.part or *.ytdl File(s) !")
                for part_file in part_files:
                    try:
                        os.remove(part_file)
                        cleaner_yeet += 1
                        print(f"     #> Deleted {part_file}")
                    except OSError as e:
                        print(f"     #> Error deleting {part_file}: {e}")
            else:
                print("     #> NO *.part or *.ytdl Files FOUND!")

            print(f"    # $$ COMPLETE :D")
    print(f"{bar}\n     CLEANER FINISHED\n{bar}")

def open_txtfile(config):
    os.system("sudo nano " + link_path)

# ===========================================
#   Start Actual Skript
while True: 
    print(
        f"{bar}\n{logo}\n{bar}\nCRTL+C to exit\n\nAvailable save paths:"
    )

    for i, path in enumerate(paths):
        if os.path.exists(path):
            file_count = 0
            need_cleanup = False

            for file in os.listdir(path):
                if not file.endswith("-poster.jpg"):
                    file_count += 1
                if file.endswith(".part") or file.endswith(".ytdl"):
                    need_cleanup = True

            status = "NeedCleanup" if need_cleanup else "Clean"
            print(f"    -> {i}: /{str(file_count).rjust(4)} files {status}/ {os.path.basename(os.path.normpath(path)).ljust(20)}")

        else:
            print(f"    -> {i}: Path does not exist / {os.path.basename(os.path.normpath(path))}")
    print(f"     -> {len(paths)}: # CLEANER #")
    print(f"     -> {len(paths)+1}: # CONFIG #")
    print(f"     -> {len(paths)+2}: # EXIT #")

    while True:
        try:
            index = int(input("\n>> Enter index of desired save path: "))
            print(index)
            if index < 0 or index > len(paths) + 2:
                raise ValueError
            break
        except ValueError:
            print(">!! Invalid Input!")
    if index == len(paths) + 2:
        print(f"{bar}\n>> EXITING\n{bar}")
        sys.exit(0)      
    elif index == len(paths):
        cleanerf()
        continue
    elif index == len(paths) + 1:
        manage_paths()
        continue
        
    save_path = paths[index]

    open_txtfile(config)

    if not os.path.exists(link_path):
        print(">!! File not found. Exiting.")
        exit()

    print(f"\n>> Started downloading videos to {save_path}\n")
    error_count = 0
    with open(link_path, "r") as file:
        try:
            links = file.readlines()
            total_links = len(links)
            processed_links = 0

            for link in links:
                link = link.strip()
                if link:
                    processed_links += 1
                    print(f"{bar}\n[{processed_links}/{total_links}] Verarbeitung von Link...")
                    if is_hashed_link(link):
                        print(f">> {ENC_TAG} - Decrypted link found!")
                        link = decrypt_link(link)
                        is_avlid = is_valid_url(link)
                        if not is_avlid:
                            print(f">> {ENC_TAG} - Decrypted link is not valid!")
                            continue
                        print(f">> {ENC_TAG} - Successful! Decrypted link!")
                    elif not is_valid_url(link):
                        print(f">> Invalid link: {link}")
                        continue
                    start_time = datetime.datetime.now()
                    filename = gen_name("full", save_path) + ".mp4"
                    cmd = "youtube-dl -o " + os.path.join(save_path, filename) + " " + link
                    print(">> CMD: " + cmd)
                    result = call(cmd.split(" "))
                    end_time = datetime.datetime.now()
                    if result != 0:
                        failed_downloads.append(link)
                        res_ok = "FAILED"
                        cnt_failed += 1
                    elif result == 0:
                        res_ok = "OK"
                        cnt_success += 1

                    detail_string = f"{bar}\nStatus: {res_ok}\nN° {processed_links}/{total_links}\nLink: {link}\nPath: {os.path.join(save_path, filename)}\nStart: {start_time}\nEnd  : {end_time}\n"
                    less_detail_string = f"{bar}\nStatus: {res_ok}\nN° {processed_links}/{total_links}\nLink: {link}\nStart: {start_time}"
                    download_details.append(less_detail_string)
                    print(detail_string)
            print(bar)
        except KeyboardInterrupt as e:
            print("\n>>>> KEYBOARDINTERRUPT.\n\nCleaning up *.part files")
            cleanerf()
            for detail in download_details:
                print(detail)
            exit()
    os.remove(link_path)

    is_fail = False
    if failed_downloads:
        is_fail = True
        len_failed = len(failed_downloads)
        print(f">> {len_failed} Downloads Failed \n Retry failed downloads?\n")
        cleaner = input(">> Y/N? >> ")
        if cleaner.lower() == "y" or cleaner.lower() == "yes" or cleaner.lower() == "j" or cleaner.lower() == "ja":
            for link in failed_downloads:
                try:
                    start_time = datetime.datetime.now()
                    print(bar)
                    filename = gen_name("full", save_path) + ".mp4"
                    cmd = "youtube-dl -o " + os.path.join(save_path, filename) + " " + link
                    print("CMD: " + cmd)
                    result = call(cmd.split(" "))
                    end_time = datetime.datetime.now()
                    if result != 0:
                        failed_downloads.append(link)
                        res_ok = "FAILED"
                        cnt_retry_fail += 1
                    elif result == 0:
                        res_ok = "OK"
                        cnt_retry_suc += 1
                        
                    detail_string = f"{bar}\nStatus: Retry {res_ok}\nN° {processed_links}/{total_links}\nLink: {link}\nPath: {os.path.join(save_path, filename)}\nStart: {start_time}\nEnd  : {end_time}\n"
                    less_detail_string = f"{bar}\nStatus: Retry {res_ok}\nN° {processed_links}/{total_links}\nLink: {link}\nStart: {start_time}"
                    download_details.append(less_detail_string)
                    print(detail_string)
                    time.sleep(5)
                except KeyboardInterrupt:
                    print("\n\n>>>> KEYBOARDINTERRUPT.\n\nCleaning up *.part files")
                    cleanerf()
                    for detail in download_details:
                        print(detail)
                    exit()

        elif cleaner.lower() == "n" or cleaner.lower() == "no" or cleaner.lower() == "nein":
            print(">> Do you want to save the failed downloads to a file?")
            encryp_save = input(">> Y/N? >> ")
            if encryp_save.lower() == "y" or encryp_save.lower() == "yes" or encryp_save.lower() == "j" or encryp_save.lower() == "ja":
                print(">> Start saving encrypted links of failed runs.")
                for link in failed_downloads:
                    save_encrypted_link(link, link_path)

                print(">> Successfully saved!")
            else:
                pass

    if is_fail:
        f_t = "\nWhich is recommended since some downloads failed."
    else:
        f_t = ""
    print("\n\n>> Downloading finished.\nDo you want to clean up all '*.mp4.part' files?" + f_t)
    cleaner = input(">> Y/N? >> ")
    if cleaner.lower() == "y" or cleaner.lower() == "yes" or cleaner.lower() == "j" or cleaner.lower() == "ja":
        cleanerf()
    else:
        print("\n     #### NOT CLEANING UP ####\n\n")
    for detail in download_details:
        print(detail)

    print(f"{bar}\n>> FINISHED {len(download_details)} Runs\n{cnt_failed} failed.\n{cnt_success} successful.\n{cnt_retry_fail} failed retries.\n{cnt_retry_suc} successful retries.\nCYA :)\n{bar}")
    break
