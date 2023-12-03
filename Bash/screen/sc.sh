#!/bin/bash

if type screen >/dev/null 2>&1; then
    echo ">> Screen ist installiert"
else
    echo ">> Screen ist nicht installiert"
    echo "Bitte führe 'sudo apt install screen' aus, oder installiere es für deine Distro."
    exit
fi


# Funktion zum Auflisten aller aktiven screen-Sitzungen und dem Beitritt zu einer von ihnen
list_and_join() {
    echo "Wählen Sie die Sitzungsnummer zum Beitreten aus:"
    select opt in $(screen -ls | grep 'Detached' | awk '{print $1}'); do
        screen -r $opt
        break
    done
}

# Funktion zum Erstellen einer neuen screen-Sitzung
create_screen() {
    read -p "Geben Sie einen Namen für den screen ein (max. 10 Zeichen, keine Zahlen): " screen_name
    while [[ ! "$screen_name" =~ ^[a-zA-Z]{1,10}$ ]]; do
        echo "Ungültiger Name. Bitte erneut eingeben."
        read -p "Geben Sie einen Namen für den screen ein (max. 10 Zeichen, keine Zahlen): " screen_name
    done
    screen -AmdS $screen_name
}

# Funktion zum Erstellen und Betreten einer neuen screen-Sitzung
create_and_join_screen() {
    read -p "Geben Sie einen Namen für den screen ein (max. 10 Zeichen, keine Zahlen): " screen_name
    while [[ ! "$screen_name" =~ ^[a-zA-Z]{1,10}$ ]]; do
        echo "Ungültiger Name. Bitte erneut eingeben."
        read -p "Geben Sie einen Namen für den screen ein (max. 10 Zeichen, keine Zahlen): " screen_name
    done
    screen -AmdS $screen_name
    screen -r $screen_name
}

# Funktion zum Detachen einer screen-Sitzung per Indexnummer
unbind_screen() {
    echo "Wählen Sie die Sitzungsnummer zum Detachen aus:"
    select opt in $(screen -ls | grep '(Attached)' | awk '{print $1}'); do
        screen -d $opt
        break
    done
}

# Hauptmenü
PS3='Bitte wählen Sie eine Option: '
select opt in "List and Join" "Create" "Create and Join" "Unbind" "Help" "Exit"; do
    case $opt in
        "List and Join")
            list_and_join
            ;;
        "Create")
            create_screen
            ;;
        "Create and Join")
            create_and_join_screen
            ;;
        "Unbind")
            unbind_screen
            ;;
        "Help")
            echo "Screen ist ein Linux Tool welches dir erlaubt auf eine Art weitere 'Bildschirme' zu deiner Konsolensitzung hinzuzufügen, welche im Hintergrund weiterlaufen. Mit CRTL+A+D kannst du von einem 'Screen' zurück auf den Monitor und der Screen oder was auch immer er macht, wird weiterhin ausgeführt."
            echo "Hier sind die wichtigsten Befehle des Commands 'screen' in der Konsole:"
            echo "'screen -AmdS <name>' ohne die <> erstellst du so einen weiteren Bildschirm. Diese haben eine PID (Eine Zahl als ID) und einen Namen."
            echo "'screen -r <name/PID)>' zum verbinden auf einen Screen."
            echo "'screen -d <name/PID>' wenn der Screen noch bei einer anderen Session angezeigt wird oder die vorherige SSH oder Screenverbindung nicht korrekt beendet wurde, trennt dieser Befehl diese Verbindung sodass man wieder verbinden kann."
            echo "'screen -ls' Listet alle aktiven Screens und deren PID"
            ;;
        "Exit")
            break
            ;;
        *) echo "Ungültige Option $REPLY";;
    esac
done
