PRINT '+-------------------------------------------------------------+'
PRINT '|W1: nazwisko i imię klienta, datę wypożyczenia i datę zwrotu |'
PRINT '|kasety oraz tytuł filmu. Wynik prezentacji widoku ustawić    |'
PRINT '|rosnąco według nazwiska, imienia i daty wypożyczenia.        |'
PRINT '+-------------------------------------------------------------+'

SELECT *
    FROM lista_wypozyczen
    ORDER BY nazwisko, imie, data_wypozyczenia
GO 

PRINT '+-------------------------------------------------------------+'
PRINT '|W2: Identyfikator Kasety, Tytuł filmu na tej kasecie i ilość |'
PRINT '|wypożyczeń tej kasety, Wynik prezentacji widoku ustawić      |'
PRINT '|malejąco według identyfikatora kasety                        |'
PRINT '+-------------------------------------------------------------+'

SELECT *
    FROM kasety_wypozyczenia
    ORDER BY id DESC
GO 

PRINT '+----------------------------------+'
PRINT '|Klienci ktorzy nic nie wypozyczyli|'
PRINT '+----------------------------------+'

SELECT *
    FROM klienci_duchy
GO 

PRINT '+----------------------------------------------------------+'
PRINT '|Klienci ktorzy wyporzyczyli cos wczesniej niz miesiac temu|'
PRINT '+----------------------------------------------------------+'

SELECT *
    FROM klienci_nieaktywni
GO 

PRINT '+---------------------------------+'
PRINT '|Filmy ktorych nikt nie wypozyczyl|'
PRINT '+---------------------------------+'

SELECT *
    FROM nieruszane_filmy
GO