# APUNTES SQL DQL

- [Introducción](#introduccion)
- [Comandos SQL](#comandos-sql)
	- [FROM](#from)
	- [SELECT](#select)
	- [WHERE](#where)
	- [Funciones de agregado](#funciones-de-agregado)
		- [SUM](#sum)
		- [COUNT](#count)
		- [MAX](#max)
		- [MIN](#min)
		- [AVG](#avg)
	- [Complementando las funciones de agregado](#complementando-las-funciones-de-agregado)
		- [DISTINCT](#distinct)
		- [GROUP BY](#group-by)
		- [HAVING](#having)
	- [Más utilidades](#mas-utilidades)
		- [BETWEEN](#between)
		- [ROUND](#round)
		- [ORDER BY](#order-by)
		- [LIMIT](#limit)
		- [IN](#in)
		- [ALL](#all)
		- [Algunas utilidades para cadenas](#algunas-utilidades-para-cadenas)
			- [CONCAT](#concat)
			- [REPLACE](#replace)
			- [LEFT y RIGHT](#left-y-right)
		- [LIKE](#like)
		- [COALESCE](#coalesce)
- [Subconsultas](#subconsultas)
	- [Consulta 6](#consulta-6)
	- [Consulta 8](#consulta-8)
	- [Consulta 9](#consulta-9)
	- [Consulta 10](#consulta-10)
- [JOINS](#joins)
	- [INNER JOIN](#inner-join)
	- [LEFT JOIN](#left-join)
	- [RIGHT JOIN](#right-join)
	- [ON](#on)
- [Consultas con JOIN](#consultas-con-join)
	- [Consulta 8](#consulta-8-join)
	- [Consulta 10](#consulta-10-join)
	- [Consulta 11](#consulta-11-join)
- [Más consultas con JOIN](#mas-consultas-con-join)
	- [Consulta 9](#consulta-9-mas-join)
	- [Consulta 11](#consulta-11-mas-join)
	- [Consulta 12](#consulta-12-mas-join)
	- [Consulta 15](#consulta-15-mas-join)
- [JOIN y los nulos](#join-y-los-nulos)
	- [Consulta 2 nulos](#consulta-2-nulos)
	- [Consulta 3 nulos](#consulta-3-nulos)
	- [Consulta 4 nulos](#consulta-4-nulos)
	- [Consulta 7 nulos](#consulta-7-nulos)

## Introduccion

Utilizando la herramienta [SQLZOO](https://sqlzoo.net/), hemos aprendido realizar consultas utilizando el lenguaje SQL. En estos apuntes se recopilará información útil para poder resolver las consultas que esta página nos ofrece.

## COMANDOS SQL

### FROM

From nos permite escoger de qué **tabla** o **_tablas_** queremos obtener los datos.

La sintaxis es muy simple:

```sql
FROM nombre-tabla;
```

De todas formas, ```FROM``` no se puede usar por sí sólo. La consulta mínima debe constar también de un [```SELECT```](#select).

### SELECT

Select nos permite escoger las __columnas__ que queremos de una determinada tabla.

Por ejemplo, dada la tabla ```world```:

  

| name | continent | capital |
|------|-----------|---------|
|China|Asia|Beijing|
|Spain|Europe|Madrid|
|United States|North America|Washington, D.C.|

  

La siguiente consulta:

```sql
SELECT name, continent
FROM world;
```

Daría como resultado:

| name | continent |
|------|-----------|
|China|Asia|
|Spain|Europe|
|United States|North America|
<br/>

  

Podemos utilizar __*__ para que nos devuelva todas las columnas:

```sql
SELECT *
FROM world;
```

Daría como resultado:

| name | continent | capital |
|------|-----------|---------|
|China|Asia|Beijing|
|Spain|Europe|Madrid|
|United States|North America|Washington, D.C.|

  

Más adelante también veremos que se pueden anidar ```SELECT```, de forma que podremos [realizar consultas dentro de otras](#subconsultas).

  

### WHERE

La sentencia ```WHERE``` nos permite añadir condiciones a nuestra consulta.

Las condiciones se especifican mediante *__predicados booleanos__*, es decir, expresiones que pueden ser __verdaderas__ o __falsas__.

Para componer nuestros predicados, podemos utilizar los siguientes operadores:

  

|operador|descripcion|
|-|-
| = | igual
| > | mayor que
| < | menor que
| >= | mayor o igual que
| <= | menor o igual que
| <> | distinto de
| ```BETWEEN``` | entre un rango de valores
| ``` IN ``` | contenido en un subconjunto
| ```LIKE``` | similar a = , __pero nos permite el uso de patrones__

Daremos unos ejemplos de uso sobre los tres últimos en [una sección posterior](#mas-utilidades).

<br>

Además de esto, con ```AND``` y ```OR ``` podremos combinar predicados.

``` p1 AND p2 ``` es __true__ si p1 __y__ p2 son true.

``` p1 OR p2 ``` es __true__ si p1 __o__ p2 es true.

  

Para ilustrar el funcionamiento del ```WHERE```, haremos un ejemplo con la siguiente tabla (```nobel```) con ganadores del premio Nobel:

  

año|materia|ganador
-|-|-
1960|Medicina|Sir Frank Macfarlane Burnet
1960|Medicina|Peter Madawar
1960|Literatura|Saint-John Perse
1960|Química|Willard F. Libby

  

La siguiente consulta:

```sql
SELECT *
FROM nobel
WHERE materia = 'Medicina'
AND año = 1960;
```

Nos devolvería:
|año|materia|ganador
|-|-|-
|1960|Medicina|Sir Frank Macfarlane Burnet
|1960|Medicina|Peter Madawar

  

Algo interesante que también podemos ver en esta pequeña consulta es que las __cadenas__ deben ir entre __comillas simples__, mientras que los números no.

  

## Funciones de agregado

Son funciones que nos devuelven un valor escalar a partir de una colección. Usaremos la siguiente tabla (```valores```) para ilustrar su funcionamiento:

  

|numeros|
|-|
|1|
|5|
|4|
|-3|
|7|
|-2|

  

#### SUM

Esta función de agregado __suma todos los valores__ de la colección que recibe como parámetro.

```sql
SELECT SUM(numeros)
FROM valores;
```

Nos devolverá:
|SUM(numeros)|
|-|
|12|

  

#### COUNT

Esta función de agregado __cuenta los elementos__ que tiene la colección que recibe como parámetro.

```sql
SELECT COUNT(numeros)
FROM valores;
```

  

Nos devolverá:
|COUNT(numeros)|
|-|
|6|

  

#### MAX

Esta función de agregado nos devuelve el __valor máximo__ de la colección que recibe como parámetro.

```sql
SELECT MAX(numeros)
FROM valores;
```

  

Nos devolverá:

|MAX(numeros)|
|-|
|7|

#### MIN

Esta función de agregado nos devuelve el __valor mínimo__ de la colección que recibe como parámetro.

```sql
SELECT MIN(numeros)
FROM valores;
```

  

Nos devolverá:
|MIN(numeros)|
|-|
|-3|

#### AVG

Esta función de agregado nos devuelve el __valor medio__ de la colección que recibe como parámetro.

```sql
SELECT AVG(numeros)
FROM valores;
```

  

Nos devolverá:
|AVG(numeros)|
|-|
|2|

  
  

## COMPLEMENTANDO LAS FUNCIONES DE AGREGADO

  

Para complementar las funciones de agregado, existen tres cláusulas que nos serán muy útiles: ```DISTINCT```,```GROUP BY``` y ```HAVING``` .

  

#### DISTINCT

Nos devuelve los valores de la colección que recibe como parámetro, pero __sin repetidos__.

Utilizaremos como ejemplo la siguiente tabla ```world```:

name|continent|capital
-|-|-
Spain|Europe|Madrid
China|Asia|Beijing
Uganda|Africa|Kampala
India|Asia|New Delhi
France|Europe|Paris

  

Si queremos ver qué *continentes* figuran en la tabla, puede que lo primero que se nos ocurra hacer sea esto:

```sql
SELECT continent
FROM world;
```

Pero esto nos devolvería algo así:

|continent|
|-|
|Africa|
|Asia|
|Asia|
|Europe|
|Europe|

Con una tabla tan pequeña y fuera de contexto, puede que no nos importe demasiado que salgan repetidos a la hora de querer ver qué *continentes* aparecen en ella.

Pero en situaciones que requieran __eliminar elementos repetidos__ es donde entra en juego la utilidad de ```DISTINCT```:

  

```sql
SELECT DISTINCT(continent)
FROM world;
```

Nos devolvería:

|continent|
|-|
|Africa|
|Asia|
|Europe|

  

### GROUP BY

Nos permite agrupar filas que tienen los mismos valores.

Tomemos como ejemplo la siguiente tabla (```world```):

  

name|continent|capital
-|-|-
Spain|Europe|Madrid
China|Asia|Beijing
Uganda|Africa|Kampala
India|Asia|New Delhi
France|Europe|Paris

  

Queremos ver, por ejemplo, la *cantidad de países* que tenemos *por continente* . Ahora que conocemos ```DISTINCT```, que elimina valores repetidos, es posible que nos tiente hacer esto:

```sql
SELECT DISTINCT(continent),COUNT(*)
FROM world;
```

Pero esto es incorrecto, lo que sucedería aquí es que

```DISTINCT(continent)``` intentaría devolvernos tantas tuplas como *continentes* haya en la tabla (en este caso, 3).

por otra parte, ```COUNT(*)``` estaría contando la cantidad de tuplas que hay, devolviendo el número en una única tupla.

No se corresponde la cantidad de tuplas que devuelven una y otra, ¿cómo podemos solucionar esto? La respuesta es con ```GROUP BY```:

```sql
SELECT continent,COUNT(*)
FROM world
GROUP BY continent;
```

```GROUP BY``` agrupa los elementos __antes__ del ```SELECT```, solucionando nuestro problema.

Nos devolvería:

continent|COUNT(*)
-|-
Africa|1
Asia|2
Europe|2

  

### HAVING

Funciona como un ```WHERE```, es decir, nos permite añadir condiciones.

Lo que lo diferencia de este es que mientras que ```WHERE``` se aplica a filas individuales,  ```HAVING``` se aplica a posteriori del ```GROUP BY``` y las __*funciones de agregado*__.

Veamos un ejemplo sobre la misma tabla ```world```. En caso de querer que sólo nos muestre aquellos *continentes* que tengan 2 *países*, lo primero que se nos puede venir a la mente es hacer esto:

  

```sql
SELECT continent, COUNT(*)
FROM world
WHERE COUNT(*)=2
GROUP BY continent;
```

Pero esto sería incorrecto. ```WHERE``` sólo nos permite añadir condiciones a las filas antes de ser agrupadas. Para resolver esto, tenemos que usar ```HAVING```:

  

```sql
SELECT continent, COUNT(*)
FROM world
GROUP BY continent
HAVING COUNT(*)=2;
```

Obteniendo así el resultado deseado:

continent|COUNT(*)
-|-
Asia|2
Europe|2

## MAS UTILIDADES

### AS

Nos permite dar un nombre temporal a una tabla o a una columna.

Por ejemplo:

```sql
SELECT name
FROM world AS w;
```

Esto es útil para hacer nombres más legibles o cómodos y para [ciertas subconsultas](#subconsultas).

### BETWEEN

Como hemos mencionado [anteriormente](#where), ```BETWEEN``` nos permite especificar un rango de valores. Tomaremos como ejemplo la __consulta 3__ de [esta sección de SQLZOO](https://sqlzoo.net/wiki/SELECT_basics):

```sql
SELECT name,area
FROM world
WHERE area BETWEEN 200000 AND 250000
```

Nos devolverá el *país* y el *área* de aquellas tuplas cuya *área* esté entre 200000 y 250000.

  

### ROUND

Permite redondear números.

```ROUND(numero,posicion)```

La posición se refiere a la situación del dígito respecto a la coma decimal.

La coma se sitúa en la posición 0. Los números negativos aproximarían a posiciones más a la izquierda (por ejemplo -2 aproximaría a centenas) y los positivos a posiciones más a la derecha (por ejemplo 2 aproximaría a centésimas).

  

### ORDER BY

Nos permite ordenar por una o varias columnas, de forma ascendente (```ASC```) o desdencente (```DESC```). Si no se especifica, la forma predeterminada es ascendente.

Por ejemplo, sobre la tabla ```world``` de [SQLZOO](https://sqlzoo.net/):

```sql
SELECT continent,name,area
FROM world
ORDER BY continent ASC, area DESC;
```

Esta consulta ordenará por *continente* de forma ascendente y en caso de repetirse el nombre del continente, pasará a ordenar por *área* de forma descendente.

### LIMIT

Sirve para limitar la cantidad de resultados que devuelve nuestra consulta.

Tiene la siguiente sintaxis: ``` LIMIT indice_comienzo,tamaño```

Por ejemplo, ```LIMIT 5,10``` nos daría 10 tuplas, partiendo de la 5 (__la primera tupla es la tupla 0__).

Si sólo se especifica un número, se considera que empieza en la tupla 0 y el número especificado es el tamaño deseado.

### IN

Como hemos mencionado [anteriormente](#where), ```IN``` nos permite comprobar si el valor está contenido en un subconjunto.

Tomaremos como ejemplo la __consulta 2__ de [esta sección de SQLZOO](https://sqlzoo.net/wiki/SELECT_basics):

```sql
SELECT name, population
FROM world
WHERE name IN ('Sweden', 'Norway', 'Denmark');
```

Nos devolverá las tuplas de los *países* Sweden, Norway y Denmark. Puede parecer un poco trivial, ya que esto es fácilmente sustituible por predicados unidos por ```OR``` , pero cobra más sentido cuando la comparación se realiza sobre subconjuntos cuyos valores podemos no conocer a priori.

### ALL

Similar a ```IN```, nos permite comprobar si el valor cumple la condición respecto a todos los elementos de un subconjunto. También de cierta forma análoga a ```IN```, es como realizar una serie de predicados, unidos en este caso por ```AND```.

Veremos un ejemplo de uso cuando aprendamos a hacer [subconsultas](#subconsultas).

### ALGUNAS UTILIDADES PARA CADENAS

- Comodín % : representa cualquier caracter, repetido 0 o n veces.

- Comodín _ : representa cualquier caracter, repetido 1 única vez.

  

Los comodines son utilizados por el operador ```LIKE```.

#### CONCAT

Nos permite concatenar elementos, ya sean __cadenas__ o __expresiones regulares__ (lo cual nos será útil para combinar con ```LIKE```.

```CONCAT(cadena1,cadena2,cadena3...)```

  

#### REPLACE

Nos permite sustituir caracteres en una cadena.

```REPLACE(cadena,char_original,char_nuevo)```

#### LEFT y RIGHT

Permiten seleccionar una determinada cantidad de caracteres de una __cadena__, comenzando por la izquierda (```LEFT```) o por la derecha (```RIGHT```).

```LEFT(cadena,cantidad)```

```RIGHT(cadena,cantidad)```

### LIKE

Como hemos mencionado [anteriormente](#where), ```LIKE``` nos permite hacer la misma función que el operador =, permitiéndonos a mayores poder comparar con __expresiones regulares__. Por ejemplo:

```sql
SELECT name,capital
FROM world
WHERE capital LIKE CONCAT(name,' %');
```

Nos devolverá *país* y *capital* siempre y cuando la *capital* sea una extensión del *nombre*.

  

### COALESCE

Recibe cualquier número de argumentos y devuelve el primero que no sea nulo o ```NULL``` en caso de que todos lo sean.

```COALESCE(x,y,z)```

## SUBCONSULTAS

Como hemos mencionado al final del [apartado de SELECT](#select), es posible que en algún momento necesitemos realizar una consulta dentro de otra.

Veamos algunos ejemplos interesantes de [SQLZOO relativos a subconsultas](https://sqlzoo.net/wiki/SELECT_within_SELECT_Tutorial):

  

#### CONSULTA 6

```sql
SELECT name
FROM world
WHERE gdp > ALL(
	SELECT gdp
	FROM world
	WHERE continent='Europe'
	AND gdp IS NOT NULL);
```

Podemos ver como es necesario utilizar una subconsulta en primer lugar para obtener el *gdp* de todos los países de Europa. Gracias a ```ALL```, podemos hacer la comparación con todos los elementos a la vez.

  

#### CONSULTA 8

```sql
SELECT continent, name
FROM world as x
WHERE x.name <= ALL (
	SELECT name
	FROM world as y
	WHERE x.continent=y.continent);
```

Además de la utilidad de la subconsulta y de ```ALL```, como hemos visto anteriormente, esta consulta también es interesante por dos cosas:

La primera es que podemos ver como de esta vez estamos comparando cadenas en vez de números.

La segunda y más interesante es cómo podemos aprovechar los alias (```AS```) para poder comparar dentro de la subconsulta el *continente* de fuera de la subconsulta.

Escoge un país ```x.name``` y, dentro de la subconsulta, obtiene todos los países de su mismo continente ```WHERE x.continent=y.continent```. Luego comparará con todos ```ALL``` los elementos obtenidos en la subconsulta si precede alfabéticamente a todos o es él mismo ```<=```.

#### CONSULTA 9

```sql
SELECT name, continent, population
FROM world AS x
WHERE 25000000 >= ALL (
SELECT population
FROM world AS y
WHERE x.continent = y.continent);
```

La dificultad de esta consulta reside en conseguir comprender el enunciado.

En esta consulta, para cada tupla se necesitará saber el continente ```x.continent``` y se comprobará si todos ```ALL``` los elementos del mismo continente ```x.continent=y.continent``` tienen una *población* inferior a 25000000.

Un posible enunciado más inteligible sería algo como:

__Muestra nombre, continente y población de aquellos países cuyo continente no tenga ningún país en el que la población supere 25000000__.

  

#### CONSULTA 10

```sql
SELECT name,continent
FROM world AS x
WHERE x.population > ALL(
	SELECT 3*population
	FROM world AS y WHERE x.continent=y.continent
	AND x.name<>y.name);
```

Lo interesante que tiene esta consulta es que necesitamos una nueva forma de que un país no interfiera consigo mismo en la subconsulta. En la [consulta 8](#consulta-8) el truco que usamos es que aquel país que fuese anterior alfabéticamente a todos, no podía ser anterior a sí mismo, incumpliendo la cláusula ```< ALL```. Colocando ```<= ALL```, podemos hacer que algún país sea anterior a todos los demás e igual a sí mismo.

En este caso, tenemos que evitar esta clase de problema (la *población* de un país nunca será mayor que 3 veces ella misma) eliminando directamente el valor en la subconsulta ```x.name <> y.name```.

  

## JOINS

Los ```JOIN``` se utilizan para combinar las filas de varias tablas.

  

### INNER JOIN

Se trata del producto cartesiano de las dos tablas, es decir, todas las combinaciones de tuplas posibles entre las dos ,aunque **ignorará las tuplas con valores nulos**. Se puede abreviar por ```JOIN```.

### LEFT JOIN

Se trata del producto cartesiano de las dos tablas, devolviendo todas las posibles combinaciones de tuplas, __incluyendo las tuplas de la tabla a la izquierda aún con nulos a la derecha__ del ```LEFT JOIN```.

### RIGHT JOIN

Se trata del producto cartesiano de las dos tablas, devolviendo todas las posibles combinaciones de tuplas, __incluyendo las de la tabla a la derecha aún con nulos a la izquierda__ del ```RIGHT JOIN```.

  

### ON

Al igual que ```WHERE``` y ```HAVING```, se utiliza para añadir condiciones, en su caso, específicamente a los ```JOIN```.

Así, las condiciones del ```JOIN``` están separadas del resto de condiciones de la consulta, haciendo el código más legible.

  

## CONSULTAS CON JOIN

[Fuente SQLZOO](https://sqlzoo.net/wiki/The_JOIN_operation)

  

### CONSULTA 8 JOIN

```sql
SELECT DISTINCT(goal.player)
FROM goal JOIN game ON goal.matchid = game.id
WHERE goal.teamid<>'GER'
AND (game.team1='GER' OR game.team2='GER');
```

Para realizar esta consulta, necesitamos la tabla de goles y la de partidos.

Para combinarlas, queremos que todas las tuplas sean del mismo partido ```goal.matchid = game.id```.

El equipo del gol no puede ser Alemania ```goal.teamid<>'GER'```, pero Alemania debe ser uno de los equipos que jugaron el partido ```game.team1='GER' OR game.team2='GER'```.

  

### CONSULTA 10 JOIN

```sql
SELECT game.stadium, COUNT(goal.matchid)
FROM game JOIN goal ON game.id = goal.matchid
GROUP BY game.stadium;
```

Una vez más, tenemos que tener claro como utilizar el ```ON``` para filtrar las tuplas del ```JOIN```.

En esta consulta podemos ver cómo se pueden utilizar agregadores junto con joins.

  

### CONSULTA 11 JOIN

```sql
SELECT goal.matchid, game.mdate, COUNT(goal.matchid)
FROM goal JOIN game ON goal.matchid = game.id
WHERE game.team1='POL' OR game.team2='POL'
GROUP BY goal.matchid, game.mdate;
```

Combina los conceptos vistos en la [consulta 8](#consulta-8-join) y en la [consulta 10](#consulta-10-join), pero tampoco aporta mayor dificultad.

  

## MAS CONSULTAS CON JOIN

[Fuente de las siguientes consultas](https://sqlzoo.net/wiki/More_JOIN_operations)

  

### CONSULTA 9 MAS JOIN

```sql
SELECT movie.title
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name='Harrison Ford' AND casting.ord <>1;
```

Esta vez tenemos que hacer dos ```JOIN```. En los papeles protagonistas, casting.ord = 1.

  

### CONSULTA 11 MAS JOIN

```sql
SELECT movie.yr, COUNT(movie.id)
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE actor.name = 'Rock Hudson'
GROUP BY movie.yr
HAVING COUNT(movie.id)>2;
```

Esta vez tenemos unos ```JOIN``` iguales que los de la [consulta 9](#consulta-9-mas-join).

Como añadido, podemos ver como se siguen podiendo usar agregadores.

  

### CONSULTA 12 MAS JOIN

```sql
SELECT movie.title, actor.name
FROM movie JOIN casting ON movie.id = casting.movieid
JOIN actor ON actor.id = casting.actorid
WHERE casting.ord=1
AND movie.id IN (
      SELECT casting.movieid
      FROM actor
      JOIN casting ON actor.id = casting.actorid
      WHERE actor.name = 'Julie Andrews');
```

Esta consulta es un poco más compleja, ya que requerimos una subconsulta a mayores.

Fuera de la subconsulta fijamos que tiene que ser el protagonista ```casting.ord=1``` y un identificador de película ```movie.id```, el cual debe estar entre los identificadores de las películas en las que participó Julie Andrews ```actor.name = 'Julie Andrews```, los cuales obtenemos con la subconsulta.

La mayor dificultad de este ejercicio es reconocer la subconsulta que hay que realizar y las tablas que necesitaremos para los ```JOIN``` tanto en la consulta exterior como la subconsulta.

  
  

### CONSULTA 15 MAS JOIN

```sql
SELECT DISTINCT(actor.name)
FROM actor JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid IN (
			SELECT casting.movieid
			FROM actor JOIN casting ON actor.id = casting.actorid
			WHERE actor.name = 'Art Garfunkel')
			AND actor.name <> 'Art Garfunkel';
```

Esta consulta se puede resolver íntegramente con ```JOIN```, sin recurrir a subconsultas. No obstante, he escogido ilustrar esta opción por ser, a mi parecer, más intuitiva.

Como podemos ver, en la subconsulta obtenemos un conjunto de identificadores de películas ```casting.movieid``` en las cuales participó Art Garfunkel ```actor.name = 'Art Garfunkel'```.

Para cada tupla, comprobaremos que el actor no sea el mismo Art Garfunkel ```actor.name <> 'Art Garfunkel'``` y que la película sea una en la que haya participado ```actor.name = 'Art Garfunkel```.

Utilizamos ```DISTINCT``` en el ```SELECT``` para evitar que un actor salga repetido si ha trabajado varias veces con él.

  

## JOIN Y LOS NULOS

[Fuente de las siguientes consultas](https://sqlzoo.net/wiki/Using_Null)

### CONSULTA 2 NULOS

```sql
SELECT teacher.name, dept.name
FROM teacher INNER JOIN dept ON (teacher.dept=dept.id);
```

Si ejecutamos esta consulta, podemos ver que las tuplas con null son ignoradas.

  

### CONSULTA 3 NULOS

```sql
SELECT teacher.name, dept.name
FROM teacher LEFT JOIN dept ON (teacher.dept=dept.id);
```

De esta forma, conseguimos que liste todos los nombres de profesores, aunque su departamento sea nulo.

### CONSULTA 4 NULOS

```sql
SELECT teacher.name, dept.name
FROM teacher RIGHT JOIN dept ON (teacher.dept=dept.id);
```

De esta forma, conseguimos que liste todos los departamentos, aunque el nombre del profesor sea nulo.

  

### CONSULTA 7 NULOS

```sql
SELECT COUNT(teacher.name),COUNT(teacher.mobile)
FROM teacher
```

Comprobamos que ```COUNT``` no está contando nulos, dando un resultado correcto.
