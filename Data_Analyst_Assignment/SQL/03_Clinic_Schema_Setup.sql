-- clinics
CREATE TABLE clinics (
  cid VARCHAR(50) PRIMARY KEY,
  clinic_name VARCHAR(100),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50)
);

INSERT INTO
  clinics (cid, clinic_name, city, state, country)
VALUES
  (
    'c-001',
    'XYZ Clinic',
    'CityA',
    'StateA',
    'CountryA'
  ),
  (
    'c-002',
    'ABC Clinic',
    'CityB',
    'StateB',
    'CountryA'
  ),
  (
    'c-003',
    'PQR Clinic',
    'CityA',
    'StateA',
    'CountryA'
  );

-- customer
CREATE TABLE customer (
  uid VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100),
  mobile VARCHAR(20)
);

INSERT INTO
  customer (uid, name, mobile)
VALUES
  ('u-001', 'Jon Doe', '97XXXXXXXX'),
  ('u-002', 'Alice', '98XXXXXXXX'),
  ('u-003', 'Ruthvik', '79XXXXXXXX');

-- clinic_sales
CREATE TABLE clinic_sales (
  oid VARCHAR(50) PRIMARY KEY,
  uid VARCHAR(50) NOT NULL,
  cid VARCHAR(50) NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  datetime DATETIME NOT NULL,
  sales_channel VARCHAR(50),
  FOREIGN KEY (uid) REFERENCES customer(uid),
  FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO
  clinic_sales (oid, uid, cid, amount, datetime, sales_channel)
VALUES
  (
    'cs-001',
    'u-001',
    'c-001',
    2500,
    '2021-09-23 12:03:22',
    'online'
  ),
  (
    'cs-002',
    'u-002',
    'c-001',
    1500,
    '2021-09-24 09:15:00',
    'offline'
  ),
  (
    'cs-003',
    'u-003',
    'c-002',
    3000,
    '2021-09-25 11:30:00',
    'online'
  ),
  (
    'cs-004',
    'u-001',
    'c-003',
    1200,
    '2021-10-05 14:20:00',
    'offline'
  );

-- expenses
CREATE TABLE expenses (
  eid VARCHAR(50) PRIMARY KEY,
  cid VARCHAR(50) NOT NULL,
  description VARCHAR(100),
  amount DECIMAL(10, 2) NOT NULL,
  datetime DATETIME NOT NULL,
  FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO
  expenses (eid, cid, description, amount, datetime)
VALUES
  (
    'ex-001',
    'c-001',
    'First-aid supplies',
    500,
    '2021-09-23 07:36:48'
  ),
  (
    'ex-002',
    'c-001',
    'Medicines',
    700,
    '2021-09-24 08:20:00'
  ),
  (
    'ex-003',
    'c-002',
    'Lab equipment',
    1200,
    '2021-09-25 10:00:00'
  ),
  (
    'ex-004',
    'c-003',
    'Medicines',
    400,
    '2021-10-05 13:00:00'
  );