#!/bin/python

from subprocess import call
import os
import datetime
import random
import json
import time

logo = "\n██╗   ██╗████████╗██████╗ \n╚██╗ ██╔╝╚══██╔══╝██╔══██╗\n ╚████╔╝    ██║   ██║  ██║\n  ╚██╔╝     ██║   ██║  ██║\n   ██║      ██║   ██████╔╝\n   ╚═╝      ╚═╝   ╚═════╝ "
bar = "[==================================================]"

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
    # Fehlerbehandlung, falls Dateien nicht geladen werden konnten
    print("Fehler beim Laden der Konfigurationsdateien.")

# ===========================================
# Config Editing & Functions
def write_config(config):
    with open(CONF_PATH, 'w') as file:
        json.dump(config, file, indent=4)

def display_paths(paths):
    for index, path in enumerate(paths):
        print(f"{index}: {path}")

def add_path(config):
    new_path = input(f"Gib den neuen Pfad ein:\n{base_path}")
    config["paths"].append(new_path)
    write_config(config)
    print(f"{bar}\nSavepath {new_path} gespeichert.\n{bar}")

def create_folder(config):
    folder_path = input(f"Gib den Pfad für den neuen Ordner ein:\n{base_path}")
    full_path = os.path.join(config["base_path"], folder_path)
    if not os.path.exists(full_path):
        os.makedirs(full_path)
        print(f"{bar}\nOrdner {full_path} erstellt.\n{bar}")
    else:
        print(f"{bar}\nOrdner existiert bereits.\n{bar}")

def edit_path(config):
    display_paths(config["paths"])
    index = int(input("Wähle den Index des zu bearbeitenden Pfades: "))
    new_path = input("Gib den neuen Pfad ein: ")
    config["paths"][index] = new_path
    write_config(config)

def delete_path(config):
    display_paths(config["paths"])
    index = int(input("Wähle den Index des zu löschenden Pfades: "))
    del config["paths"][index]
    write_config(config)

def manage_paths():
    options = {
        "1": add_path,
        "2": create_folder,
        "3": edit_path,
        "4": delete_path
    }
    print("Optionen:")
    print("1: Neuen Eintrag hinzufügen")
    print("2: Ordner erstellen")
    print("3: Eintrag editieren")
    print("4: Eintrag löschen")
    choice = input("Wähle eine Option: ")
    if choice in options:
        options[choice](config)
    else:
        print("Ungültige Option.")

# ===========================================
#   GEN NAME
def gen_name(mode):
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
    return random_word


import glob

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
                        print(f"     #> Deleted {part_file}")
                    except OSError as e:
                        print(f"     #> Error deleting {part_file}: {e}")
            else:
                print("     #> NO *.part or *.ytdl Files FOUND!")

            print(f"    # $$ COMPLETE :D")
    print(f"{bar}\n     CLEANER FINISHED\n{bar}")

# ===========================================
#   Start Actual Skript

print(
    f"{bar}\n{logo}\n{bar}\nCRTL+C to exit\n\nAvailable save paths:"
)
for i, path in enumerate(paths):
    print(f"    -> {i}: {os.path.basename(os.path.normpath(path))}")
print(f"     -> {len(paths)}: # CLEANER #")
print(f"     -> {len(paths)+1}: # PATHS CONFIG #")


while True:
    try:
        index = int(input("\n>> Enter index of desired save path: "))
        if index < 0 or index > len(paths) + 1:
            raise ValueError
        break
    except ValueError:
        print(">!! Invalid Input!")
        
if index == len(paths):
    cleanerf()
    exit()
elif index == len(paths) + 1:
    manage_paths()
    exit()
    
save_path = paths[index]

os.system("sudo nano " + link_path)

if not os.path.exists(link_path):
    print(">!! File not found. Exiting.")
    exit()
    
print(f"\n>> Started downloading videos to {save_path}\n")
error_count = 0
with open(link_path, "r") as f:
    try:
        for link in f:
            link = link.strip()
            if link:
                start_time = datetime.datetime.now()
                print(bar)
                filename = gen_name("full") + ".mp4"
                cmd = "youtube-dl -o " + os.path.join(save_path, filename) + " " + link
                print(">> CMD: " + cmd + "\n")
                result = call(cmd.split(" "))
                end_time = datetime.datetime.now()
                if result != 0:  # Nicht erfolgreicher Download
                    failed_downloads.append(link)
                    res_ok = "FAILED"
                elif result == 0:
                    res_ok = "OK"

                detail_string = f"\n{bar}\nStatus: {res_ok}\nLink: {link}\nPath: {os.path.join(save_path, filename)}\nStart: {start_time}\nEnd  : {end_time}"
                download_details.append(detail_string)
                print(detail_string)
        print(bar)
    except KeyboardInterrupt:
        print("\n>>>> KEYBOARDINTERRUPT.\n\nCleaning up *.part files")
        cleanerf()
        for detail in download_details:
            print(detail)
        exit()

# Versuche fehlgeschlagene Downloads erneut
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
                filename = gen_name("full") + ".mp4"
                cmd = "youtube-dl -o " + os.path.join(save_path, filename) + " " + link
                print("\n CMD: " + cmd + "\n")
                result = call(cmd.split(" "))
                end_time = datetime.datetime.now()
                if result != 0:  # Nicht erfolgreicher Download
                    failed_downloads.append(link)
                    res_ok = "FAILED"
                elif result == 0:
                    res_ok = "OK"
                    
                detail_string = f"\n{bar}\nRETRY\nStatus: {res_ok}\nLink: {link}\nPath: {os.path.join(save_path, filename)}\nStart: {start_time}\nEnd  : {end_time}\n{bar}"
                download_details.append(detail_string)
                print(detail_string)
                time.sleep(5)
            except KeyboardInterrupt:
                print("\n\n>>>> KEYBOARDINTERRUPT.\n\nCleaning up *.part files")
                cleanerf()
                for detail in download_details:
                    print(detail)
                exit()

# Bereinigung und Ausgabe der Download-Details
os.remove(link_path)
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
