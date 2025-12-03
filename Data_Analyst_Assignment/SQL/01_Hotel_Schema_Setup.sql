-- users
CREATE TABLE users (
  user_id VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  phone_number VARCHAR(20),
  mail_id VARCHAR(100),
  billing_address VARCHAR(200)
);

INSERT INTO
  users (
    user_id,
    name,
    phone_number,
    mail_id,
    billing_address
  )
VALUES
  (
    'u-001',
    'John Doe',
    '97XXXXXXXX',
    'john.doe@example.com',
    'Mumbai, Maharastra'
  ),
  (
    'u-002',
    'Sadhwini',
    '98XXXXXXXX',
    'sadhwini.m@example.com',
    'Hyderabad, Telangana'
  ),
  (
    'u-003',
    'Ruthvik',
    '79XXXXXXXX',
    'ruthvik.a@example.com',
    'Hyderabad, Telangana'
  );

-- bookings
CREATE TABLE bookings (
  booking_id VARCHAR(50) PRIMARY KEY,
  booking_date DATETIME NOT NULL,
  room_no VARCHAR(50) NOT NULL,
  user_id VARCHAR(50) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

INSERT INTO
  bookings (booking_id, booking_date, room_no, user_id)
VALUES
  (
    'bk-001',
    '2021-09-23 07:36:48',
    'rm-101',
    'u-001'
  ),
  (
    'bk-002',
    '2021-11-10 14:22:30',
    'rm-102',
    'u-002'
  ),
  (
    'bk-003',
    '2021-11-10 14:15:10',
    'rm-103',
    'u-003'
  );

-- items
CREATE TABLE items (
  item_id VARCHAR(50) PRIMARY KEY,
  item_name VARCHAR(100) NOT NULL,
  item_rate DECIMAL(10, 2) NOT NULL
);

INSERT INTO
  items (item_id, item_name, item_rate)
VALUES
  ('itm-001', 'Tawa Paratha', 18),
  ('itm-002', 'Mix Veg', 89),
  ('itm-003', 'Paneer Butter Masala', 120),
  ('itm-004', 'Chicken Curry', 150);

-- booking_commercials
CREATE TABLE booking_commercials (
  id VARCHAR(50) PRIMARY KEY,
  booking_id VARCHAR(50) NOT NULL,
  bill_id VARCHAR(50) NOT NULL,
  bill_date DATETIME NOT NULL,
  item_id VARCHAR(50) NOT NULL,
  item_quantity DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
  FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO
  booking_commercials (
    id,
    booking_id,
    bill_id,
    bill_date,
    item_id,
    item_quantity
  )
VALUES
  (
    'bc-001',
    'bk-001',
    'bl-001',
    '2021-09-23 12:03:22',
    'itm-001',
    3
  ),
  (
    'bc-002',
    'bk-001',
    'bl-001',
    '2021-09-23 12:03:22',
    'itm-002',
    1
  ),
  (
    'bc-003',
    'bk-002',
    'bl-002',
    '2021-11-10 12:05:37',
    'itm-003',
    0.5
  ),
  (
    'bc-004',
    'bk-003',
    'bl-003',
    '2021-11-10 15:20:10',
    'itm-004',
    2
  );