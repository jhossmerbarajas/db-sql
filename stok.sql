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

ALTER TABLE users ADD rol_id INT NOT NULL


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
	name VARCHAR(50) NOT NULL,
	user_id INT,
	CONSTRAINT Fk_user_category FOREIGN KEY (user_id) REFERENCES users (id)
);


CREATE TABLE products (
	id INT PRIMARY KEY IDENTITY,
	price FLOAT NOT NULL,
	year INT NOT NULL,
	quantity INT NOT NULL
);


-- Modificar table productos para agregar clave foranea y relacionarla con la categoria
ALTER TABLE products ADD category_id INT NOT NULL;

ALTER TABLE products ADD CONSTRAINT Fk_category_product
FOREIGN KEY (category_id) 
REFERENCES category (id)


-- Se vuelve a modificar la table producto para agregar una clave foranea 
-- para saber qué usuario ingreso el producto

ALTER TABLE products ADD user_id INT NOT NULL;

ALTER TABLE products ADD CONSTRAINT Fk_user_product
FOREIGN KEY (user_id) REFERENCES users (id)



-- ROLES Y PERMISOS


-- Selects ROLES
SELECT * FROM roles


-- Inserts ROLES
INSERT INTO roles VALUES ('admin')
INSERT INTO roles VALUES ('user')



-- Selects PERMISOS
SELECT * FROM permisos

-- Insert PERMISOS
INSERT INTO permisos VALUES ('create', 1)
INSERT INTO permisos VALUES ('read', 1)
INSERT INTO permisos VALUES ('update', 1)
INSERT INTO permisos VALUES ('delete', 1)

INSERT INTO permisos VALUES ('read', 2)
INSERT INTO permisos VALUES ('update', 2)

SELECT r.name, p.name
FROM roles AS r
LEFT JOIN permisos AS p
ON r.id = p.rol_id



-- ROLES Y USUARIOS
-- Insert

INSERT INTO users VALUES ('jdavid', 'jdavid@gmail.com', 'jdavid', 1)
INSERT INTO users VALUES ('joe', 'joe@gmail.com', 'joe', 2)
INSERT INTO users VALUES ('luz', 'luz@gmail.com', 'luz', 2)
INSERT INTO users VALUES ('maria', 'maria@gmail.com', 'maria', 2)
INSERT INTO users VALUES ('jhon', 'jhon@gmail.com', 'jhon', 2)
INSERT INTO users VALUES ('david', 'david@gmail.com', 'david', 1)


SELECT * FROM users

SELECT u.id, u.name, u.email, r.name, p.name
FROM roles AS r
JOIN users AS u ON r.id = u.rol_id
JOIN permisos AS p ON r.id = p.rol_id


-- CATEGORY USER
ALTER TABLE category ADD user_id INT
ALTER TABLE category ADD FOREIGN KEY (user_id) REFERENCES users(id)

INSERT INTO category VALUES ('Hogar' 1);
INSERT INTO category VALUES ('Computadoras' 1);
INSERT INTO category VALUES ('Belleza', 6);
INSERT INTO category VALUES ('Salud', 6);
INSERT INTO category VALUES ('Mascotas' 1);
INSERT INTO category VALUES ('Juegos' 1);
INSERT INTO category VALUES ('Videojuegos', 6);

SELECT u.name, c.name
FROM users AS u
JOIN category AS c
ON u.id = c.user_id


SELECT u.id, u.name, c.name, r.name
FROM category AS c
JOIN users AS u ON c.user_id = u.id
JOIN roles AS r ON r.id = u.rol_id
WHERE u.id = 1


-- CREACION DE TABLA DE MARCA Y MODELO
CREATE TABLE marcas (
	id IDENTITY INT PRIMARY KEY,
	name VARCHAR(50) NOT NULL
	category_id INT,
	FOREIGN KEY (category_id) REFERENCES category (id)
);

CREATE TABLE models (
	id INT PRIMARY KEY IDENTITY,
	model VARCHAR(50) NOT NULL,
	description VARCHAR(100),
	FOREIGN KEY (marca_id) REFERENCES marcas (id)
);

-- insersión de datos en marcas y models
INSERT INTO marcas VALUES ('Siragon', 2)
INSERT INTO marcas VALUES ('Wendy', 3)
INSERT INTO marcas VALUES ('Regina', 1)


INSERT INTO models VALUES ('Laptop', 11, 'Disco duro de 500GB SSD')
INSERT INTO models VALUES ('Polvo Compacto', 12, 'Color de tonos')
INSERT INTO models VALUES ('Nevera', 13, 'Tiene dos puertas. Además de congelador incluido')
INSERT INTO models VALUES ('Camaro', 14, 'descripcion del motor y caja')
INSERT INTO models VALUES ('Aveo', 14, 'descripcion del carro')
INSERT INTO models VALUES ('Mustang', 15, 'descripcion del carro')


-- Modificar tabla products para relacionarla con Marcas
-- Eliminaciòn de dos campos
ALTER TABLE products ADD marca_id INT

ALTER TABLE products ADD CONSTRAINT Fk_marca_product
FOREIGN KEY (marca_id) REFERENCES marcas (id)



SELECT mc.name, md.name, md.description
FROM marcas AS mc
JOIN models AS md ON mc.id = md.marca_id


--insersión de datos 
-- 							 precio  año  cant cat marc  mod
INSERT INTO products VALUES (110.00, 2020, 20,  2,  1, 	  2)
INSERT INTO products VALUES (210.00, 2020, 15,  1,  3,    6)
INSERT INTO products VALUES (150.30, 2022, 18,  3,  2,    4)
INSERT INTO products VALUES (800.00, 2023, 8,   2,  4,    8)


SELECT ct.name, mc.name, md.model, md.description, p.price, p.quantity, p.year
FROM products AS p
JOIN marcas AS mc ON p.marca_id = mc.id
JOIN models AS md ON p.model_id = md.id
JOIN category AS ct ON p.category_id = ct.id



-- Actualizacion de productos
UPDATE products SET year = '2018' WHERE id = 4

UPDATE products 
SET 
price = 90,
year = 2018  
WHERE id = 1


-- Actualizar roles de usuarios
UPDATE users SET rol_id = 2 WHERE id = 6


-- Eliminar una categoria

-- Para eliminar una categoría, se deben tener en cuenta todas las relaciones. Al momento de crear las tablas y las relaciones
-- no se crearon los ACTION, entonces, no se puede eliminar una categoria si esta relacionada con una marca.
-- Una marca no se puede eliminar si esta relacionada con un modelo y un modelo no se puede eliminar si está relacionado
-- con producto.

-- Ejemplo para eliminar una categoria

select * from marcas
select * from models
select * from products

DELETE FROM products WHERE model_id = 4
DELETE FROM models WHERE marca_id = 2
DELETE FROM marcas WHERE id = 2
DELETE FROM category WHERE id = 3


-- Tomando este ejemplo, se debe hacer lo mismo con la relacion rol - users