from google.cloud import speech_v1 as speech

def transcribe_streaming(stream_file: str) -> speech.RecognitionConfig:
    """Streams transcription of the given audio file."""

    client = speech.SpeechClient()

    with open(stream_file, "rb") as audio_file:
        content = audio_file.read()

  
    stream = [content]

    requests = (
        speech.StreamingRecognizeRequest(audio_content=chunk) for chunk in stream
    )

    config = speech.RecognitionConfig(
        encoding=speech.RecognitionConfig.AudioEncoding.LINEAR16,
        sample_rate_hertz=16000,
        language_code="en-US",
    )

    streaming_config = speech.StreamingRecognitionConfig(config=config)

    responses = client.streaming_recognize(
        config=streaming_config,
        requests=requests,
    )

    for response in responses:

        for result in response.results:
            print(f"Finished: {result.is_final}")
            print(f"Stability: {result.stability}")
            alternatives = result.alternatives

            for alternative in alternatives:
                print(f"Confidence: {alternative.confidence}")
                print(f"Transcript: {alternative.transcript}")


transcribe_streaming("output.mp3")
