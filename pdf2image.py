import os
path='/Volumes/Data/Dropbox/Scans/'
files=os.listdir(path)
filespath=[]


for x in files:
    temp=x
    if temp[-4:]=='.pdf':
        filespath.append(path+temp[:-4])



text_file = open("/Volumes/Data/Dropbox/Scans/Output.txt", "w")
text_file.write(filespath[0])
text_file.close()

from pdf2image import convert_from_path

from PIL import Image
import pytesseract

print(filespath)

for x in filespath:

    pages = convert_from_path(x+'.pdf', 500)

    for page in pages:
        page.save(x+'.jpg', 'JPEG')
        textout = pytesseract.image_to_string(Image.open(x+'.jpg'),lang='deu')
        text_file = open(x+'.txt', "w")
        text_file.write(textout)
        text_file.close()
