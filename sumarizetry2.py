from pathlib import Path
from openai import OpenAI
client = OpenAI(api_key="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")

speech_file_path = Path(__file__).parent / "speech.mp3"
response = client.audio.speech.create(
  model="tts-1",
  voice="alloy",
  input="Today is a wonderful day to build something people love!"
)

response.stream_to_file(speech_file_path)

response.stream_to_file("output.mp3")

