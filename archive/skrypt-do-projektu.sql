--wyszukam kraje ameryki północnej--
select * 
from rok2016 r16
where kraj ='Canada' or kraj ='United States'

	--dodam do każdej tabeli z rokiem kolumnę rok, żeby łatwiej mi bytło filtrować dane--
	ALTER TABLE rok2015 
	ADD rok int;
	ALTER TABLE rok2016 
	ADD rok int;
	ALTER TABLE rok2017 
	ADD rok int;
	ALTER TABLE rok2018 
	ADD rok int;
	ALTER TABLE rok2019 
	ADD rok int;
												/*--dodaję wartości do utworzonych nowych kolumn--
												insert into rok2015 (rok) values ('2015');
												insert into rok2016 (rok) values ('2016');
												insert into rok2017 (rok) values ('2017');
												insert into rok2018 (rok) values ('2018');
												insert into rok2019 (rok) values ('2019');*/ --nie działa
	
	--w roku pojawiły się wartości null, więc muszę dodać wartość roku do każdego wiersza--
	update rok2015 
	set rok = 2015;
	update rok2016 
	set rok = 2016;
	update rok2017 
	set rok = 2017;
	update rok2018 
	set rok = 2018;
	update rok2019 
	set rok = 2019;

/*
--połączę wszystkie lata i zobaczę jak prezentują się dane na przestrzeni lat--
select * 
from rok2015 r15
where kraj ='Canada' or kraj ='United States' --Canada na 5, US na 15--
union all 
select * 
from rok2016 r16
where kraj ='Canada' or kraj ='United States' --Canada na 6, US na 13--
union all
select * 
from rok2017 r17
where kraj ='Canada' or kraj ='United States' --Canada na 7, US na 14--
union all
select * 
from rok2018 r18
where kraj ='Canada' or kraj ='United States' --Canada na 7, US na 18--
union all
select * 
from rok2019 r19
where kraj ='Canada' or kraj ='United States' --Canada na 9, US na 19--
order by rok , kraj
*/ --niepotrzebne

/*Obserwuję, że Canada i US spada w rankingu z każdym rokiem.
 Spada hojność, wolność*/
--select a, b , lead(a) over (partition by b ORDER BY ) from--

--wczytałam nową tabelę region oraz wszystkie_lata i będę pracować już na tym--
--dodajemy tabelę regiony--
select *
from wszystkie_lata w
left join region r
on w.kraj = r.country

--korelacje--
select
corr(ranking,spoleczenstwo) spoleczenstwo
,corr(ranking,zdrowie) zdrowie
,corr(ranking,wolnosc) wolnosc
,corr(ranking,korupcja) korupcja
,corr(ranking,hojnosc) hojnosc
from wszystkie_lata w
left join region r
on w.kraj = r.country

--korelacje dla każdego regionu--
select region, corr(punkty, pkb) korelacja_pkb, corr(punkty, spoleczenstwo) korelacja_spol,
corr(punkty, zdrowie) korelacja_zdrowie, corr(punkty,wolnosc) korelacja_wolnosc,
corr(punkty, korupcja) korelacja_korupcja,
corr(punkty,hojnosc) korelacja_hojnosc
from wszystkie_lata wl
join region r
on r.country = wl.kraj
group by region
order by korelacja_pkb desc

--korelacja punktów--
select region, 
corr(punkty, pkb) korelacja_pkb, 
corr(punkty, spoleczenstwo) korelacja_spol,
corr(punkty, zdrowie) korelacja_zdrowie, corr(punkty,wolnosc) korelacja_wolnosc,
corr(punkty, korupcja) korelacja_korupcja,
corr(punkty,hojnosc) korelacja_hojnosc
from wszystkie_lata wl
join region r
on r.country = wl.kraj
group by region
order by korelacja_pkb desc

--policzymy średnią punktów dla każdego REGIONU/ ze wszystkich lat--
select region, avg(punkty) as srednia_punktow, avg(pkb) as srednie_pkb,
avg(spoleczenstwo) as srednie_spoleczenstwo, avg(zdrowie) as srednie_zdrowie,
avg(wolnosc) as srednia_wolnosc, avg(korupcja) as srednia_korupcja, avg(hojnosc)
as srednia_hojnosc
from wszystkie_lata wl
join region r
on r.country = wl.kraj
group by region
order by srednia_punktow desc


--średnie z każdej kolumny policzone dla każdego roku--
SELECT rok, AVG(wl.punkty) AS średni_poziom_szczęścia,
       AVG(pkb) AS średni_wpływ_PKB, AVG(spoleczenstwo) AS średni_wpływ_Rodziny,
       AVG(zdrowie) AS średni_wpływ_Oczekiwana_długość_życia, AVG(wolnosc) AS średni_wpływ_Wolności,
       AVG(korupcja) AS średni_wpływ_Postrzegania_korupcji, AVG(hojnosc) AS średni_wpływ_Hojności
FROM wszystkie_lata wl
join region r
on wl.kraj = r.country
GROUP BY rok
order by rok

--ranking 10 krajów z najwyższą średnią punktów szczęścia/ ze wszystkich lat--
select avg(punkty)srednia_punktow, wl.kraj from wszystkie_lata wl
join region r
on r.country = wl.kraj
group by wl.kraj
order by srednia_punktow desc
limit 10

--
select w.kraj,
max(punkty) - min(punkty) różnica_maks_minim,
avg(punkty) średnia_z_lat,
(max(punkty) - min(punkty))*100/avg(punkty) procentowo
from wszystkie_lata w
group by w.kraj

--Odchylenie standardowe rankingu dla każdego kraju--
select kraj, stddev(ranking)
from wszystkie_lata wl
group by kraj
order by 2 desc



--policzyć kwantyle--
0.00     0.05     0.50       0.95       0.99  \
Overall rank                  1.000  8.75000  78.5000  148.25000  154.45000   
Score                         2.853  3.48150   5.3795    7.28525    7.57470   
GDP per capita                0.000  0.25200   0.9600    1.44150    1.58865   
Social support                0.000  0.64325   1.2715    1.53800    1.58425   
Healthy life expectancy       0.000  0.28825   0.7890    1.03975    1.10330   
Freedom to make life choices  0.000  0.14275   0.4170    0.58425    0.60570   
Generosity                    0.000  0.04675   0.1775    0.34950    0.45455   
Perceptions of corruption     0.000  0.01900   0.0855    0.32225    0.41045   

1.00  
Overall rank                  156.000  
Score                           7.769  
GDP per capita                  1.684  
Social support                  1.624  
Healthy life expectancy         1.141  
Freedom to make life choices    0.631  
Generosity                      0.566  
Perceptions of corruption       0.453  
on w.kraj = r.country

