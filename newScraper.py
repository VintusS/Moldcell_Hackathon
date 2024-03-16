import requests, json
from bs4 import BeautifulSoup

newsData = 'C:\\Users\\liviu\\ELSD\\Hackathon Starpiori\\new.json'
StiriMD = "https://stiri.md/"

def find_articles(link):
    hrefs = []
    r = requests.get(link)
    soup = BeautifulSoup(r.text, 'html.parser')
    anchor_tags = soup.find_all("a")
    for tag in anchor_tags:
        href = tag.get("href")
        if "/article" in href:
            href_link = "https://stiri.md/" + href
            hrefs.append(href_link)

    return hrefs

def news(hrefs, file):
    all_output_data = []
    for href in hrefs:
        p_text = []
        r = requests.get(href)
        soup = BeautifulSoup(r.text, 'html.parser')
        title = soup.title.text
        image = soup.find('img', alt = title)['src']
        p_tags = soup.find_all("p")

        for tag in p_tags:
            text = tag.get_text()
            text = text.replace('„', '')
            p_text.append(text)

        description = p_text[0]

        output_data = {
            "Article": href,
            "Image": image,
            "Title": title,
            "Description": description
        }

        all_output_data.append(output_data)

    with open(file, 'w', encoding='utf-8') as file:
        json.dump(all_output_data, file, indent=4, ensure_ascii=False)

hrefs = find_articles(StiriMD)
news(hrefs, newsData)