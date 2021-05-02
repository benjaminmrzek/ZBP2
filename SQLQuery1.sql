--1. izpiši vse podatke o èlanih (rezultat ima 760 vrstic)
select * 
from [dbo].[Clani];

--2. izpiši vse podatke o èlanih, urejene po priimku èlana
select * 
from Clani
order by [Ime];

--3. izpiši vse podatke o èlanih, urejene po številki vasi, nato pa po imenih
select * 
from Clani
order by Vas, Ime;

--4. izpiši ime èlana, naslov in ime vasi, urejene po imenu vasi, nato po imenih èlana
select c.Ime, c.Naslov
from Clani c
inner join Vasi v on c.Vas = v.Sifra_vas
order by v.Ime_vasi, c.Ime;

--5. izpiši imena èlanov, ki vsebujejo besedo 'FRANC' (17 takih je)
select Ime
from Clani
where Ime like '%FRANC%';

--6. izpiši skupno kolièino pripeljanega grozdja po posameznem èlanu iz tabele prevzem. V izpisu naj bo šifra
-- èlana in skupna kolièina grozdja, izpis uredi po šifri èlana
select Sifra_clan, SUM(Kolicina) as 'Skupna kolièina'
from Prevzem
group by Sifra_clan
order by Sifra_clan;

--7. izpiši skupno kolièino grozdja po letnikih iz tabele Prevzem
select Letnik, SUM(Kolicina) as 'Skupna kolièina'
from Prevzem
group by Letnik;

--8. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah
select Sorta, SUM(Kolicina) as 'Skupna kolièina'
from Prevzem
where Letnik = 2000
group by Sorta
order by Sorta;

--9. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po sortah, uporabi imena sort
select s.ImeS, SUM(p.Kolicina) as 'Skupna kolièina'
from Sorta s
inner join Prevzem p on s.Sifra_sorta = p.Sorta
where p.Letnik = 2000
group by s.ImeS
order by s.ImeS;

--10. izpiši skupno kolièino grozdja za posamezno sorto za Letnik 2000 urejeno po odkupni kolièini padajoèe, uporabi imena sort
select s.ImeS, SUM(p.Kolicina) as 'Skupna kolièina'
from Prevzem p
inner join Sorta s on s.Sifra_sorta = p.Sorta
where p.Letnik = 2000
group by s.ImeS
order by SUM(p.Kolicina) desc;

--11. kateri èlan je pripeljal najveè grozdja naenkrat? Izpiši šifro èlana (9270120)
/*
select top 1 Sifra_clan, MAX(Vrednost) as 'Pripeljano grozdje'
from Prevzem
group by Sifra_clan
order by MAX(Vrednost) desc;
*/
select Sifra_clan
from Prevzem
where Vrednost = (select MAX(Vrednost) from Prevzem);

--12. izpiši ime èlana, ki je pripeljal najveè grozdja naenkrat (Koncut Damijan) 14
select c.Ime
from Clani c
inner join Prevzem p on p.Sifra_clan = c.Sifra_clan
where p.Vrednost = (select MAX(Vrednost) from Prevzem);

--13. izpiši šifro èlana, ki je v letu 2003 pripeljal najveè grozdja (9330030)
select Sifra_clan
from Prevzem
where YEAR(Datump) = 2003
and Vrednost = (select MAX(Vrednost) from Prevzem where YEAR(Datump) = 2003);

--14. Koliko je vseh èlanov (760)
select COUNT(*) as 'Število èlanov'
from Clani;

--15. Koliko èlanov je pripeljalo grozdje v letu 2001 (720)
select COUNT(*) as 'Èlani, ki so pripeljali grozdje'
from
(
select Sifra_clan
from Prevzem
where YEAR(Datump) = 2001
group by Sifra_clan
) src;

--16. Koliko èlanov ni pripeljalo grozdja v letu 2001 (40)
select COUNT(*) - (select COUNT(*)
from(
select Sifra_clan
from Prevzem
where YEAR(Datump) = 2001
group by Sifra_clan
) src)
from Clani;

--17. izpiši imena in naslove èlanov, ki niso pripeljali grozdja v letu 2001, uredi po imenu
select Ime, Naslov
from Clani
where Sifra_clan NOT IN (select Sifra_clan
from Prevzem
where YEAR(Datump) = 2001
group by Sifra_clan)
order by Ime;

--18. izpiši imena in naslove èlanov, ki niso pripeljali grozdja v letu 2000 ali 2001 ali 2002 ali 2003, uredi po imenu
select Ime, Naslov
from Clani
where Sifra_clan NOT IN (select Sifra_clan
from Prevzem
where YEAR(Datump) = 2000 or YEAR(Datump) = 2001 or YEAR(Datump) = 2002 or YEAR(Datump) = 2003
group by Sifra_clan)
order by Ime;

--19. izpiši povpreèno sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorte skupna kolièina in povpreèna stopnja sladkorje
-- povpreèno sladkorno stopnjo izraèunamo kot povpreèje kolièina*sladkor nato delimo s kolièino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajoèe
select *
from(
select s.ImeS
from Prevzem p
inner join Sorta s on s.Sifra_sorta = p.Sorta
group by s.ImeS
)src;


select s.ImeS
from Prevzem p
inner join Sorta s on s.Sifra_sorta = p.Sorta
group by s.ImeS;

--20. izpiši povpreèno sladkorno stopnjo po sortah. V izpisu naj bo letnik,ime sorte skupna kolièina in povpreèna stopnja sladkorje
-- povpreèno sladkorno stopnjo izraèunamo kot povpreèje sladkornih stopenj nato delimo s kolièino, izpis uredi po letnikih in
-- po sladkornih stopnjah, padajoèe
-- primerjaj rezultate 24. in 25. naloge. Kateri so po tvojem mnenju pravilni? Zakaj?

--Insert, update, delete
--1. izdelaj novo tabelo, ki ima enako strukturo kot Sorta z imenom Grozdje
create table Grozdje(
Sifra_grozdje int NOT NULL,
ImeS nvarchar(50) NULL,
Sifrav int NULL,
SifraUE int NULL,
Barva nvarchar(50) NULL,
CONSTRAINT PK_Grozdje PRIMARY KEY(Sifra_grozdje)
);

--2. vstavi v tabelo podatke o sortah iz tabele sorta
insert into Grozdje
select * from Sorta;

--3. vstavi v tabelo grozdje sorto 501 z imenom Laški rizling
insert into Grozdje(Sifra_grozdje,ImeS) values (501,'Laški rizling');

--4. popravi barvo vseh sort, kjer je vrednost barve null v belo
update Grozdje
set Barva = 'belo'
where Barva is null;

--5. izbriši podatke iz tabele Grozdje
truncate table Grozdje;

--6. izbriši tabelo Grozdje
drop table Grozdje;