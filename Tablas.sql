/*CREACION DE TABLAS*/

CREATE TABLE proveedor (
    codigo     VARCHAR(8) NOT NULL,
    telefono   VARCHAR(10) NOT NULL,
    correo     VARCHAR(15) NOT NULL
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
    ciudad             VARCHAR(25) NOT NULL,
    direccion_postal   VARCHAR(6)
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
    cantidad_piezas        VARCHAR(5) NOT NULL,
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
        
        
/*RESTRICCIONES DECLARATIVAS*/
ALTER TABLE proveedor
    ADD CONSTRAINT ck_correo_proveer CHECK ( correo LIKE '%@%'
                                             AND correo LIKE '%.com.co' ); /*Restriccion para correo de proveedor*/

ALTER TABLE proveedor ADD CONSTRAINT ck_codigo CHECK ( codigo LIKE 'PROV%' );  /*Restriccion para codigo de proveedor*/

ALTER TABLE proveedor
    ADD CONSTRAINT ck_telefono CHECK ( substr(telefono, 1, 1) = '3'
                                       AND length(telefono) = 10 ); /*Restriccion para telefono de proveedor*/

ALTER TABLE persona_juridica
    ADD CONSTRAINT ck_juridica_cedula CHECK ( length(cedula) = 10 ); /*Restriccion para cedula de persona juridica */

ALTER TABLE persona_juridica
    ADD CONSTRAINT ck_juridica__nit CHECK ( length(nit) = 10 ); /*Restriccion para nit de la persona juridica*/

ALTER TABLE persona_juridica ADD CONSTRAINT ck_juridica_codigo CHECK ( codigo LIKE 'PROV%' ); /*Restriccion para codigo de persona juridica*/

ALTER TABLE empresa
    ADD CONSTRAINT ck_empresa_nit CHECK ( length(nit) = 10 ); /*Restriccion para nit de la empresa*/

ALTER TABLE empresa ADD CONSTRAINT ck_empresa_codgio CHECK ( codigo LIKE 'PROV%' ); /*Restriccion para codigo de la empresa*/

ALTER TABLE bodega ADD CONSTRAINT ck_bodega_nombre CHECK ( nombre_bodega LIKE 'Bodega %' ); /*Restriccion para nombre de la bodega*/

ALTER TABLE inventario
    ADD CONSTRAINT ck_disponible_inventario CHECK ( disponibilidad IN (
        'Disponible',
        'No Disponible'
    ) ); /*Restriccion de disponible en inventario*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_cargo CHECK ( cargo IN (
        'TECNICO ERA 1',
        'TECNICO ERA 2',
        'OPERADOR POZO',
        'RECORREDOR POZO',
        'INGENIERO PETROLERO POZO',
        'HSQE'
    ) ); /*Restriccion de cargos en empleado*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_correo CHECK ( correo LIKE ( '%@petrolinventories.com.co' ) ); /*Restriccion de correo en empleado*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_depto CHECK ( departamento_trabajo IN (
        'Pozos Petroleros'
    ) ); /*Restriccion de departamento en empleado*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_id CHECK ( substr(id, 1, 3) = '000' ); /*Restriccion de id de empleado*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_cedula CHECK ( length(cedula) = 10 ); /*Restriccion de cedula de empleado*/

ALTER TABLE empleado
    ADD CONSTRAINT ck_empleado_telefono CHECK ( numero_telefonico LIKE ( '%Ext.%' ) ); /*Restriccion de numero de empleado*/

ALTER TABLE experto
    ADD CONSTRAINT ck_experto_dpto CHECK ( departamento_experiencia IN (
        'Pozos Petroleros'
    ) ); /*Restriccion de departamento de experto*/

ALTER TABLE experto
    ADD CONSTRAINT ck_experto_id CHECK ( substr(id, 1, 3) = '001' ); /*Restriccion de id de experto*/

ALTER TABLE estado
    ADD CONSTRAINT ck_estado_calidad CHECK ( calidad IN (
        'E',
        'B',
        'R',
        'M',
        'P'
    ) ); /*Restriccion de calidad de estado*/

ALTER TABLE permiso
    ADD CONSTRAINT ck_permiso_estado CHECK ( estado IN (
        'Aceptado',
        'No Aceptado'
    ) ); /*Restriccion de aceptacion de permiso*/

ALTER TABLE pedido_pieza
    ADD CONSTRAINT ck_pedido_cantidad CHECK ( length(cantidad_piezas) <= 3 ); /*Restriccion de cantidad de piezas*/

ALTER TABLE pieza_extraccion_petrolera
    ADD CONSTRAINT ck_pieza_tipo CHECK ( tipo IN (
        'Engranajes',
        'Tornillos',
        'Soldadoras',
        'Tubos',
        'Perforadoras'
    ) ); /*Restriccion de tipos de pieza*/


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
