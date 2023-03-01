import re

# Zadanie 1. Znajdź wszystkie pozycje w tekście, gdzie znajdują się cyfry
tekst = "Dzisiaj mamy 10 dzień miesiąca 03 roku 2011"

digits = "[0-9]"

#num = re.findall(digits, tekst) 
#print(num)
#print(re.search(digits,tekst))

re.search(digits, tekst).span()
wynik = re.finditer(digits, tekst)

for element in wynik:
    element.span()[0]
