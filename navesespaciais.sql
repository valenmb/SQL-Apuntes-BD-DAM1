DROP SCHEMA IF EXISTS NavesEspaciais;
CREATE SCHEMA IF NOT EXISTS NavesEspaciais;

CREATE TABLE NavesEspaciais.Servizo(
	clave_servizo CHAR(5),
	nome_servizo VARCHAR(30),
	PRIMARY KEY (clave_servizo,nome_servizo)
	);

CREATE TABLE NavesEspaciais.Dependencia(
	codigo_dependencia CHAR(5) PRIMARY KEY,
	nome_dependencia VARCHAR(30) UNIQUE NOT NULL,
	clave_servizo CHAR(5),
	nome_servizo VARCHAR(30),
	funcion VARCHAR(20),
	localizacion VARCHAR(20),
	FOREIGN KEY (clave_servizo,nome_servizo)
	REFERENCES NavesEspaciais.Servizo (clave_servizo,nome_servizo)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	);

CREATE TABLE NavesEspaciais.Camara(
	codigo_dependencia CHAR(5) PRIMARY KEY,
	categoria VARCHAR(30) NOT NULL,
	capacidade integer NOT NULL,
	FOREIGN KEY (codigo_dependencia)
	REFERENCES NavesEspaciais.Dependencia (codigo_dependencia)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	CHECK (capacidade>0)
	);

CREATE TABLE NavesEspaciais.Tripulacion(
	codigo_tripulacion CHAR(5) PRIMARY KEY,
	nome_tripulacion VARCHAR(30),
	categoria VARCHAR(20) NOT NULL,
	antiguidade INTEGER DEFAULT 0,
	procedencia CHAR(20),
	adm CHAR(20) NOT NULL,
	codigo_dependencia CHAR(5) NOT NULL,
	codigo_camara CHAR(5) NOT NULL,
	FOREIGN KEY (codigo_dependencia)
	REFERENCES NavesEspaciais.Dependencia (codigo_dependencia)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (codigo_camara)
	REFERENCES NavesEspaciais.Camara (codigo_dependencia)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	);

CREATE TABLE NavesEspaciais.Planeta(
	codigo_planeta CHAR(5) PRIMARY KEY,
	nome_planeta VARCHAR(30) NOT NULL UNIQUE,
	galaxia CHAR(15) NOT NULL,
	coordenadas CHAR(15) NOT NULL UNIQUE
	);

CREATE TABLE NavesEspaciais.Visita(
	codigo_tripulacion CHAR(5),
	codigo_planeta CHAR(5),
	data_visita DATE,
	tempo INTEGER NOT NULL,
	PRIMARY KEY (codigo_tripulacion,codigo_planeta,data_visita),
	FOREIGN KEY (codigo_tripulacion)
	REFERENCES NavesEspaciais.Tripulacion (codigo_tripulacion)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (codigo_planeta)
	REFERENCES NavesEspaciais.Planeta (codigo_planeta)
	ON DELETE CASCADE
	ON UPDATE CASCADE
);


CREATE TABLE NavesEspaciais.Raza(
	nome_raza VARCHAR(30) PRIMARY KEY,
	altura INTEGER NOT NULL,
	anchura INTEGER NOT NULL,
	peso INTEGER NOT NULL,
	poboacion INTEGER NOT NULL
	);

CREATE TABLE NavesEspaciais.Habita(
	codigo_planeta CHAR(5),
	nome_raza VARCHAR(30),
	poboacion_parcial INTEGER NOT NULL,
	PRIMARY KEY (codigo_planeta,nome_raza),
	FOREIGN KEY (codigo_planeta)
	REFERENCES NavesEspaciais.Planeta (codigo_planeta)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (nome_raza)
	REFERENCES NavesEspaciais.Raza (nome_raza)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	);
