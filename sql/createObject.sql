CREATE TABLE USER_TABLE (
user_id VARCHAR(20)PRIMARY KEY,
user_name VARCHAR(23),
email VARCHAR(23)CONSTRAINT checkemail CHECK(EMAIL LIKE '%@%'),
pass VARCHAR(23),
date_of_reg DATE,
address VARCHAR(100),
contact_no VARCHAR(11)
)
drop table user_table
alter 
CREATE SEQUENCE user_id_seq;

CREATE OR REPLACE TRIGGER user_trigger
    BEFORE INSERT
    ON USER_TABLE
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.user_id IS NULL THEN
        SELECT 'U'||TO_CHAR(user_id_seq.NEXTVAL,'0000000') INTO :NEW.user_id FROM DUAL;
    END IF;
END;

create table admin_table (
admin_id VARCHAR(20) PRIMARY KEY,
email varchar(23) CONSTRAINT checkemailadmin CHECK(EMAIL LIKE '%@%'),
pass varchar(23)
);
drop table admin_table
drop SEQUENCE admin_id_seq
drop TRIGGER admin_trigger
CREATE SEQUENCE admin_id_seq;

CREATE OR REPLACE TRIGGER admin_trigger
    BEFORE INSERT
    ON admin_table
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.admin_id IS NULL THEN
        SELECT 'A'||TO_CHAR(admin_id_seq.NEXTVAL,'0000000') INTO :NEW.admin_id FROM DUAL;
    END IF;
END;

create table category (
category_id varchar(7) PRIMARY KEY,
category_name varchar(23)
)

CREATE SEQUENCE category_id_seq;

CREATE OR REPLACE TRIGGER category_trigger
    BEFORE INSERT
    ON category
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.category_id IS NULL THEN
        SELECT 'C'||TO_CHAR(category_id_seq.NEXTVAL,'0000000') INTO :NEW.category_id FROM DUAL;
    END IF;
END; 

create table product (
product_id varchar(7) PRIMARY KEY,
product_name varchar(23),
category_id varchar(7) REFERENCES CATEGORY(category_id),
product_price number(8,2),
product_image varchar2(23),
product_available_qty number
)

CREATE SEQUENCE product_id_seq;

CREATE OR REPLACE TRIGGER product_trigger
    BEFORE INSERT
    ON PRODUCT 
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.product_id IS NULL THEN
        SELECT 'P'||TO_CHAR(product_id_seq.NEXTVAL,'0000000') INTO :NEW.product_id FROM DUAL;
    END IF;
END; 

create table cart (
cart_id varchar(7) PRIMARY KEY,
user_id varchar(7) REFERENCES USER_TABLE(user_id)
)
drop table cart

CREATE SEQUENCE cart_id_seq;

CREATE OR REPLACE TRIGGER cart_trigger
    BEFORE INSERT
    ON CART 
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.cart_id IS NULL THEN
        SELECT 'T'||TO_CHAR(cart_id_seq.NEXTVAL,'0000000') INTO :NEW.cart_id FROM DUAL;
    END IF;
END; 

create table cart_items (
cart_items_id varchar(7) PRIMARY KEY,
cart_id varchar(7) REFERENCES cart(cart_id),
user_id varchar(7) REFERENCES USER_TABLE(user_id),
product_id varchar(7) REFERENCES product(product_id),
product_qty varchar(5)
)

CREATE SEQUENCE cart_items_id_seq;

CREATE OR REPLACE TRIGGER cart_items_id_trigger
    BEFORE INSERT
    ON cart_items
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.cart_items_id IS NULL THEN
        SELECT 'I'||TO_CHAR(cart_items_id_seq.NEXTVAL,'0000000') INTO :NEW.cart_items_id FROM DUAL;
    END IF;
END; 

create table coupon (
coupon_id varchar(7) PRIMARY KEY,
coupon_name varchar(23),
discount_val number,
exp_date date
)

CREATE SEQUENCE coupon_id_seq;

CREATE OR REPLACE TRIGGER coupon_trigger
    BEFORE INSERT
    ON coupon 
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.coupon_id IS NULL THEN
        SELECT 'CC'||TO_CHAR(coupon_id_seq.NEXTVAL,'0000000') INTO :NEW.coupon_id FROM DUAL;
    END IF;
END; 

CREATE TABLE order_table (
order_id VARCHAR(7)PRIMARY KEY,
cart_id VARCHAR(7)REFERENCES CART(CART_ID),
user_id VARCHAR(7)REFERENCES USER_TABLE(USER_ID),
order_date DATE DEFAULT SYSDATE NOT NULL,
delivery_date DATE DEFAULT SYSDATE + 7,
coupon_id VARCHAR(7),
bill_amount NUMBER,
payment_method VARCHAR(23) CONSTRAINT PM_CHECK CHECK(LOWER(PAYMENT_METHOD)IN('cod', 'debit/credit card', 'online wallet'))
)

CREATE SEQUENCE order_id_seq;

CREATE OR REPLACE TRIGGER order_trigger
    BEFORE INSERT
    ON order_table 
    REFERENCING NEW AS NEW OLD AS OLD
    FOR EACH ROW
BEGIN
    IF :NEW.order_id IS NULL THEN
        SELECT 'O'||TO_CHAR(order_id_seq.NEXTVAL,'0000000') INTO :NEW.order_id FROM DUAL;
    END IF;
END; 

insert into ADMIN(email, pass) values('pantiamarc@gmail.com', '1234567');