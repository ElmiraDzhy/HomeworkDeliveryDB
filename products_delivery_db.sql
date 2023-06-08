CREATE TABLE products
(
    id    serial PRIMARY KEY,
    name  varchar(300) NOT NULL CHECK ( name != '' ),
    price numeric      NOT NULL CHECK ( price > 0 )
);

CREATE TABLE clients
(
    id           serial PRIMARY KEY,
    name         varchar(300) NOT NULL CHECK ( name != '' ),
    address      jsonb NOT NULL,
    phone_number varchar(20)  NOT NULL
);

CREATE TABLE invoices
(
    id         serial PRIMARY KEY,
    client_id  int REFERENCES clients (id),
    created_at timestamp NOT NULL DEFAULT current_timestamp
);

CREATE TABLE orders
(
    id         serial PRIMARY KEY,
    product_id int REFERENCES products (id),
    invoice_id int REFERENCES invoices (id) UNIQUE,
    quantity   int NOT NULL DEFAULT 1
);

CREATE TABLE shipments
(
    id         serial PRIMARY KEY,
    created_at timestamp NOT NULL DEFAULT current_timestamp

);

ALTER TABLE invoices
    ADD COLUMN order_id int REFERENCES orders (id); -- for 1:1 relation


CREATE TABLE orders_to_shipments
(
    order_id              int REFERENCES orders (id),
    shipment_id           int REFERENCES shipments (id),
    quantity_for_shipment int NOT NULL,
    PRIMARY KEY (order_id, shipment_id)
);