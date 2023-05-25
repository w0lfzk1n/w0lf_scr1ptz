#!/bin/bash
#       ╔   ═   ╦   ╩   ╗   ║   ╠   ╚   ╝

#╔═════════════════════════════════════════════════════════════════════════════════════════╗
#║ Name:         bash_basics.sh
#║
#║ Aufruf:       ./bash_basics.sh [<1. Parameter>] [<2. Parameter>]
#║               [Beide Parameter können frei gewählt werden und werden bei der Argumente
#║                Option im Menü verwendet.]
#║
#║ Beschreibung: Lernskript welches einen Beschreibungstext mit simplen Beispiel ausgibt
#║               und diesen Beispielcode verbose in der Konsole zum mitlesen ausführt.
#╠═════════════════════════════════════════════════════════════════════════════════════════
#║ Version:      0.0.1
#║ Datum:        29.01.2020
#╚═════════════════════════════════════════════════════════════════════════════════════════╝

# Websites:
#       ASCII GEN: https://patorjk.com/software/taag/#p=display&f=Graffiti
#       Editor   : https://code.visualstudio.com/

# Tipps:
#   Auf Windows, in den Microsoft Store gehen
#   UBUNTO 22.04.01 LTS installieren & aufsetzen (easy, braucht ca 2GB Speicher)
#       cd /mnt/
#       ls -l
#   Hier seht ihr eure Drives (C Drive, etc)
#   wechselt in den Ordner/Pfad wo sich das Skript hier befindet

# Dieses Skript besteht aus 2 Teilen.
#   Teil 1: TEXTE_Array (menu)
#       --Ein grosser Array mit vielen Texten, kann grossteils übersprungen werden.
#   Teil 2: MAIN
#       --Der Hauptteil in Form einer while Schlaufe, solange der USer nicht 0 eingibt oder mit CRTL-C
#         das Skript verlässt, zeige das Menü und mache Userabfrage, bei einer korrekten Abfrage, rufe den Text
#         anhand der ID und des keywords ab, die im Array hinterlegt sind.

# Ich habe eine Weile an diesem Skript gearbeitet, ca 6h total.
# Ich bitte euch also, mit Respekt dieses Skript zu benutzen.
# Wer es unerlaubt teilt oder als seine Arbeit ausgibt, bekommt mit Lineal auf die Finger!

#       ==        __                   __           ==
#       ==      _/  |_  ____ ___  ____/  |_         ==
#       ==      \   __\/ __ \\  \/  /\   __\        ==
#       ==       |  | \  ___/ >    <  |  |          ==
#       ==       |__|  \___  >__/\_ \ |__|          ==
#       ==                 \/      \/               ==

#Multidimensionaler Array für Texte
declare -A menu
#Objekt 0, Welcome Text und Disclaimer
menu[0,welcome]="__________               .__   __________               .__        
\______   \_____    _____|  |__\______   \_____    _____|__| ____  
 |    |  _/\__  \  /  ___/  |  \|    |  _/\__  \  /  ___/  |/ ___\ 
 |    |   \ / __ \_\___ \|   Y  \    |   \ / __ \_\___ \|  \  \___ 
 |______  /(____  /____  >___|  /______  /(____  /____  >__|\___  >
        \/      \/     \/     \/       \/      \/     \/        \/ 

    >> Bash Basic Menu      Wolfskind       v0.0.2
═════════════════════════════════════════════════════════════════════════════════════
            %%%  DISCLAIMER  %%%

Skript ist eine persönliche Übung, ich bitte um respektvollen Umgang.
Eine Sammlung an Informationstexten und Codebeispielen zur Verwendung
von der UNIX-SHell 'BASH' für Konsole und Skripts.
Ebenso wie Grundlegendes Programmierwissen und Regeln.

Texte können lang werden, daher hochscrollen muss gewährleistet sein.
Die Informationen sind Anfängerfreundlich gehalten und sollten leicht
zu verstehen und anzuwenden sein.

Es gibt 3 Teile bei jedem Menüpunkt:
    >> Eine Beschreibung
    >> Einen kleinen simplen Beispielcode
    >> Das Ergebnis des Beispielcodes (meist mit Userinput zum lernen)

Wer den Code öffnet und lesen will, sollte meinen Kommentaren folgen!
Es wird erst mehr und komplizierter wirken als es ist!

Sobald ihr jedoch etwas durch die Texte gelesen habt und selbst etwas herumgespielt habt,
solltet ihr jedoch das simple Skript hier verstehen, welches nur ein paar
Texte ausgibt.
Habt ihr hiermit etwas gelernt? Ich würde mich über ein Gipfeli freuen ;] <3

Das Skript ist eine persönliche Übung, das ich mit dem Hintergedanken
an ein allgemein nützliches Werkzeug erschaffen habe.
Wer es ohne meine Erlaubnis teilt oder etwas aus diesem Skript als eigene Arbeit aus/abgibt, 
bekommt mit Lineal auf die Finger!
═════════════════════════════════════════════════════════════════════════════════════

[CRTL + C] um zu verlassen
"
#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               INFO TEXT
menu[0,info]='
°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°
GESCHICHTE und AUFBAU:

Bash, auch bekannt als Bourne Again Shell, ist eine Unix-Shell, die von Brian Fox entwickelt wurde.
Sie wurde 1989 veröffentlicht und ist eine Weiterentwicklung der Bourne Shell, die von Steve Bourne entwickelt wurde.

Bash ist eine der am häufigsten verwendeten Shells auf Unix-Systemen und wird auch auf vielen Linux- und MacOS-Systemen verwendet.

Die grundlegenden Bausteine für jedes Programm in Bash sind Befehle, Variablen und Steuerstrukturen.

>> Befehle
    sind Anweisungen, die an die Shell gesendet werden, um bestimmte Aktionen auszuführen.

>> Variablen
    speichern Werte und können verwendet werden, um die Ausführung von Befehlen zu beeinflussen.

>> Steuerstrukturen
    ermöglichen es, die Ausführung von Befehlen zu steuern, indem Bedingungen geprüft und Schleifen ausgeführt werden.

°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°
DIE HÄUFIGSTEN FEHLER:

>> Syntaxfehler:
    Einer der häufigsten Fehler, die Anfänger beim Programmieren machen, ist das Schreiben von Code mit falscher Syntax.
    Dies kann dazu führen, dass das Programm nicht korrekt ausgeführt wird oder sogar abstürzt.

>> Fehlende Schreibweise:
    Ein weiterer häufiger Fehler ist das Vergessen von Schreibweise, wie zum Beispiel das Vergessen von Anführungszeichen, Klammern oder Semikolons (;).
    Dies kann dazu führen, dass das Programm nicht korrekt ausgeführt wird.

>> Unvollständige Bedingungen:
    Anfänger machen oft den Fehler, unvollständige Bedingungen (if, for,...) zu schreiben, die dazu führen,
    dass das Programm unerwartete Ergebnisse liefert oder sogar abstürzt.

>> Unklare Variablen:
    Wenn Variablen nicht korrekt deklariert oder benannt werden,
    kann dies dazu führen, dass das Programm nicht korrekt ausgeführt wird oder Fehler aufweist.

>> Unklare Struktur:
    Oftmals macht man sich anfangs wenig Gedanken, um den Code den man gerade schreibt. Dies könnte zur Folge haben
    dass dieser Teil Code im nachhinein Probleme wegen der Umsetzung, Speicherung oder Deklarierung von Werten oder Funktionen bringt.
    Ein guter Code, wurde im vorhinein gut geplant, jede Struktur an Abläufen durchdachte und verfolgt einem einheitlichen Schema.

>> Fehlende Fehlerbehandlung:
    Ein weiterer häufiger Fehler ist das Fehlen von Fehlerbehandlung im Code.
    Dies kann dazu führen, dass das Programm direkt nach dem Fehler komplett beendet wird, anstatt nur einen Fehler anzuzeigen.

°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°
WAS IST EIN PROGRAMM:

Ein Programm ist eine Anweisungssammlung, die von einem Computer ausgeführt wird, um eine bestimmte Aufgabe auszuführen.
Ein gutes Programm ist gut strukturiert und einfach zu verstehen.
Ein gutes Programm sollte auch effizient sein und nicht unnötig Ressourcen verbrauchen, wie zum Beispiel das selbe Stückchen code zum löschen
von Datei X, 35x im code deklarieren.

Ein gutes Programm besteht aus mehreren Teilen, die zusammenarbeiten, um die Aufgabe auszuführen.
Diese Teile sind:

>>Eingabe:
    Hier werden Daten von außen empfangen, wie zum Beispiel von einer Tastatur oder einer Datei.

>>Verarbeitung:
    Hier werden die Daten verarbeitet, um die gewünschte Aufgabe auszuführen. Dies kann Mathematische Berechnungen, logische Vergleiche, Schleifen und vieles mehr beinhalten.

>>Ausgabe:
    Hier werden die Ergebnisse des Programms ausgegeben, wie zum Beispiel auf dem Bildschirm oder in einer Datei gespeichert.

°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°
WIE FANGE ICH RICHTIG AN?

Eine gute Programmierstrategie ist es, den Code in kleine, überschaubare und wiederverwendbare Funktionen zu unterteilen.
Sogenannte "Blöcke", jeder Block hat dann eine bestimmte Aufgabe.
    Gebe "X" aus
    Berechne die Summe aus...
    Verschiebe die Datei in diesen Ordner

Die Verwendung erleichtert es, Fehler zu finden und zu beheben und es ermöglicht es auch, den Code später zu erweitern oder zu ändern.
>> z.B:
    WIE MAN ES NICHT TUT
        read -p "Welche Datei willst du verschieben?" index
        if [index == 1] {
            hole_name_der_Datei($1)
            hole_grösse_der_Datei($1)
            verschiebe_Datei
            printe_Resultat

        } elif [index == 2] {
            hole_name_der_Datei($2)
            hole_grösse_der_Datei($2)
            verschiebe_Datei
            printe_Resultat

        } elif [index == 3] {.....

    WIE MAN ES MACHEN KÖNNTE
        function process_file() {
            hole_name_der_Datei($1)
            hole_grösse_der_Datei($1)
            verschiebe_Datei
            printe_Resultat
        }

        read -p "Welche Datei willst du verschieben?" index
        if [index == 1] {
            process_file $1
        } elif [index == 2] {
            process_file $2
        } elif [index == 3] {...

Mehr hierzu unter Menüpunkt FUNKTIONEN

Wichtig bei der Benutzung von BASH, ist das Beachten der richtigen Verwendung von Leerzeichen!
Verschiedene Programmiersprachen, bestehen auf die ausnahmslos richtig verwendete Formatierung.
>> z.B.
    # FALSCH
    haus_nummer = 20

    # KORREKT
    hausnummer=20

Während die obere Angabe in BASH falsch ist, wäre sie zum Beispiel in der Sprache "Python" korrekt.
In Python wiederrum, wird auf die richtige Verwendung von Tabs geachtet.
>> z.B.
    # FALSCH
    a = 20
    if a > 19:
    print("a ist grösser als 19")

    # KORREKT
    a = 20
    if a > 19:
        print("a ist grösser als 19")

Es ist möglich ALLES in eine einzelne Zeile zu schreiben, oder zumindest einen Teil davon.
Hierbei ist es wichtig, wie es in Java zum Beispiel IMMER notwendig ist, dem Programm mit einem Semicolon ";"
mitzuteilen dass diese Linie/ dieser Satz nun fertig ist.
>> z.B.
    a=9
    if [a == 9]; do;
        echo "a ist 9"

Eine weitere gute Strategie ist es, den Code gut zu kommentieren, um zu erklären, was jeder Teil des Codes tut.
Dies erleichtert es, den Code später zu verstehen und zu warten.
Ebenso helfen simple aber eindeutige Namensgebungen oder gegebenfalls kategorisierungen der Variablen.
>>z.B:
    spiel_stand=0
    spiel_runde=0
    spiel_spieler=0

    player_leben=0
    player_score=0
    player_name="Hans Peter"

Es ist auch wichtig, den Code regelmäßig zu testen und zu debuggen (testen), um sicherzustellen, dass er korrekt funktioniert.

Wenn man beim Schreiben von Code Spass hat, ist es wichtig, sich Zeit zu nehmen, um die Aufgabe zu verstehen und gut zu planen, bevor man mit dem Schreiben des Codes beginnt.
Es ist auch wichtig, sich kleine Erfolge zu gönnen und sich nicht zu sehr unter Druck zu setzen.
Man sollte sich auch die Zeit nehmen, um über den Code nachzudenken und ihn zu optimieren, um sicherzustellen, dass er effizient und gut strukturiert ist.

Schlechter oder wenig durchdachter Code, verdirbt einem schnell die Lust, da es dann nicht so funktioniert wie man es will :)

Jeder Mensch schreibt Code anders, daher ist es wichtig zu wissen, dass es nie wirklich "den richtigen Code" geben wird.
Jeder Mensch muss seinen eigenen Weg und Schema finden, wie er Code schreibt und gestaltet.'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#                       VARIABLEN
menu[1,desc]='
Mit Variablen kann man innerhalb des Skriptes/Programmes anhand eindeutiger "Namen" Werte wie Strings(text), Integer(zahlen), Boolean(true/false)
und anderes speichern.

Variablen werden deklariert indem man ihnen einen Wert zuweist.

Dies geschieht mit dem "=" Zeichen,
Wichtig zu beachten ist die korrekte Anwendung von Leerzeichen!
Siehe mehr dazu unter Menüoption "Fehlerbehandlung"
>>z.B.
    name="John"

    NICHT
    name = "John"

Variablen können später im Skript verwendet werden, indem man den Variablennamen in doppelte Anführungszeichen mit einem "$" schreibt,
>>z.B.
    echo "Hallo, $name"

Es gibt verschiedene Zeichen um "Strings" in Programmiersprachen zu deklarieren, manche ermöglichen spezielle Funktionen,
wie " ermöglicht, mit dem $ Zeichen, andere Variablen aufzurufen, das bei anderen nicht geht.
Gängig ist es jedoch, " zu nutzen.

Bash unterscheidet nicht zwischen verschiedenen Datentypen, Variablen sind also einfach Zeichenketten.
Man muss also keinen Datentyp wie zB bei Java angeben.

Man kann auch arithmetische Operationen (Plus/Minus/Mal/Geteilt) auf Variablen anwenden,
indem man sie in doppelte runde Klammern schreibt,
>>z.B.
    x=5;
    echo $((x+3))

Möchtest du mehrere Objekte in einem Variablen aufruf benutzen, zB um das Ergenis von
13-6
anzeigen zu lassen, müssen {} nach dem $ benutzt werden.
Zum Beispiel, wie unten einen Text aus dem am Anfang des Skriptes erstellten Arrays, in welchem alle Texte dieses Skriptes gespeichert sind.
>>z.B.
    variablen_beschreibung="${menu[1,description]}"

"1" dient hierbei der überprüfung mit der Index und der Eingabe des Users.
"description" dient der Identifizierung, da es zu jedem Objekt in diesem Skript ein "example" und ein "description" String mit Text gibt.

Es ist auch möglich, Variablen als readonly zu deklarieren, was bedeutet, dass sie nicht mehr verändert werden können,
indem man "readonly" vor der Variablendeklaration verwendet.
Bei normalen Variablen, ist es möglich diese im Laufe des Skriptes mit neuen Werten zu deklarieren oder diese (im Falle von Zahlen) zu verändern.
>>z.B.
    readonly constant=3

Soll nun zum Beispiel vom User der Name abgefragt werden und in eine EmailAdresse verwandelt werden,
kann man die Funktion "read" nutzten und mit einem $ in eine andere Variable einbauen.
>>z.B.
    read -p "Wie lautet dein Name:" input_name
    echo "$input_name.schule@email.com"
'
menu[1,example]='x=13;
read -p "Gebe den Wert für Y ein: " y
echo "x=$x"
echo "y=$y"
echo "x-y=$((x-y))"'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#                       ARGUMENTE
menu[2,desc]='
Argumente werden in Bash verwendet, um Skripte mit zusätzlichen Informationen aufzurufen.
Sie werden dem Skriptnamen nach aufgerufen,
>> z.B.
    ./myscript.sh arg1 arg2.

Innerhalb des Skripts können die Argumente über spezielle Variablen abgerufen werden,
>> z.B.
    $1 für das erste Argument,
    $2 für das zweite Argument,
    usw...
    echo "Erstes Argument: $1, Zweites Argument: $2"

Es ist auch möglich, das gesamte Argumentenarray mit $@ oder $* abzurufen.
Dadurch werden alle Argumente in einem Array aufgerufen.
>> z.B.
    Mehr zur Benutzung von Arrays unter Menüpunkt "Arrays"

Ein einfaches Beispiel für die Verwendung von Argumenten in Bash könnte sein,
ein Skript zum Umbenennen von Dateien, das als Argumente den alten Dateinamen und den neuen Dateinamen entgegennimmt.

>> Inhalt des Skriptes "rename.sh":
    mv "$1" "$2"
    (mv = move <Datei/Ordner> <Zielpfad/Neuer Name>)

>> Aufruf des Skripts:
    ./rename.sh oldfile.txt newfile.txt

Dies würde die Datei "oldfile.txt" in "newfile.txt" umbenennen.

Zusätzlich zum Skriptaufruf, gibt es beim Aufrufen von Funktionen innerhalb des Skriptes die Möglichkeit, Argumente an den
dann folgenden Code weiter zu geben.

Hierzu bitte unter dem Menüpunkt "Funktionen" mehr lesen.'
menu[2,example]='
echo "       --Argument 1 des aktuellen Skripts: $1
       --Argument 2 des aktuellen Skripts: $2

(Wenn leer, wurde das ./bash_basics.sh Skript ohne Argumente gestartet)"'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               FOR-SCHLEIFE
menu[3,desc]='
For-Schleifen in Bash werden verwendet, um eine bestimmte Anweisung oder Gruppe von Anweisungen mehrmals auszuführen.
Es gibt verschiedene Arten von For-Schleifen, die in Bash verwendet werden können.

Das Keyword "do" besagt dass das Programm das dannach folgende tun soll, wenn die vorherige Angabe noch wahr ist und 
beendet mit dem Keyword "done" den Loop.

Eine häufig verwendete Art ist die "for-in"-Schleife, die verwendet wird, um durch eine Liste von Werten zu iterieren.
Die Objekte durch die iteriert (gelooped) wird, wird einfach nach dem "in" angehängt.

>>z.B.
    for value in 1 2 3 4 5
    do
        echo $value
    done

Dieser Code würde die Werte von 1 bis 5 auf dem Bildschirm ausgeben.

Eine weitere Art von For-Schleife ist die "for-range"-Schleife, die verwendet wird, um durch einen bestimmten Bereich von Werten zu iterieren.

>>z.B.
    for value in {1..5}
    do
        echo $value
    done

Eine weitere Art von for-Schleife ist die C-style for-Schleife, die auf ähnliche Weise wie in C-Programmierung verwendet werden kann
Hierbei wird zuerst der "Zähler" i mit 0 deklariert, dannach die Vorraussetzung (i kleiner 5) und zum Schluss die Operation welche am Ende
durchgeführt wird (i++ erhöhe i um +1)

>>z.B.
    for ((i=0; i<5; i++));
    do
        echo $i
    done

Eine weitere Art, wie For-Schleifen in Bash verwendet werden können, ist die Iteration durch ein Array.
Ein Array ist eine Sammlung von Werten, die unter einem gemeinsamen Namen gespeichert werden.

Ein Array in Bash kann deklariert werden, indem man die Werte in runde Klammern setzt und durch Leerzeichen getrennt.
Mehr unter Menüpunkt "Arrays"

>>z.B.
    colors=("red" "green" "blue")

Um durch die Werte eines Arrays zu iterieren, kann man die for-in Schleife verwenden und den Namen des Arrays anstelle einer Liste von Werten angeben

>>z.B.
    for color in "${colors[@]}"
    do
        echo $color
    done

Dieser Code würde die Werte "red", "green" und "blue" auf dem Bildschirm ausgeben.

Es ist auch möglich, die index (Position) des Array zu benutzen

>>z.B.
    for i in "${!colors[@]}"
    do
        echo $i ${colors[i]}
    done

Dieser Code würde die Indizes (Position als $i) und die Werte des Array auf dem Bildschirm ausgeben.
    0 red
    1 green
    2 blue

Es ist auch möglich, for-Schleifen mit Konditionen und anderen logischen Anweisungen zu kombinieren, um bestimmte Aktionen unter bestimmten Bedingungen auszuführen.

Ein einfaches Beispiel für die Verwendung einer for-Schleife in Bash könnte sein, ein Skript, das eine bestimmte Anzahl von Dateien erstellt.

>>z.B.
    for i in {1..5}
    do
        touch "file$i.txt"
        (touch = Editor, erstellt Datei ohne direktes öffnen)
    done

Dieser Code würde Dateien mit Namen file1.txt, file2.txt, file3.txt, file4.txt und file5.txt erstellen.'
menu[3,example]='for i in {1..5};
do
    echo "      Durchlauf NR° $i";
done'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#           WHILE-LOOP
menu[4,desc]='
While-Schleifen in Bash werden verwendet, um bestimmte Aktionen solange auszuführen, bis eine bestimmte Bedingung erfüllt ist.
Die Syntax (Schreibweise) einer While-Schleife ähnelt der von if-Anweisungen und besteht aus dem Schlüsselwort "while" gefolgt von einer Bedingung,
die in runden Klammern gesetzt wird.

Die Schleife beginnt mit dem "do" Schlüsselwort und endet mit dem "done" Schlüsselwort.

>>z.B.
    count=1
    while [ $count -le 5 ]
    do
        echo $count
        count=$((count+1))
    done

Dieser Code würde die Zahlen von 1 bis 5 auf dem Bildschirm ausgeben.
Die Bedingung "count -le 5" überprüft, ob die Variable "count" kleiner oder gleich 5 ist.
    -le = less equal /kleiner gleich
        Mehr zu Vergleichen, unter Menüpunkt "If-Statement"

Solange die Bedingung wahr ist, werden die Anweisungen innerhalb der Schleife ausgeführt.

Es ist auch möglich, die while Schleife mit einer Bedingung zu kombinieren, die auf einen bestimmten Wert geprüft wird,

>>z.B.
    while read line
    do
        echo $line
    done < file.txt

Dieser Code würde die Inhalte der Datei file.txt zeilenweise auf dem Bildschirm ausgeben.

While-Schleifen ermöglichen es, bestimmte Aufgaben solange auszuführen, bis eine bestimmte Bedingung erfüllt ist und sind besonders nützlich
für die Verarbeitung von Eingabedaten oder die Automatisierung von Aufgaben, die eine bestimmte Anzahl von Schritten erfordern.'
menu[4,example]='i=0;
while [ $i -lt 5 ];
do
    echo "i ist kleiner als 5, i = $i";
    i=$((i+1));
done'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               IF-STATEMENT
menu[5,desc]='
If-Statements in Bash werden verwendet, um bestimmte Aktionen auszuführen, wenn eine bestimmte Bedingung erfüllt ist.
Sie ermöglichen es, die Ausführung von Code basierend auf bestimmten Kriterien zu steuern.

Die Syntax eines If-Statements besteht aus dem Schlüsselwort "if" gefolgt von einer Bedingung in runden Klammern.
Die Anweisungen, die ausgeführt werden sollen, falls die Bedingung wahr ist, werden anschließend in eckigen Klammern gesetzt.

Das Keyword "then" besagt, dass ab hier der Code beginnt, welcher ausgeführt werden soll, wenn das IF-Statement wahr ist
und wird mit dem Keyword "fi" (finish) beendet.

>>z.B.
    age=25
    if [ $age -gt 18 ]
    then
        echo "Sie sind volljährig."
    fi

Dieser Code überprüft, ob die Variable "age" größer als 18 ist.
Wenn die Bedingung wahr ist, wird die Nachricht "Sie sind volljährig." auf dem Bildschirm ausgegeben.

Es ist auch möglich, mehrere Bedingungen in einem If-Statement zu verwenden und Aktionen auszuführen, falls die Bedingungen entweder wahr oder falsch sind.
If-Statements in Bash können auch mit "elif" (else if) erweitert werden, um mehrere Bedingungen zu überprüfen. 
Mit "elif" kann man eine zusätzliche Bedingung angeben, die überprüft werden soll, falls die erste Bedingung (die im "if" Teil steht) nicht erfüllt ist.
Wenn es eine Aktion geben soll, welche ausgeführt wird wenn gar kein IF-Statement wahr ist, verwendet man "else" welche keine Bedingungen zum überprüfen
bekommt.

>>z.B.
    if [ $age -lt 18 ]
    then
        echo "Sie sind minderjährig."
    elif [ $age -ge 18 ] && [ $age -lt 30 ]
    then
        echo "Sie sind im Alter zwischen 18 und 29."
    else
        echo "Sie sind 30 oder älter. Du alter Sack!"
    fi

Dieser Code überprüft, ob die Variable "age" größer als 18 und kleiner als 30 ist.
Falls die Bedingungen erfüllt sind, wird die Nachricht "Sie sind im Alter zwischen 18 und 29." auf dem Bildschirm ausgegeben.
Ansonsten wird die Nachricht "Sie sind entweder jünger als 18 oder älter als 29." ausgegeben.

If-Statements sind ein wichtiger Bestandteil jeder Programmiersprache und ermöglichen es, die Ausführung von Code zu steuern und auf bestimmte Bedingungen zu reagieren.

Liste an Optionen zum Vergleichen:
    -eq:
        Prüft, ob zwei Werte gleich sind (z.B. if [ $x -eq 5 ])
    -ne:
        Prüft, ob zwei Werte ungleich sind (z.B. if [ $x -ne 5 ])
    -lt:
        Prüft, ob ein Wert kleiner als ein anderer ist (z.B. if [ $x -lt 5 ])
    -le:
        Prüft, ob ein Wert kleiner oder gleich einem anderen ist (z.B. if [ $count -le 5 ])
    -gt:
        Prüft, ob ein Wert größer als ein anderer ist (z.B. if [ $x -gt 5 ])
    -ge:
        Prüft, ob ein Wert größer oder gleich einem anderen ist (z.B. if [ $x -ge 5 ])
    == :
        Prüft, ob zwei Werte gleich sind (z.B. if [ $x == 5 ])
    != :
        Prüft, ob zwei Werte ungleich sind (z.B. if [ $x != 5 ])'
menu[5,example]='read -p "Dein Alter: " age
if [[ $age -lt 18 ]]
then
    echo "Sie sind minderjährig."
elif [[ $age -ge 18 ]] && [[ $age -lt 30 ]]
then
    echo "Sie sind im Alter zwischen 18 und 29."
else
    echo "Sie sind 30 oder älter."
fi'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               BEFEHLE
menu[6,desc]='
Befehle in der Kommandozeile, auch als Shell-Befehle bekannt, sind Anweisungen, die in einer Shell-Eingabeaufforderung eingegeben werden,
um bestimmte Aktionen auf einem Computer auszuführen.
Diese Befehle ermöglichen es dem Benutzer, Dateien zu verwalten, Programme auszuführen, Netzwerkverbindungen herzustellen und vieles mehr.

Befehle sind eines der wichtigsten Werkzeuge, beim richtigen Umgang mit Computern sowie Netzwerken.
Für die meisten Befehle gibt es die sogenannte "manpage" (manual) also eine Anleitung.
>> z.B.
    man ls

Befehle können auch in einem Skript aufgerufen werde, wie das unten genannte Beispiel zeigen wird.
Und auch deren Rückgabe (Resultate) können in Variablen gespeichert werden, sowie innerhalb eines Strings/einer anderen Variable verwendet
werden.
Hierbei ist zu beachten, dass die Befehle in CAPS geschrieben werden müssen!
>> z.B.
    result_pwd="Aktueller Pfad: $PWD"


LISTE VON GÄNGIGEN BASH BEFEHLEN    
>>"ls"
     - Listet die Dateien und Ordner im aktuellen Verzeichnis auf.
>>"cd"
     - Wechselt das aktuelle Verzeichnis.
>>"mkdir"
     - Erstellt einen neuen Ordner.
>>"touch"
     - Erstellt eine neue leere Datei.
>>"cp"
     - Kopiert Dateien oder Ordner.
>>"mv"
     - Verschiebt oder umbenennt Dateien oder Ordner.
>>"rm"
     - Löscht Dateien oder Ordner.
     -r = recursiv um Ordner zu löschen (rm -r <Pfad zum Ordner>)
>>"rmdir"
     - Lösche einen LEEREN Ordner
>>"pwd"
     - Gibt das aktuelle Verzeichnis aus.
>>"echo"
     - Gibt einen gegebenen Text auf der Konsole aus.
>>"cat"
     - Zeigt den Inhalt einer Datei an.
>>"less"
     - Zeigt den Inhalt einer Datei an, aber man kann durch die Datei scrollen.
>>"grep"
     - Sucht nach einem bestimmten Text in einer Datei oder im Verzeichnis.
>>"find"
     - Sucht nach Dateien oder Ordnern im Verzeichnis.
>>"chmod"
     - Ändert die Zugriffsrechte für Dateien oder Ordner.
>>"chown"
     - Ändert den Besitzer oder Gruppe von Dateien oder Ordnern.
>>"man"
     - Zeigt die Handbuchseite für einen Befehl an.
>>"whoami"
     - Gibt den aktuellen Benutzer aus.
>>"clear"
     - Löscht den Inhalt des Terminals.
>>"history"
     - Gibt die Befehlsverlauf aus.
>>"exit"
     - Beendet die aktuelle Shell-Sitzung.
>>"sudo"
     - Führt einen Befehl als Root-Benutzer aus.
>>"apt-get
    " - Verwaltet Pakete und Abhängigkeiten auf Ubuntu-Systemen.
>>"yum"
     - Verwaltet Pakete und Abhängigkeiten auf Red Hat-Systemen.
>>"wget"
     - Lädt Dateien von einem HTTP- oder FTP-Server herunter.
>>"curl"
     - Sendet HTTP-Anfragen und zeigt die Antworten an.'
menu[6,example]='echo "Derzeitiges Verzeichnis:"
pwd
echo "Ersten 5 Dateien im Verzeichnis:"
ls -l | head -n 5'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               FUNKTIONEN
menu[7,desc]='
"Funktionen" beim Programmieren, sind Stücke an Code,
welche man durch ein Schüsselwort aufrufen und ausführen kann.

Diesem kann man Werte weitergeben und zurück erhalten.
Diese werden hauptsächlich dann verwendet, wenn ein Stück Code mehrfach an mehreren Stellen angewendet werden soll, dies aber massig
Paltz verschwenden und somit "je nachdem" auch die Leistung des Programmes beeinträchtigen würde.
Ein sauberer Code besteht aus vielen "Schachteln/Blocks", wobei jede Schachtel seinen eigenen individuellen Zweck besitzt.

Dies erleichtert die Übersichtlichkeit des Skripts und vereinfacht die Fehlerbehebung um einiges!

In Bash kann man eine aufrufbare Funktion erstellen und aufrufen, indem man dem folgenden Muster folgt:
>> z.B.
    function function_name() {
        # Code hier
    }

    function_name

"function" ist ein Schlüsselwort, das anzeigt, dass es sich um eine Funktion handelt
"function_name" ist der Name der Funktion.
Es kann beliebig gewählt werden, aber es sollten keine Leerzeichen oder Sonderzeichen enthalten sein!
Namen von Funktionen und Variablen sind immer simple aber eindeutig zu halten, sodass ihr auch in 6 Monaten selbst und auch andere versteht,
was diese Funktion am Ende genau macht.

Die runden Klammern sind optional, aber es ist eine gute Praxis, sie zu verwenden.
Innerhalb der geschweiften Klammern sind die Befehle, die ausgeführt werden, wenn die Funktion aufgerufen wird.

Beim Aufrufen der Funktionen durch ihren Namen, können auch Argumente weitergegeben werden.
Siehe Menü-Option "Argumente"
>> z.B:
    function greet() {
        echo "Hello, $1"
    }
    greet John

In diesem Beispiel erstellen wir eine Funktion "greet" die einen parameter entgegen nimmt und diesen dann ausgibt.
Aufruf der Funktion "greet" mit dem Wert "John".

Beachten sie das die Funktion erst nach der Deklaration aufgerufen werden kann.

Man kann auch Funktionen mit Rückgabewerten erstellen indem man einfach eine Variable mit dem gewünschten Rückgabewert zurück gibt,
>> z.B:
    function add() {
        echo $(( $1 + $2 ))
    }

    result=$(add 3 4)
    echo $result
    
In diesem Beispiel erstellen wir eine Funktion "add" die zwei Parameter entgegen nimmt und diese addiert und das Ergebnis zurück gibt.

Variablen und Werte die in einer Funktion deklariert werden, können !! nicht !!, ohne dass sie zurückgegeben wurden, verwendet werden.
>> z.B:
    function how_to_not() {
        a="tetris"
    }
    echo "$a"
'
menu[7,example]='
function add() {
    echo $(( $1 + $2 ))
}
read -p "Zahl 1 zum addieren: " a
read -p "Zahl 2 zum addieren: " b
result=$(add "$a" "$b")
echo "Resultat aus $a + $b = $result"'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               ARRAYS
menu[8,desc]='
Arrays sind ein wichtiger Bestandteil jeder Programmiersprache,
da sie es ermöglichen, mehrere Werte unter einem gemeinsamen Namen zu speichern.
>> z.B.
    namen=( "Max" "Moritz" "Julia" )

Jeder Wert im Array wird durch ein Leerzeichen voneinander getrennt und in eckige Klammern (") gesetzt.
Der Array-Name kann dann verwendet werden, um auf einzelne Werte im Array zugreifen.
Computer fangen bei 0 an zu zählen!
Somit ist in Arrays das erste Objekt "Max" mit der Index 0 aufzurufen!
>> z.B:
    echo ${namen[0]} # gibt "Max" aus
    echo ${namen[1]} # gibt "Moritz" aus
    echo ${namen[2]} # gibt "Julia" aus

Man kann auch ein Array mit einem For-Schleife durchlaufen:
>> z.B.
    for name in "${namen[@]}"
    do
        echo $name
    done

Ebenso ist es möglich in einem Array, einen Wert mit einem individuellen keyword aufrufbar zu machen.
Genau so, wie es in diesem Skript, mit den verschiedenen Info und Beispieltexten gemacht wird.
Dies ist jedoch komplizierter als die normale Benutzung von Arrays, da Multidimensionale Arrays (3D Array)
komplex sind.
>> z.B.
    #Erstelle Array namens menu
    declare -A menu
    #Speichere die Texte, Wichtig! keine Leerzeichen!
    menu[1,description]="Hier steht der Text"
    menu[2,description]="Hier steht noch ein Text"
    menu[2,example]="Hier steht der zweite Text, der Index 2"

Gibt der User nun die Index 2 ein, haben wir 2 individuelle Textobjekte mit denen wir arbeiten können.
Den "description" Text geben wir mitsamt des "example" Textes aus, jedoch werden wir mit "eval" (evaluation = ausführung)
den "example" textteil ausführen um zu sehen was er macht.

Jedoch mache ich hier nochmals ein Arraybeispiel, welches vielleicht genauer zeigen kann, wie ein Multidimensionaler Array
aussieht.
Dieses Beispiel ist aus einem JAVA-SCRIPT Code:
>> z.B.
    var autos =
        [
            # Hier beginnt das erste Objekt, dass mehrere Parameter mit Werten gespeichert hat
            {
                "marke": "bmw",
                "model": "XY",
                "ps": 600,
                "preis": 12000
            },

            # Und hier das zweite ;]
            {
                "marke": "kia",
                "model": "XY",
                "ps": 400,
                "preis": 6000
            },
                    {
                "marke": "mini",
                "model": "XY",
                "ps": 190,
                "preis": 42
            },
        ]

Bei der folgenden Variable "autos" ist ein nun möglich verschiedene Werte herraus zu lesen.
>> z.B.
    autos[0].marke
    # Gibt "bmw" aus
    
    autos[2].ps
    # Gibt "190" aus
    
Ich hoffe das hat Arrays verständlich erklärt. ^~^'

menu[8,example]='
namen=()
echo "Erstellen wir nun einen Array mit Namen.
while true;
do
    read -p "Geben Sie einen Namen ein (Ende mit q): " name
    if [ "$name" == "q" ];
    then
        break
    fi
    namen+=($name)
done
echo "Eingegebene Namen: ${namen[@]}"'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               SWITCH-CASE
menu[9,desc]='
"switch case" ist eine Art von Auswahlstruktur in Bash, die es ermöglicht, aus mehreren möglichen Auswahloptionen auszuwählen. 
Es besteht aus mehreren "cases", die durch "case" gekennzeichnet sind, 
und einer "default" Option, die ausgeführt wird, 
falls keiner der "cases" zutrifft.

Switch case ist ähnlich wie ein If-Statement, ist jedoch in der verarbeitung der "checks/überprufungen" ob es zutrifft schneller.
Dieses Verfahren wird dann eingesetzt, wenn es sehr viele Auswahlmöglichkeiten geben sollte.
>> z.B.
    Dieses Skript hat wenige Auswahlmöglichkeiten,
    IF-STatements sind also noch in Ordnung.

    Ein Chatbot mit über 250 Befehlen, und Userinput im 20 Sekundentakt 
    tut sich angenehmer mit einem Switch-Case Statement.


>> z.B.
    echo "Wählen Sie eine Zahl von 1-3 oder "unicorn":"
    read number

    case $number in
        1)
            echo "Sie haben die Zahl 1 gewählt."
            ;;
        2)
            echo "Sie haben die Zahl 2 gewählt."
            ;;
        3)
            echo "Sie haben die Zahl 3 gewählt."
            ;;
        "unicorn")
            echo "Brrrrrrrrrrrrrrrrrr."
            ;;
        *)
            echo "Ungültige Eingabe. Bitte wählen Sie eine Zahl von 1-3."
    esac

In diesem Beispiel fordert der Befehl "echo" den Benutzer auf, eine Zahl von 1-3 einzugeben.
Die eingegebene Zahl wird in die Variable "number" gespeichert.
Der "case" Befehl prüft dann die Variable "number" auf Übereinstimmung mit den verschiedenen "case" Optionen (1, 2, 3 oder "unicorn") und führt die entsprechende Aktion aus.
Falls keine Übereinstimmung gefunden wird, wird die "default" Option ausgeführt welcher mit dem Keyword "*" zu deklarieren ist.

Es ist zu beachten, dass jeder "case" mit ")" endet und jeder case-block mit ";;" endet.
Die default-option wird mit "*)" gekennzeichnet und esac am ende des switch-case block.
'

menu[9,example]='
echo "Wählen Sie eine Zahl von 1-3 oder "unicorn":"
read number

case $number in
    1)
        echo "Sie haben die Zahl 1 gewählt."
        ;;
    2)
        echo "Sie haben die Zahl 2 gewählt."
        ;;
    3)
        echo "Sie haben die Zahl 3 gewählt."
        ;;
    "unicorn")
        echo "Brrrrrrrrrrrrrrrrrr."
        ;;
    *)
        echo "Ungültige Eingabe. Bitte wählen Sie eine Zahl von 1-3."
esac
'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               STRING-BEARBEITUNG
menu[10,desc]='
In Bash können Sie mit dem Befehl "echo" Strings ausgeben 
und mit dem Operator "${variable}" Variableninhalte in andere Strings einfügen.

Operatoren sind zum Beispiel:
    - || "Logisches ODER"
    - && "Logisches UND"
    - <  "Kleiner als"
    - <= "KleinerGleich als" (Wahr ist, wenn Zahl kleiner oder genau die Zahl ist)
    - >  "Grösser als"
    - >= "GrösserGleich als"
    - =  "Gleich"
    - != "Nicht-Gleich"

Es gibt auch viele weitere Befehle und Operatoren zur Bearbeitung von Strings, 
wie z.B. zum Zusammensetzen von Strings mit ".",

Zum Ersetzen von Teilstrings mit "sed" 
oder zum Extrahieren von Teilstrings mit "cut".

Für eine genause liste, bitte ich doch Google zu nutzen, da dies das Ausmass dieses Skripts sprengen würde.

>> z.B.
    name="John Doe"
    number="AZ666"
    echo "Hallo, mein Name ist ${name}."
    echo "Mein Name hat $(echo $name | wc -c) Zeichen."
    echo "$number.$name"

LISTE AN OPERATOREN UND BEFEHLEN FÜR STRING-BEARBEITUNG
    String-Konkatenation (Zusammenführen): 
        "string1" "string2" oder "string1""string2"

    String-Länge bekommen:
        ${#string}

    Substring-Extraktion (Zeige nur von startzeichen(4) bis Zeichen(9) oder length(Ende) an):
        ${string:start:length}

    String-Ersetzung:
        ${string/altes/neues}

    String-Ersetzung (alle Vorkommen):
        ${string//altes/neues}

    String-Suche:
        ${string/%suffix/ersatz}

    String-Suche (alle Vorkommen):
        ${string//%suffix/ersatz}

    String-Suche (am Anfang):
        ${string/#prefix/ersatz}

    String-Suche (alle Vorkommen am Anfang):
        ${string//#prefix/ersatz}

    Befehl cut:
        cut -f1 -d ":" <file>

    Befehl sed:
        sed "s/altes/neues/g" <file>

    Befehl grep:
        grep -o "regex" <file>

    Befehl awk:
        awk "{ print $1 }" <file>

    Befehl tr:
        tr "[:lower:]" "[:upper:]" <file>
'
menu[10,example]='
    name="John Doe"
    number="AZ666"
    echo "Hallo, mein Name ist ${name}.
    Meine Nummer ist $number"
    echo "Mein Name hat $(echo $name | wc -c) Zeichen."
    echo "$number ist ${#number} Zeichen lang."
    echo "$name ist in number-kategorie: ${number:2:5}"
'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               FEHLER-BEARBEITUNG
menu[11,desc]='
In Bash können Sie Fehler mit dem "if-statement" und dem Rückgabewert des letzten Befehls
(0 für Erfolg, andere Werte für Fehler) abfangen.
Sie können auch den Befehl "set -e" verwenden, um das Skript bei jedem Fehler sofort zu beenden.
Es gibt auch den Befehl "trap", mit dem Sie Aktionen für bestimmte Signale
(wie z.B. Fehler) definieren können.
>> z.B.
    set -e
    #Kopiere Datei
    cp file1 file2 || { echo "Fehler beim Kopieren"; exit 1; }
    echo "Datei erfolgreich kopiert"

Fehlerbehandlung in Bash ist wichtig, um sicherzustellen, dass Ihr Skript korrekt ausgeführt wird und mögliche Probleme erkannt werden. 
Es gibt mehrere Möglichkeiten, Fehler in Bash zu behandeln.

Eine andere Möglichkeit ist die Verwendung von "if-then-else" Anweisungen, um spezifische Aktionen auszuführen, 
wenn ein Befehl erfolgreich oder fehlerhaft ausgeführt wird. 
    Beispielsweise können Sie eine Meldung ausgeben wie oben beschrieben, 
wenn ein Befehl fehlschlägt, oder einen anderen Befehl ausführen, um das Problem zu beheben.

Eine weitere Möglichkeit ist die Verwendung von "try-catch" Anweisungen,
die in Bash nicht direkt unterstützt werden, 
aber mit Hilfe von Skriptsprachen wie Python oder Perl nachgebildet werden kann.

In Bash selbst gibt es jedoch keine native Unterstützung für diese Art von Anweisungen (Try-Catch).
Eine Möglichkeit, diese Art der Fehlerbehandlung zu implementieren, 
ist die Verwendung einer Skriptsprache wie Python oder Perl in Verbindung mit Bash.

Ein einfaches Beispiel dafür ist das Abfragen einer Zahl vom Benutzer und das Versuchen, diese Zahl mit einer anderen zu dividieren.
Wenn es zu einem Fehler kommt, z.B. Division durch Null, wird eine Fehlermeldung ausgegeben:
>> z.B.
    echo "Geben Sie eine Zahl ein:"
    read number1
    echo "Geben Sie eine weitere Zahl ein:"
    read number2

    # Versuchen Sie, die erste Zahl durch die zweite Zahl zu teilen
    # Wenn es zu einem Fehler kommt, wird die Fehlermeldung ausgegeben
    result=$(python -c "try:
        print($number1 / $number2)
    except ZeroDivisionError:
        print(`Fehler: Division durch Null`)")
    echo "Ergebnis: $result"

In diesem Beispiel wird der Befehl "try" verwendet, um den Code auszuführen,
der möglicherweise einen Fehler verursacht. 
Der "except" Teil fängt dann den Fehler ab und gibt eine entsprechende Fehlermeldung aus.

Es ist wichtig zu beachten, dass dies nur ein einfaches Beispiel ist 
und in der Praxis in vielen Fällen komplexere Fehlerbehandlung erfordert.

Es ist auch möglich, Fehlermeldungen in eine Logdatei zu schreiben, 
um später darauf zugreifen zu können. Hierfür kann man den Befehl "tee" verwenden.

Insgesamt gibt es viele Möglichkeiten, 
Fehler in Bash zu behandeln und es ist wichtig, die Methode auszuwählen, 
die am besten zu Ihrem Skript und den Anforderungen passt.
'
menu[11,example]='
    echo "Geben Sie eine Zahl ein:"
    read number1
    echo "Geben Sie eine weitere Zahl ein:"
    read number2
    result=$(python -c "try:
        print($number1 / $number2)
    except ZeroDivisionError:
        print(`Fehler: Division durch Null`)")
    echo "Ergebnis: $result"
'

#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               SANDBOX
menu[69,desc]='
                           .______.                 
  ___________    ____    __| _/\_ |__   _______  ___
 /  ___/\__  \  /    \  / __ |  | __ \ /  _ \  \/  /
 \___ \  / __ \|   |  \/ /_/ |  | \_\ (  <_> >    < 
/____  >(____  /___|  /\____ |  |___  /\____/__/\_ \
     \/      \/     \/      \/      \/            \/

Die Sandbox Option dieses Skripts, führt ein paar Befehle aus,
welche euch ermöglichen eure code Ideen oder Tests direkt aus diesem
Skript heraus zu machen.

Ablauf:
    >> Warte auf Userinput für Texteditor-Auswahl
    >> Erstelle Textdatei "bash_sandbox.txt" im Ordner wo das aktuelle Skript ist
    >> Öffne die Textdatei und warte bis user die schliesst
    >> Überprüfe ob die Datei existiert / Inhalt hat
    >> Wenn ja: führe die Datei aus || Wenn nein: Fehlermeldung

Tipps:
        Es macht Sinn, Zuerst die "man" (manual/Anleitung) zu den Editoren zu lesen!
        Sonst seid ihr wie ich am Anfang gefangen in eurem Editor :P

    Um den Nano Editor MIT speichern zu verlassen, drücke zuerst
        -> CRTL + O
            (O wie OSCAR)
    Dannach
        -> CRTL + X

    Um den Nano Editor OHNE speichern zu verlassen:
        -> CRTL + X
        ->   Y

'
menu[69,example]='
echo "Welchen Editor möchten Sie verwenden: nano oder vim?"
read editor

# Erstelle eine neue Datei im aktuellen Pfad
touch sandbox.sh

# Öffne die Datei im gewählten Editor
if [ "$editor" == "nano" ]; then
  nano sandbox.sh
elif [ "$editor" == "vim" ]; then
  vim sandbox.sh
else
  echo "Ungültige Eingabe. Bitte wählen Sie nano oder vim."
  exit 1
fi

# Überprüfen Sie, ob die Datei Inhalt hat
if [ -s sandbox.sh ]; then
  # Ausführen des Inhalts als Bash-Code
  echo "
    AUSGEFÜHRTER CODE AUS DATEI:
    "
  source sandbox.sh
else
  echo "Die Datei ist leer. Keine Ausführung durchgeführt."
  exit 0
fi
'


#°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,..,ø¤º°`°º¤ø,.,ø¤°º¤ø,..,ø¤º°`°º¤ø,.
#               LEERE BEISPIELTEXTE MIT SONDER-ID
menu[100,desc]='
HIER BESCHREIBUNGSTEXT
'
menu[100,example]='
HIER BEISPIELCODE
'


#       ==                     .__              ==
#       ==        _____ _____  |__| ____        ==
#       ==       /     \\__  \ |  |/    \       ==
#       ==      |  Y Y  \/ __ \|  |   |  \      ==
#       ==      |__|_|  (____  /__|___|  /      ==
#       ==            \/     \/        \/       ==

#Main While Loop des Skripts, loope solange hier durch, bis der User 0 als Eingabe macht, oder mit CRTL+C das Skript verlässt
while true; do
#Lösche alte Ausgaben
    clear
    # Zeige Logo und Menu
    echo "${menu[0,welcome]}"
    echo "╔══════════════════════════════════════════╗"
    echo "╠  1. Variablen"
    echo "╠  2. Argumente nutzen"
    echo "╠  3. FOR loop Benutzung"
    echo "╠  4. WHILE loop Benutzung"
    echo "╠  5. IF statement Benutzung"
    echo "╠  6. Befehle für Konsole und Skript"
    echo "╠  7. Funktionen definieren"
    echo "╠  8. Arrays"
    echo "╠  9. Switch-Case Benutzung"
    echo "╠ 10. String-Bearbeitung"
    echo "╠ 11. Fehlerbehandlung"
    echo "╠  0. Exit"
    echo "╠══════════════════════════"
    echo "╠ 42 Info über Bash und Programme"
    echo "╠ 69 Coding-Sandbox"
    echo "╚══════════════════════════════════════════╝"
    read -p "Gebe die Menüzahl ein: " choice
    
    
    # Wenn Userinput == 0, dann exit
    if [[ $choice == 0 ]]; then
        exit

        elif [[ $choice == 1 ]]; then
        # VARIABLEN TEXTE AUSGEBEN
        echo "
                    .__      ___.   .__                 
___  _______ _______|__|____ \_ |__ |  |   ____   ____  
\  \/ /\__  \\_  __ \  \__  \ | __ \|  | _/ __ \ /    \ 
 \   /  / __ \|  | \/  |/ __ \| \_\ \  |_\  ___/|   |  \.
  \_/  (____  /__|  |__(____  /___  /____/\___  >___|  /
            \/              \/    \/          \/     \/ "


# Rufe den abgelegten Text unter dem oben definierten Arrayobjekt
#   ${menu[$choice,desc]}"
#   $choice = usereingabe
# Usereingabe ist hier also 1, dieser Wert muss aber nicht unbedingt $choice bleiben
        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        #BEISPIEL AUSFÜHREN, eval(uation) = ausführen
        eval "${menu[1,example]}"

#======================================================================

        elif [[ $choice == 2 ]]; then
        # Argumente nutzen
        echo "
                                                 __          
_____ _______  ____  __ __  _____   ____   _____/  |_  ____  
\__  \\_  __ \/ ___\|  |  \/     \_/ __ \ /    \   __\/ __ \ 
 / __ \|  | \/ /_/  >  |  /  Y Y  \  ___/|   |  \  | \  ___/ 
(____  /__|  \___  /|____/|__|_|  /\___  >___|  /__|  \___  >
     \/     /_____/             \/     \/     \/          \/ "

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 3 ]]; then
        # FOR LOOP
        echo "
  _____                      .__                        
_/ ____\___________          |  |   ____   ____ ______  
\   __\/  _ \_  __ \  ______ |  |  /  _ \ /  _ \.\____\ 
 |  | (  <_> )  | \/ /_____/ |  |_(  <_> |  <_> )  |_> >
 |__|  \____/|__|            |____/\____/ \____/|   __/ 
                                                |__|    "
                                                
                echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 4 ]]; then
        # FOR LOOP
        echo "
        .__    .__.__                   .__                        
__  _  _|  |__ |__|  |   ____           |  |   ____   ____ ______  
\ \/ \/ /  |  \|  |  | _/ __ \   ______ |  |  /  _ \ /  _ \\____ \ 
 \     /|   Y  \  |  |_\  ___/  /_____/ |  |_(  <_> |  <_> )  |_> >
  \/\_/ |___|  /__|____/\___  >         |____/\____/ \____/|   __/ 
             \/             \/                             |__|    "
                                                
                echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 5 ]]; then
        # IF Statement$
        echo "
.__  _____                   __          __                                __   
|__|/ ____\          _______/  |______ _/  |_  ____   _____   ____   _____/  |_ 
|  \   __\  ______  /  ___/\   __\__  \.\  __\/ __ \ /     \_/ __ \ /    \   __\.
|  ||  |   /_____/  \___ \  |  |  / __ \|  | \  ___/|  Y Y  \  ___/|   |  \  |  
|__||__|           /____  > |__| (____  /__|  \___  >__|_|  /\___  >___|  /__|  
                        \/            \/          \/      \/     \/     \/      "

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 6 ]]; then
        # Gängige Befehle
        echo "
___.           _____      .__    .__          
\_ |__   _____/ ____\____ |  |__ |  |   ____  
 | __ \_/ __ \   __\/ __ \|  |  \|  | _/ __ \ 
 | \_\ \  ___/|  | \  ___/|   Y  \  |_\  ___/ 
 |___  /\___  >__|  \___  >___|  /____/\___  >
     \/     \/          \/     \/          \/ "

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 7 ]]; then
        # Funktionen
        echo "
  _____             __      __  .__                             
_/ ____\_ __  ____ |  | ___/  |_|__| ____   ____   ____   ____  
\   __\  |  \/    \|  |/ /\   __\  |/  _ \ /    \_/ __ \ /    \ 
 |  | |  |  /   |  \    <  |  | |  (  <_> )   |  \  ___/|   |  \.
 |__| |____/|___|  /__|_ \ |__| |__|\____/|___|  /\___  >___|  /
                 \/     \/                     \/     \/     \/ "

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 8 ]]; then
        # Arrays
        echo "                        
_____ ___________________  ___.__. ______
\__  \\_  __ \_  __ \__  \<   |  |/  ___/
 / __ \|  | \/|  | \// __ \\___  |\___ \ 
(____  /__|   |__|  (____  / ____/____  >
     \/                  \/\/         \/ "

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 9 ]]; then
        # Arrays
        echo "                        
                .__  __         .__                                           
  ________  _  _|__|/  |_  ____ |  |__             ____ _____    ______ ____  
 /  ___/\ \/ \/ /  \   __\/ ___\|  |  \   ______ _/___\.\__  \  /  ___// __ \ 
 \___ \  \     /|  ||  | \  \___|   Y  \ /_____/ \  \___ / __ \_\___\.\  ___/ 
/____  >  \/\_/ |__||__|  \___  >___|  /          \___  >____  /____  >\___  >
     \/                       \/     \/               \/     \/     \/     \/ "

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 10 ]]; then
        # Arrays
        echo "
          __         .__                      
  _______/  |________|__| ____    ____  ______
 /  ___/\   __\_  __ \  |/    \  / ___\/  ___/
 \___ \  |  |  |  | \/  |   |  \/ /_/  >___ \ 
/____  > |__|  |__|  |__|___|  /\___  /____  >
     \/                      \//_____/     \/ "

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 11 ]]; then
        # Arrays
        echo "                                         
  __________________  ___________  ______
_/ __ \_  __ \_  __ \/  _ \_  __ \/  ___/
\  ___/|  | \/|  | \(  <_> )  | \/\___ \ 
 \___  >__|   |__|   \____/|__|  /____  >
     \/                               \/ "

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 42 ]]; then
        # Funktionen
        echo "
.__        _____       
|__| _____/ ____\____  
|  |/    \   __\/  _ \ 
|  |   |  \  | (  <_> )
|__|___|  /__|  \____/ 
        \/             "

        echo "
════════> BESCHREIBUNG <════════:
${menu[0,info]}"

#======================================================================

        elif [[ $choice == 69 ]]; then
        # Arrays
        echo "                        
OPTIONS-LOGO"

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

        elif [[ $choice == 100 ]]; then
        # LEERES BEISPIELSLAYOUT
        echo "                        
OPTIONS-LOGO"

        echo "
════════> BESCHREIBUNG <════════:
${menu[$choice,desc]}"
        echo "
════════> BEISPIEL <════════:
${menu[$choice,example]}

════════> RESULTAT BEISPIEL <════════:
"
        eval "${menu[$choice,example]}"

#======================================================================

    else
        # Invalid input
        echo "
    UNGÜLTIGE AUSWAHL, BITTE ÜBERPRÜFE DEINE EINGABE UND VERSUCHE ES ERNEUT."
    fi

    #EINGABE DAMIT USER ZEIT HAT UM FEHLER ETC ZU LESEN
    read -p "
    ! DRÜCKE ENTER UM FORTZUFAHREN ! " cont
done