
/* Tratamento dos dados realizado anteriormente - Python */

/* Alteração do data type */


/* 1. Alteração para bit */

alter table dbo.hotel_bookings_CLEAN
alter column is_canceled bit

alter table dbo.hotel_bookings_CLEAN
alter column is_repeated_guest bit

alter table dbo.hotel_bookings_CLEAN
alter column required_car_parking_spaces bit


/* 2. Alteração para int */

alter table dbo.hotel_bookings_CLEAN
alter column lead_time int

alter table dbo.hotel_bookings_CLEAN
alter column arrival_date_year int

alter table dbo.hotel_bookings_CLEAN
alter column arrival_date_week_number int

alter table dbo.hotel_bookings_CLEAN
alter column arrival_date_day_of_month int

alter table dbo.hotel_bookings_CLEAN
alter column stays_in_weekend_nights int

alter table dbo.hotel_bookings_CLEAN
alter column stays_in_week_nights int

alter table dbo.hotel_bookings_CLEAN
alter column adults int

alter table dbo.hotel_bookings_CLEAN
alter column children int

alter table dbo.hotel_bookings_CLEAN
alter column babies int

alter table dbo.hotel_bookings_CLEAN
alter column previous_cancellations int

alter table dbo.hotel_bookings_CLEAN
alter column previous_bookings_not_canceled int

alter table dbo.hotel_bookings_CLEAN
alter column booking_changes int

alter table dbo.hotel_bookings_CLEAN
alter column agent int

alter table dbo.hotel_bookings_CLEAN
alter column company int

alter table dbo.hotel_bookings_CLEAN
alter column days_in_waiting_list int

alter table dbo.hotel_bookings_CLEAN
alter column total_of_special_requests int


/* 3. Alteração para float */

alter table dbo.hotel_bookings_CLEAN
alter column adr float


/* 4. Alteração para date */

alter table dbo.hotel_bookings_CLEAN
alter column reservation_status_date date


/* ========================================================================================= */

/* Análise exploratória - Geral */

/* 1. Quantidade de Reservas */


select hotel as tipo_hotel,
       count(*) as total_reservas
from dbo.hotel_bookings_CLEAN
group by hotel


------------------------------------------------------------------------------------------------


/* 2. Quantidade de Reservas e Total de Cancelamentos */

select hotel as tipo_hotel,
       count(*) as total_reservas,
       sum(case when is_canceled = 1 then 1 else 0 end) as total_cancelamentos
from dbo.hotel_bookings_CLEAN
group by hotel


------------------------------------------------------------------------------------------------


/* 3. Percentual de Reservas Canceladas */

select hotel as tipo_hotel,
	   count(*) as total_reservas,
	   sum(case when is_canceled = 1 then 1 else 0 end) as total_cancelamentos,
	   cast(sum(case when is_canceled = 1 then 1 else 0 end) * 100.0 / nullif(count(*), 0) as decimal(10,2)) as percentual_cancelamento
from dbo.hotel_bookings_CLEAN
group by hotel


------------------------------------------------------------------------------------------------


/* 4. Reservas e Cancelamentos por Trimestre */

select    
		case
			 when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			 when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			 when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			 when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
		else 'desconhecido'
		end as trimestre_chegada,
		t1.hotel as tipo_hotel,
		count(*) as total_reservas,
		sum(case when t1.is_canceled = 1 then 1 else 0 end) as total_cancelamentos,
		(cast(sum(case when t1.is_canceled = 1 then 1 else 0 end) as decimal(10, 2)) * 100.0) / count(*) as percentual_cancelamento
from hotel_bookings_CLEAN as t1
group by
		 case
			  when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			  when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			  when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			  when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
		 else 'desconhecido'
		 end,
		 t1.hotel
order by tipo_hotel,
		 trimestre_chegada


------------------------------------------------------------------------------------------------


/* 5. Total e percentual de Reservas e Cancelamentos por Trimestre de cada ano */
		
select t1.hotel as tipo_hotel, 
	   t1.arrival_date_year as ano_chegada, 
	   case
			when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
			else 'desconhecido'
       end as trimestre_chegada, 
       count(*) as total_reservas,  
       sum(case when t1.is_canceled = 1 then 1 else 0 end) as total_cancelamentos,
       (cast(sum(case when t1.is_canceled = 1 then 1 else 0 end) as decimal(10, 2)) * 100.0) / count(*) as cancelamento_percentual
from hotel_bookings_CLEAN as t1
group by t1.arrival_date_year,
		case
			when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
			else 'desconhecido'
		end,
        t1.hotel
order by tipo_hotel,
         ano_chegada,
         trimestre_chegada


------------------------------------------------------------------------------------------------


/* 6. Ocupação (Reservas) por Segmento de Mercado */

select market_segment,
       count(*) as total_reservas
from hotel_bookings_CLEAN
group by market_segment
order by total_reservas desc


------------------------------------------------------------------------------------------------


/* 7. Reservas por hotel e Segmento de Mercado */

select hotel,
       market_segment,
       count(*) as total_reservas
from hotel_bookings_CLEAN
group by hotel,
         market_segment
order by hotel,
         total_reservas desc


------------------------------------------------------------------------------------------------


/* 8. Reservas e a Taxa de Cancelamento Trimestralmente, Por Segmento de Mercado.  */

select
	   case
			when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
	   else 'desconhecido'
	   end as trimestre_chegada,
       t1.market_segment as segmento_mercado,
       count(*) as total_reservas,
       sum(case when t1.is_canceled = 1 then 1 else 0 end) as total_cancelamentos,
       (cast(sum(case when t1.is_canceled = 1 then 1 else 0 end) as decimal(10, 2)) * 100.0) / count(*) as cancelamento_percentual
from hotel_bookings_CLEAN as t1
group by
	     case
			  when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			  when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			  when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
		      when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
		  else 'desconhecido'
		  end,
		  t1.market_segment
order by trimestre_chegada,
		 total_reservas desc


------------------------------------------------------------------------------------------------


/* 9. Cancelamento por Ano, Trimestre e Segmento de Mercado.  */

select t1.arrival_date_year as ano_chegada,
	   case
			when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
			else 'desconhecido'
	   end as trimestre_chegada,    
       t1.market_segment as segmento_mercado,
       count(*) as total_reservas,
       sum(case when t1.is_canceled = 1 then 1 else 0 end) as total_cancelamentos,
       (cast(sum(case when t1.is_canceled = 1 then 1 else 0 end) as decimal(10, 2)) * 100.0) / count(*) as cancelamento_percentual
from hotel_bookings_clean as t1
group by t1.arrival_date_year, 
		 case
		      when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			  when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
		   	  when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			  when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
			  else 'desconhecido'
		  end,
          t1.market_segment
order by ano_chegada,
         trimestre_chegada,
         total_reservas desc


------------------------------------------------------------------------------------------------


/* 10. Risco por Ano, Trimestre, Tipo de Hotel e Segmento.  */


select t1.arrival_date_year as ano_chegada,
       t1.hotel as tipo_hotel,
	   case
		    when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
			else 'desconhecido'
	   end as trimestre_chegada,
    t1.market_segment as segmento_mercado,
    count(*) as total_reservas,
    sum(case when t1.is_canceled = 1 then 1 else 0 end) as total_cancelamentos,
    (cast(sum(case when t1.is_canceled = 1 then 1 else 0 end) as decimal(10, 2)) * 100.0) / count(*) as cancelamento_percentual
from hotel_bookings_CLEAN as t1
group by t1.arrival_date_year,
		 t1.hotel,
		 case
			  when t1.arrival_date_month in ('january', 'february', 'march') then 't1 (jan-mar)'
			  when t1.arrival_date_month in ('april', 'may', 'june') then 't2 (abr-jun)'
			  when t1.arrival_date_month in ('july', 'august', 'september') then 't3 (jul-set)'
			  when t1.arrival_date_month in ('october', 'november', 'december') then 't4 (out-dez)'
			  else 'desconhecido'
		  end,
          t1.market_segment
order by ano_chegada,
         tipo_hotel,
         trimestre_chegada,
         total_reservas desc


/* ========================================================================================= */


/* Análise exploratória - ADR */

/* 1. Criação de vistas para as queries ficarem mais limpas */


/* vista com reservas válidas (adr > 0) */
create view view_bookings_valid_adr as
select*
from dbo.hotel_bookings_CLEAN
where adr > 0


/* vista com preço médio por hotel e tipo de quarto (base para perdas por cancelamento) */
create view view_room_avg_price as
select hotel,
	   assigned_room_type,
       round(avg(adr), 2) as avg_room_price
from dbo.hotel_bookings_CLEAN
where adr > 0
group by hotel,
         assigned_room_type

/* vista com perdas estimadas por cancelamento */
create view view_cancelation_losses as
select
    b.hotel,
    b.assigned_room_type,
    ra.avg_room_price,
    count(*) as total_canceled,
    round(sum(case
                   when b.adr = 0 then ra.avg_room_price
                   when b.adr > 0 then
                       case
                            when ra.avg_room_price - b.adr < 0 then 0
                            else ra.avg_room_price - b.adr
                            end
                   when b.adr < 0 then ra.avg_room_price + abs(b.adr)
                   else 0
                   end), 2) as total_estimated_loss
from dbo.hotel_bookings_CLEAN b
	join view_room_avg_price ra
		on ra.hotel = b.hotel
			and ra.assigned_room_type = b.assigned_room_type
where b.is_canceled = 1
group by b.hotel,
         b.assigned_room_type,
         ra.avg_room_price


------------------------------------------------------------------------------------------------


/* 2. adr médio por hotel e período */

select hotel,
	   arrival_date_year,
       arrival_date_month,
       round(avg(adr), 2) as avg_adr
from view_bookings_valid_adr
group by hotel,
         arrival_date_year,
         arrival_date_month
order by hotel,
         arrival_date_year,
         arrival_date_month


------------------------------------------------------------------------------------------------


/* 3. tipo de pagamento mais frequente */

select hotel,
       deposit_type,
       count(*) as total_reservas
from dbo.hotel_bookings_CLEAN
group by hotel,
         deposit_type
order by hotel,
         total_reservas desc


------------------------------------------------------------------------------------------------


/* 4. tipo de pagamento com maior valor médio e volume */

select hotel,
       deposit_type,
       round(avg(adr), 2) as avg_transaction_value,
       count(*) as total_transactions
from view_bookings_valid_adr
group by hotel,
         deposit_type
order by avg_transaction_value desc


------------------------------------------------------------------------------------------------


/* 5. tipos de quarto mais caros */

select reserved_room_type,
       round(avg(adr), 2) as avg_room_rate
from view_bookings_valid_adr
group by reserved_room_type
order by avg_room_rate desc


------------------------------------------------------------------------------------------------


/* 6. preço médio por hotel e ano */

select hotel,
       arrival_date_year,
       round(avg(adr), 2) as avg_rate
from view_bookings_valid_adr
group by hotel,
         arrival_date_year
order by arrival_date_year,
         avg_rate desc


------------------------------------------------------------------------------------------------


/* 7. adr médio por tipo de pagamento e hotel */

select hotel,
       deposit_type,
       round(avg(adr), 2) as avg_rate
from view_bookings_valid_adr
group by hotel,
         deposit_type
order by avg_rate desc


------------------------------------------------------------------------------------------------


/* 8. adr médio por tipo de estadia */

select hotel,
       case
			 when stays_in_week_nights = 0 and stays_in_weekend_nights > 0 then 'weekend only'
			 when stays_in_week_nights > 0 and stays_in_weekend_nights = 0 then 'week only'
			 when stays_in_week_nights > 0 and stays_in_weekend_nights > 0 then 'week + weekend'
			 when stays_in_week_nights = 0 and stays_in_weekend_nights = 0 then 'day use'
			 else 'other'
			 end as stay_type,
       round(avg(adr), 2) as avg_rate
from view_bookings_valid_adr
group by hotel,
         case
             when stays_in_week_nights = 0 and stays_in_weekend_nights > 0 then 'weekend only'
             when stays_in_week_nights > 0 and stays_in_weekend_nights = 0 then 'week only'
             when stays_in_week_nights > 0 and stays_in_weekend_nights > 0 then 'week + weekend'
             when stays_in_week_nights = 0 and stays_in_weekend_nights = 0 then 'day use'
             else 'other'
			 end
order by avg_rate desc


------------------------------------------------------------------------------------------------


/* 9. cancelamentos × adr médio */

select is_canceled,
       round(avg(adr), 2) as avg_adr
from view_bookings_valid_adr
group by is_canceled


------------------------------------------------------------------------------------------------


/* 10. revenue por reserva */

select hotel,
       adr * (stays_in_week_nights + stays_in_weekend_nights) as total_revenue
from view_bookings_valid_adr
where stays_in_week_nights > 0
   or stays_in_weekend_nights > 0
order by total_revenue desc


------------------------------------------------------------------------------------------------


/* 11. cancelamentos por intervalo de adr */

select
       case
            when adr < 50 then '0–49'
            when adr between 50 and 99 then '50–99'
            when adr between 100 and 149 then '100–149'
            when adr between 150 and 199 then '150–199'
            when adr between 200 and 250 then '200–250'
            else '250+'
            end as adr_range,
       count(*) as total_bookings,
       sum(case when is_canceled = 1 then 1 else 0 end) as canceled_bookings,
       round(100.0 * sum(case when is_canceled = 1 then 1 else 0 end) / count(*), 2) as cancelation_rate
from dbo.hotel_bookings_CLEAN
group by
        case
             when adr < 50 then '0–49'
             when adr between 50 and 99 then '50–99'
             when adr between 100 and 149 then '100–149'
             when adr between 150 and 199 then '150–199'
             when adr between 200 and 250 then '200–250'
             else '250+'
             end
order by cancelation_rate desc


------------------------------------------------------------------------------------------------


/* 12. numero de registos por tipo de familia e por mes por ano e por hotel*/

select case 
			when adults >= 1 and children >=1 and babies >= 1 then 'Familia completa'
			when adults >= 1 and children >=1 and babies = 0 then 'Familia com crianças'
			when adults >= 1 and babies >=1 and children = 0 then 'family com bébés'
			when adults >= 1 and children = 0 and babies = 0 then 'Sem dependentes'
			when adults >= 0 and children = 1 and babies = 1 then 'Crianças e bébés'
			when adults >= 0 and children = 0 and babies >= 1 then 'Bébés'
			when adults >= 0 and children >= 1 and babies = 0 then 'Crianças'
			else 'nada'
            end as Family_type,
       avg ( adr) as avg_adr,
       count (*) as 'total bookings',
       [hotel]
from dbo.hotel_bookings_CLEAN
group by case
			when adults >= 1 and children >=1 and babies >= 1 then 'Familia completa'
			when adults >= 1 and children >=1 and babies = 0 then 'Familia com crianças'
			when adults >= 1 and babies >=1 and children = 0 then 'family com bébés'
			when adults >= 1 and children = 0 and babies = 0 then 'Sem dependentes'
			when adults >= 0 and children = 1 and babies = 1 then 'Crianças e bébés'
			when adults >= 0 and children = 0 and babies >= 1 then 'Bébés'
			when adults >= 0 and children >= 1 and babies = 0 then 'Crianças'
			else 'nada'
	        end,
		    [hotel]
order by 'total bookings' desc


------------------------------------------------------------------------------------------------


/* 13. Mercado x Nºde noites x Rendimento */

select hotel,
       market_segment,
       sum ([stays_in_week_nights]) as 'week_room_nights',
       sum ([stays_in_weekend_nights]) as 'weekend_room_nights',
       count (*) as 'total bookings',
       count (case when is_canceled = 1 then 1 end) as 'Number of cancelations',
       100* Sum(Case when is_canceled = 1 Then 1 else 0 END) / Count(*) AS cancellation_rate_percent,
       round ( avg ( adr), 2) as ' Revenue'
from dbo.hotel_bookings_CLEAN
where adr > 0
group by hotel,market_segment
order by week_room_nights desc,
         weekend_room_nights desc


------------------------------------------------------------------------------------------------


/* 14. Cancelamentos x ADR */

select is_canceled,
       round ( avg (adr), 2) as 'average_adr'
from dbo.hotel_bookings_CLEAN
where adr > 0
group by is_canceled


------------------------------------------------------------------------------------------------


/* 15. total de potencial rendimento perdido por cancelamentos por hotel*/


with room_avg as (select hotel,
						 assigned_room_type,
						 round(avg(adr), 2) as avg_price
				  from dbo.hotel_bookings_CLEAN
				  group by hotel, assigned_room_type)
select b.hotel,
	   b.assigned_room_type as room_type,
	   ra.avg_price,
       sum(case when b.adr = 0 then 1 else 0 end) as count_adr_zero,
       sum(case when b.adr > 0 then 1 else 0 end) as count_adr_positive,
       sum(case when b.adr < 0 then 1 else 0 end) as count_adr_negative,
       count(*) as total_canceled,
       round(sum(case when b.adr = 0 then ra.avg_price else 0 end), 2) as loss_adr_zero,
       round(sum(case when b.adr > 0 then 
                                         case when ra.avg_price - b.adr < 0 then 0 else ra.avg_price - b.adr end
                      else 0 end), 2) as loss_adr_positive,
       round(sum(case when b.adr < 0 then ra.avg_price + abs(b.adr) else 0 end), 2) as loss_adr_negative,
       round(sum(case
					when b.adr = 0 then ra.avg_price
					when b.adr > 0 then 
					                   case when ra.avg_price - b.adr < 0 then 0 else ra.avg_price - b.adr end
                    when b.adr < 0 then ra.avg_price + abs(b.adr)
                    else 0
                    end), 2) as total_loss
from dbo.hotel_bookings_CLEAN as b
	 join room_avg as ra 
		  on ra.hotel = b.hotel
		  and ra.assigned_room_type = b.assigned_room_type
where b.is_canceled = 1
group by b.hotel,
		 b.assigned_room_type,
		 ra.avg_price
order by hotel, total_loss


/* ========================================================================================= */


/* Análise exploratória -  Lead time */

/* 1. Criação de uma vista para as queries ficarem mais limpas */

create view view_lead_time as
select *,
       case 
           when lead_time <= 7 then '0–7 dias'
           when lead_time <= 15 then '8–15 dias'
           when lead_time <= 30 then '16–30 dias'
           when lead_time <= 60 then '31–60 dias'
           when lead_time <= 120 then '61–120 dias'
           when lead_time <= 180 then '121–180 dias'
           else '180+ dias'
       end as lead_time_group
from dbo.hotel_bookings_CLEAN


------------------------------------------------------------------------------------------------


/* 2. Lead Time por Hotel (visão geral) */

select hotel,
       avg(lead_time) as avg_lead_time,
       min(lead_time) as min_lead_time,
       max(lead_time) as max_lead_time
from view_lead_time
group by hotel


--------------------------------------------------------------------------------------------------


/* 3. Distribuição do Lead Time (grupos) */

select hotel,
       lead_time_group,
       count(*) as total_reservas
from view_lead_time
group by hotel,
	     lead_time_group
order by hotel,
		 total_reservas desc


--------------------------------------------------------------------------------------------------


/* 4. Distribuição do Lead Time (grupos) */

select hotel,
       arrival_date_year,
       lead_time_group,
       count(*) as total,
       sum(case when is_canceled = 1 then 1 end) as canceladas,
       sum(case when is_canceled = 0 then 1 end) as nao_canceladas,
       format(100.0 * SUM(case when is_canceled = 1 then 1 end) / count(*), 'N2') as taxa_cancelamento
from view_lead_time
group by hotel,
		 arrival_date_year,
		 lead_time_group
order by hotel,
		 arrival_date_year,
		 taxa_cancelamento desc


--------------------------------------------------------------------------------------------------


/* 5. Evolução Mensal/Anual do Lead Time */

select hotel,
	   arrival_date_year,
	   arrival_date_month,
       avg(lead_time) as avg_lead_time
from view_lead_time
group by hotel,
		 arrival_date_year,
		 arrival_date_month
order by hotel,
		 arrival_date_year,
		 arrival_date_month


--------------------------------------------------------------------------------------------------


/* 6. Lead Time × Market Segment */

select hotel,
	   market_segment,
       avg(lead_time) as avg_lead_time,
       count(*) as total
from view_lead_time
group by hotel, market_segment
order by avg_lead_time desc


--------------------------------------------------------------------------------------------------


/* 7. Lead Time × País */

select hotel,
	   arrival_date_year,
	   arrival_date_month,
	   country,
       avg(lead_time) as avg_lead_time,
       count(*) as total_reservas
from view_lead_time
group by hotel,
		 arrival_date_year,
		 arrival_date_month,
		 country
order by hotel,
		 arrival_date_year,
		 arrival_date_month,
		 avg_lead_time desc

		 -------------------

select hotel,
	   arrival_date_year,
	   country,
       count(*) as total_reservas
from view_lead_time
group by hotel,
		 arrival_date_year,
		 country
order by hotel,
		 arrival_date_year,
		 total_reservas desc


--------------------------------------------------------------------------------------------------


/* 8. Lead Time × Repeated Guests */

select hotel,
	   is_repeated_guest,
       avg(lead_time) as avg_lead_time,
	   min(lead_time) as min_lead_time,
	   max(lead_time) as max_lead_time
from view_lead_time
group by hotel,
		 is_repeated_guest


--------------------------------------------------------------------------------------------------


/* 9. Lead Time × Room Type */

select hotel,
	   reserved_room_type,
       avg(lead_time) as avg_lead_time,
       count(*) as total,
	   round (avg(adr), 2) as avg_price
from view_lead_time
group by hotel,
		 reserved_room_type
order by hotel,
		 avg_price desc

		 -------------------

select hotel,
       reserved_room_type,
       avg_price,
       dense_rank() over (partition by hotel order by avg_price desc) as price_rank
from (select hotel,
			 reserved_room_type,
			 round(avg(adr),2) as avg_price
	  from dbo.hotel_bookings_RAW
	  group by hotel, reserved_room_type) as ranking_room_type
order by hotel,
		 price_rank


--------------------------------------------------------------------------------------------------


/* 10. ADR × Lead Time */

select hotel,
	   lead_time_group,
       round(avg(adr), 2) as avg_price
from view_lead_time
group by hotel,
		 lead_time_group
order by hotel,
		 avg_price desc


--------------------------------------------------------------------------------------------------


/* 11. Waiting List × Cancelamento */

select hotel,
	   lead_time_group,
       case when days_in_waiting_list > 0 then 'Waiting List' else 'N/A' end as waiting_list,
       sum(case when is_canceled = 1 then 1 end) as canceladas,
       sum(case when is_canceled = 0 then 1 end) as nao_canceladas,
       format(100.0 * sum(case when is_canceled = 1 then 1 end) / count(*), 'N2') as taxa_cancelamento
from view_lead_time
group by hotel,
		 lead_time_group,
		 case when days_in_waiting_list > 0 then 'Waiting List' else 'N/A' end
order by hotel,
		 lead_time_group,
		 case when days_in_waiting_list > 0 then 'Waiting List' else 'N/A' end