import zipfile

to_unzip = "merde.zip"

try:
    with zipfile.ZipFile(to_unzip) as f:
        f.extractall("merde")
except:
    print("suuuuu")