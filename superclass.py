from TTS import TTS
from STT import STT



class superclass:
    def __init__(self, _tts:TTS,_stt:STT) -> None:
        if type(_stt) is not STT:
            raise AssertionError("PLease give me a TTS class")
        else:
            self.stt=_stt
        