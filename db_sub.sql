-- db sub setup 

CREATE SCHEMA inventory;

----------------------------------------------------------
-- Table customers
----------------------------------------------------------

CREATE TABLE "inventory"."customers" (
    "id" integer NOT NULL primary key,
    "first_name" character varying(255) NOT NULL,
    "last_name" character varying(255) NOT NULL,
    "email" character varying(255) NOT NULL
);

ALTER TABLE customers ADD bitmask integer; 


-- 1. Fonction de trigger
CREATE OR REPLACE FUNCTION set_bitmask_on_customers()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.last_name = 'Thomas' THEN
        NEW.bitmask := 1;
    ELSIF NEW.last_name = 'Anderson' THEN
        NEW.bitmask := 2;
    ELSE
        NEW.bitmask := 3;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Trigger associé (avant INSERT et UPDATE)
CREATE TRIGGER trg_set_bitmask
BEFORE INSERT OR UPDATE ON customers
FOR EACH ROW
EXECUTE FUNCTION set_bitmask_on_customers();



----------------------------------------------------------
-- Table products
----------------------------------------------------------

CREATE TABLE "inventory"."products" (
    "id" integer NOT NULL primary key,
    "name" character varying(255),
    "weight" double precision NULL,
    "bitmask" integer
);

-- 1. Fonction de trigger
CREATE OR REPLACE FUNCTION set_bitmask_on_product()
RETURNS TRIGGER AS $$
BEGIN
  IF NEW.weight IS NULL THEN
    NEW.bitmask := NULL;
  ELSIF NEW.weight < 1 THEN
    NEW.bitmask := 1;
  ELSIF NEW.weight < 10 THEN
    NEW.bitmask := 10;
  ELSE
    NEW.bitmask := 100;
  END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2. Trigger associé (avant INSERT et UPDATE)
CREATE TRIGGER trg_set_bitmask_products
BEFORE INSERT OR UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION set_bitmask_on_product();



----------------------------------------------------------
-- Table Order
----------------------------------------------------------

CREATE TABLE "inventory"."orders" (
    "id" integer NOT NULL primary key,
    "order_date" date,
    "purchaser" integer,
    "product_id" integer,
    "bitmask" integer
);

ALTER TABLE orders ADD bitmask integer; 

-- 1. Fonction de trigger
CREATE OR REPLACE FUNCTION set_bitmask_on_order()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.order_date < 16800 THEN
        NEW.bitmask := 1;
    ELSIF NEW.order_date < 18261 THEN
        NEW.bitmask := 2;
    ELSIF NEW.order_date < 20088 THEN
        NEW.bitmask := 2;
    ELSE
        NEW.bitmask := 3;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 2015-12-31 => 16800
-- 2019-12-31 => 18261
-- 2024-12-31 => 20088


-- 2. Trigger associé (avant INSERT et UPDATE)
CREATE TRIGGER trg_set_bitmask_order
BEFORE INSERT OR UPDATE ON orders
FOR EACH ROW
EXECUTE FUNCTION set_bitmask_on_order();
