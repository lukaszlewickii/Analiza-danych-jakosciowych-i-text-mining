### Mini-project 1 ###

"""
Projekt przesyłamy bez kodów - przygotowujemy tylko 5 obrazków (chmury słów) w zip + opis danych/komentarz w readme.
Ocena:
- czy dobrze wyczyszczono dane, czy nie pojawiają się żadne stopword #, emotki itd.,
- czy dokonano stemmingu (nie trzeba ale dobrze zrobić, konieczne jest gdy występuje dużo słów typu drink + drinks itd.),
- czy na pewno wszystkie słowa na chmurze są potrzebne (tak jak pojawiło się u nas jedno dominujące coffee).    
"""
import re

sent1 = "ala ma kota i bardzo rzadko spaceruje kot szaleje wieczorem"
sent2 = "ala ma psa i bardzo często spaceruje wieczorem"

term1 = re.split(" ", sent1)
term2 = re.split(" ", sent2)

set(term1) | set(term2)
set(term1) & set(term2)
set(term1) - set(term2)
set(term2) - set(term1)