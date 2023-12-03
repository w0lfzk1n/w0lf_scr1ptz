#!/bin/python

import os
import random
import glob
import requests
import json

bar = "[==================================================]"
logo = f"{bar}\n___________.__.__\n\_   _____/|__|  |   ____\n |    __)  |  |  | _/ __ \.\n |     \   |  |  |_\  ___/\n \___  /   |__|____/\___  >\n_____\/___              \/\n\______   \ ____   ____ _____    _____   ____\n |       _// __ \ /    \.\__ \  /     \_/ __ \n |    |   \  ___/|   |  \/ __ \|  Y Y  \  ___\n |____|_  /\___  >___|  (____  /__|_|  /\___  \n        \/     \/     \/     \/      \/     \/ \n{bar}"

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
        print(f"File not found: {file_path}")
        return None
    except json.JSONDecodeError:
        print(f"Error while parsing JSON-File: {file_path}")
        return None

config = read_json_file(CONF_PATH)

if config:
    core_path = config["base_path"]

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

    valid_extensions = config["valid_rename_extensions"]
    exclude_parts = config["rename_exclude_part"]
else:
    print("Error while loading Config files.")
    exit()

print(logo)
print("\nIf you have set a core path in the configfile, you can use it by typing 'y' in the next step.")
print("Configfile core path: python_data/core_python_conf.json")
print("Othrwise you can type in the full path manually.")
use_core = input("\n>> Use core path from configfile? (y/n): ")
if use_core.lower() == "y" or use_core.lower() == "yes" or use_core.lower() == "j" or use_core.lower() == "ja":
    core = core_path
else:
    core = ""
path = core + input(f"ENTER A PATH: {core}")
path = path.replace("\\", "/")

if not os.path.exists(path):
    print(f"\n>> Path '{path}' does not exist. Panic Exit.")
    exit()
else:
    print(f"\n>> Path '{path}' is valid")

# ===========================================
#   GEN NAME FUNCTION
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

def get_files_by_extension(path, valid_extensions):
    available_extensions = set()
    files = []

    for ext in valid_extensions:
        matched_files = glob.glob(os.path.join(path, f"*{ext}"))
        files.extend(matched_files)

        if matched_files:
            available_extensions.add(ext)

    return files, available_extensions

while True:
    print("\n1) Own Name\n2) Random Name\n3) Random Nature Name\n4) Random Tec Name\n5) Random Myth Name\n6) Random Space Name\n")
    names = input("Choice: ")
    if names in ["1", "2", "3", "4", "5", "6"]:
        break # Break out of the while-loop when a valid input is given of the list
    print("Wrong Input. Please enter between 1 and 6.")

files = []
for ext in valid_extensions:
    files.extend(glob.glob(os.path.join(path, f"*{ext}")))

# Hole Dateien und verfügbare Erweiterungen
files, available_extensions = get_files_by_extension(path, valid_extensions)

print(bar)
for i, ext in enumerate(valid_extensions):
    print(f"-- {ext}")
print(bar)
print("\nAvailable extensions in the directory:")
for i, ext in enumerate(available_extensions):
    print(f"{i}: {ext}")

chosen_extension_indexes = input("\nChoose one or more extensions by index (comma-separated): ").split(',')

# Konvertiere die Eingabe in Indizes und filtere ungültige Eingaben
valid_indexes = [int(index.strip()) for index in chosen_extension_indexes if index.strip().isdigit() and int(index.strip()) in range(len(available_extensions))]
chosen_extensions = [list(available_extensions)[index] for index in valid_indexes]

# Filter files by chosen extensions
files = [file for file in files if any(file.endswith(ext) for ext in chosen_extensions)]

if names == "1":
    name = input("\n>> Name for files: ")
    owncounter = 0

for file in files:
    if any(part in file for part in exclude_parts):
        trigger_part = [part for part in exclude_parts if part in file][0]
        if trigger_part == "-poster":
            os.remove(file)
            print(f">> Deleted File [ {os.path.basename(file)} ] due {trigger_part}\n{bar}")
        else:
            print(f">> Skipped File [ {os.path.basename(file)} ] due {trigger_part}\n{bar}")
        continue
    if names == "1":
        random_word = name + str(owncounter)
        owncounter += 1
    elif names == "2":
        random_word = gen_name("full")
    elif names == "3":
        random_word = gen_name("nature")
    elif names == "4":
        random_word = gen_name("tec")
    elif names == "5":
        random_word = gen_name("myth")
    elif names == "6":
        random_word = gen_name("space")
    
    file_extension = os.path.splitext(file)[1]
    new_file_name = os.path.join(
        os.path.dirname(file), f"{random_word}{file_extension}"
    )
    os.rename(file, new_file_name)
    print(
        f">> File [ {os.path.basename(file)} ]\nchanged [ {os.path.basename(new_file_name)} ]\n{bar}"
    )
print("\n>> Done :) Bye")