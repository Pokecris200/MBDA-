CREATE TABLE  Adultos(cedula NUMBER(10)NOT NULL,correo VARCHAR(50),telefonos NUMBER(10));
CREATE TABLE Personas(Codigo NUMBER(10) NOT NULL,nombre VARCHAR(15),genero VARCHAR(9),talla NUMBER(2),nacimiento DATE);
CREATE TABLE Opinion(Numero NUMBER(5) NOT NULL, Fecha DATE, Opinion VARCHAR(250), Codigo NUMBER(10) NOT NULL, Codigo_bien NUMBER(10) NOT NULL);
CREATE TABLE OpinionesGrupales(Razon VARCHAR(250), Estrellas NUMBER(1) NOT NULL);
CREATE TABLE Familias(Numero NUMBER(3) NOT NULL, Codigo NUMBER(10) NOT NULL, Nombre VARCHAR(20));
CREATE TABLE Localidades(Nombre VARCHAR(20)NOT NULL, Prioridad VARCHAR(5), Departamento VARCHAR(10) NOT NULL);
CREATE TABLE Bienes(Codigo NUMBER(10) NOT NULL, Nombre VARCHAR(20), Tipo VARCHAR(10), Medida NUMBER(3), Unitario NUMBER(1), Retirado VARCHAR(2)NOT NULL, Numero_familia NUMBER(3) NOT NULL);
CREATE TABLE Reemplazo(Codigo1 NUMBER(10) NOT NULL, Codigo2 NUMBER(10) NOT NULL);
CREATE TABLE Asignaciones(Numero NUMBER(10) NOT NULL,fecha DATE,aceptado VARCHAR(2),numero_familia NUMBER(3) NOT NULL);
