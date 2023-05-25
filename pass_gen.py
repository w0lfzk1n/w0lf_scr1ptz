from cmath import isnan
import random
#   V0.1
#   Usage: python Pass_Gen.py
#LOGO
logo = "\n██████   █████  ███████ ███████ ██     ██  ██████  ██████  ██████            \n██   ██ ██   ██ ██      ██      ██     ██ ██    ██ ██   ██ ██   ██           \n██████  ███████ ███████ ███████ ██  █  ██ ██    ██ ██████  ██   ██           \n██      ██   ██      ██      ██ ██ ███ ██ ██    ██ ██   ██ ██   ██           \n██      ██   ██ ███████ ███████  ███ ███   ██████  ██   ██ ██████            \n                                                                             \n                                                                             \n ██████  ███████ ███    ██ ███████ ██████   █████  ████████  ██████  ██████  \n██       ██      ████   ██ ██      ██   ██ ██   ██    ██    ██    ██ ██   ██ \n██   ███ █████   ██ ██  ██ █████   ██████  ███████    ██    ██    ██ ██████  \n██    ██ ██      ██  ██ ██ ██      ██   ██ ██   ██    ██    ██    ██ ██   ██ \n ██████  ███████ ██   ████ ███████ ██   ██ ██   ██    ██     ██████  ██   ██ \n                                                                             \n\n██████  ██    ██                                                         \n██   ██  ██  ██                                                          \n██████    ████                                                           \n██   ██    ██                                                            \n██████     ██                                                            \n                                                                         \n██     ██  ██████  ██      ███████ ███████ ██   ██  ██ ███    ██ ██████  \n██     ██ ██  ████ ██      ██         ███  ██  ██  ███ ████   ██ ██   ██ \n██  █  ██ ██ ██ ██ ██      █████     ███   █████    ██ ██ ██  ██ ██   ██ \n██ ███ ██ ████  ██ ██      ██       ███    ██  ██   ██ ██  ██ ██ ██   ██ \n ███ ███   ██████  ███████ ██      ███████ ██   ██  ██ ██   ████ ██████  \n                                                                         "
print(logo,"\n\n")
#Check if Char is already present in Raw Char list for password
def check(lists,raw,char):
    boo = True #boolean is true
    while boo: #while boo is true
        if char in raw: #if char is in chosen ones
            char = random.choice(lists) #choose and check again
        else: #if not, set boo to false to stop while loop and return char
            boo = False
            return char
#Password length Quote
def pwlen():
    boo2 = True
    while boo2:
        print("\nHow long should the password be?")
        pass_len = input("= ")
        if isnan(int(pass_len)) == True:
            print("\n!! Go again, i need a number !!\n")
        elif isnan(int(pass_len)) == False:
            return int(pass_len)
#Characters to use in Password
all_caps = ["A","B","C","D","E","F","G","H", "I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
all_low = ["a","b","c","d", "e", "f", "g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","x","y","z"]
all_num = ["1","2","3","4","5","6","7","8","9","0"]
extra = ["!","?","@","#","/","+","$",".","*","%","(",")","=","<",">","^","°","§","-","_","&",":",";","[","]","{","}","~"]
chars = [all_caps, all_low, all_num, extra]
passw_raw = []
#Get Password Length of User
boo3 = True
while boo3:
    paslen = int(pwlen())
    if paslen < 8:
        print("!! This Password is not secure, make it longer !!")
    elif paslen > 30:
        print("!! I know a long thing, but thats too long !!")
    else:
        boo3 = False
#For each list, take 3 random chars and check if this char is taken already
i = 0
for list in chars:
    while i < round(paslen/4)+1:
        app = check(list,passw_raw,random.choice(list))
        passw_raw.append(app) #push char to the raw array
        i += 1
    i = 0
#Print the chosen raw chars && Password length && RAW Chars Len
print("RAW_CHARS=" ,passw_raw)
print("RAW_C_LEN=" ,len(passw_raw))
password = ""
#Take random char from chosen ones, add to string and remove from array
while i < paslen:
    #print(passw_raw, " | ", password)
    char = random.choice(passw_raw)
    passw_raw.remove(char)
    password += char
    i += 1
#Show Generated Password
print("\n############ GEN°1 Password",password,"\n############ Shuffle Start")
#Shuffle Password 7x
buff1 = []
for x in password:
    buff1.append(x)
i = 0
desi = "############"
while i < round(paslen/3):
    random.shuffle(buff1)
    buff2 = ""
    for x in buff1:
        buff2 += x
    print("\n",desi," Shuffle N°",i+1,"\n         ",buff2)
    i+=1
    desi += "#######"
#Print final Password
print("\n██████   █████  ███████ ███████    \n██   ██ ██   ██ ██      ██      ██ \n██████  ███████ ███████ ███████    \n██      ██   ██      ██      ██ ██ \n██      ██   ██ ███████ ███████    \n                                   \n \n█████ ",buff2," █████\n ")