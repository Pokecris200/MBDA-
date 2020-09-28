CREATE TABLE Cliente (
    tid         VARCHAR(2) NOT NULL,
    nid         NUMBER(15) NOT NULL,
    nombre      VARCHAR(20) NOT NULL,
    correo      VARCHAR(10),
    recomienda   NUMBER(15) NOT NULL
);
CREATE TABLE Telefono (
    telefono    NUMBER(10) NOT NULL,
    nid         NUMBER(15) NOT NULL
);
CREATE TABLE Factura (
    numero      NUMBER(5) NOT NULL,
    fecha       DATE NOT NULL,
    total       NUMBER(10,2) NOT NULL,
    nid         NUMBER(15) NOT NULL
);
CREATE TABLE LineaFactura (
    cantidad    NUMBER(10) NOT NULL,
    precio_venta NUMBER(10,2) NOT NULL,
    numero      NUMBER(5) NOT NULL,
    codigo      VARCHAR(5) NOT NULL
);
CREATE TABLE Bien (
    codigo      VARCHAR(5) NOT NULL,
    nombre      VARCHAR(20) NOT NULL,
    precio_venta NUMBER(10,2) NOT NULL
);
CREATE TABLE Servicio (
    mano_obra  NUMBER(10,2) NOT NULL,
    costo       NUMBER(10,2) NOT NULL,
    codigo      VARCHAR(5) NOT NULL
);
CREATE TABLE Servicio (
    existencias NUMBER(4) NOT NULL,
    precio_compra NUMBER(10,2) NOT NULL,
    codigo      VARCHAR(5) NOT NULL
);
CREATE TABLE Puedereemplazar (
    codigoin    VARCHAR(5) NOT NULL,
    codigoout   VARCHAR(5) NOT NULL
);
CREATE TABLE Utiliza (
    cantidad    NUMBER(10) NOT NULL,
    codigo_servicio  VARCHAR(5) NOT NULL,
    codigo_producto  VARCHAR(5) NOT NULL
);.

/*PRIMARY KEYS*/
/*CREACION CORRECTA DE PK*/
ALTER TABLE Cliente ADD CONSTRAINT PK_cliente_tid_nid PRIMARY KEY ( tid,
                                                                    nid );

ALTER TABLE Telefono ADD CONSTRAINT PK_telefonos_telefono PRIMARY KEY ( telefono );

ALTER TABLE Factura ADD CONSTRAINT PK_factura_numero PRIMARY KEY ( numero );

ALTER TABLE Lineafactura ADD CONSTRAINT PK_lineafact_numero PRIMARY KEY ( numero );

ALTER TABLE Bien ADD CONSTRAINT PK_bien_codigo PRIMARY KEY ( codigo );

ALTER TABLE Servicio ADD CONSTRAINT PK_servicio_codigo PRIMARY KEY ( codigo );

ALTER TABLE Producto ADD CONSTRAINT PK_producto_codigo PRIMARY KEY ( codigo );

ALTER TABLE Utiliza ADD CONSTRAINT PK_servicio_producto PRIMARY KEY ( codigo_servicio,
                                                                      codigo_producto );

ALTER TABLE Reemplazar ADD CONSTRAINT PK_in_out PRIMARY KEY ( codigo_in,
                                                              codigo_out );

/*UNIQUE KEYS*/
/*CREACION CORRECTAS DE UNIQUE KEYS*/
ALTER TABLE Cliente ADD CONSTRAINT UK_correo UNIQUE(correo);


/*FOREIGN KEYS*/
/*CREACION CORRECTA DE FOREIGN KEYS*/
ALTER TABLE Telefonos
    ADD CONSTRAINT FK_Telefonos_nid FOREIGN KEY ( nid )
        REFERENCES Cliente ( nid );
ALTER TABLE Factura
    ADD CONSTRAINT FK_Factura_nid FOREIGN KEY ( nid )
        REFERENCES Cliente ( nid );
ALTER TABLE LineaFactura
    ADD CONSTRAINT FK_LineaFactura_numero FOREIGN KEY ( numero )
        REFERENCES Factura ( numero );
ALTER TABLE LineaFactura
    ADD CONSTRAINT FK_LineaFactura_codigo FOREIGN KEY ( codigo )
        REFERENCES Bien ( codigo );
ALTER TABLE Servicio
    ADD CONSTRAINT FK_Servicio_codigo FOREIGN KEY ( codigo )
        REFERENCES Bien ( codigo );
ALTER TABLE Prducto
    ADD CONSTRAINT FK_Producto_codigo FOREIGN KEY ( codigo )
        REFERENCES Bien ( codigo );
ALTER TABLE Utiliza
    ADD CONSTRAINT FK_Utiliza_codigo_servicio FOREIGN KEY ( codigo_servicio )
        REFERENCES Servicio ( codigo );
ALTER TABLE Utiliza
    ADD CONSTRAINT FK_Utiliza_codigo_producto FOREIGN KEY ( codigo_producto )
        REFERENCES Producto ( codigo );
ALTER TABLE Reemplazar ADD CONSTRAINT FK_Codigoin FOREIGN KEY(codigoin) REFERENCES Producto(codigo);
ALTER TABLE Reemplazar ADD CONSTRAINT FK_Codigoout FOREIGN KEY(codigoout) REFERENCES Producto(codigo);


/*Restricciones*/

ALTER TABLE Bien ADD CONSTRAINT ck_Bien_moneda CHECK((precioventa AS NUMERIC(8))-precioventa = 0.00 OR (precioventa AS NUMERIC(8))-precioventa = 0.50 );
ALTER TABLE Factura ADD CONSTRAINT ck_Factura_moneda CHECK((total AS NUMERIC(8))-total = 0.00 OR (total AS NUMERIC(8))-total = 0.50 );
ALTER TABLE LineaFactura ADD CONSTRAINT ck_LineaFactura_moneda CHECK((precioventa AS NUMERIC(8))-precioventa = 0.00 OR (precioventa AS NUMERIC(8))-precioventa = 0.50 );
ALTER TABLE Producto ADD CONSTRAINT ck_Producto_moneda CHECK((preciocompra AS NUMERIC(8))-preciocompra = 0.00 OR (preciocompra AS NUMERIC(8))-preciocompra = 0.50 );
ALTER TABLE Servicio ADD CONSTRAINT ck_Servicio_moneda_1 CHECK((manodeobra AS NUMERIC(8))-manodeobra = 0.00 OR (manodeobra AS NUMERIC(8))-manodeobra = 0.50 );
ALTER TABLE Servicio ADD CONSTRAINT ck_Servicio_moneda_2 CHECK((costo AS NUMERIC(8))-costo = 0.00 OR (costo AS NUMERIC(8))-costo = 0.50 );
/*El precio de venta de los productos debe ser 10% mayor al de compra*/
                                                                                                      
CREATE ASSERTION Precio_venta AS CHECK(SELECT *
FROM Bien 
JOIN Producto ON Bien.codigo = Producto.codigo
WHERE Bien.precio_venta = Producto.precio_compra - (Producto.precio_compra*0.10));;

/*El precio de venta de los servicios debe ser 20% mayor a su costo*/
CREATE ASSERTION Precio_compra AS CHECK(SELECT *
FROM Bien 
JOIN Servicio ON Bien.codigo = Servicio.codigo
WHERE Bien.precio_venta = Servicio.costo - (Servicio.costo * 0.20 ););

/*MANTENER CLIENTE*/

/*TipoId puede tener uno de los siguientes valores CC (Cedula de ciudadania) , CE (Cedula de extranjería) o NT(Nit)*/
ALTER TABLE cliente ADD CONSTRAINT ck_id CHECK ( tid LIKE '[CC-CE-NT]' );

/*Un cliente debe tener mínimo un teléfono*/
ALTER TABLE telefono ADD CONSTRAINT ck_telefono CHECK ( telefono != NULL );

/*El nombre debe tener mínimo 10 caracteres*/
ALTER TABLE cliente
    ADD CONSTRAINT ck_nombre CHECK ( datalength(cliente.nombre) >= 10 );

/*El correo debe tener máximo un @ y un .*/
ALTER TABLE cliente
    ADD CONSTRAINT ck_correo CHECK ( ( LEN(correo) - datalength(REPLACE(correo, '@', '')) ) / LEN(correo) = 1
                                     AND ( LEN(correo) - DATALENGTH(REPLACE(correo, '.', '')) ) / LEN(correo) = 1 );
                                     
/*Un cliente no se puede auto-recomendar*/
ALTER TABLE cliente ADD CONSTRAINT ck_recomendacion CHECK ( recomienda != nid );
  
                                                                                                      
                                                                                                      
/*Triggers*/
CREATE OR REPLACE TRIGGER Eliminar_Factura
BEFORE DELETE ON Bien
BEGIN
    IF (EXISTS(SELECT *
                FROM Servicio
                JOIN Bien ON Bien.codigo = Servicio.codigo) 
        OR EXISTS(SELECT *
                  FROM Factura
                  JOIN LineaFactura ON Factura.numero = LineaFactura.numero
                  JOIN Bien ON LineaFactura.codigo = Bien.codigo))THEN
    RAISE 'No se puede borrar el bien ';
    END IF;
END;

CREATE OR REPLACE TRIGGER Nuevo_Codigo
AFTER INSERT ON Bien
BEGIN
    IF new.codigo = NULL THEN
        new.codigo := SUBSTR(new.nombre,0,5)
    END IF;
END;



CREATE OR REPLACE TRIGGER Eliminar_Cliente
BEFORE DELETE ON Cliente
BEGIN
    IF(EXISTS(SELECT *
              FROM Factura
              JOIN Cliente ON Cliente.nid = Factura.nid))THEN
    RAISE 'No se puede borrar el cliente ';
    END IF;
END;

CREATE OR REPLACE TRIGGER Nuevo_Correo
AFTER INSERT ON Bien
BEGIN
    IF new.correo = NULL THEN
        new.correo := TO_CHAR(new.nid)||'@vendemmos.com.co'
END;
