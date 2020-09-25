/*Creacion de tablas*/
CREATE TABLE adultos (
    codigo      NUMBER(7) NOT NULL,
    cedula      NUMBER(12) NOT NULL,
    correo      VARCHAR(40) NOT NULL
);

CREATE TABLE telefono (
    cedula    NUMBER(12) NOT NULL,
    telefono   NUMBER(12) NOT NULL
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

CREATE TABLE reemplazo (
    bien    VARCHAR(5) NOT NULL,
    bien_reemplazo   VARCHAR(5) NOT NULL
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

/*Pobla ok*/
/*Poblar personas*/
INSERT INTO persona VALUES (
    6541258,
    'Jose maria Gimenez',
    'M',
    'tll',
    TO_DATE('1990/08/20', 'yyyy/mm/dd')
);

INSERT INTO persona VALUES (
    1134502,
    'Alejandra Rodriguez',
    'F',
    'tll',
    TO_DATE('1970/10/01', 'yyyy/mm/dd')
);
INSERT INTO persona VALUES (
    8541535,
    'Maria Fernanda Forero',
    'F',
    'tll',
    TO_DATE('1975/02/25', 'yyyy/mm/dd')
);
/*poblar opinion*/
INSERT INTO opinion VALUES (
    10000,
    TO_DATE('2020/09/23', 'yyyy/mm/dd'),
    'B',
    'Ha sido ayuda',
    6541258,
    12345
);

INSERT INTO opinion VALUES (
    10001,
    TO_DATE('2020/09/25', 'yyyy/mm/dd'),
    'M',
    'Caotico',
    1134502,
    26456
);

INSERT INTO opinion VALUES (
    10002,
    TO_DATE('2020/09/28', 'yyyy/mm/dd'),
    'E',
    'Agradezco por todo',
    8541535,
    87264
);

/*poblar familia*/
INSERT INTO familia VALUES (
    22225,
    6541258,
    'Bosa'
);

INSERT INTO familia VALUES (
    22226,
    1134502,
    'San Cristobal'
);

INSERT INTO familia VALUES (
    22227,
    8541535,
    'Chapinero'
);

/*poblar localidad*/
INSERT INTO localidad VALUES (
    'Bosa',
    5,
    'Bogota'
);

INSERT INTO localidad VALUES (
    'San Cristobal',
    3,
    'Bogota'
);

INSERT INTO localidad VALUES (
    'Chapinero',
    1,
    'Bogota'
);
/*poblar bien*/
INSERT INTO bien VALUES (
    12345,
    'Jean',
    'V',
    'S',
    24684,
    0,
    11111
);

INSERT INTO bien VALUES (
    12345,
    'Leche',
    'P',
    'No',
    31245,
    8,
    11112
);

INSERT INTO bien VALUES (
    12345,
    'Esferos',
    'G',
    'No',
    79135,
    5,
    11113
);
/*poblar asignacion*/
INSERT INTO asignacion VALUES (
    200063214,
    TO_DATE('2020/09/24', 'yyyy/mm/dd'),
    1,
    22225
);

INSERT INTO asignacion VALUES (
    301068513,
    TO_DATE('2020/10/05', 'yyyy/mm/dd'),
    0,
    22226
);

INSERT INTO asignacion VALUES (
    410075754,
    TO_DATE('2020/08/25', 'yyyy/mm/dd'),
    NULL,
    22227
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


/*Poblar NoOK donde aceptan los insert pero no deberia*/
INSERT INTO adulto VALUES (
    315,
    123,
    'diego.Forero@mail.com'
); /*No es posible que la cedula tenga tan pocos digitos*/

INSERT INTO persona VALUES (
    315,
    'Diego',
    'M',
    32,
    TO_DATE('2010/09/24', 'yyyy/mm/dd')
);/*Aun no ha cumplido la mayoria de edad, no deberia de estar en esta tabla*/

INSERT INTO vestuario VALUES (
    2,
    'A',
    375
);/*'A' no es una talla de ropa valida*/

INSERT INTO localidad VALUES (
    'Chapinero',
    9,
    'Meta'
);/*9 se pasa del nivel de prioridad de la localidad, el cual va de 1 a 5*/

INSERT INTO telefono VALUES (
    315,
    3287984597
);/*no es posible que una cedula valida tenga tan pocos digitos*/


/*Atributos*/
ALTER TABLE bien
    ADD CONSTRAINT ck_bien_unitario CHECK ( unitario < 100000
                                            AND unitario > - 1 );

ALTER TABLE adultos
    ADD CONSTRAINT ck_correo CHECK ( correo LIKE '%@%'
                                     AND correo LIKE '%.%' );

ALTER TABLE opiniongrupal
    ADD CONSTRAINT ck_estrellas CHECK ( estrellas < 6
                                        AND estrellas > 0 );

ALTER TABLE persona
    ADD CONSTRAINT ck_genero CHECK ( genero IN (
        'M',
        'F',
        'O'
    ) );

ALTER TABLE opinion
    ADD CONSTRAINT ck_opinion CHECK ( opinion IN (
        'E',
        'B',
        'R',
        'M'
    ) );

ALTER TABLE alojamiento ADD CONSTRAINT ck_cantidad_a CHECK ( personas > 0 );

ALTER TABLE vestuario ADD CONSTRAINT ck_cantidad_v CHECK ( cantidad > 0 );

ALTER TABLE perecedero ADD CONSTRAINT ck_cantidad_p CHECK ( cantidad > 0 );

ALTER TABLE generico ADD CONSTRAINT ck_cantidad_g CHECK ( cantidad > 0 );

ALTER TABLE bien
    ADD CONSTRAINT ck_bien_codigo CHECK ( ( codigo LIKE ( '%0' )
                                            OR codigo LIKE ( '%1' ) )
                                          AND ( substr(codigo, 0, 2) = upper(substr(codigo, 0, 2)) )
                                          AND translate(substr(codigo, 2, 2), 'T 0123456789', 'T') IS NULL );

ALTER TABLE localidad
    ADD CONSTRAINT ck_prioridad CHECK ( prioridad BETWEEN 0 AND 6 );

ALTER TABLE persona
    ADD CONSTRAINT ck_talla CHECK ( talla IN (
        'XS',
        'S',
        'M',
        'L',
        'XL'
    ) );

ALTER TABLE vestuario
    ADD CONSTRAINT ck_talla_v CHECK ( talla IN (
        'XS',
        'S',
        'M',
        'L',
        'XL'
    ) );

ALTER TABLE telefono
    ADD CONSTRAINT ck_telefono CHECK ( telefono BETWEEN 999999 AND 1000000000000 );

ALTER TABLE bien
    ADD CONSTRAINT ck_opinion CHECK ( tipo IN (
        'G',
        'P',
        'V',
        'A'
    ) );
                                               

/*PRIMARY KEYS*/
ALTER TABLE adultos ADD CONSTRAINT pk_adultos_cedula PRIMARY KEY ( cedula );

ALTER TABLE telefono ADD CONSTRAINT pk_telefono_telefono PRIMARY KEY ( telefono );

ALTER TABLE persona ADD CONSTRAINT pk_presona_codigo PRIMARY KEY ( codigo );

ALTER TABLE opinion ADD CONSTRAINT pk_opinion_numero PRIMARY KEY ( numero );

ALTER TABLE opiniongrupal ADD CONSTRAINT pk_grupal_numero PRIMARY KEY ( numero );

ALTER TABLE familia ADD CONSTRAINT pk_familia_numero PRIMARY KEY ( numero );

ALTER TABLE localidad ADD CONSTRAINT pk_localidad_nombre PRIMARY KEY ( nombre );

ALTER TABLE bien ADD CONSTRAINT pk_bien_codigo PRIMARY KEY ( codigo );

ALTER TABLE reemplazo ADD CONSTRAINT pk_reemplaza_bien PRIMARY KEY ( bien,
                                                                     bien_reemplazo );

ALTER TABLE asignacion ADD CONSTRAINT pk_asignacion_numero PRIMARY KEY ( numero );

ALTER TABLE detalle ADD CONSTRAINT pk_detalle_orden PRIMARY KEY ( orden );

ALTER TABLE alojamiento ADD CONSTRAINT pk_alojamiento_orden PRIMARY KEY ( orden );

ALTER TABLE vestuario ADD CONSTRAINT pk_vestuario_orden PRIMARY KEY ( orden );

ALTER TABLE generico ADD CONSTRAINT pk_generico_orden PRIMARY KEY ( orden );

ALTER TABLE perecedero ADD CONSTRAINT pk_perecedero_orden PRIMARY KEY ( orden );


/*UNIQUE KEYS*/
ALTER TABLE adultos ADD CONSTRAINT uk_adulto_correo UNIQUE ( correo );

ALTER TABLE opinion ADD CONSTRAINT uk_opinion_justificacion UNIQUE ( justificacion );

    
/*FOREIGN KEYS*/
ALTER TABLE adultos
    ADD CONSTRAINT FK_Adulto_Codigo FOREIGN KEY ( codigo )
        REFERENCES persona ( codigo );

ALTER TABLE telefono
    ADD CONSTRAINT FK_Telefono_Cedula FOREIGN KEY ( cedula )
        REFERENCES adultos ( cedula );

ALTER TABLE opinion
    ADD CONSTRAINT FK_Opinion_Codigo FOREIGN KEY ( codigo )
        REFERENCES persona ( codigo );

ALTER TABLE opinion
    ADD CONSTRAINT FK_Opinion_Codigo_Bien FOREIGN KEY ( codigo_bien )
        REFERENCES bien ( codigo );

ALTER TABLE opiniongrupal
    ADD CONSTRAINT FK_Opiniongrupal_Numero FOREIGN KEY ( numero )
        REFERENCES opinion ( numero );

ALTER TABLE familia
    ADD CONSTRAINT FK_Familia_Codigo FOREIGN KEY ( codigo )
        REFERENCES persona ( codigo );

ALTER TABLE familia
    ADD CONSTRAINT FK_Familia_Nombre FOREIGN KEY ( nombre )
        REFERENCES localidad ( nombre );

ALTER TABLE reemplazo
    ADD CONSTRAINT FK_Reemplaza_Bien FOREIGN KEY ( bien )
        REFERENCES bien ( codigo );

ALTER TABLE reemplazo
    ADD CONSTRAINT FK_Reemplaza_Bien_reemplazo FOREIGN KEY ( bien_reemplazo )
        REFERENCES bien ( codigo );

ALTER TABLE alojamiento
    ADD CONSTRAINT FK_Alojamiento_Orden FOREIGN KEY ( orden )
        REFERENCES detalle ( orden );

ALTER TABLE alojamiento
    ADD CONSTRAINT FK_Alojamiento_Nombre FOREIGN KEY ( nombre )
        REFERENCES localidad ( nombre );

ALTER TABLE vestuario
    ADD CONSTRAINT FK_Vestuario_Orden FOREIGN KEY ( orden )
        REFERENCES detalle ( orden );

ALTER TABLE generico
    ADD CONSTRAINT FK_Generico_Orden FOREIGN KEY ( orden )
        REFERENCES detalle ( orden );

ALTER TABLE perecedero
    ADD CONSTRAINT FK_Perecedero_Orden FOREIGN KEY ( orden )
        REFERENCES detalle ( orden );

ALTER TABLE detalle
    ADD CONSTRAINT FK_Detalle_Numero FOREIGN KEY ( numero )
        REFERENCES asignacion ( numero );

ALTER TABLE detalle
    ADD CONSTRAINT FK_Detalle_Codigo FOREIGN KEY ( codigo )
        REFERENCES bien ( codigo );

ALTER TABLE asignacion
    ADD CONSTRAINT FK_Asignacion_Numero FOREIGN KEY ( numerofamilia )
        REFERENCES familia ( numero );


/*Eliminar datos de tablas*/
DELETE FROM adulto;

DELETE FROM telefono;

DELETE FROM persona;

DELETE FROM opinion;

DELETE FROM opiniongrupal;

DELETE FROM familia;

DELETE FROM localidad;

DELETE FROM reemplazo;

DELETE FROM alojamiento;

DELETE FROM vestuario;

DELETE FROM generico;

DELETE FROM perecedero;

DELETE FROM detalle;

DELETE FROM bien;

DELETE FROM asignacion;


/*Eliminar tablas*/

DROP TABLE adultos CASCADE CONSTRAINTS;

DROP TABLE telefono CASCADE CONSTRAINTS;

DROP TABLE alojamiento CASCADE CONSTRAINTS;

DROP TABLE asignacion CASCADE CONSTRAINTS;

DROP TABLE bien CASCADE CONSTRAINTS;

DROP TABLE detalle CASCADE CONSTRAINTS;

DROP TABLE familia CASCADE CONSTRAINTS;

DROP TABLE generico CASCADE CONSTRAINTS;

DROP TABLE localidad CASCADE CONSTRAINTS;

DROP TABLE opinion CASCADE CONSTRAINTS;

DROP TABLE opiniongrupal CASCADE CONSTRAINTS;

DROP TABLE perecedero CASCADE CONSTRAINTS;

DROP TABLE persona CASCADE CONSTRAINTS;

DROP TABLE reemplazo CASCADE CONSTRAINTS;

DROP TABLE vestuario CASCADE CONSTRAINTS;
