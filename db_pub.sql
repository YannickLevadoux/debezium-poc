SELECT * FROM customers;
UPDATE customers SET first_name='Anne Marie' WHERE id=1004;

INSERT INTO customers (first_name, last_name, email) VALUES ('Sarah', 'Thompson', 'kitt@acme.com');
INSERT INTO customers (first_name, last_name, email) VALUES ('Kenneth', 'Anderson', 'kander@acme.com');

INSERT INTO customers (first_name, last_name, email) VALUES ('Sarah', 'Thompson', 'kit2t@acme.com');
INSERT INTO customers (first_name, last_name, email) VALUES ('Kenneth', 'Anderson', 'kander2@acme.com');


DELETE FROM customers WHERE id=1005;





CREATE TABLE cars (
  id SERIAL PRIMARY KEY,
  brand VARCHAR(255),
  model VARCHAR(255),
  year INT
);

-- si pas de clé primaire, la clé dans kafka sera null

INSERT INTO cars (brand, model, year) VALUES ('Ford', 'Mustang', 1964); 
INSERT INTO cars (brand, model, year) VALUES ('Peugeot', '205', 1988); 


ALTER TABLE cars ADD color VARCHAR(255); 
INSERT INTO cars (brand, model, year, color) VALUES ('Peugeot', '205', 1989, 'blue'); 
UPDATE cars SET color = 'red' WHERE id = 1;



