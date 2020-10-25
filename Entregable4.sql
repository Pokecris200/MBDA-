/*CREACION DE TABLAS*/

CREATE TABLE proveedor (
    codigo     VARCHAR(8) NOT NULL,
    telefono   VARCHAR(10) NOT NULL,
    correo     VARCHAR(50) NOT NULL
);

CREATE TABLE persona_juridica (
    nombre     VARCHAR(20) NOT NULL,
    apellido   VARCHAR(20) NOT NULL,
    cedula     VARCHAR(10) NOT NULL,
    nit        VARCHAR(10) NOT NULL,
    codigo     VARCHAR(8) NOT NULL
);

CREATE TABLE empresa (
    nombre             VARCHAR(25) NOT NULL,
    nit                VARCHAR(10) NOT NULL,
    codigo             VARCHAR(8) NOT NULL,
    direccion          VARCHAR(50) NOT NULL,
    ciudad             VARCHAR(50) NOT NULL,
    direccion_postal   VARCHAR(20)
);

CREATE TABLE provee (
    codigo_proveedor   VARCHAR(8) NOT NULL,
    nombre_bodega      VARCHAR(20) NOT NULL
    
);
CREATE TABLE bodega (
    nombre_bodega        VARCHAR(20) NOT NULL,
    municipio            VARCHAR(20) NOT NULL,
    departamento         VARCHAR(20) NOT NULL
);

CREATE TABLE inventario (
    nombre_bodega           VARCHAR(20) NOT NULL,   
    numero_serie_pieza      NUMBER(6) NOT NULL,
    id_inventarios          VARCHAR(6) NOT NULL,
    disponibilidad          VARCHAR(13) NOT NULL
);

CREATE TABLE revisa (
    id_empleado     VARCHAR(7) NOT NULL,
    id_inventario   VARCHAR(6) NOT NULL
);

CREATE TABLE empleado (
    nombre                 VARCHAR(20) NOT NULL,
    apellido               VARCHAR(20) NOT NULL,
    id                     VARCHAR(7) NOT NULL,
    cargo                  VARCHAR(25) NOT NULL,
    correo                 VARCHAR(15) NOT NULL,
    numero_telefonico      VARCHAR(20) NOT NULL,
    departamento_trabajo   VARCHAR(20) NOT NULL,
    cedula                 VARCHAR(10) NOT NULL
);

CREATE TABLE experto (
    id                         VARCHAR(7) NOT NULL,
    departamento_experiencia   VARCHAR(20) NOT NULL
);

CREATE TABLE estado (
    numero_revision   NUMBER(7) NOT NULL,
    revisado_por      VARCHAR(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    calidad           VARCHAR(1) NOT NULL,
    observaciones     VARCHAR(250) NOT NULL
);


CREATE TABLE permiso (
    numero_permiso    NUMBER(7) NOT NULL,
    id_autor          VARCHAR(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    detalle           VARCHAR(250) NOT NULL,
    estado            VARCHAR(13) NOT NULL,
    pedido            NUMBER(7)
);

CREATE TABLE pedido_pieza (
    numero_pedido          NUMBER(7) NOT NULL,
    id_autor               VARCHAR(7) NOT NULL,
    departamento_trabajo   VARCHAR(20) NOT NULL,
    cantidad_piezas        NUMBER(5) NOT NULL,
    estado                 VARCHAR(13) NOT NULL,
    bodega_reclamo         VARCHAR(20) NOT NULL
);

CREATE TABLE pieza_extraccion_petrolera (
    numero_serie   NUMBER(6) NOT NULL,
    tipo           VARCHAR(15) NOT NULL,
    dimensiones    VARCHAR(10) NOT NULL
);


/*
PRIMARY KEYS*/
ALTER TABLE empresa ADD CONSTRAINT pk_empresa_codigo PRIMARY KEY ( codigo );

ALTER TABLE persona_juridica ADD CONSTRAINT pk_juridica_codigo PRIMARY KEY ( codigo );

ALTER TABLE proveedor ADD CONSTRAINT pk_proveedor_codigo PRIMARY KEY ( codigo );

ALTER TABLE provee ADD CONSTRAINT pk_provee_codigos PRIMARY KEY ( codigo_proveedor,
                                                                  nombre_bodega );

ALTER TABLE bodega ADD CONSTRAINT pk_bodega_nombre PRIMARY KEY ( nombre_bodega );

ALTER TABLE inventario ADD CONSTRAINT pk_inventario_id PRIMARY KEY ( id_inventarios );

ALTER TABLE revisa ADD CONSTRAINT pk_revisa_inventario PRIMARY KEY ( id_inventario,
                                                                     id_empleado );

ALTER TABLE pieza_extraccion_petrolera ADD CONSTRAINT pk_numero_extraccion PRIMARY KEY ( numero_serie );

ALTER TABLE pedido_pieza ADD CONSTRAINT pk_numero_pedido PRIMARY KEY ( numero_pedido );

ALTER TABLE permiso ADD CONSTRAINT pk_numero_permiso PRIMARY KEY ( numero_permiso );

ALTER TABLE empleado ADD CONSTRAINT pk_empleado_id PRIMARY KEY ( id );

ALTER TABLE experto ADD CONSTRAINT pk_experto_id PRIMARY KEY ( id );

ALTER TABLE estado ADD CONSTRAINT pk_estado_revision PRIMARY KEY ( numero_revision );


/*UNIQUE KEYS*/

ALTER TABLE persona_juridica ADD CONSTRAINT uk_juridica_nit UNIQUE ( nit );

ALTER TABLE persona_juridica ADD CONSTRAINT uk_juridica_cedula UNIQUE ( cedula );

ALTER TABLE empresa ADD CONSTRAINT uk_empresa_nombre UNIQUE ( nombre );

ALTER TABLE empresa ADD CONSTRAINT uk_empresa_nit UNIQUE ( nit );

ALTER TABLE proveedor ADD CONSTRAINT uk_proveedor_telefono UNIQUE ( telefono );

ALTER TABLE proveedor ADD CONSTRAINT uk_proveedor_correo UNIQUE ( correo );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_correo UNIQUE ( correo );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_telefono UNIQUE ( numero_telefonico );

ALTER TABLE empleado ADD CONSTRAINT uk_empleado_cedula UNIQUE ( cedula );

ALTER TABLE pieza_extraccion_petrolera ADD CONSTRAINT uk_pieza_dimensiones UNIQUE ( dimensiones );



/*FOREIGN KEYS*/

ALTER TABLE empresa
    ADD CONSTRAINT fk_empresa_codigo FOREIGN KEY ( codigo )
        REFERENCES proveedor ( codigo );

ALTER TABLE persona_juridica
    ADD CONSTRAINT fk_persona_codigo FOREIGN KEY ( codigo )
        REFERENCES proveedor ( codigo );

ALTER TABLE provee
    ADD CONSTRAINT fk_provee_proveedor FOREIGN KEY ( codigo_proveedor )
        REFERENCES proveedor ( codigo );

ALTER TABLE provee
    ADD CONSTRAINT fk_provee_bodega FOREIGN KEY ( nombre_bodega )
        REFERENCES bodega ( nombre_bodega );
         
ALTER TABLE experto
    ADD CONSTRAINT fk_experto_identificador FOREIGN KEY ( id )
        REFERENCES empleado ( id );

ALTER TABLE inventario
    ADD CONSTRAINT fk_inventario_pieza FOREIGN KEY ( numero_serie_pieza )
        REFERENCES pieza_extraccion_petrolera ( numero_serie );   

ALTER TABLE inventario
    ADD CONSTRAINT fk_inventario_bodega FOREIGN KEY ( nombre_bodega )
        REFERENCES bodega ( nombre_bodega );    
        
ALTER TABLE revisa
    ADD CONSTRAINT fk_revisa_inventario FOREIGN KEY ( id_inventario )
        REFERENCES inventario ( id_inventarios );

ALTER TABLE revisa
    ADD CONSTRAINT fk_revisa_empleado FOREIGN KEY ( id_empleado )
        REFERENCES empleado ( id );

ALTER TABLE estado
    ADD CONSTRAINT fk_estado_revisado FOREIGN KEY ( revisado_por )
        REFERENCES experto ( id );

ALTER TABLE estado
    ADD CONSTRAINT fk_estado_pieza FOREIGN KEY ( numero_pieza )
        REFERENCES pieza_extraccion_petrolera ( numero_serie );

ALTER TABLE permiso
    ADD CONSTRAINT fk_permiso_id_autor FOREIGN KEY ( id_autor )
        REFERENCES empleado ( id );

ALTER TABLE permiso
    ADD CONSTRAINT fk_permiso_pedido FOREIGN KEY ( pedido )
        REFERENCES pedido_pieza ( numero_pedido );

ALTER TABLE pedido_pieza
    ADD CONSTRAINT fk_pedido_autor FOREIGN KEY ( id_autor )
        REFERENCES empleado ( id );

ALTER TABLE pedido_pieza
    ADD CONSTRAINT fk_pedido_bodega FOREIGN KEY ( bodega_reclamo )
        REFERENCES bodega ( nombre_bodega );
		
		
/*XPoblar*/
DELETE FROM proveedor;

DELETE FROM persona_juridica;

DELETE FROM empresa;

DELETE FROM provee;

DELETE FROM bodega;

DELETE FROM inventario;

DELETE FROM empleado;

DELETE FROM experto;

DELETE FROM estado;

DELETE FROM permiso;

DELETE FROM pedido_pieza;

DELETE FROM pieza_extraccion_petrolera;

DELETE FROM revisa;
        
        
        
/*RESTRICCIONES DECLARATIVAS*/



/*Restriccion para correo de proveedor*/
ALTER TABLE proveedor
    ADD CONSTRAINT ck_correo_proveer CHECK ( correo LIKE '%@%'
                                             AND correo LIKE '%.com.co' ); 
/*TuplasOK*/
INSERT INTO proveedor VALUES ('PROV2654','3118569787','ProveedorPrueba@gmail.com.co');
/*TuplasNoOK*/
INSERT INTO proveedor VALUES ('PROV1234','968574123','Nodebefuncionar@edu.com');



/*Restriccion para codigo de proveedor*/
ALTER TABLE proveedor ADD CONSTRAINT ck_proveedor_codigo CHECK ( codigo LIKE 'PROV%' ); 
/*TuplasOK*/
INSERT INTO proveedor VALUES ('PROV2656','3118569757','ProveedorPrueba1@gmail.com.co');
/*TuplasNoOK*/
INSERT INTO proveedor VALUES ('NOPE1234','968574123', 'Nodebefuncionar@edu.com.co');



/*Restriccion para cedula de persona juridica */
ALTER TABLE persona_juridica
    ADD CONSTRAINT ck_juridica_cedula CHECK ( length(cedula) = 10 );
/*TuplasOK*/
INSERT INTO persona_juridica VALUES ('Diego', 'González', '1007196612', '9685324658', 'PROV9659');
/*TuplasNoOK*/
INSERT INTO persona_juridica VALUES ('Cristian', 'Forero', '96532', '9685965658', 'PROV3025');   



/*Restriccion para nit de la persona juridica*/
ALTER TABLE persona_juridica
    ADD CONSTRAINT ck_juridica__nit CHECK ( length(nit) = 10 ); 
/*TuplasOK*/
INSERT INTO persona_juridica VALUES ('Juan', 'Castro', '96584632187', '6325982555', 'PROV6354');
/*TuplasNoOK*/
INSERT INTO persona_juridica VALUES ('Julian', 'Gonzalez', '9654329856', '9658742', 'PROV5698');   



/*Restriccion para codigo de persona juridica*/
ALTER TABLE persona_juridica ADD CONSTRAINT ck_juridica_codigo CHECK ( codigo LIKE 'PROV%' ); 
/*TuplasOK*/
INSERT INTO persona_juridica VALUES ('Danilo', 'Jurista', '9862542259', '9523641877', 'PROV6158');
/*TuplasNoOK*/
INSERT INTO persona_juridica VALUES ('Sofia', 'Gualteros', '9955446852', '2266551189', 'NOPE9526');  



/*Restriccion para nit de la empresa*/
ALTER TABLE empresa
    ADD CONSTRAINT ck_empresa_nit CHECK ( length(nit) = 10 ); 
/*TuplasOK*/
INSERT INTO empresa VALUES ('Sociedad de abogados SAS ', '9862542259','PROV6158', 'Carrera 5 sur numero 98-569', 'Bogotá', '500001');
/*TuplasNoOK*/
INSERT INTO empresa VALUES ('CODENSA SAS', '265874','PROV7584', 'Calle 9na numero 98-254', 'Bogotá', '500001');	


	
/*Restriccion para codigo de la empresa*/
ALTER TABLE empresa ADD CONSTRAINT ck_empresa_codgio CHECK ( codigo LIKE 'PROV%' ); 
/*TuplasOK*/
INSERT INTO empresa VALUES ('Empresa Nuevos Ingenieros', '27497223894','PROV6158', 'Calle novena numero 15-98', 'Villavicencio', '500004');
/*TuplasNoOK*/
INSERT INTO empresa VALUES ('Proveedor ECI libros', '7394057623','NOPE9674', 'Calle 230 norte numero 25-100', 'Bogotá', '100001');	



/*Restriccion para nombre de la bodega*/
ALTER TABLE bodega ADD CONSTRAINT ck_bodega_nombre CHECK ( nombre_bodega LIKE 'Bodega %' ); 
/*TuplasOK*/
INSERT INTO bodega VALUES ('Bodega Chichimene', 'Villavicencio', 'Meta');
/*TuplasNoOK*/
INSERT INTO bodega VALUES ('Centro de mercado San Fernando', 'San José', 'Guaviare');



/*Restriccion de cargos en empleado*/
ALTER TABLE empleado
    ADD CONSTRAINT ck_cargo CHECK ( cargo IN (
        'TECNICO ERA 1',
        'TECNICO ERA 2',
        'OPERADOR POZO',
        'RECORREDOR POZO',
        'INGENIERO PETROLERO POZO'
    ) ); 		
/*TuplasOK*/
INSERT INTO empleado VALUES ('Alejandro', 'Gonzalez', 'E000678', 'INGENIERO PETROLERO POZO', 'luis.gonzalez@petrolinventories.com.co', 'Ext. 985648', 'Pozos petroleros', '8521479632');
/*TuplasNoOK*/
INSERT INTO empleado VALUES ('Carlos', 'Fernandez', 'E000598', 'CEO PETROL INVENTORIES', 'carlos.fernandez@petrolinventories.com.co', 'Ext. 00001', 'Corporativo', '1155968547');


	
/*Restriccion de correo en empleado*/
ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_correo CHECK ( correo LIKE ( '%@petrolinventories.com.co' ) );
/*TuplasOK*/
INSERT INTO empleado VALUES ('Gonzalo', 'Pistacho', 'E0002547', 'TECNICO ERA 1', 'gonzalo.pistacho@petrolinventories.com.co', 'Ext. 9584621', 'Pozos petroleros', '1000589652');
/*TuplasNoOK*/
INSERT INTO empleado VALUES ('Jairo', 'Beltran', 'E000269', 'TECNICO ERA 2', 'carlos.fernandez@gmail.com', 'Ext. 9612587', 'Pozos petroleros', '526487166');


	
/*Restriccion de departamento en empleado*/
ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_depto CHECK ( departamento_trabajo IN (
        'Pozos Petroleros'
    ) ); 
/*TuplasOK*/
INSERT INTO empleado VALUES ('Sofia', 'Gualteros', 'E000532', 'INGENIERO PETROLERO POZO', 'sofia.gualteros@petrolinventories.com.co', 'Ext. 91664852', 'Pozos petroleros', '5262300015');
/*TuplasNoOK*/
INSERT INTO empleado VALUES ('Adolfo', 'Jimenez', 'E000614', 'TECNICO ERA 2', 'adolfo.jimenez@petrolinventories.com.co', 'Ext. 826481', 'Corporativo', '16588823654');


	
/*Restriccion de id de empleado*/
ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_id CHECK ( substr(id, 0, 3) = 'E000' ); 
/*TuplasOK*/
INSERT INTO empleado VALUES ('Jose', 'Valdiri', 'E000555', 'INGENIERO PETROLERO POZO', 'jose.valdiri@petrolinventories.com.co', 'Ext. 9164888', 'Pozos petroleros', '2229995684');
/*TuplasNoOK*/
INSERT INTO empleado VALUES ('Ana', 'Vizcaino', 'E012614', 'TECNICO ERA 2', 'ana.vizcaino@petrolinventories.com.co', 'Ext. 826481', 'Pozos petroleros', '1116668524');	
	
	
	
/*Restriccion de cedula de empleado*/
ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_cedula CHECK ( length(cedula) = 10 ); /*Restriccion de cedula de empleado*/
/*TuplasOK*/
INSERT INTO empleado VALUES ('Luis', 'Gonzalez', 'E000951', 'TECNICO ERA 1', 'luis.gonzalez@petrolinventories.com.co', 'Ext. 96652418', 'Pozos petroleros', '1596358788');
/*TuplasNoOK*/
INSERT INTO empleado VALUES ('Alejandra', 'Parra', 'E000962', 'TECNICO ERA 2', 'alejandra.parra@petrolinventories.com.co', 'Ext. 856241', 'Pozos petroleros', '1116');	


	
/*Restriccion de departamento de experto*/
ALTER TABLE experto
    ADD CONSTRAINT ck_experto_dpto CHECK ( departamento_experiencia IN (
        'Pozos Petroleros'
    ) ); 
/*TuplasOK*/
INSERT INTO empleado VALUES ('E100985','Pozos petroleros');
/*TuplasNoOK*/
INSERT INTO empleado VALUES ('E100521','Corporativos');
	


/*Restriccion de id de experto*/
ALTER TABLE experto
    ADD CONSTRAINT ck_experto_id CHECK ( substr(id, 0, 3) = 'E100' ); 
/*TuplasOK*/
INSERT INTO empleado VALUES ('E100985','Pozos petroleros');
/*TuplasNoOK*/
INSERT INTO empleado VALUES ('E001521','Pozos petroleros');	


	
/*Restriccion de calidad de estado*/
ALTER TABLE estado
    ADD CONSTRAINT ck_estado_calidad CHECK ( calidad IN (
        'E',
        'B',
        'R',
        'M',
        'P'
    ) ); 
/*TuplasOK*/
INSERT INTO estado VALUES (1265987, 'E100924', 196587, 'E', 'Pieza en buen estado');
/*TuplasNoOK*/
INSERT INTO estado VALUES (1625875, 'E100222', 665544, 'I', 'Pieza en buen estado');	



/*Restriccion de aceptacion de permiso*/
ALTER TABLE permiso
    ADD CONSTRAINT ck_permiso_estado CHECK ( estado IN (
        'Aceptado',
        'No Aceptado'
    ) ); 
/*TuplasOK*/
INSERT INTO permiso VALUES (1265987, 'E000986', 965244, 'Se necesita pieza para extraccion petrolera', 'Aceptado', 9988526);
/*TuplasNoOK*/
INSERT INTO permiso VALUES (5599228, 'E000228', 955568, 'Se necesita pieza para extraccion petrolera', 'No dado', null);



/*Restriccion autor de permiso*/
ALTER TABLE permiso
	ADD CONSTRAINT ck_autor_permiso CHECK ( substr(id_autor, 0, 3) = 'E000' );
/*TuplasOK*/
INSERT INTO permiso VALUES (1265987, 'E000111', 885522, 'Se necesita pieza para pozo numero 20 Chichimene', 'Aceptado', 6644775);
/*TuplasNoOK*/
INSERT INTO permiso VALUES (9922001, 'E123556', 663354, 'Se necesita pieza para extraccion petrolera', 'Aceptado', 8866225);



/*Restriccion de autor de pedido de piezas*/
ALTER TABLE pedido_pieza
    ADD CONSTRAINT ck_autor_pedido_pieza CHECK ( substr(id_autor, 0, 3) = 'E000' );
/*TuplasOK*/
INSERT INTO pedido_pieza VALUES (9154877, 'E000669', 'Pozos petroleros', '1500', 'Bodega Chichimene');
/*TuplasNoOK*/
INSERT INTO pedido_pieza VALUES (2299885, 'E159666', 'Pozos petroleros', '1234', 'Bodega Chichimene');	



/*Restriccion de bodegas en pedido*/
ALTER TABLE pedido_pieza 
	ADD CONSTRAINT ck_bodega_pedido CHECK( bodega_reclamo LIKE 'Bodega %' );
/*TuplasOK*/
INSERT INTO pedido_pieza VALUES (0065874, 'E000670', 'Pozos petroleros', '1600', 'Bodega Chichimene');
/*TuplasNoOK*/
INSERT INTO pedido_pieza VALUES (2299885, 'E000956', 'Pozos petroleros', '1235', 'Centro Chichimene');


/*Restriccion de departamento para pedidos*/
ALTER TABLE pedido_pieza
    ADD CONSTRAINT ck_pedido_dpto CHECK ( departamento_trabajo IN (
        'Pozos Petroleros'
    ) ); 	
/*TuplasOK*/
INSERT INTO pedido_pieza VALUES (1159865, 'E000533', 'Pozos petroleros', '1600', 'Bodega Chichimene');
/*TuplasNoOK*/
INSERT INTO pedido_pieza VALUES (9936547, 'E000225', 'Corporativo', '1235', 'Bodega Chichimene');


	
/*Restriccion de tipos de pieza*/	
ALTER TABLE pieza_extraccion_petrolera
    ADD CONSTRAINT ck_pieza_tipo CHECK ( tipo IN (
        'Engranajes',
        'Tornillos',
        'Soldadoras',
        'Tubos',
        'Perforadoras'
    ) ); 
/*TuplasOK*/
INSERT INTO pieza_extraccion_petrolera VALUES (956854, 'Engranajes', '3mm x 5mm x 8mm');
/*TuplasNoOK*/
INSERT INTO pieza_extraccion_petrolera VALUES (965874, 'Pozos pruebas', '5mm x 8mm x 11mm');



/*=========================================PROCEDIMENTALES=====================================*/
/*Mantener Pieza*/

/*El numero maximo de piezas que se pueden solicitar es 50*/
CREATE OR REPLACE TRIGGER Max_tubos
BEFORE INSERT ON PedidoPiezas
FOR EACH ROW
BEGIN
	IF :NEW.CantidadPiezas > 50 THEN
		RAISE_APPLICATION_ERROR(-15200,'El numero maximo de piezas que se pueden solicitar es 50');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO bodega VALUES('Bodega Chichimene', 'Villavicencio', 'Meta');
INSERT INTO empleado VALUES('Diego' 'Fernandez', 'E000949', 'INGENIERO PETROLERO POZO', 'diego.fernandez@petrolinventories.com.co', 'Ext. 956481', 'Pozos petroleros', '1007196548');
INSERT INTO pedido_pieza VALUES(9568471, 'E000949', 'Pozos petroleros', 25, 'Bodega Chichimene');
/*DisparadorNoOK*/
INSERT INTO bodega VALUES('Bodega Chichimene', 'Villavicencio', 'Meta');
INSERT INTO empleado VALUES('Luis' 'Parra', 'E000675', 'INGENIERO PETROLERO POZO', 'luis.parra@petrolinventories.com.co', 'Ext. 856412', 'Pozos petroleros', '9562844456');
INSERT INTO pedido_pieza VALUES(9658231, 'E000675', 'Pozos petroleros', 100, 'Bodega Chichimene');
/*XDisparador*/
DROP TRIGGER Max_tubos;



/*El numero de pedido se genera automaticamente y empieza en 1*/
CREATE OR REPLACE TRIGGER Id_Pedido
BEFORE INSERT ON PedidoPiezas
FOR EACH ROW
DECLARE x NUMBER;	
BEGIN
	SELECT MAX(numeropedido) INTO x
	FROM PedidoPiezas
	IF x IS NULL THEN
		:NEW.numeropedido := 1;
	ELSE
		:NEW.numeropedido := x+1;
	END IF;
END;
/
/*DisparadorOk*/
/*DisparadorNoOK*/
/*XDisparador*/
DROP TRIGGER Id_pedido;



/*Las dimensiones de las piezas no se pueden actualizar*/
CREATE OR REPLACE TRIGGER ACT_Dimensiones
BEFORE UPDATE ON PiezasExtraccionPetrolera
FOR EACH ROW
BEGIN
	IF :NEW.dimensiones != :OLD.dimensiones THEN
		RAISE_APPLICATION_ERROR(-200,'Las dimensiones de las piezas no se pueden actualizar');
	END IF;
END;
/
/*DisparadorOk*/
/*DisparadorNoOK*/
/*XDisparador*/
DROP TRIGGER ACT_Dimensiones;



/*No se pueden actualizar los pedidos que constan de Herramientas*/
CREATE OR REPLACE TRIGGER Pedidos_Herramientas
BEFORE UPDATE ON pedido_pieza
FOR EACH ROW
DECLARE tipoPedido VARCHAR;
BEGIN
	SELECT PiezasExtraccionPetrolera.tipo INTO tipoPedido
	FROM pedido_pieza
	JOIN permiso ON permiso.numero_permiso = pedido_pieza.NumeroPermiso                                  /*ARREGLAR ESTE TRIGGER*/
	JOIN PiezasExtraccionPetrolera ON permiso.NumeroSeriePieza = PiezasExtraccionPetrolera.NumeroSerie
	WHERE :NEW.NumeroPermiso = permiso.NumeroPermiso
	IF tipoPedido = 'Herramienta' THEN
		RAISE_APPLICATION_ERROR(-500,'No se pueden actualizar los pedidos que constan de Herramientas');
	END IF;
END;
/
/*DisparadorOk*/
/*DisparadorNoOK*/
/*XDisparador*/
DROP TRIGGER Pedidos_Herramientas;



/*solo se pueden actualizar pedidos si no estan aceptados*/
CREATE OR REPLACE TRIGGER Actualizacion_pedidos
BEFORE UPDATE ON pedido_pieza
FOR EACH ROW
BEGIN
	IF :OLD.estado = 'Aceptados' THEN
		RAISE_APPLICATION_ERROR(654,'Solo se pueden actualizar pedidos si no estan aceptados');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO empleado VALUES('Amparo' 'Cardenas', 'E000100', 'INGENIERO PETROLERO POZO', 'amparo.cardenas@petrolinventories.com.co', 'Ext. 552200', 'Pozos petroleros', '9921004877');
INSERT INTO bodega VALUES('Bodega Central', 'Cajicá', 'Cundinamarca');
INSERT INTO pieza_extraccion_petrolera VALUES(525298, 'Engranajes', '3mm x 10mm x 5mm');
INSERT INTO permiso VALUES(1295632,'E000100', 525298, 'Se necesita esta pieza para terminar la construccion de pozo numero 60', 'Aceptado', 9963251);
INSERT INTO pedido_pieza VALUES(9963251, 'E000100', 'Pozos petroleros', 21, 'No Aceptado', 'Bodega Central');
UPDATE pedido_pieza SET estado = 'Aceptado' AND cantidad_piezas = 20 WHERE pedido_pieza.numero_pedido = 9963251
/*DisparadorNoOK*/
INSERT INTO empleado VALUES('Andres' 'Lara', 'E000885', 'INGENIERO PETROLERO POZO', 'andres.lara@petrolinventories.com.co', 'Ext. 882214', 'Pozos petroleros', '1000653222');
INSERT INTO pieza_extraccion_petrolera VALUES(859632, 'Engranajes', '23mm x 104mm x 52mm');
INSERT INTO permiso VALUES(9922001,'E000885', 859632, 'Se necesita esta pieza para terminar la construccion de pozo numero 15', 'Aceptado', 9956214);
INSERT INTO pedido_pieza VALUES(9956214, 'E000885', 'Pozos petroleros', 14, 'Aceptado', 'Bodega Central');
UPDATE pedido_pieza SET cantidad_piezas = 20 AND bodega_reclamo = 'Bodega Chichimene' WHERE pedido_pieza.numero_pedido = 9956214
/*XDisparador*/
DROP TRIGGER Actualizacion_pedidos;



/*No se pueden eliminar pedidos Aceptados*/
CREATE OR REPLACE TRIGGER Eliminacion_Pedidos
BEFORE DELETE ON pedido_pieza
FOR EACH ROW
BEGIN
	IF :OLD.estado = 'Aceptado' THEN
		RAISE_APPLICATION_ERROR(654,'No se pueden eliminar pedidos Aceptados');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO empleado VALUES('Jose' 'Gualteros', 'E000999', 'INGENIERO PETROLERO POZO', 'jose.gualteros@petrolinventories.com.co', 'Ext. 859261', 'Pozos petroleros', '9563001587');
INSERT INTO bodega VALUES('Bodega Central', 'Cajicá', 'Cundinamarca');
INSERT INTO pieza_extraccion_petrolera VALUES(116695, 'Tubos', '3mm x 10mm x 5mm');
INSERT INTO permiso VALUES(1295632,'E000999', 116695, 'Se necesita esta pieza para terminar la construccion de pozo numero 15', 'Aceptado', 9956214);
INSERT INTO pedido_pieza VALUES(9956214, 'E000999', 'Pozos petroleros', 49, 'No Aceptado', 'Bodega Central');
DELETE FROM pedido_pieza WHERE pedido_pieza.id_autor = 'E000999';
/*DisparadorNoOK*/
INSERT INTO empleado VALUES('Clara' 'Gualteros', 'E000852', 'INGENIERO PETROLERO POZO', 'clara.gualteros@petrolinventories.com.co', 'Ext. 111159', 'Pozos petroleros', '9992651847');
INSERT INTO pieza_extraccion_petrolera VALUES(662351, 'Tubos', '4mm x 67mm x 123mm');
INSERT INTO permiso VALUES(9632511,'E000852', 662351, 'Se necesita esta pieza para terminar la construccion de pozo numero 54', 'Aceptado', 8596333);
INSERT INTO pedido_pieza VALUES(8596333, 'E000852', 'Pozos petroleros', 49, 'Aceptado', 'Bodega Central');
DELETE FROM pedido_pieza WHERE pedido_pieza.id_autor = 'E000852';
/*XDisparador*/
DROP TRIGGER Eliminacion_Pedidos;



/*================================================================================================================================*/
/*Mantener Personal*/

/*El id de los empleados se genera automaticamente y es incremental, teniendo en cuenta que los expertos empezan con la serie "E100" y el resto de empleados tienen la serie "E000"*/
CREATE OR REPLACE TRIGGER Id_Empleados
BEFORE INSERT ON empleado
FOR EACH ROW
DECLARE x NUMBER;	
BEGIN
	SELECT MAX(TO_NUMBER(SUBSTR(ID,4))) INTO x
	FROM empleado
	IF x IS NULL AND :NEW.cargo LIKE 'Experto%'THEN
		:NEW.ID := 'E1001';
	ELSIF x IS NULL THEN
		:NEW.ID := 'E0001';
	ELSIF :NEW.cargo LIKE 'Experto%' THEN
		:NEW.ID := 'E100' || TO_CHAR(x+1);
	ELSE
		:NEW.ID := 'E000' || TO_CHAR(x+1);
	END IF;
END;
/
/*DisparadorOk*/
/*DisparadorNoOK*/
/*XDisparador*/
DROP TRIGGER Id_Empleados;



/*Si los empleados no tienen un correo se le genera uno*/
CREATE OR REPLACE TRIGGER Generacion_Correo
AFTER INSERT ON empleado
FOR EACH ROW
DECLARE 
nombreC VARCHAR;
apellidoC VARCHAR;
codigo VARCHAR;
BEGIN
	nombreC := :NEW.nombre;
	apellidoC := :NEW.apellido;
	codigo := TO_CHAR(:NEW.codigo);
	IF :NEW.correo is NULL THEN
		:NEW.correo := nombreC || '.'|| apellidoC || '-' || codigo || '@petrolinventories.com';
	END IF;
END;
/
/*DisparadorOk*/
/*DisparadorNoOK*/                
/*XDisparador*/
DROP TRIGGER Generacion_Correo;



/*Solo se pueden actualizar El departamento de trabajo, el cargo y el numero de telefono*/
CREATE OR REPLACE TRIGGER TriggerActualizacion
BEFORE UPDATE ON empleado
FOR EACH ROW
BEGIN
	IF :NEW.nombre != :OLD.nombre OR :NEW.apellido != :OLD.apellido OR :NEW.ID != :OLD.ID OR :NEW.correo != :OLD.correo OR :NEW.cedula != :OLD.cedula THEN
		RAISE_APPLICATION_ERROR(-1000,'Solo se pueden actualizar El departamento de trabajo, el cargo y el numero de telefono');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO empleado VALUES('Ana' 'Bernal', 'E000956', 'INGENIERO PETROLERO POZO', 'ana.bernal@petrolinventories.com.co', 'Ext. 859261', 'Pozos petroleros', '9563001587');
UPDATE empleado SET departamento_trabajo = 'Corporativo' WHERE empleado.id = 'E000956';
UPDATE empleado SET cargo = 'TECNICO ERA 1' WHERE empleado.id = 'E000956';
UPDATE empleado SET numero_telefonico = 'Ext. 888562' WHERE empleado.id = 'E000956';
/*DisparadorNoOK*/
INSERT INTO empleado VALUES('Juan' 'Bernal', 'E000123', 'TECNICO ERA 1', 'juan.bernal@petrolinventories.com.co', 'Ext. 165922', 'Pozos petroleros', '9992658741');
UPDATE empleado SET id = 'E100888' WHERE empleado.id = 'E000123';
/*XDisparador*/
DROP TRIGGER TriggerActualizacion



/*No se puede actualizar el departamento de experiencia*/
CREATE OR REPLACE TRIGGER TriggerExperto
BEFORE UPDATE ON experto
FOR EACH ROW
BEGIN
	IF :OLD.Departamento_Experiencia != :NEW.Departamento_Experiencia THEN
		RAISE_APPLICATION_ERROR(-1001,'No se puede actualizar el departamento de experiencia');
	END IF;
END;
/
/*DisparadorOk*/
INSERT INTO empleado VALUES('Diego' 'Chicuazque', 'E100010', 'TECNICO ERA 1', 'diego.chicuazuque@petrolinventories.com.co', 'Ext. 856321', 'Pozos petroleros', '9562315487');
UPDATE empleado SET id = 'E100918' WHERE empleado.id = 'E100010';
INSERT INTO experto VALUES('E100010','Pozos petroleros');
UPDATE experto SET id = 'E100918' WHERE experto.id = 'E100010';
/*DisparadorNoOK*/
INSERT INTO empleado VALUES('Gabriel' 'Silva', 'E100662', 'TECNICO ERA 2', 'gabriel.silva@petrolinventories.com.co', 'Ext. 859632', 'Pozos petroleros', '9955228814');
INSERT INTO experto VALUES('E100662','Pozos petroleros');
UPDATE experto SET id_empleado = 'Corporativo' WHERE experto.id = 'E100662';
/*XDisparador*/
DROP TRIGGER TriggerExperto;




/*Eliminar datos*/
DELETE FROM proveedor;

DELETE FROM persona_juridica;

DELETE FROM empresa;

DELETE FROM provee;

DELETE FROM bodega;

DELETE FROM inventario;

DELETE FROM empleado;

DELETE FROM experto;

DELETE FROM estado;

DELETE FROM permiso;

DELETE FROM pedido_pieza;

DELETE FROM pieza_extraccion_petrolera;

DELETE FROM revisa;


/*ELIMINAR TABLAS*/
DROP TABLE proveedor CASCADE CONSTRAINTS;

DROP TABLE persona_juridica CASCADE CONSTRAINTS;

DROP TABLE empresa CASCADE CONSTRAINTS;

DROP TABLE provee CASCADE CONSTRAINTS;

DROP TABLE bodega CASCADE CONSTRAINTS;

DROP TABLE inventario CASCADE CONSTRAINTS;

DROP TABLE empleado CASCADE CONSTRAINTS;

DROP TABLE experto CASCADE CONSTRAINTS;

DROP TABLE estado CASCADE CONSTRAINTS;

DROP TABLE permiso CASCADE CONSTRAINTS;

DROP TABLE pedido_pieza CASCADE CONSTRAINTS;

DROP TABLE pieza_extraccion_petrolera CASCADE CONSTRAINTS;

DROP TABLE revisa CASCADE CONSTRAINTS;
