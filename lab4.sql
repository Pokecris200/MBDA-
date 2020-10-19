/*Creacion de tablas*/
CREATE TABLE adultos (
    codigo   NUMBER(7) NOT NULL,
    cedula   VARCHAR(12) NOT NULL,
    correo   VARCHAR(40) NOT NULL
);

CREATE TABLE telefono (
    cedula     VARCHAR(12) NOT NULL,
    telefono   VARCHAR(12) NOT NULL
);
/*Refactorizacion de persona: Nos faltaba el atributo nuleable 'numero' para la persona*/
CREATE TABLE persona (
    codigo       NUMBER(7) NOT NULL,
    nombre       VARCHAR(50) NOT NULL,
    genero       VARCHAR(1) NOT NULL,
    talla        VARCHAR(3) NOT NULL,
    nacimiento   DATE NOT NULL,
    numero       NUMBER(5)
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
/*Refactorizacion: a tabla familia se le agrega el atributo nuleable 'codigo_representante'*/
CREATE TABLE familia (
    numero                 NUMBER(5) NOT NULL,
    codigo                 NUMBER(7) NOT NULL,
    nombre                 VARCHAR(15) NOT NULL,
    codigo_representante   NUMBER(7)
);

CREATE TABLE localidad (
    nombre         VARCHAR(15) NOT NULL,
    prioridad      NUMBER(1) NOT NULL,
    departamento   VARCHAR(15) NOT NULL
);

CREATE TABLE reemplazo (
    bien             VARCHAR(5) NOT NULL,
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
/*Refactorizacion: Se le agrega un valor al nuevo atributo hecho en la refactorizacion(numero)*/
INSERT INTO persona VALUES (
    6541258,
    'Jose maria Jimenez',
    'F',
    'M',
    TO_DATE('1990/08/20', 'yyyy/mm/dd'),
    15000
);

INSERT
    INTO persona
VALUES (
    1134502,
    'Alejandra Rodriguez',
    'F',
    'L',
    TO_DATE('1970/10/01', 'yyyy/mm/dd'),
    15001
);

INSERT INTO persona VALUES (
    8541535,
    'Maria Fernanda Forero',
    'F',
    'S',
    TO_DATE('1975/02/25', 'yyyy/mm/dd'),
    15001
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
/*Refactorizacion: Se le agrega al insert un valor al nuevo atributo (numero_representante)*/

INSERT INTO familia VALUES (
    22225,
    6541258,
    'Bosa',
    1574865
);

INSERT INTO familia VALUES (
    22226,
    1134502,
    'San Cristobal',
    1659486
);

INSERT INTO familia VALUES (
    22227,
    8541535,
    'Chapinero',
    9531547
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


/*Poblar NoOK*/
/*Poblar NoOK donde no se acepta los INSERT*/

INSERT INTO adultos VALUES (
    25698,
    79186597,
    NULL
);/*El correo no puede ser nulo*/

INSERT INTO telefono VALUES (
    NULL,
    3228369854
);/*La cedula es un string, cuando debe ser un numero que no supere los 12 digitos*/

INSERT INTO persona VALUES (
    315,
    'Santiago',
    'M',
    NULL,
    TO_DATE('2020/09/24', 'yyyy/mm/dd'),
    36541
);/*El atributo talla debe ser un numero, no puede ser nulo*/

INSERT INTO vestuario VALUES (
    NULL,
    32,
    678
);/*La cantidad de vestuario no puede ser nula*/

INSERT INTO familia VALUES (
    315,
    NULL,
    'Familia Gomez',
    6524187
);/*El atributo codigo debe ser un numero que o supere los 7 digitos, no puede ser nulo*/



/*Poblar NoOK donde aceptan los insert pero no deberia*/

INSERT INTO adultos VALUES (
    315,
    123,
    'diego.Forero@mail.com'
); /*No es posible que la cedula tenga tan pocos digitos*/

INSERT INTO persona VALUES (
    315,
    'Diego',
    'M',
    32,
    TO_DATE('2010/09/24', 'yyyy/mm/dd'),
    15001
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


/*Eliminar datos de tablas*/
DELETE FROM adultos;

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
    ADD CONSTRAINT ck_opinion_de_bien CHECK ( tipo IN (
        'G',
        'P',
        'V',
        'A'
    ) );
ALTER TABLE adultos
    ADD CONSTRAINT ck_cedula_adultos CHECK ( cedula BETWEEN 9999999999 AND 1000000000000 );
                                               

/*Revision de proteccion*/
/*Proteccion de cedula*/
/*ALTER TABLE persona
    ADD CONSTRAINT ck_cedula CHECK ( cedula BETWEEN 9999999999 AND 1000000000000 );    */
INSERT INTO adultos VALUES (
    315,
    123,
    'diego.Forero@mail.com'
); 
/*Proteccion de edad*/
/*ALTER TABLE persona
    ADD CONSTRAINT ck_edad CHECK ( extract(year.nacimiento) < 2003 );*/
INSERT INTO persona VALUES (
    315,
    'Diego',
    'M',
    32,
    TO_DATE('2010/09/24', 'yyyy/mm/dd'),
    12245
);

/*Proteccion de talla*/
/*ALTER TABLE vestuario
    ADD CONSTRAINT ck_talla_v CHECK ( talla IN (
        'XS',
        'S',
        'M',
        'L',
        'XL'
    ) );*/
INSERT INTO vestuario VALUES (
    2,
    'A',
    375
);

/*Proteccion nivel de localidad*/
/*ALTER TABLE localidad
    ADD CONSTRAINT ck_prioridad CHECK ( prioridad BETWEEN 0 AND 6 );
INSERT INTO localidad VALUES (
    'Chapinero',
    9,
    'Meta'
);*/


    

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
                                               
                                               
/*Consulta los bienes mas populares del ultimo mes*/
/*SELECT
    bien.tipo,
    COUNT(detalle.codigo)
FROM
    asignacion
    JOIN detalle ON asignacion.numero = detalle.numero
    JOIN bien ON detalle.codigo = bien.codigo
WHERE
    months_between(fecha, current_date) <= 1
GROUP BY
    bien.tipo;        */
    
/*Consulta las personas con edad mayor a 70 años*/
/*SELECT
    nombre
FROM
    persona
WHERE EXTRACT (YEAR(nacimiento))< 1951;*/



/*RESTRICCIONES PROCEDIMENTALES*/
/*El numero de la opinion y la fecha son valores automaticos*/
CREATE OR REPLACE TRIGGER Num_Fecha_Aut
BEFORE INSERT ON opinion
FOR EACH ROW
DECLARE
x INTEGER;
y INTEGER;
BEGIN
IF :New.numero IS Null AND :New.fecha IS NULL
THEN :New.numero := 1; :New.fecha := SYSDATE;
ELSE
SELECT MAX(numero) INTO y FROM opinion;
:New.numero := y+1;
:New.fecha := SYSDATE;
END IF;
END;
/
/*XDisparador*/
DROP TRIGGER Num_Fecha_Aut;   

/*No se pueden dar opiniones sobre bienes que han sido retirados.*/
CREATE OR REPLACE TRIGGER Opinion_retirado
BEFORE INSERT OR UPDATE ON opinion
FOR EACH ROW
DECLARE
x INTEGER;
BEGIN
SELECT retirado INTO x FROM bien
WHERE :New.codigo_bien = codigo;
IF x = 1
THEN RAISE_APPLICATION_ERROR(-10001,'No se pueden dar opiniones sobre bienes que han sido retirados.');
END IF;
END;
/

/*XDisparador*/
DROP TRIGGER Opinion_retirado;  

/*Las personas que dan la opinión deben pertenecer a una familia que ha aceptado recibir ese bien en una asignación de hace menos de tres meses.*/
       
    CREATE OR REPLACE TRIGGER asignacion_bien_tres_meses
    BEFORE INSERT OR UPDATE ON opinion
    FOR EACH ROW
    DECLARE
    x NUMBER;
    y NUMBER;
    z INTEGER;
    BEGIN
        SELECT
            asignacion.numerofamilia INTO x
        FROM persona 
        INNER JOIN asignacion 
        ON persona.numero = asignacion.numerofamilia
        WHERE :New.codigo = persona.codigo;
       
        SELECT
            MONTHS_BETWEEN(SYSDATE, fecha) INTO y
        FROM asignacion
        WHERE x = numerofamilia;
       
        SELECT
            aceptado INTO z
        FROM asignacion
        WHERE x = numerofamilia;
       
        IF y>3 AND z = 1
            THEN RAISE_APPLICATION_ERROR(-10002,'Las personas que dan la opinión deben pertenecer a una familia que ha aceptado recibir ese bien en una asignación de hace menos de tres meses.');
        END IF;
       
    END;
	/
	/*XDisparador*/
	DROP TRIGGER asignacion_bien_tres_meses;
    
    
    /* Si la opinión es M: alo, la justificación debe contener la palabra MALO y tener una longitud mayor a 10. */
   
    CREATE OR REPLACE TRIGGER justificacion_pesima
    BEFORE INSERT OR UPDATE ON opinion
    FOR EACH ROW
    BEGIN
    IF :New.opinion = 'M' AND (LENGTH(:New.justificacion)<= 10 OR UPPER(:New.justificacion) NOT LIKE('%MALO%'))
        THEN RAISE_APPLICATION_ERROR(-10003,'Si la opinión es M: alo, la justificación debe contener la palabra MALO y tener una longitud mayor a 10');
    END IF;
    END;
	/
	/*XDisparador*/
	DROP TRIGGER justificacion_pesima;
    
    
    
    /*Las opiniones grupales solo las puede dar el representante familiar*/
   
   CREATE OR REPLACE TRIGGER opiniones_familia BEFORE
    INSERT OR UPDATE ON opiniongrupal
    FOR EACH ROW
DECLARE
    x NUMBER;
BEGIN
    SELECT
        COUNT(familia.codigo)
    INTO x
    FROM
        familia
        JOIN opinion ON familia.codigo = opinion.codigo
    WHERE
        :new.numero = opinion.numero;

    IF x = 0 THEN
        raise_application_error(-10004, 'Las opiniones grupales solo las puede dar el representante familiar');
    END IF;
END;
/

	/*XDisparador*/
	DROP TRIGGER opiniones_familia;
    
    
    
/*Si no se dan las estrellas en una opinión grupal y existen evaluaciones de la familia para ese bien,
 las estrellas se calculan promediando los valores asociados a las opiniones (E 5, B 4, R 3, M 2)*/


CREATE OR REPLACE TRIGGER Promedio_estrellas BEFORE
    INSERT OR UPDATE ON opiniongrupal
    FOR EACH ROW
DECLARE
    x CHAR;
BEGIN SELECT
          opinion.opinion
      INTO x
      FROM
          opinion
      WHERE
          :new.numero = opinion.numero;
IF x = 'E' THEN
    :new.estrellas := 5;
ELSIF x = 'B' THEN
    :new.estrellas := 4;
ELSIF x = 'R' THEN
    :new.estrellas := 3;
ELSE
    :new.estrellas := 2;
END IF;

end;
/

	/*XDisparador*/
	DROP TRIGGER Promedio_estrellas;
    
    
    
/*El único dato a modificar es la justificación y el detalle. 
	El detalle sólo se puede modificar si no se ingreso al momento de adición.*/
	
CREATE OR REPLACE TRIGGER detalle_razon_modificar BEFORE
    UPDATE ON opiniongrupal
    FOR EACH ROW
BEGIN
    IF :new.numero != :old.numero OR :new.estrellas != :old.estrellas THEN
        raise_application_error(-10005, 'El unico dato valido para modificar es razon');
    END IF;

    IF :old.razon IS NOT NULL THEN
        raise_application_error(-10006, 'El detalle sólo se puede modificar si no se ingreso al momento de adición.');
    END IF;

END;
/

	
	/*XDisparador*/
	DROP TRIGGER detalle_razon_modificar;
    
    
    
    
/* Sólo es posible eliminar la opinión si es la última registrada. */

CREATE OR REPLACE TRIGGER eliminar_opinion BEFORE
    DELETE ON opinion
    FOR EACH ROW
DECLARE
    x INTEGER;
BEGIN
    SELECT
        MAX(numero)
    INTO x
    FROM
        opinion;

    IF :old.numero != x THEN
        raise_application_error(-10008, 'Sólo es posible eliminar la opinión si es la última registrada.');
    END IF;

END;
/
/*XDisparador*/
DROP TRIGGER eliminar_opinion;



/*El número, la fecha y el estado se generan automáticamente. */

CREATE OR REPLACE TRIGGER numero_fecha_asig BEFORE
    INSERT OR UPDATE ON asignacion
    FOR EACH ROW
DECLARE
    x INTEGER;
BEGIN
    SELECT
        MAX(numero)
    INTO x
    FROM
        asignacion;

    IF x IS NULL THEN
        :new.numero := 1;
    ELSE
        :new.numero := x + 1;
    END IF;

    :new.fecha := sysdate;
    :new.aceptado := 0;
END;
/
/*XDisparador*/
DROP TRIGGER numero_fecha_asig;




/*El numero de las personas del alojamiento debe ser menor o igual al numero de las personas de la familia*/

CREATE OR REPLACE TRIGGER personas_alojamiento BEFORE
    INSERT OR UPDATE ON alojamiento
    FOR EACH ROW
DECLARE
    x INTEGER;
BEGIN
    SELECT
        COUNT(persona.codigo)
    INTO x
    FROM
        detalle
        JOIN asignacion ON detalle.numero = asignacion.numero
        JOIN familia ON asignacion.numerofamilia = familia.numero
        JOIN persona ON familia.codigo = persona.codigo
    WHERE
        :new.orden = detalle.orden;

    IF x > :new.personas THEN
        raise_application_error(-20010, 'El numero de las personas del alojamiento debe ser menor o igual al numero de las personas de la familia'
        );
    END IF;

END;
/
/*XDisparador*/
DROP TRIGGER personas_alojamiento;



/* La talla del vestuario asignado debe corresponder a la talla de uno de los miembros de la familia*/

CREATE OR REPLACE TRIGGER talla_vestuario BEFORE
    INSERT OR UPDATE ON vestuario
    FOR EACH ROW
DECLARE
    x INTEGER(2);
BEGIN
    SELECT
        COUNT(p.talla)
    INTO x
    FROM
        detalle      d
        INNER JOIN asignacion   a ON d.numero = a.numero
        INNER JOIN familia      f ON f.numero = a.numerofamilia
        INNER JOIN persona      p ON p.numero = f.numero
    WHERE
        :new.orden = d.orden
        AND :new.talla = p.talla;

    IF x = 0 THEN
        raise_application_error(-20009, 'La talla del vestuario asignado debe corresponder a la talla de uno de los miembros de la
            familia '
        );
    END IF;
END;
/
/*XDisparador*/
DROP TRIGGER talla_vestuario;



/*La fecha de vencimiento de los alimentos perecederos deber ser minimo un mes despues de la fecha de asignacion*/
CREATE OR REPLACE TRIGGER fecha_vencimiento BEFORE
    INSERT OR UPDATE ON perecedero
    FOR EACH ROW
DECLARE
    x DATE;
BEGIN
    SELECT
        a.fecha
    INTO x
    FROM
        detalle       d
        INNER JOIN asignacion   a ON a.numero = d.numero
    WHERE
        :new.orden = d.orden;

    IF months_between(x, :new.vencimiento) < 1 THEN
        raise_application_error(-20009, 'La fecha fin de el alojamiento debe ser mayor a la fecha inicio.*/La fecha de vencimiento de los alimentos perecederos debe ser mínino un mes después de la
            fecha de asignación'
        );
    END IF;

END;
/
/*XDisparador*/
DROP TRIGGER fecha_vencimiento;


/*Solo pueden eliminar asignaciones que no esten aceptadas*/
CREATE OR REPLACE TRIGGER UP_Aceptacion
BEFORE DELETE ON asignacion
FOR EACH ROW
BEGIN
    IF :old.aceptado = 1 THEN
        RAISE_APPLICATION_ERROR(-89654, 'Solo pueden eliminar asignaciones que no esten aceptadas');
    END IF;
END;
/
/*XDisparador*/
DROP TRIGGER UP_Aceptacion;


/*Solamente se puede eliminar los alojaminetos despues de su fecha de fin.*/
CREATE OR REPLACE TRIGGER UP_Eliminacion_Alojamiento
BEFORE DELETE ON Alojamiento
FOR EACH ROW
BEGIN
    IF SYSDATE < :old.fin OR :old.fin is NULL THEN
        RAISE_APPLICATION_ERROR(-14522, 'Solamente se puede eliminar los alojaminetos despues de su fecha de fin.');
    END IF;
END;
/
/*XDisparador*/
DROP TRIGGER UP_Eliminacion_Alojamiento;



/*Todos los bienes al entrar se les coloca por defecto retirado en falso
Un bien no puede reemplazarse a si mismo*/
CREATE OR REPLACE TRIGGER UP_Bien_entrada
BEFORE INSERT ON bien
FOR EACH ROW
BEGIN
    :new.retirado := 0;
END;
/
CREATE OR REPLACE TRIGGER UP_BiReemplaza_entrada
BEFORE INSERT OR UPDATE ON reemplazo
FOR EACH ROW
BEGIN
    IF :new.Bien = :new.bien_reemplazo THEN
        RAISE_APPLICATION_ERROR(-54821, 'Un bien no puede reemplazarse a si mismo');
    END IF;
END;
/
/*XDisparador*/
DROP TRIGGER UP_Bien_entrada;
DROP TRIGGER UP_BiReemplaza_entrada;


/*No se pueden modificar ni el nombre, ni l codigo ni el tipo ni la medida de bien*/
CREATE OR REPLACE TRIGGER UP_Bien_Actu
BEFORE UPDATE ON bien
FOR EACH ROW
BEGIN
    IF :new.codigo != :old.codigo OR :new.nombre != :old.nombre OR :new.tipo != :old.tipo OR :new.medida != :old.medida THEN
        RAISE_APPLICATION_ERROR(-65421, 'No se pueden modificar ni el nombre, ni l codigo ni el tipo ni la medida de bien');
    END IF;
END;
/
/*XDisparador*/
DROP TRIGGER UP_Bien_Actu;

/*Solo se pueden eliminar los bienes retirados*/
CREATE OR REPLACE TRIGGER UP_Eliminacion_Bien
BEFORE DELETE ON bien
FOR EACH ROW
BEGIN
    IF :old.retirado = 0 THEN
        RAISE_APPLICATION_ERROR(-54821, 'Solo se pueden eliminar los bienes retirados');
    END IF;
END;
/
/*XDisparador*/
DROP TRIGGER UP_Eliminacion_Bien;




/*Eliminar datos de tablas*/
DELETE FROM adultos;

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
