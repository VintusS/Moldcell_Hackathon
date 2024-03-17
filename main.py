from conversation import Conversator
conv = Conversator()


# conv.get_response_from_audio_file("test.mp3")

input_text=input("Dialog: ")
while input_text!="gata":
    print(conv.get_response(input_text))
    conv.get_audio_response(input_text, 'output.mp3')
    input_text=input("Dialog: ")

# print(conv.get_response("Ce noutati sunt azi?"))
