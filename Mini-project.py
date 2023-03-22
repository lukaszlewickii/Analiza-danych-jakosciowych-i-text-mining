#### Zadanie 2.

import re

sent1 = "ala ma kota i bardzo rzadko spaceruje kot szaleje wieczorem"
sent2 = "ala ma psa i bardzo często spaceruje wieczorem"

term1 = re.split(" ", sent1)
term2 = re.split(" ", sent2)

set(term1) | set(term2)
set(term1) & set(term2)
set(term1) - set(term2)
set(term2) - set(term1)