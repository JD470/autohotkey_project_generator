import zipfile

to_unzip = ""
name = ""
with open("to_unzip.txt", "r") as f:
    a = f.read().split()
    print(a[0])
    to_unzip = a[0]
    name = a[1]

try:
    with zipfile.ZipFile(to_unzip) as f:
        f.extractall(name)
except:
    print("Unziping didn't work!")