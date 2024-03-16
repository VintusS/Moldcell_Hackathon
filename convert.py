from gtts import gTTS
import os 
from scrapp import text

mytext=text
language = 'ro'

obj =gTTS(text=mytext, lang=language , slow=False)

obj.save("Try1.caf")