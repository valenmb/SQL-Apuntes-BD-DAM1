DROP SCHEMA IF EXISTS Investigacion;
CREATE SCHEMA IF NOT EXISTS Investigacion;

CREATE TABLE Investigacion.Sede(
	nome_sede VARCHAR(30) PRIMARY KEY,
	campus VARCHAR(30) NOT NULL
	);

CREATE TABLE Investigacion.Departamento(
	nome_departamento VARCHAR(30) PRIMARY KEY,
	telefono CHAR(9) NOT NULL,
	director CHAR(9)
	);

CREATE TABLE Investigacion.Ubicacion(
	nome_sede VARCHAR(30),
	nome_departamento VARCHAR(30),
	PRIMARY KEY (nome_sede,nome_departamento),
	FOREIGN KEY (nome_sede)
	REFERENCES Investigacion.Sede (nome_sede)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (nome_departamento)
	REFERENCES Investigacion.Departamento (nome_departamento)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	);
CREATE TABLE Investigacion.Grupo(
	nome_grupo VARCHAR(30),
	nome_departamento VARCHAR(30),
	area VARCHAR(30) NOT NULL,
	lider CHAR(9),
	CONSTRAINT PK_Grupo
		PRIMARY KEY (nome_grupo,nome_departamento),
	CONSTRAINT FK_Departamento_Grupo
		FOREIGN KEY (nome_departamento)
		REFERENCES Investigacion.Departamento (nome_departamento)
		ON DELETE CASCADE
		ON UPDATE CASCADE
	);	

CREATE TABLE Investigacion.Profesor(
	dni CHAR(9) PRIMARY KEY,
	nome_profesor VARCHAR(30) NOT NULL,
	titulacion VARCHAR(30) NOT NULL,
	experiencia integer,
	n_grupo VARCHAR(30),
	n_departamento VARCHAR(30),
	FOREIGN KEY (n_grupo,n_departamento) REFERENCES Investigacion.Grupo (nome_grupo,nome_departamento)
	ON DELETE SET NULL
	ON UPDATE CASCADE
	);

ALTER TABLE Investigacion.Departamento
	ADD CONSTRAINT FK_Profesor_Departamento
		FOREIGN KEY (director) REFERENCES Investigacion.Profesor (dni)
		ON DELETE SET NULL
		ON UPDATE CASCADE;

ALTER TABLE Investigacion.Grupo
	ADD CONSTRAINT FK_Profesor_Grupo
		FOREIGN KEY (lider) REFERENCES Investigacion.Profesor (dni)
		ON DELETE SET NULL
		ON UPDATE CASCADE;

CREATE TABLE Investigacion.Proxecto(
	codigo_proxecto CHAR(5) PRIMARY KEY,
	nome_proxecto VARCHAR(30) UNIQUE NOT NULL,
	orzamento DECIMAL NOT NULL,
	data_inicio DATE NOT NULL,
	data_fin DATE,
	nome_grupo VARCHAR(30),
	nome_departamento VARCHAR(30),
	FOREIGN KEY (nome_grupo,nome_departamento)
	REFERENCES Investigacion.Grupo (nome_grupo,nome_departamento)
	ON DELETE SET NULL
	ON UPDATE CASCADE,
	CHECK (data_inicio<data_fin)
	);

CREATE TABLE Investigacion.Participa(
	dni CHAR(9),
	codigo_proxecto CHAR(5),
	data_inicio DATE NOT NULL,
	data_fin DATE,
	dedicacion INTEGER NOT NULL,
	PRIMARY KEY (dni,codigo_proxecto),
	FOREIGN KEY (dni)
	REFERENCES Investigacion.Profesor (dni)
	ON DELETE NO ACTION
	ON UPDATE CASCADE,
	FOREIGN KEY (codigo_proxecto)
	REFERENCES Investigacion.Proxecto (codigo_proxecto)
	ON DELETE NO ACTION
	ON UPDATE CASCADE
	);

CREATE TABLE Investigacion.Programa(
	nome_programa VARCHAR(30) PRIMARY KEY
	);
CREATE TABLE Investigacion.Financia(
	nome_programa VARCHAR(30),
	codigo_proxecto CHAR(5),
	numero_proxecto INTEGER NOT NULL,
	cantidade_financiada DECIMAL NOT NULL,
	PRIMARY KEY (nome_programa,codigo_proxecto),
	FOREIGN KEY (nome_programa)
	REFERENCES Investigacion.Programa (nome_programa)
	ON DELETE CASCADE
	ON UPDATE CASCADE,
	FOREIGN KEY (codigo_proxecto)
	REFERENCES Investigacion.Proxecto (codigo_proxecto)
	ON DELETE CASCADE
	ON UPDATE CASCADE
	);
