Use Data310
select * from Driver_Licenses
----------------------------- 
-- OUT OF COUNTRY TRANSFERS
-- 1. What are the top five countries that people moved from to KING County? 
-- Answer: Canada, Brazil, India, China and Germany

Select prior_country, COUNT(*) as Total_Transfers, county
from Driver_Licenses
where out_of_country_license_transfers ='1' and county= 'King'
group by prior_country, county
order by Total_Transfers desc


-- 2. What are the top five countries that people moved from to Snohomish County? 
-- Answer: Canada, Brazil, South Korea, Guam, India

Select prior_country, COUNT(*) as Total_Transfers, county
from Driver_Licenses
where out_of_country_license_transfers ='1' and county= 'Snohomish'
group by prior_country, county
order by Total_Transfers desc



-- 3. What are the top five countries that people moved from to Pierce County? 
-- Answer: American Samoa, Guam, Canada, South Korea, Puerto Rico

Select prior_country, COUNT(*) as Total_Transfers, county
from Driver_Licenses
where out_of_country_license_transfers ='1' and county= 'Pierce'
group by prior_country, county
order by Total_Transfers desc


-- 4. What percentage of people from out of the country moved to KING County?
-- Answer: 57% of King County has foreignors from out of the country

select (count(prior_country) * 100 / (select count(prior_country) from driver_licenses where out_of_country_license_transfers = '1')) as Percentage_King
from driver_licenses
where out_of_country_license_transfers = '1' and county = 'King'

-- 5. Other than King, Snohomish and Pierce County, what are the next 3 most popular counties that people from out of the country register for a new license? 
-- Answer: Clark (329 transfers), Whatcom (286 transfers) and Spokane (176 transfers)

select county, count(*) as Transfers_Count
from Driver_Licenses
where county not in ('Pierce', 'King', 'Snohomish') and out_of_country_license_transfers = '1'
group by county
order by Transfers_Count desc

-- Which month and year have the most people transferred licenses/ids from out of the country? the least?
-- Answer: The max was in October, 2018 (514 transfers) and the least was in June, 2020 (28 transfers)

select month, year, count(out_of_country_license_transfers) as Num_Transfers
from Driver_Licenses
where out_of_country_license_transfers = '1'
group by month, year
order by Num_Transfers desc


--------------------------------
-- OUT OF STATE TRANSFERS
-- What are the top five states that people have moved from? 
-- Answer: California (4498 transfers), Arizona( 1722 transfers) , Alaska (770 transfers), Alabama (236 transfers), Arkansas (200 transfers)
select prior_state, count(*) as Total_Transfers
from Driver_Licenses
where prior_state != 'Washington' and prior_state != 'Not Applicable'
group by prior_state
order by Total_Transfers desc

-- What are the top five states that people moved from to KING County? 
-- Answer: California (1617 transfers), Arizona (425 transfers), Alaska (152 transfers), Alabama (66 transfers), Arkansas (55 transfers)

Select prior_state, count(*) as Total_Transfers, county
from Driver_Licenses
where prior_state != 'Washington' and prior_state != 'Not Applicable' and county='King'
group by prior_state, county
order by Total_Transfers desc

-- What are the top five states that people moved from to Snohomish County? 
-- Answer: California (312 transfers), Arizona (156 transfers), Alaska (60 transfers), Alabama (19 transfers), Arkansas (16 transfers)

Select prior_state, count(*) as Total_Transfers, county
from Driver_Licenses
where prior_state != 'Washington' and prior_state != 'Not Applicable' and county='Snohomish'
group by prior_state, county
order by Total_Transfers desc

-- What are the top five states that people moved from to Pierce County? 
-- Answer: California (438 transfers), Arizona (204 transfers), Alaska (87 transfers), Alabama (33 transfers), Arkansas (31 transfers)

Select prior_state, count(*) as Total_Transfers, county
from Driver_Licenses
where prior_state != 'Washington' and prior_state != 'Not Applicable' and county='Pierce'
group by prior_state, county
order by Total_Transfers desc

-- What percentage of people from out of state moved to KING County?
-- Answer: 31% of the people in King County are from out of the state

select (count(prior_state) * 100 / (select count(prior_state) from driver_licenses where prior_state != 'Washington' and prior_state != 'Not Applicable' )) as Percentage_King
from driver_licenses
where prior_state != 'Washington' and prior_state != 'Not Applicable' and county='King'

-- Other than King, Snohomish and Pierce County, what are the next 3 most popular counties that people from out of state register for a new license? 
-- Answer: Clark (607 transfers), Spokane (582 transfers), Thurston (312 transfers), Kitsap (296 transfers) and Whatcom (230 transfers)

select county, count(*) as Transfers_Count
from Driver_Licenses
where county not in ('Pierce', 'King', 'Snohomish') and prior_state != 'Washington' and prior_state != 'Not Applicable'
group by county
order by Transfers_Count desc


-- Which month and year have the most people transferred licenses/ids from out of the state? the least?
-- Answer: The most month/year is 10/2020 with 583 transfers and the least month/year is 5/2020 with 1 transfer

select month, year, count(prior_state) as Num_Transfers
from Driver_Licenses
where prior_state != 'Washington' and prior_state != 'Not Applicable'
group by month, year
order by Num_Transfers desc

---------------------------------------

-- Business Decisions

-- #1 The state of Washington has asked you to provide information on how to reallocate budget for the counties. You are being asked to create a classification system of up to 5 levels that assigns each county by transfer frequency for budget priority. What would that classification system look like? 
select county, count(county) as num_transfers
from Driver_Licenses
where county != 'Unknown'
group by county
order by num_transfers desc

-- #2 The state would like to create a conference for Licensing Agencies to attend. Which two months of the year would be the best to have a conference with the least amount of transfers? 
-- for out of country transfers, the best months are April and May
select month, count(out_of_country_license_transfers) as Num_Transfers
from Driver_Licenses
where out_of_country_license_transfers = '1'
group by month
order by Num_Transfers desc


-- for out of state transfers, the best months are April and May
select month, count(prior_state) as Num_Transfers
from Driver_Licenses
where prior_state != 'Washington' and prior_state != 'Not Applicable'
group by month
order by Num_Transfers desc

-- #3 For the top transfering countries

SELECT distinct Prior_Country, COUNT(*) AS Total_Transfers, county
                    FROM Driver_Licenses
                    WHERE out_of_country_license_transfers = '1'
                    GROUP BY Prior_Country, county
                    ORDER BY Total_Transfers DESC