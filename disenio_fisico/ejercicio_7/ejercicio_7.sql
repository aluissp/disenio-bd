DROP DATABASE IF EXISTS ejercicio_7;

CREATE DATABASE ejercicio_7;

USE ejercicio_7;

CREATE TABLE users(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  lastname VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL
);

CREATE TABLE accounts(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED NOT NULL,
  name VARCHAR(255) NOT NULL,
  balance DECIMAL(12, 2) NOT NULL,
  description VARCHAR(255) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE coporate_accounts(
  account_id INT UNSIGNED PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  tax_id VARCHAR(255) NOT NULL UNIQUE,
  FOREIGN KEY (account_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE transfers(
  from_account_id INT UNSIGNED NOT NULL,
  to_account_id INT UNSIGNED NOT NULL,
  amount DECIMAL(12, 2) NOT NULL,
  state ENUM("PAYED", "REFUNDED"),
  `date` DATETIME NOT NULL,
  FOREIGN KEY (from_account_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (to_account_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE bank_accounts(
  id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  number VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE bank_account_associations (
  account_id INT UNSIGNED NOT NULL,
  bank_account_id INT UNSIGNED NOT NULL,
  PRIMARY KEY(account_id, bank_account_id),
  FOREIGN KEY (account_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE CASCADE,
  FOREIGN KEY (bank_account_id) REFERENCES bank_accounts(id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE bank_transfers(
  account_id INT UNSIGNED NOT NULL,
  bank_id INT UNSIGNED NOT NULL,
  transfers_direction ENUM("INCOMING", "OUTGOING") NOT NULL,
  start_date DATETIME NOT NULL,
  end_date DATETIME NOT NULL,
  state ENUM("PROCESANDO", "COMPLETADA", "CANCELADA") NOT NULL,
  amount DECIMAL(12, 2) NOT NULL,
  FOREIGN KEY (account_id) REFERENCES accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT,
  FOREIGN KEY (bank_id) REFERENCES bank_accounts(id) ON UPDATE CASCADE ON DELETE RESTRICT
);