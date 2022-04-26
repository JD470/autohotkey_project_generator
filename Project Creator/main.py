import zipfile

to_unzip = "template.zip"

try:
    with zipfile.ZipFile(to_unzip) as f:
        f.extractall("template")
except:
    print("The file didn't unzip")
