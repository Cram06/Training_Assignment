insert into admin_table(email, pass) values('pantiamarc@gmail.com', 'HOTDOG');
select * from admin_table

INSERT INTO category (category_name) VALUES ('Electronics');
INSERT INTO category (category_name) VALUES ('Clothes');
INSERT INTO category (category_name) VALUES ('Mask');
INSERT INTO category (category_name) VALUES ('Home Entertainment');

select * from category

SELECT * FROM PRODUCT
INSERT INTO product (
    product_name,
    product_price,
    category_id,
    product_image,
    product_available_qty
) VALUES (
    'Monitor',
    14200.00,
    'C 0000001',
    'monitor.jpg',
    51
);
INSERT INTO product (
    product_name,
    product_price,
    category_id,
    product_image,
    product_available_qty
) VALUES (
    'TVPlus',
    21200.00,
    'C 0000001',
    'tv.jpg',
    51
);

INSERT INTO product (
    product_name,
    product_price,
    category_id,
    product_image,
    product_available_qty
) VALUES (
    'Videoke',
    5000.00,
    'C 0000004',
    'tv.jpg',
    100
);