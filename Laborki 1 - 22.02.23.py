import re

# Zadanie 1. Znajdź wszystkie pozycje w tekście, gdzie znajdują się cyfry
tekst = "Dzisiaj mamy 10 dzień miesiąca 03 roku 2011"

#print(re.search('1', tekst))

"""
print("Original String : " + tekst) 
num = ""
for c in tekst:
    if c.isdigit():
        num = num + c
print("Extracted numbers from the list : " + num) 
"""

num = re.findall(r'\d', tekst) 
print(num)