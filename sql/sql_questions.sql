--************************************************
-- 1)Acquisition by date?
-- The query shows the acquisition date and the count per day, in descending order.
CREATE VIEW vw_acquisition_by_date AS
(
	SELECT 
		acquisition_date AS acquisition_date,
		COUNT (*) AS acquisition
	FROM 
		public.users
	GROUP BY	
		acquisition_date
	ORDER BY 
		acquisition_date desc
)

--************************************************
-- 2)Revenue by country?
-- The query shows the payment revenue and sum per country, with 2 digit, ordered by revenue.
CREATE VIEW vw_revenue_by_country AS
(
	SELECT 
		u.country,
		ROUND(SUM(p.revenue),2) AS revenue
	FROM 
		public.users u JOIN public.payments p
		ON u.user_id = p.user_id
	GROUP BY	
		u.country
	ORDER BY 
		revenue desc
)
--************************************************
-- 3) Acquisition and revenue by country?
-- Expected result columns: country, acquisition, revenue.
SELECT 
	u.country,
	COALESCE(rbc.revenue,0) AS revenue,
	COUNT(u.acquisition_date) AS acquisition
FROM 
	public.users u LEFT JOIN vw_revenue_by_country rbc
	ON u.country = rbc.country
GROUP BY
	u.country,
	rbc.revenue

--************************************************
--4) Countries without any revenue?
-- View country created. Get all the countries not in revenue_by_country
CREATE VIEW vw_countries AS 
(
	SELECT
		DISTINCT country
	FROM
		public.users
)
SELECT 
	country
FROM 
	vw_countries vwc
WHERE 
	vwc.country NOT IN (SELECT country FROM vw_revenue_by_country)
	
--************************************************
-- 5) Country with the highest revenue?
--Get the MAX revenue, and show the country name that match. One record only.

SELECT
	country
FROM
	vw_revenue_by_country vm_r
WHERE 
	vm_r.revenue = (SELECT MAX(revenue) FROM vw_revenue_by_country)

--************************************************
-- 6) Share of revenue by country?
-- Revenue_share: percentage of revenue that came from countries

SELECT
    vw_rc.country,
	--SUM(SUM(vw_rc.revenue)) OVER () AS total_revenue,
	ROUND(SUM(vw_rc.revenue) / SUM(SUM(vw_rc.revenue)) OVER (), 4) AS revenue_share
FROM 
	vw_revenue_by_country vw_rc
GROUP BY
	vw_rc.country
	
--************************************************
--7) Acquisition and revenue by date?
-- For this query I started creating a view with all the possible dates on users and payments tables. 
-- From here I compare this dates with the view acquisition_by_date and with CTE payments_by_date. 
-- Use COALESCE in the caswe the result is null.
-- Expected result columns: date, acquisition, revenue.
WITH dates_table AS
(
	SELECT
		DISTINCT payment_date AS date
	FROM
		payments
	UNION
	SELECT
		DISTINCT acquisition_date AS date
	FROM
		users
	ORDER BY date
), revenue_by_date AS
(
	SELECT 
		payment_date,
		SUM(revenue) AS revenue_date
	FROM 
		payments
	GROUP BY	
		payment_date
)
SELECT 
	dt.date AS date, 
	COALESCE(vw_ad.acquisition,0) AS acquisition, 
	COALESCE(rbd.revenue_date,0) AS revenue
FROM
	dates_table dt
	LEFT JOIN vw_acquisition_by_date vw_ad ON dt.date = vw_ad.acquisition_date
	LEFT JOIN revenue_by_date rbd ON dt.date = rbd.payment_date
	