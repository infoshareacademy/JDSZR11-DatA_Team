select *
from h2015 as h5 
	join h2016 as h6 
	on h5.country = h6.country 
	left join h2017 as h7 
	on h5.country = h7.country  
	left join h2018 as h8 
	on h5.country = h8."Country or region" 
	left join h2019 as h9 
	on h5.country = h9."Country or region" 


create view  v_wszystkie_lata
as
select *
from h2015 as h5 
	join h2016 as h6 
	on h5.country = h6.country 
	 join h2017 as h7 
	on h5.country = h7.country  
	join h2018 as h8 
	on h5.country = h8."Country or region" 
	 join h2019 as h9 
	on h5.country = h9."Country or region" ;

select * from v_wszystkie_lata
--Robić projekt na funkcji okna--

select  * from h2016 h 
union all
select * from h2017 h2 



/*
 * Co biorę pod uwagę? Family, Trust, Economy, Region = Happiness Score*/


select *
from rok
order by "Happiness Rank" 


