import argparse
from google.cloud import speech

class STT:
    def __init__(self):
        pass

    def transcribe_file(self,speech_file: str):
        """Transcribe audio file to text

        Args:
            - speech_file (str): Path to speech file

        Returns:
            str: Transcription
        """        

        """Transcribe the given audio file."""
        client = speech.SpeechClient()

        with open(speech_file, "rb") as audio_file:
            content = audio_file.read()

        audio = speech.RecognitionAudio(content=content)
        config = speech.RecognitionConfig(
            encoding=speech.RecognitionConfig.AudioEncoding.MP3,
            sample_rate_hertz=16000,
            language_code="ro-RO",
        )

        response = client.recognize(config=config, audio=audio)
        for result in response.results:
            answer = result.alternatives[0].transcript

        return answer

