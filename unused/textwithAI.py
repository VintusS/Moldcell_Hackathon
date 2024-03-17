import vertexai
from vertexai.language_models import ChatModel
from google.cloud import texttospeech
from google.cloud import speech
import os
import argparse

vertexai.init(project="moldcell-hackaton-pinguinii", location="us-central1")
chat_model = ChatModel.from_pretrained("chat-bison")

def synthesize_text(text):
    """Synthesizes speech from the input string of text."""
    client = texttospeech.TextToSpeechClient()

    input_text = texttospeech.SynthesisInput(text=text)

    voice = texttospeech.VoiceSelectionParams(
        language_code="ro-RO",
        name="ro-RO-Standard-A",
        ssml_gender=texttospeech.SsmlVoiceGender.FEMALE,
)


    audio_config = texttospeech.AudioConfig(
        audio_encoding=texttospeech.AudioEncoding.MP3
    )

    response = client.synthesize_speech(
        request={"input": input_text, "voice": voice, "audio_config": audio_config}
    )


    with open("output.mp3", "wb") as out:
        out.write(response.audio_content)
        print('Audio content written to file "output.mp3"')




chat = chat_model.start_chat(
    context="""You are an assistant that is specialized in elder people healthcare. You do speak Romanian only. Write answer shortly""",
)

response = chat.send_message("Cine este Murafa?")

text_to_convert = response.text
text_to_convert="nu Rafa este un medicament antiinflamator nesteroidian insp utilizat pentru a trata durerea inflamația și febra este disponibil sub formă de tablete capsule sirop și injecții nu rasa este utilizat pentru a trata o varietate de afecțiuni inclusiv artrita durerea de spate durerile musculare durerile de cap durerile dentare și febră"
synthesize_text(text_to_convert)




