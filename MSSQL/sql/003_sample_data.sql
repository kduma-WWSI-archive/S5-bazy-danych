IF EXISTS(SELECT * FROM rodzaje)
    BEGIN
        PRINT '+------------------------------------+'
        PRINT '|W bazie znajdują się już jakieś dane|'
        PRINT '+------------------------------------+'
    END
ELSE
    BEGIN
        PRINT '+-------------------------+'
        PRINT '|Wstawiam dane przykładowe|'
        PRINT '+-------------------------+'

        INSERT INTO rodzaje (nazwa)
            VALUES ('Komedia'),
                    ('Sensacja'),
                    ('Kryminal'),
                    ('Thriller'),
                    ('Western'),
                    ('Gangsterski')

        
        INSERT INTO rezyser (nazwisko, imie)
            VALUES ('Zucker', 'David'),
                    ('Rodriguez', 'Robert'),
                    ('Fuqua', 'Antoine')

        
        INSERT INTO kraje (nazwa)
            VALUES ('USA'),
                    ('Wielka Brytania'),
                    ('Polska')

        
        INSERT INTO filmy (tytul, rezyser_id, cena, kolor, opis)
            VALUES ('The Naked Gun: From the Files of Police Squad!',
                    ( SELECT TOP 1 id FROM rezyser WHERE nazwisko = 'Zucker' ),
                    15,
                    'K',
                    'Do USA przylatuje Królowa Elżbieta II. Porucznik Frank Drebin ma za zadanie zapewnić jej bezpieczeństwo.'
                    ),
                    ('Airplane!',
                    ( SELECT TOP 1 id FROM rezyser WHERE nazwisko = 'Zucker' ),
                    13,
                    'K',
                    'W związku z zatruciem załogi samolotu pasażerskiego były pilot wojskowy - Ted Striker - musi pokonać lęk przed lataniem i ponownie usiąść za sterami.'
                    ),
                    ('Desperado',
                    ( SELECT TOP 1 id FROM rezyser WHERE nazwisko = 'Rodriguez' ),
                    18,
                    'K',
                    'W małym miasteczku pojawia się El Mariachi, były muzyk z futerałem pełnym broni. Poszukuje zabójcy swojej ukochanej, by pomścić jej śmierć.'
                    ),
                    ('The Magnificent Seven',
                    ( SELECT TOP 1 id FROM rezyser WHERE nazwisko = 'Fuqua' ),
                    20,
                    'K',
                    'Siedmiu rewolwerowców łączy się, by pomóc w ochronie wioski przed uzbrojoną bandą złoczyńców.'
                    )

        
        INSERT INTO filmy_kraje (film_id, kraj_id)
            VALUES (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Naked Gun: From the Files of Police Squad!' ),
                    ( SELECT TOP 1 id FROM kraje WHERE nazwa = 'USA' )
                    ),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Airplane!' ),
                    ( SELECT TOP 1 id FROM kraje WHERE nazwa = 'USA' )
                    ),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Desperado' ),
                    ( SELECT TOP 1 id FROM kraje WHERE nazwa = 'USA' )
                    ),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Magnificent Seven' ),
                    ( SELECT TOP 1 id FROM kraje WHERE nazwa = 'USA' )
                    )

        
        INSERT INTO filmy_rodzaje (film_id, rodzaj_id)
            VALUES (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Naked Gun: From the Files of Police Squad!' ),
                    ( SELECT TOP 1 id FROM rodzaje WHERE nazwa = 'Komedia' )
                    ),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Naked Gun: From the Files of Police Squad!' ),
                    ( SELECT TOP 1 id FROM rodzaje WHERE nazwa = 'Sensacja' )
                    ),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Airplane!' ),
                    ( SELECT TOP 1 id FROM rodzaje WHERE nazwa = 'Komedia' )
                    ),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Desperado' ),
                    ( SELECT TOP 1 id FROM rodzaje WHERE nazwa = 'Sensacja' )
                    ),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Desperado' ),
                    ( SELECT TOP 1 id FROM rodzaje WHERE nazwa = 'Gangsterski' )
                    ),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Magnificent Seven' ),
                    ( SELECT TOP 1 id FROM rodzaje WHERE nazwa = 'Western' )
                    )

        
        INSERT INTO kasety (film_id, status)
            VALUES (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Naked Gun: From the Files of Police Squad!' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Naked Gun: From the Files of Police Squad!' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Naked Gun: From the Files of Police Squad!' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Airplane!' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Airplane!' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Desperado' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Desperado' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Desperado' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'Desperado' ), 'K'),
                    (( SELECT TOP 1 id FROM filmy WHERE tytul = 'The Magnificent Seven' ), 'K')

        
        INSERT INTO klienci (imie, nazwisko, wiek, adres, telefon, plec)
            VALUES ('Micah', 'Hale', 93, 'Ap #452-1049 Quisque Ave', '(016977) 9236', 'M'),
                    ('Hermione', 'Cunningham', 45, 'Ap #878-9649 Ullamcorper Ave', '(029) 5917 5059', 'K'),
                    ('Sonia', 'Foreman', 64, '7118 Morbi St.', '07624 640340', 'M'),
                    ('Ciara', 'Hartman', 63, '9410 Nibh Ave', '0356 527 1689', 'K'),
                    ('Tatum', 'Cooper', 53, '895-6934 Euismod Avenue', '0800 053 7551', 'K'),
                    ('Ignacia', 'Mcfadden', 26, '9953 Sit St.', '076 2563 7394', 'M'),
                    ('Geoffrey', 'Simon', 52, 'Ap #959-6368 Penatibus Rd.', '070 4601 3635', 'M'),
                    ('Tasha', 'Washington', 77, '241-3183 Scelerisque St.', '055 0944 8037', 'M'),
                    ('Hunter', 'Swanson', 97, 'P.O. Box 679, 5435 Neque Avenue', '0886 570 7081', 'K'),
                    ('Leslie', 'Frederick', 27, 'Ap #130-3464 Augue Ave', '07624 123938', 'M'),
                    ('Porter', 'Warner', 65, '1998 Libero St.', '(01313) 34360', 'K'),
                    ('Martha', 'Le', 35, 'Ap #480-5643 Parturient Rd.', '(023) 2972 0008', 'M'),
                    ('Regina', 'Brady', 42, '4529 Amet Avenue', '0845 46 42', 'K'),
                    ('Merritt', 'Townsend', 86, '742-4184 Ac Av.', '0362 711 9105', 'K'),
                    ('Carissa', 'Page', 92, '6469 Purus Road', '(0118) 169 5266', 'K')

        
        INSERT INTO wypozyczenia (klient_id, kaseta_id, data_wypozyczenia, data_zwrotu, kwota)
            VALUES (1, 2, '2018-09-11', '2018-09-12', 10),
                    (1, 6, '2018-09-15', '2018-09-16', 15),
                    (2, 3, '2018-09-11', '2018-09-12', 5),
                    (7, 2, '2018-09-11', '2018-09-12', 13),
                    (4, 1, '2018-09-11', '2018-09-12', 10),
                    (1, 2, '2018-10-11', '2018-10-12', 14),
                    (8, 7, '2018-09-11', '2018-09-12', 8)

    END
GO 