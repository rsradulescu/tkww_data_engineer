--Shared definition in the challenge instructions

--***************************
-- users table
--***************************

DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT,
    acquisition_date DATE,
    country varchar(30)
);

INSERT INTO users VALUES
(1, '2018-12-05', 'Spain'),
(2, '2018-12-05', 'China'),
(3, '2018-12-06', 'Spain'),
(4, '2018-12-06', 'United States');

--***************************
-- payments table
--***************************

DROP TABLE IF EXISTS payments;
CREATE TABLE payments (
    user_id INT,
    payment_date DATE,
    revenue NUMERIC(16, 6)
);

INSERT INTO payments VALUES
(3, '2018-12-06', 50),
(4, '2018-12-13', 60);