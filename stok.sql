-- La cláusula PRIMARY KEY (Llave primaria) se utiliza para definir la clave principal de la tabla. 
-- Las columnas que forman la clave principal no pueden contener valores nulos ni pueden haber 
-- valores duplicados de la combinación de columnas.

-- La cláusula FOREIGN KEY: Una clave foránea es una columna o conjunto de columnas que contiene 
-- un valor que hace referencia a una fila de otra tabla.


CREATE DATABASE stock;
USE stock;

CREATE TABLE users (
	id INT IDENTITY NOT NULL PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	password VARCHAR (255) NOT NULL
);


CREATE TABLE roles (
	id INT PRIMARY KEY IDENTITY NOT NULL,
	name VARCHAR (50) NOT NULL
);


ALTER TABLE users ADD FOREIGN KEY (rol_id) 
REFERENCES roles (id)
ON DELETE SET NULL;


CREATE TABLE permisos (
	id INT IDENTITY PRIMARY KEY,
	name VARCHAR (40) NOT NULL,
	rol_id INT,
	FOREIGN KEY (rol_id) REFERENCES roles (id)
);



CREATE TABLE category (
	id INT IDENTITY PRIMARY KEY,
	name VARCHAR(50) NOT NULL
);


CREATE TABLE products (
	id INT PRIMARY KEY IDENTITY,
	name VARCHAR (50) NOT NULL,
	description VARCHAR (100) NOT NULL,
	price FLOAT NOT NULL,
	year INT NOT NULL
);


-- Modificar table productos para agregar clave foranea y relacionarla con la categoria
ALTER TABLE products ADD category_id INT NOT NULL;

ALTER TABLE products ADD CONSTRAINT Fk_category 
FOREIGN KEY (category_id) 
REFERENCES category (id)


-- Se vuelve a modificar la table producto para agregar una clave foranea 
-- para saber qué usuario ingreso el producto

ALTER TABLE products ADD user_id INT NOT NULL;

ALTER TABLE products ADD CONSTRAINT Fk_user 
FOREIGN KEY (user_id) REFERENCES users (id)