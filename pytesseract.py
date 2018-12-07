try:
    from PIL import Image
except ImportError:
    import Image
import pytesseract


print(pytesseract.image_to_string(Image.open('/Users/David/Downloads/test.png'),lang='deu2'))
