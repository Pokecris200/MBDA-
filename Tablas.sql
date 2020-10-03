/*CREACION DE TABLAS*/

CREATE TABLE proveedor (
    codigo     VARCHAR(8) NOT NULL,
    telefono   NUMBER(10) NOT NULL,
    correo     VARCHAR(15) NOT NULL
);

CREATE TABLE persona_juridica (
    nombre     VARCHAR(20) NOT NULL,
    apellido   VARCHAR(20) NOT NULL,
    cedula     NUMBER(10) NOT NULL,
    nit        NUMBER(10) NOT NULL,
    codigo     VARCHAR(8) NOT NULL
);

CREATE TABLE empresa (
    nombre             VARCHAR(25) NOT NULL,
    nit                NUMBER(10) NOT NULL,
    codigo             VARCHAR(8) NOT NULL,
    direccion          VARCHAR(50) NOT NULL,
    ciudad             VARCHAR(25) NOT NULL,
    direccion_postal   VARCHAR(6),
    telefono2          NUMBER(10)
);

CREATE TABLE provee (
    codigo_proveedor   VARCHAR(8) NOT NULL,
    nombre_bodega      VARCHAR(20) NOT NULL
    
);
CREATE TABLE bodega (
    nombre_bodega        VARCHAR(20) NOT NULL,
    municipio            VARCHAR(20) NOT NULL,
    departamento         VARCHAR(20) NOT NULL,
    proveedor            VARCHAR(8) NOT NULL
);

CREATE TABLE inventario (
    nombre_bodega           VARCHAR(20) NOT NULL,   
    numero_serie_pieza      NUMBER(6) NOT NULL,
    ID_inventario           VARCHAR(6) NOT NULL,
    disponibilidad          VARCHAR(13) NOT NULL
);

CREATE TABLE empleado (
    nombre                 VARCHAR(20) NOT NULL,
    apellido               VARCHAR(20) NOT NULL,
    id                     NUMBER(7) NOT NULL,
    cargo                  VARCHAR(25) NOT NULL,
    correo                 VARCHAR(15) NOT NULL,
    numero_telefonico      NUMBER(10) NOT NULL,
    departamento_trabajo   VARCHAR(20) NOT NULL,
    cedula                 NUMBER(10) NOT NULL
);

CREATE TABLE experto (
    id                         NUMBER(7) NOT NULL,
    departamento_experiencia   VARCHAR(20) NOT NULL
);

CREATE TABLE estado (
    numero_revision   NUMBER(7) NOT NULL,
    revisado_por      NUMBER(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    calidad           VARCHAR(1) NOT NULL,
    observaciones     VARCHAR(250) NOT NULL
);


CREATE TABLE permiso (
    numero_permiso    NUMBER(7) NOT NULL,
    id_autor          NUMBER(7) NOT NULL,
    numero_pieza      NUMBER(6) NOT NULL,
    detalle           VARCHAR(250) NOT NULL,
    estado            VARCHAR(8) NOT NULL,
    pedido            NUMBER(7)
);

CREATE TABLE pedido_pieza (
    numero_pedido          NUMBER(7) NOT NULL,
    id_autor               NUMBER(7) NOT NULL,
    departamento_trabajo   VARCHAR(20) NOT NULL,
    cantidad_piezas        NUMBER(5) NOT NULL,
    bodega_reclamo         VARCHAR(20) NOT NULL
);

CREATE TABLE pieza_extraccion_petrolera (
    numero_serie   NUMBER(6) NOT NULL,
    tipo           VARCHAR(15) NOT NULL,
    dimensiones    VARCHAR(10) NOT NULL
);


/*PRIMARY KEYS*/
ALTER TABLE empresa ADD CONSTRAINT pk_empresa_nit PRIMARY KEY ( nit );

ALTER TABLE persona_juridica ADD CONSTRAINT pk_juridica_cedula PRIMARY KEY ( cedula );

ALTER TABLE proveedor ADD CONSTRAINT pk_proveedor_codigo PRIMARY KEY ( codigo );

ALTER TABLE provee ADD CONSTRAINT pk_provee_codigos PRIMARY KEY ( codigo_proveedor,
                                                                  nombre_bodega );

ALTER TABLE bodega ADD CONSTRAINT pk_bodega_nombre PRIMARY KEY ( nombre_bodega );

ALTER TABLE inventario ADD CONSTRAINT pk_inventario_id PRIMARY KEY ( ID_inventario );

ALTER TABLE pieza_extraccion_petrolera ADD CONSTRAINT pk_numero_extraccion PRIMARY KEY ( numero_serie );

ALTER TABLE pedido_pieza ADD CONSTRAINT pk_numero_pedido PRIMARY KEY ( numero_pedido );

ALTER TABLE permiso ADD CONSTRAINT pk_numero_permiso PRIMARY KEY ( numero_permiso );

ALTER TABLE empleado ADD CONSTRAINT pk_empleado_id PRIMARY KEY ( id );

ALTER TABLE experto ADD CONSTRAINT pk_experto_id PRIMARY KEY ( id );

ALTER TABLE estado ADD CONSTRAINT pk_estado_revision PRIMARY KEY ( numero_revision );


/*UNIQUE KEYS*/

ALTER TABLE persona_juridica ADD CONSTRAINT uk_juridica_nit UNIQUE ( nit );

ALTER TABLE empresa ADD CONSTRAINT uk_empresa_nombre UNIQUE ( nombre );

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

ALTER TABLE inventario
    ADD CONSTRAINT fk_inventario_pieza FOREIGN KEY ( numero_serie_pieza )
        REFERENCES pieza_extraccion_petrolera ( numero_serie );    /*TOCA HACER LA RELACION ENTRE EMPLEADO Y EXPERTO, PUESTO QUE NO TENGO */

ALTER TABLE inventario
    ADD CONSTRAINT fk_inventario_bodega FOREIGN KEY ( nombre_bodega )
        REFERENCES bodega ( nombre_bodega );     /*NI PUTA IDEA DE CUAL PUEDE SER, Y NO ME SALE LA RESPUESTA DE LOS HUEVOS*/

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
    ADD CONSTRAINT fk_permiso_numero_pieza FOREIGN KEY ( numero_pieza )
        REFERENCES pieza_extraccion_petrolera ( numero_serie );

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
ALTER TABLE proveedor ADD CONSTRAINT ck_correo CHECK ( correo LIKE '%@petrolinventories.com.co' ); /*correo valido de la empresa termina asi*/

ALTER TABLE proveedor ADD CONSTRAINT ck_codigo CHECK ( codigo LIKE 'PROV%' );

ALTER TABLE proveedor
    ADD CONSTRAINT ck_telefono CHECK ( telefono BETWEEN 3000000000 AND 4000000000 );

ALTER TABLE persona_juridica
    ADD CONSTRAINT ck_juridica_cedula CHECK ( cedula BETWEEN 1000000000 AND 9999999999 );

ALTER TABLE persona_juridica
    ADD CONSTRAINT ck_juridica__nit CHECK ( nit BETWEEN 1000000000 AND 9999999999 );/*TOCAR METERLE PRIMERO EL LEN PARA QUE COJA LOS PRIMEROS 9 NUMEROS,AUNQUE TOCARIA CAMBIAR EL ATRIBUTO DE INT A VARCHAR, PERO POR EL MOMENTO SE DEJA COMO INT*/

ALTER TABLE persona_juridica ADD CONSTRAINT ck_juridica_codigo CHECK ( codigo LIKE 'PROV%' );

ALTER TABLE empresa
    ADD CONSTRAINT ck_empresa_nit CHECK ( nit BETWEEN 1000000000 AND 9999999999 );

ALTER TABLE empresa ADD CONSTRAINT ck_empresa_codgio CHECK ( codigo LIKE 'PROV%' );

ALTER TABLE provee ADD CONSTRAINT ck_provee_proveedor CHECK ( codigo_proveedor LIKE 'PROV%' );

ALTER TABLE provee ADD CONSTRAINT ck_provee_bodega CHECK ( nombre_bodega LIKE 'Bodega %' );

ALTER TABLE bodega ADD CONSTRAINT ck_bodega_nombre CHECK ( nombre_bodega LIKE 'Bodega %' );
       
        
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


