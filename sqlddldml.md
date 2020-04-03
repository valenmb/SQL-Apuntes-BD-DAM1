# APUNTES DDL Y DML
-  [DDL](#ddl)
	- [CREATE](#create)
		- [CREAR UNA BASE DE DATOS](#crear-una-base-de-datos)
		- [CREAR UNA TABLA](#crear-una-tabla)
			- [TIPOS DE DATOS](#tipos-de-datos)
	- [CONSTRAINTS](#constraints)
		- [PRIMARY KEY](#primary-key)
		- [FOREIGN KEY](#foreign-key)
			- [BORRADO Y ACTUALIZACIÓN](#borrado-y-actualizacion)
			- [MATCH FULL Y MATCH PARTIAL](#match-full-y-match-partial)
		- [UNIQUE](#unique)
		- [CHECK](#check)
			- [DEFERRABLE](#deferrable)
		- [NOT NULL](#not-null)
	- [DROP](#drop)
		- [BORRAR UNA BASE DE DATOS](#borrar-una-base-de-datos)
		- [BORRAR UNA TABLA](#borrar-una-tabla)
	- [ALTER TABLE](#alter-table)
		- [AÑADIENDO UNA RESTRICCION](#añadiendo-una-restriccion)
		- [ELIMINANDO UNA RESTRICCION](#eliminando-una-restriccion)
		- [AÑADIENDO UNA COLUMNA](#añadiendo-una-columna)
		- [ELIMINANDO UNA COLUMNA](#eliminando-una-columna)
		- [MODIFICANDO UNA COLUMNA](#modificando-una-columna)
- [DML](#dml)
	- [INSERT](#insert)
	- [DELETE](#delete)
	- [UPDATE](#update)
		
## DDL
DDL (Data Definition Languaje) nos permite definir las estructuras que almacenarán los datos. Está compuesto por tres sentencias:
`CREATE` , ` ALTER ` y ` DROP `.

### CREATE
Nos permite crear nuevas __bases de datos__ o __tablas__.

#### CREAR UNA BASE DE DATOS
Para crear una nueva base de datos, utilizaremos la siguiente sintaxis:
```sql
CREATE (SCHEMA|DATABASE) <nombreBD>;
```
Podemos utilizar tanto la notación `SCHEMA` como `DATABASE`, ya que estas son sinónimas.

Ejemplo:
```sql
CREATE SCHEMA ejemplo;
```
o bien
```sql
CREATE DATABASE ejemplo;
```

Algunas cláusulas interesantes que podríamos añadir de forma opcional a la sintaxis de `CREATE`  al crear una base de datos son:
* `CHARACTER SET` : Nos permite cambiar el set de caracteres a utilizar.
* `COLLATE` : Se usa junto con `CHARACTER SET`. Nos permite cambiar las reglas con las que se comparan los caracteres de un set. 
* `IF NOT EXISTS` : La base de datos se creará sólo si aún no existe.

Todo combinado nos dejaría con la siguiente sintaxis:

```sql
CREATE (SCHEMA|DATABASE) [IF NOT EXISTS] <nombreDB>
[CHARACTER SET <nombreCharset> [COLLATE <nombreCollation>]];
```

Un ejemplo de uso:

```sql
CREATE SCHEMA IF NOT EXISTS ejemplo
CHARACTER SET UTF8 COLLATE utf8_bin;
```

#### CREAR UNA TABLA
Para crear una nueva tabla, utilizaremos la siguiente sintaxis:
```sql
CREATE TABLE <nombreTabla>(
	atributo1 tipoDato [RESTRICCIONES],
	atributo2 tipoDato [RESTRICCIONES],
	atributo3 tipoDato [RESTRICCIONES],
	...
);
```

Como indica la sintaxis propuesta, es posible que los datos tengan ciertas restricciones (`CONSTRAINTS`), de las que hablaremos *un poco más adelante*.

##### TIPOS DE DATOS
Como hemos visto, es necesario asignarle un tipo de dato a todos los atributos. Algunos tipos comunes son:

* Numéricos:
	* INTEGER: número entero de 4 bytes
	* DECIMAL: número exacto de precisión variable
	* REAL: número de punto flotante de precisión simple
	* SERIAL: entero autoincrementado
* Caracteres:
	* CHAR: longitud fija
	* VARCHAR: longitud variable limitada
	* TEXT: longitud variable ilimitada
* Tiempo:
	* DATE: fecha (día, mes y año)
	* TIME: hora (hora, minuto, segundo)
	* TIMESTAMP: date + time
* Otros:
	* BOOLEAN: true o false
	* MONEY: tipo específico para dinero

Una vez vistos los tipos de datos, podemos poner un pequeño ejemplo:

```sql
CREATE TABLE profesor(
	id INTEGER,
	nombre VARCHAR(30),
	departamento VARCHAR(20)
);
```

### CONSTRAINTS
Como hemos mencionado anteriormente, es posible que los datos tengan ciertas restricciones, es lo que concemos como `CONSTRAINTS`.
Una forma genérica de declaración de `CONSTRAINTS` es esta:
```sql
CONSTRAINT <nombreConstraint>
-- después vendría la sintaxis correspondiente a la restricción
```
A continuación explicaremos las restricciones de uso más común.

#### PRIMARY KEY
`PRIMARY KEY` es la restricción de clave primaria. En las bases de datos relacionales, cada tupla debe tener un identificador único y no nulo, que puede ser un atributo o una combinación de ellos.
La fórmula genérica de esta restricción es la siguiente:
```sql
[CONSTRAINT <nombrePK>]
PRIMARY KEY (<atributos>);
```
Veamos un ejemplo de cómo añadir la clave primaria al crear la anterior tabla de *profesores*:

```sql
CREATE TABLE profesores(
	id INTEGER,
	nombre VARCHAR(30),
	departamento VARCHAR(20),
	CONSTRAINT PKProfesores
	PRIMARY KEY(id);
);
```

Otra forma válida:

```sql
CREATE TABLE profesores(
	id INTEGER,
	nombre VARCHAR(30),
	departamento VARCHAR(20),
	PRIMARY KEY(id);
);
```
Otro ejemplo válido:
```sql
CREATE TABLE profesores(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30),
	departamento VARCHAR(20)
);
```

#### FOREIGN KEY
`FOREIGN KEY` es la restricción de clave ajena. Nos permite identificar una columna o grupo de columnas en una tabla que referencien a otra.
La sintaxis de esta restricción es la siguiente:
```sql
[CONSTRAINT <nombreFK>]
FOREIGN KEY (<atributos>)
	REFERENCES <nombreTablaReferenciada> [(<atributosReferenciados>)]
	[ON DELETE NO ACTION|CASCADE|SET NULL|SET DEFAULT]
	[ON UPDATE NO ACTION|CASCADE|SET NULL|SET DEFAULT]
	[MATCH FULL|MATCH PARTIAL];
```

##### BORRADO Y ACTUALIZACION
`ON DELETE` y `ON UPDATE` son restricciones de integridad referencial, nos permite determinar el comportamiento de las tuplas de la tabla dependiente conforme se borra o modifican las de la tabla referenciada.
Los posibles comportamientos son:
* `NO ACTION` : Es el equivalente a omitir la cláusula. Las modificaciones o borrado de la tupla referenciada no afecta a la dependiente.
* `SET NULL` : Cuando hay modificación o borrado de la tupla referenciada, la clave ajena en la dependiente se pondrá a `NULL`.
* `SET DEFAULT`: Cuando hay modificación o borrado de la tupla referenciada, la clave ajena en la dependiente tomará el valor establecido por defecto.
* `CASCADE`: Si se borra la tupla referenciada, se borra también la dependiente. Si se actualiza la clave referenciada, se actualizará también la clave ajena.

##### MATCH FULL Y MATCH PARTIAL
También son restricciones de integridad referencial.
* `MATCH FULL` : La clave ajena será válida si todas las columnas de la clave ajena son nulas o si todas las columnas de la clave ajena son no nulas y  existe una tupla en la tabla referenciada cuya clave coincida.
* `MATCH PARTIAL` : La clave ajena será válida si para cada tupla de la tabla dependiente los valores de los atributos no nulos de la clave ajena coinciden con los correspondientes en una tupla de la referenciada.

Vemos un ejemplo. En primer lugar, tomaremos la tabla *profesores* que hicimos para anteriores ejemplos:

 ```sql
CREATE TABLE profesores(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30),
	departamento VARCHAR(20)
);
```
Ahora, crearemos una tabla *alumnos*, en la que cada uno tenga asignado un profesor:
```sql
CREATE TABLE alumnos(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30),
	idProfesor INTEGER,
	CONSTRAINT FKProfesoresAlumnos 
	FOREIGN KEY (idProfesor) REFERENCES profesores
	ON DELETE SET NULL
	ON UPDATE CASCADE
);
```
Es importante que la `FOREIGN KEY` tenga el __mismo tipo de dato__ que el atributo que referencia.
Otro dato interesante es que cuando hacemos el `REFERENCES`, si omitimos el atributo referenciado escogerá automáticamente la __clave primaria__.


#### UNIQUE
La restricción `UNIQUE` nos permite obligar a un atributo a que sea único. Es útil a la hora de definir __claves candidatas__.
Sintaxis:
```sql
[CONSTRAINT <nombreUnique>]
UNIQUE (<atributos>);
```

Un par de ejemplos:
 ```sql
CREATE TABLE profesores(
	id INTEGER PRIMARY KEY,
	idAlternativo INTEGER UNIQUE,
	nombre VARCHAR(30),
	departamento VARCHAR(20)
);
```
 ```sql
CREATE TABLE profesores(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30),
	telefono VARCHAR(20),
	departamento VARCHAR(20),
	UNIQUE(telefono)
);
```


#### CHECK
La restricción `CHECK` especifica mediante un __predicado__ un requisito que se debe cumplir.
Sintaxis:
```sql
[CONSTRAINT <nombreCheck>]
CHECK (predicado)
[[NOT] DEFERRABLE]
[INITIALLY INMEDIATE|INITIALLY DEFERRABLE];
```

##### DEFERRABLE
`DEFERRABLE` es una restricción que nos permite indicar al sistema si el check se debe realizar al final de la *transacción*.

Una transacción es una unidad de trabajo compuesta por varias tareas, cuyo resultado final debe ser que se ejecuten todas o ninguna de ellas.

-`INITIALLY INMEDIATE` : indica que inicialmente la restricción se comprueba después de cada operación SQL.
-`INITIALLY DEFERRABLE` : indica que inicialmente la restricción se comprueba después de cada transacción.

Veamos un ejemplo de uso de `CHECK`:

```sql
CREATE TABLE profesores(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30),
	departamento VARCHAR(20),
	fechaNacimiento DATE,
	fechaIngreso DATE,
	CHECK (fechaIngreso>fechaNacimiento)
);
```

#### NOT NULL
La restricción `NOT NULL` nos permite obligar a un atributo a que no sea nulo.
Ejemplo:
```sql
CREATE TABLE profesores(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30) NOT NULL,
	departamento VARCHAR(20)
);
```

### DROP
Como contraparte de `CREATE`, permite borrar partes de la estructura de datos, ya sea una __tabla__ o la __base de datos__.

#### BORRAR UNA BASE DE DATOS
Utilizaremos la siguiente sintaxis:
```sql
DROP SCHEMA|DATABASE [IF EXISTS] <nombreBD>;
```

Ejemplo:
```sql
DROP SCHEMA IF EXISTS ejemplo;
```

#### BORRAR UNA TABLA
Utilizaremos la siguiente sintaxis:
```sql
DROP TABLE [IF EXISTS] <nombreTabla>
[CASCADE|RESTRICT];
```

- ```RESTRICT```: Impide el borrado si existen elementos dependientes de la tabla. Es la opción por defecto.
- ```CASCADE```: Hace que se borre todo lo asociado con la tabla.

Ejemplo:
```sql
DROP TABLE profesores CASCADE;
```




### ALTER TABLE
Se usa para añadir y borrar __restricciones__ de una tabla, así como añadir, borrar o modificar el tipo de datos de una __columna__.

#### AÑADIENDO UNA RESTRICCION
Para añadir una restricción con `ALTER` usaremos la siguiente sintaxis:
```sql
ALTER TABLE <nombreTabla>
ADD CONSTRAINT <constraint>;
```

Para ilustrar su funcionamiento, tomaremos como ejemplo las tablas de profesores y alumnos:
```sql
CREATE TABLE profesores(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30),
	departamento VARCHAR(20)
);
```

```sql
CREATE TABLE alumnos(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30),
	idProfesor INTEGER,
);
```
Esta vez, en la tabla de alumnos no hemos añadido la restricción de clave ajena. Podemos utilizar un `ALTER` a posteriori para añdírselo:
```sql
ALTER TABLE alumnos
ADD CONSTRAINT FKProfesoresAlumnos
FOREIGN KEY (idProfesor) REFERENCES profesores
	ON DELETE SET NULL
	ON UPDATE CASCADE;
```

#### ELIMINANDO UNA RESTRICCION
Para eliminar una restricción con `ALTER` usaremos la siguiente sintaxis:
```sql
ALTER TABLE <nombreTabla>
DROP CONSTRAINT <NombreConstraint>;
```

Por ejemplo, podemos borrar la clave ajena que usamos en el ejemplo anterior:
```sql
ALTER TABLE alumnos
DROP CONSTRAINT FKProfesoresAlumnos;
```

#### AÑADIENDO UNA COLUMNA
Para añadir una columna con `ALTER` usaremos la siguiente sintaxis:
``` sql
ALTER TABLE <nombreTabla>
ADD [COLUMN] <atributo> <dominio>;
```

Por ejemplo, tomando *profesores*:
```sql
CREATE TABLE profesores(
	id INTEGER PRIMARY KEY,
	nombre VARCHAR(30),
	departamento VARCHAR(20)
);
```

Queremos añadirle un atributo que sea el teléfono de contacto:
```sql
ALTER TABLE profesores
ADD COLUMN telefono VARCHAR(20);
```
#### ELIMINANDO UNA COLUMNA
Para eliminar una columna con `ALTER` usaremos la siguiente sintaxis:
``` sql
ALTER TABLE <nombreTabla>
DROP COLUMN <atributo> [CASCADE|RESTRICT];
```
- ```RESTRICT```: Impide el borrado si existen elementos dependientes de la columna. Es la opción por defecto.
- ```CASCADE```: Hace que se borre todo lo asociado con la columna.

Por ejemplo, podemos borrar la columna que añadimos en el ejemplo anterior:
```sql
ALTER TABLE profesores
DROP COLUMN telefono;
```
#### MODIFICANDO UNA COLUMNA
Si queremos modificar el tipo de dato de una columna, podemos hacerlo de la siguiente manera:

```sql
ALTER TABLE <nombreTabla>
ALTER COLUMN <nombreColumna> TYPE nuevoTipo;
```

Por ejemplo:
```sql
ALTER TABLE profesores
ALTER COLUMN nombre TYPE VARCHAR(35);
```

## DML
DML (Data Manipulation Languaje) nos permite la modificación de los datos contenidos en la base de datos. Está compuesto por tres sentencias:
`INSERT` , `DELETE` y `UPDATE`.

### INSERT
Se utiliza para insertar nuevos datos en las tablas. Tiene la siguiente sintaxis:
```sql
INSERT INTO <nombreTabla> [(atributo1,atributo2,...)]
VALUES (valor1,valor2,...)|SELECT...
```
Un ejemplo:
```sql
INSERT INTO profesores (id,nombre,departamento)
VALUES 	(1,"Manolo","Informática"),
	(2,"Pepe", "Administración"),
	(3,"Ana","Administración");
```

En caso de usar un `SELECT` para hacer la inserción de datos, hay que tener en cuenta la cantidad de __columnas__ que este vaya a devolver, además de los __tipos de datos__.

### DELETE
Se utiliza para borrar datos de las tablas. Tiene la siguiente sintaxis:
``` sql
DELETE FROM <nombreTabla>
[WHERE predicado];
``` 

Por ejemplo, dadas las tuplas que añadimos antes:
```sql
DELETE FROM profesores
WHERE departamento = "Administración";
```
Borraría las tuplas cuyo departamento sea "Administración".
Si omitimos el `WHERE`:
```sql
DELETE FROM profesores;
```
Borraría todas las tuplas.

### UPDATE
Permite modificar datos de la tablas. Tiene la siguiente sintaxis:
```sql
UPDATE <nombreTabla>
SET  <atributo1> = valor1,
     <atributo2> = valor2
[WHERE predicado];
```

Un ejemplo:
```sql
UPDATE profesores
SET departamento = "Computer Science"
WHERE departamento = "Informática";
```
Sobreescribiría en todas las tuplas los departamentos que sean "Informática" con "Computer Science".
Si omitimos el `WHERE`:
```sql
UPDATE profesores
SET departamento = "Computer Science";
```
Sobreescribiría en todas las tuplas el departamento con "Computer Science".
