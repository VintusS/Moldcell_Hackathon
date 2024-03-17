from TTS import TextToSpeech
from insurance import InsuranceExpert
from STT import SpeechToText
import json 
class Conversator:
    def __init__(self):
        self.__tts = TextToSpeech()
        self.__ie = InsuranceExpert()
        self.__stt = SpeechToText()
        
    def get_response(self, input_text:str):
        response = self.__ie.get_response(input_text)
        response = json.loads(response.text)
        return response['text']
    
    def get_audio_response(self, input_text:str, output_file:str):
        response = self.get_response(input_text)
        self.__tts.synthesize(response, output_file)
        
    def get_response_from_audio_file(self, speech_file:str):
        text = self.__stt.transcribe_file(speech_file)
        print(text)
        self.get_audio_response(text, "output.mp3")
        
    