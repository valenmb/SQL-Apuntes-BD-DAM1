# INSTALACION DE MYSQL EN UBUNTU

## Instalacion
En primer lugar, utilizaremos el comando `sudo apt-get update`, que actualizará la lista de paquetes. Tendremos que escribir nuestra contraseña para continuar.

Una vez hecho, con el comando `sudo apt-get install mysql-server`
instalaremos mysql server (nos pedirá la contraseña otra vez).

Una vez esté instalado, con `sudo mysql` arrancaremos la shell de mysql server.

## Probando mysql server 
Ahora podremos hacer unas pruebas:
- Creamos una base de datos *prueba*:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql1.PNG)

- Creamos una tabla *profesores*, con los atributos *id*, *nombre* y *departamento*:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql2.PNG)

- Insertamos unos valores en la tabla:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql3.PNG)

- Hacemos una consulta simple para ver que realizamos los pasos anteriores correctamente:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql4.PNG)

- Modificamos las tuplas en las que el *departamento* sea Informática:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql5.PNG)

- Comprobamos que se hizo correctamente:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql6.PNG)

- Borramos las tuplas en las que el *departamento* sea Administración:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql7.PNG)

- Comprobamos que se hizo correctamente:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql8.PNG)

- Borramos la columna de los *departamentos*:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql9.PNG)

- Comprobamos que se hizo correctamente:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql10.PNG)

- Ya hemos hecho unas cuantas pruebas. Borramos la base de datos:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql11.PNG)

- Vemos que se ha borrado correctamente:

![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/apuntesmysql12.PNG)

