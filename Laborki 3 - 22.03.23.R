---
title: "Stemming tekstu"
author: "Bogna Zacny"
date: "lato 2022/2023"
output: 
  html_document: 
    highlight: tango
    theme: cerulean
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE, warning=FALSE, message = FALSE)
library("stringr")
library("stringi")
library("SnowballC")
library("wordcloud")
```

### Przygotowanie środowiska

Przydatne pakiety

```
install.packages(c("stringr", "stringi", "SnowballC", "wordcloud"))
library("stringr")
library("stringi")
library("SnowballC")
library("wordcloud")
```

### Przygotowanie tekstu


```{r}
tekst <- c("@ayyytylerb 4+8=12<24>35 that is 3/6 7^5 ~so true drink lots of coffee|tea",
"RT @bryzy_brib: Senior March tmw morning at 7:25 A.M. in the SENIOR lot. Get up early, make yo coffee/breakfast, cus this will only happen ?",
"If you believe in #gunsense tomorrow would be a very good day to have your coffee any place BUT @Starbucks Guns+Coffee=#nosense @MomsDemand",
"My cute coffee mug - 5.8$. http://t.co/2udvMU6XIG",
"RT @slaredo21: I wish we had Starbucks here... Cause coffee dates in the morning sound perff!",
"Does anyone ever get a cup of coffee before a cocktail??",
"I like my coffee like I like my women...black, bitter, and preferably fair trade. I love #Archer",
"@dreamwwediva ya didn't have coffee did ya?",
"RT @iDougherty42: I just want\r\n some coffee.",
"RT @Dorkv76: I can't care before coffee.",
"No lie I wouldn't mind coming home smelling like coffee",
"RT @JonasWorldFeed: Play Ping Pong with Joe. Take a tour of the stage with Nick. Have coffee with Kevin. Charity auction: https://t.co/VTkK?",
"Have I ever told any of you that Tate Donovan bought my stepmom coffee?",
"RT @JonasWorldFeed: Play Ping Pong with Joe. Take a tour of the stage with Nick. Have coffee with Kevin. Charity auction: https://t.co/VTkK?",
"@HeatherWhaley I was about 2 joke it takes 2 hands to hold hot coffee...then I read headline! #Don'tDrinkNShoot",
"RT @MoveTheSticks: Charlie Whitehurst looks like he should be working \nat a coffee shop in Portland or hosting a renovation show on HGTV.",
"Coffee always makes everything better.",
"RT @AdelaideReview: Food For Thought: @Annabelleats shares a delicious Venison and Porcini Mushroom Pie Recipe. http://t.co/N8O7vqFKWN http?",
"RT @LittleMelss: lmfao!!!@bryanlaca: nahhh Melanie u is fa sho like an ummm a Coffee table ;) ) yeeeee lmaoo",
"I wonder if Christian Colon will get a cup of coffee once the rosters\r expand to 40 man in September. Really nothing to lose by doing so.")

# length(tekst)
```

#### 1. Normalizacja tekstu

Oczyszczenie tekstów tweetów na temat kawy z: znaków przełamania linii, linków, nazw użytkowników, hasztagów, znaku &, „RT”, a także liczb (cyfr) i znaków przestankowych.

```{r}
# stri_enc_isutf8(tekst)
# tekst_enc <- stringi::stri_encode(tekst, to = "UTF-8")

czysc_tekst <- function(tekst){
  require(stringr)
  
  tekst_tenmp <- str_replace_all(tekst, "\\s{2,}", " ") %>% 
    str_replace_all("[:cntrl:]", " ") %>% #"(\r\n|\r|\n)"
    tolower() %>% 
    str_remove_all("rt") %>% 
    str_remove_all("&amp") %>% 
    str_remove_all("#[a-zA-Z0-9']*") %>% 
    str_remove_all("@\\w+") %>% 
    str_remove_all("(f|ht)(tp)([^ ]*)") %>% 
    str_remove_all("http(s?)([^ ]*)") %>% 
    str_replace_all("[[:punct:]]", " ") %>% # "[!\"#%&'()*,-./:;?@[\]^_`{|}~]"
    str_replace_all("[\\$\\+\\<\\=\\>\\^\\~\\|]", " ") %>% 
    str_remove_all("\\d") %>%
    str_replace_all("\\s{2,}", " ") %>% 
    str_trim()
}
czysty <- czysc_tekst(tekst)

czysty
```

```{r}
# które znaki w klasie [:punct:]?

znaki <- " [ ! \" # $ % & ' ( ) * + , - . / : ; < = > ? @ [ \ ] ^ _ ` { | } ~ ]"

str_extract_all(znaki, "[^[:punct:]]")
```

Usunięcie duplikatów

```{r}
czysty <- czysty[!duplicated(czysty)]
```


#### 2. Tokenizacja - cięcie tekstu

Z oczyszczonych tekstów - wodrębnienie tokenów.

```{r}
tokeny <- str_split(czysty, " ")
```

#### 3. Stop lista

Ze zbioru tokenów usunięcie nieistotnych słów ([stopwords](https://www.textfixer.com/tutorials/common-english-words.txt))

```{r}
sciezka <- "https://www.textfixer.com/tutorials/common-english-words.txt"

stopwords <- scan(sciezka, character(), sep = ',')

# stri_enc_isutf8(stopwords)
# stopwords <- stringi::stri_encode(stopwords, to = "UTF-8")
# is.vector(stopwords)
```


```{r}
stopwords <- c(stopwords, "ya", "yeeeee", "yo", "ummm", "m", "t")

stopwords <-  c("a", "able", "about", "across", "after", "all", "almost", "also", "am", "among", "an", "and", "any", "are", "as", "at", "be", "because", "been", "but", "by", "can", "cannot", "could", "dear", "did", "do", "does", "either", "else", "ever", "every", "for", "from", "get", "got", "had", "has", "have", "he", "her", "hers", "him", "his", "how", "however", "i", "if", "in", "into", "is", "it", "its", "just", "least", "let", "like", "likely", "may", "me", "might", "most", "must", "my", "neither", "no", "nor", "not", "of", "off", "often", "on", "only", "or", "other", "our", "own", "rather", "said", "say", "says", "she", "should", "since", "so", "some", "than", "that", "the", "their", "them", "then", "there", "these", "they", "this", "tis", "to", "too", "twas", "us", "wants", "was", "we", "were", "what", "when", "where", "which", "while", "who", "whom", "why", "will", "with", "would", "yet", "you", "your", "ya")

# stri_enc_isascii(stopwords)
# stopwords <- stringi::stri_encode(stopwords, to = "UTF-8")
```


```{r}

wek <- tokeny[[1]]
wek[!wek %in% stopwords]

termy <- lapply(tokeny, function(x) x[!x %in% stopwords])
```

#### 4. Stemming

Wyodrębnienie rdzeni. Zastosowanie algorytmu Portera: [snowball](https://snowballstem.org/)


```{r}
library("SnowballC")

(wek <- termy[[16]])
wordStem(wek)

termy_stem <- lapply(termy, function(x) wordStem(x, language = "porter"))
termy_stem <- lapply(termy, function(x) wordStem(x, language = "english"))
```


#### 5. Zliczenie wystąpień 

Przygotowanie *bag-of-words*

```{r}
termy <- unlist(termy_stem)
unikaty <- unique(termy)

bow <- sapply(unikaty, function(x) sum(termy == x[1]))
```

#### 6. Wizualizacja

Wykres kolumnowy

```{r}
bow_sort <- sort(bow, decreasing = TRUE)
barplot(bow_sort[1:10])
```

Chmura słów

```{r}
library("wordcloud")

wordcloud(names(bow_sort), bow_sort)
```


### Mini-projekt I - **Chmura słów**

Przygotuj chmurę słów (lub wykres kolumnowy dla 50 najczęściej używanych słów) w oparciu o *bag-of-words*. Dla pozyskanych przez Ciebie dokumentów (w języku angielskim). Korpus ma odzwierciedlać pewną dychotomię - konflikt, dyskusję dwóch stron pewnego zjawiska np: zmian klimatycznych, lockdownu, ulubionego sportu (rugby vs. piłka nożna). Mogą to być: teksty tweetów na wybrane tematy (min 1000 tweetów dla każdej strony); dwóch grup artykułów (po 3-5 dla każdej strony, każdy ponad 2000 wyrazów); wypowiedzi dwóch ekspertów czy polityków (po 3-5 dla każdej strony, każdy ponad 2000 wyrazów).

Analizę wykonaj w dwóch wersjach:

a) dwa teksty traktowane są osobno - jako dwa osobne korpusy, przygotuj dwie wizualizacje dla każdej strony osobno.
b) dwa teksty traktowane są jako jeden i wykonaj wizualizację prezentującą:
    - termów charakterystycznych dla każdej ze stron (termy pojawiające się w wypowiedziach jednej strony ale nie pojawiające się w wypowiedziach drugiej strony),
    - termów wspólnych dla dwóch stron (termy pojawiające się w wypowiedziach jednej i drugiej strony jednocześnie).

install.packages("languageserver")
