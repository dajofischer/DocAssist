import os
path='/Volumes/Data/Dropbox/Scans/'
files=os.listdir(path)
filespath=[]

for x in files:
    temp=x
    if temp[-4:]=='.pdf':
        filespath.append(path+temp[:-4])



#filespath=filespath[3:4]

print(len(filespath))

text_file = open("/Volumes/Data/Dropbox/Scans/Output.txt", "w")
text_file.close()
text_file = open("/Volumes/Data/Dropbox/Scans/Output.txt", "a")
from pdf2image import convert_from_path

from PIL import Image
import pytesseract

print(filespath)

for x in filespath:

    pages = convert_from_path(x+'.pdf', 500)

    pagelength = len(pages)
    actualpage=1
    text_file.write('$%@ begin filename: '+x)
    text_file.write('\n')
    text_file.write('\n')
    for page in pages:
        text_file.write('$%@ begin page:'+str(actualpage)+'/'+str(pagelength))
        actualpage=actualpage+1
        text_file.write('\n')
        page.save(x+'.jpg', 'JPEG')
        textout = pytesseract.image_to_string(Image.open(x+'.jpg'),lang='deu')
        #text_file = open(x+'.txt', "w")
        #text_file.write(textout)
        #text_file.close()
        text_file.write(textout)
        text_file.write('\n')
        text_file.write('\n')
    os.remove(x+'.jpg')

text_file.close()
