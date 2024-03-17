import vertexai
from vertexai.language_models import ChatModel
from google.cloud import texttospeech
from google.cloud import speech
from dotenv import load_dotenv,dotenv_values
from google.oauth2 import service_account
import requests
import playsound
import base64

class TextToSpeech:
    def __init__(self) -> None:
        self.__init_config()  # Call the config initialization method

    def __init_config(self):
        load_dotenv()
        self.__config = dotenv_values(".env")
        self.__project_id = self.__config['PROJECT_ID']
        # Move token assignment here:
        self.__google_auth_token = self.__config['GOOGLE_AUTH_TOKEN']
        self.__location = self.__config['LOCATION']
        self.__gcloud_credentials_path = self.__config['CREDENTIALS_FILE']
        self.__gcloud_credentials = service_account.Credentials.from_service_account_file(filename=self.__gcloud_credentials_path)

        
    def synthesize(self, input_text:str, output_file:str):
        headers={
            "Authorization" : f"Bearer {self.__google_auth_token}",
            "x-goog-user-project" : self.__project_id,
            "Content-Type" : "application/json; charset=utf-8"
        }
        
        data = {
       "input": {"text": input_text},
       "voice": {
           "languageCode": "ro-RO",  # Change to "ro-RO" for Romanian
        "name": "ro-RO-Standard-A",  # Optional: Romanian voice name (optional)
        "ssmlGender": "FEMALE",  # Optional: Voice gender (optional)
       },
       "audioConfig": {"audioEncoding": "MP3"},
   }

        response = requests.post(
            url="https://texttospeech.googleapis.com/v1/text:synthesize",
            headers=headers,
            json=data,
        )

        response.raise_for_status()  # Raise an exception for non-200 status codes

        audio_data = base64.b64decode(response.content)

            # Write decoded data to MP3 file
        with open(output_file, "wb") as f:
                f.write(audio_data)
        
        print(f"Audio content written to file {output_file}")
        self.__last_output_file = f'/home/flexksx/GitHub/Moldcell_Hackathon/{output_file}'

        