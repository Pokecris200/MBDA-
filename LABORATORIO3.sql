/*Creacion de tablas*/
CREATE TABLE adulto (
    codigo      NUMBER(7) NOT NULL,
    cedula      NUMBER(12) NOT NULL,
    correo      VARCHAR(40) NOT NULL
);

CREATE TABLE telefono (
    cedula    NUMBER(12) NOT NULL,
    telfono   NUMBER(12) NOT NULL
);

CREATE TABLE persona (
    codigo       NUMBER(7) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    genero       VARCHAR(1) NOT NULL,
    talla        VARCHAR(3) NOT NULL,
    nacimiento   DATE NOT NULL
);

CREATE TABLE opinion (
    numero          NUMBER(5) NOT NULL,
    fecha           DATE,
    opinion         VARCHAR(1) NOT NULL,
    justificacion   VARCHAR(20) NOT NULL,
    codigo          NUMBER(7) NOT NULL,
    codigo_bien     VARCHAR(5) NOT NULL
);

CREATE TABLE opiniongrupal (
    razon           VARCHAR(200),
    estrellas       NUMBER(1) NOT NULL,
    numero          NUMBER(5) NOT NULL,
    fecha           DATE NOT NULL,
    opinion         VARCHAR(1) NOT NULL,
    justificacion   VARCHAR(20) NOT NULL,
    codigo          NUMBER(7) NOT NULL,
    codigo_bien     VARCHAR(5) NOT NULL
);

CREATE TABLE familia (
    numero   NUMBER(5) NOT NULL,
    codigo   NUMBER(7) NOT NULL,
    nombre   VARCHAR(15) NOT NULL
);

CREATE TABLE localidad (
    nombre         VARCHAR(15) NOT NULL,
    prioridad      NUMBER(1) NOT NULL,
    departamento   VARCHAR(15) NOT NULL
);

CREATE TABLE remplazo (
    codigo    VARCHAR(5) NOT NULL,
    codigo1   VARCHAR(5) NOT NULL
);

CREATE TABLE alojamiento (
    nombre     VARCHAR(15) NOT NULL,
    personas   NUMBER(4) NOT NULL,
    inicio     DATE NOT NULL,
    fin        DATE,
    orden      NUMBER(4) NOT NULL
);

CREATE TABLE vestuario (
    cantidad   NUMBER(4) NOT NULL,
    talla      VARCHAR(3) NOT NULL,
    orden      NUMBER(4) NOT NULL
);

CREATE TABLE generico (
    cantidad   NUMBER(4) NOT NULL,
    orden      NUMBER(4) NOT NULL
);

CREATE TABLE perecedero (
    cantidad      NUMBER(4) NOT NULL,
    vencimiento   DATE NOT NULL,
    orden         NUMBER(4) NOT NULL
);

CREATE TABLE detalle (
    orden    NUMBER(4) NOT NULL,
    numero   NUMBER(9) NOT NULL,
    codigo   VARCHAR(5) NOT NULL
);

CREATE TABLE bien (
    codigo     VARCHAR(5) NOT NULL,
    nombre     VARCHAR(30) NOT NULL,
    tipo       VARCHAR(1) NOT NULL,
    medida     VARCHAR(2) NOT NULL,
    unitario   NUMBER(5) NOT NULL,
    retirado   NUMBER(1) NOT NULL,
    numero     NUMBER(5) NOT NULL
);

CREATE TABLE asignacion (
    numero          NUMBER(9) NOT NULL,
    fecha           DATE NOT NULL,
    aceptado        NUMBER(1),
    numerofamilia   NUMBER(5) NOT NULL
);
/*Poblar NoOK donde no se acepta los INSERT*/
INSERT INTO adulto VALUES (
    25698,
    79186597,
    NULL
);/*El correo no puede ser nulo*/

INSERT INTO telefono VALUES (
    'Santiago',
    3228369854
);/*La cedula es un string, cuando debe ser un numero que no supere los 12 digitos*/

INSERT INTO persona VALUES (
    315,
    'Santiago',
    'M',
    NULL,
    TO_DATE('2020/09/24', 'yyyy/mm/dd')
);/*El atributo talla debe ser un numero, no puede ser nulo*/

INSERT INTO vestuario VALUES (
    NULL,
    32,
    678
);/*La cantidad de vestuario no puede ser nula*/

INSERT INTO familia VALUES (
    315,
    NULL,
    'Familia Gomez'
);/*El atributo codigo debe ser un numero que o supere los 7 digitos, no puede ser nulo*/

/*Diego es gay*/
