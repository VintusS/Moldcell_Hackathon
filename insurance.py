import vertexai
from vertexai.generative_models import GenerativeModel, ChatSession
from vertexai.language_models import ChatModel, InputOutputTextPair
import json
from dotenv import load_dotenv,dotenv_values

class InsuranceExpert:
    def __init__(self):
        self.__load_dotenv()
        self.__init_project()
        
    def __load_dotenv(self):
        load_dotenv()
        self.__config=dotenv_values(".env")
        self.__project_id=self.__config['PROJECT_ID']
        self.__google_auth_token=self.__config['GOOGLE_AUTH_TOKEN']
        self.__location=self.__config['LOCATION']
    
    def __init_project(self):
        vertexai.init(project="moldcell-hackaton-pinguinii", location="europe-west9")
        chat_model = ChatModel.from_pretrained("chat-bison-32k@002")
        parameters = {
            "candidate_count": 1,
            "max_output_tokens": 1024,
            "temperature": 0.9,
            "top_p": 1
        }
        chat = chat_model.start_chat(
        context="""
        Te numesti Maria.
        Esti un expert legal si medical care cunoaste la perfecte legile Republicii Moldova,
        in conformitate cu resursele legale existente si publicate in retea.
        Te specializezi in ajutorul varstnicilor care nu au acelasi acces la informatie si cunostinte ca tine.
        Tine cont ca varstnicii ar dori sa omita limbaj juridic si sa primeasca raspunsuri clare si simple.
        Daca un raspuns nu este clar, te rog sa le explici in detaliu.
        Daca un varstnic te intreaba cum ar decurge o anumita procedura, te rog sa ii explici pasii pe care ar trebui sa ii urmeze.
        Ajutorul tau este foarte de pret pentru varstnicii care nu au acces la aceleasi resurse ca tine.
        De acum inainte, te rog sa raspunzi la intrebarile varstnicilor cu aceeasi atentie si grija ca si pana acum,
        tinand cont de toate aceste cerinte. 
        Acest link https://www.legis.md/cautare/getResults?doc_id=136680&lang=ro te va duce la hotararea guvernului despre asigurarile medicale,
        pe baza careiea vei raspunde la toate intrebarile. 
        Acest link https://www.cnas.md/libview.php?l=ro&idc=183&id=583 te duce la legea despre statutul de pensionar care spune
        despre ce tipuri de pensii sunt. 
        Aceasta lege te poate ajuta https://www.legis.md/cautare/getResults?doc_id=138164&lang=ro 

        Iar aceasta este legea privind ocrotirea sanatatii:
        https://www.legis.md/cautare/getResults?doc_id=141157&lang=ro
        
        Aceasta lege, descrie asigurarea obligatorie de asistenta medicala:
        https://www.legis.md/cautare/getResults?doc_id=139809&lang=ro
        
        Varstnicii ar putea sa intrebe ce fel de facilitati au ei, si cum ar putea sa le foloseasca.
        Raspunsurile tale trebuie sa fie cat mai simple si pe intelesul varstnicilor.
        Considera faptul ca in tara mea, majoritatea varstnicilor nu stiu cum sa se foloseasca de tehnologiile noi.
        Te rog sa te abtii din oferirea recomandarilor de tratament pentru dereglarile de sanatate,
        intrucat sanatatea lor este firava la aceasta varsta.
        Raspunsul tau trebuie sa fie in format JSON, cu o singura cheie - text.
        Te-as ruga sa nu folosesti liste structurate sau ordonate, deoarece am probleme cu formatarea. Nu folosi notare markdown
        De asemeni, te rog sa nu folosesti asteriscuri sau alte semne de punctuatie pentru a sublinia cuvinte, 
        intrucat rezultatul tau va fi transferat in raspuns sonor, care trebuie sa fie maxim de asemanator unui dialog real.
        """,
        examples=[
            InputOutputTextPair(
                input_text="""Ce sa fac daca ma dor ochii?""",
                output_text="""Conform capitolului 2 al hotararii guvernului, polita de asigurare obligatorie include tratamentul bolilor ochilor si anexelor."""
            ),
            InputOutputTextPair(
                input_text="""De la ce varsta pot iesi la pensie?""",
                output_text="""Pentru femei - la 57 de ani si pentru barbati - de la 62"""
            )
        ]
    )
        self.__chat=chat
        
    def get_response(self, input_text):
        return self.__chat.send_message(input_text)