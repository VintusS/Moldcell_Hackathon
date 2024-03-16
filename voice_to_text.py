import argparse
from google.cloud import speech

def transcribe_file(speech_file: str) -> speech.RecognizeResponse:
    """Transcribe the given audio file."""
    client = speech.SpeechClient()

    with open(speech_file, "rb") as audio_file:
        content = audio_file.read()

    audio = speech.RecognitionAudio(content=content)
    config = speech.RecognitionConfig(
        encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
        sample_rate_hertz=16000,
        language_code="ro-RO",
    )

    response = client.recognize(config=config, audio=audio)

    for result in response.results:
 
        print(f"Transcript: {result.alternatives[0].transcript}")

    return response

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Transcribe audio file.")
    parser.add_argument("output",type=str,help="Path to the file for transcription")

    args=parser.parse_args()
    print(transcribe_file(args.output))