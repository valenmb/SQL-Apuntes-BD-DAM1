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


# Ejercicios Proyectos de investigación y Naves espaciales en mysql

Siguiendo las instrucciones de los enunciados de [Proyectos de investigación](https://github.com/davidgchaves/first-steps-with-git-and-github-wirtz-asir1-and-dam1/tree/master/exercicios-ddl/1-proxectos-de-investigacion) y [Naves espaciales](https://github.com/davidgchaves/first-steps-with-git-and-github-wirtz-asir1-and-dam1/tree/master/exercicios-ddl/2-naves-espaciais), hemos hecho dos scripts:
- [Script Proyectos de investigación](investigacion.sql)
- [Script Naves espaciales](navesespaciais.sql)


Para poder ejecutar los scripts en la shell de mysql, usaremos el comando
`source /ruta_del_script/script.sql`

## Comandos de la shell de mysql para visualizar nuestras bases de datos

- Con el comando `show databases` podemos ver todas nuestras bases de datos:

  ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql1.png)

- Con el comando `use nombre_base_datos` podemos seleccionar la base de datos que queremos usar:

  ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql2.png)
  
   ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql6.png)
  
- Con el comando `show tables` podremos ver todas las tablas de la base de datos en la que estemos trabajando:

  ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql3.png)
  
  ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql7.png)
  
- Para ver con más detalle cada una de las tablas, podemos utilizar `desc nombre_tabla`

   ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql4.png)
   
   ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql5.png)
   
   ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql8.png)
   
   ![image](https://github.com/valenmb/SQL-Apuntes-BD-DAM1/blob/master/img/comandosshellsql9.png)

De esta forma podremos ir comprobando la estructura que hemos creado en los scripts.
