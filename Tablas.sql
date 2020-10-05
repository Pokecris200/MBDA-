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



/*POBLAR OK*/
/*Poblar proveedor*/
insert into proveedor (codigo, telefono, correo) values ('PROV9882', '3338956382', 'ocrew0@patch.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV6720', '3770117488', 'wbavridge1@eventbrite.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV8536', '3794267789', 'dcomazzo2@techcrunch.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV4671', '3964980191', 'cswayne4@mozilla.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV1401', '3497768940', 'jtessier5@qq.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV9446', '3241867988', 'wkeppy7@mac.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV8165', '3192708652', 'boliveti9@chicagotribune.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV4796', '3710490286', 'fvinesc@mtv.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV8478', '3665357231', 'gfeathersbye@alibaba.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV5130', '3493216823', 'mjaggsf@ft.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV8627', '3475434951', 'vesserg@patch.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV3202', '3501015479', 'abreffith@mozilla.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV2719', '3517039061', 'jsoggi@nationalgeographic.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV3470', '3907893294', 'rbendigk@bravesites.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV5474', '3341118703', 'fjocklen@wikispaces.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV4926', '3895814150', 'cmazeyp@multiply.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV3417', '3339365846', 'tlevesleyq@sitemeter.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV9593', '3440003835', 'jfearner@tinyurl.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV2588', '3868079623', 'vhullands@eepurl.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV9602', '3273499389', 'ccoggant@studiopress.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV8259', '3477805327', 'rbunclarku@cbsnews.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV5910', '3129032503', 'ebrabbenv@weibo.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV3405', '3179590064', 'vcolreinx@marriott.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV5938', '3327430183', 'glinturny@delicious.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV7677', '3192300851', 'pmousez@lycos.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV6264', '3396357747', 'aferrelli10@xing.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV4454', '3953590772', 'ldall11@wufoo.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV3381', '3209157600', 'rheaven15@bandcamp.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV9235', '3387476093', 'cwebbbowen18@canalblog.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV6594', '3160360478', 'apetras19@godaddy.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV3836', '3266407841', 'pdroogan1a@nytimes.com.co');
insert into proveedor (codigo, telefono, correo) values ('PROV2893', '3162013530', 'fhearne1d@mac.com.co');

/*poblar persona juridica*/
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Merle', 'Bafford', '2646547164', '4991564373', 'PROV9634');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Brook', 'Peasnone', '7674937716', '8062564273', 'PROV6943');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Darill', 'Scourfield', '3318698174', '91842101', 'PROV6301');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Farlay', 'Baison', '7163707759', '5688936768', 'PROV5822');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Packston', 'Challicombe', '1301301336', '4534703576', 'PROV6259');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Reiko', 'Wasielewski', '5694374324', '7170888138', 'PROV8527');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Octavia', 'Langan', '9403931218', '6482351732', 'PROV8719');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Alane', 'Stockey', '5859636959', '2732051229', 'PROV5053');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Denver', 'Coombs', '6914933795', '3847784600', 'PROV5572');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Danice', 'Botterill', '9259600185', '1955179391', 'PROV4570');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Tabbie', 'Pawelski', '602559424', '334469139', 'PROV3137');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Magnum', 'Weldrake', '2684290769', '4046322211', 'PROV3326');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Hewitt', 'Sandeford', '9163116132', '2594358903', 'PROV8141');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Ardath', 'Gauford', '4045355795', '450357811', 'PROV1976');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Klarika', 'Peyntue', '7977706063', '2689807491', 'PROV1029');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Dermot', 'Yanuk', '8331735632', '7479299337', 'PROV9474');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Tera', 'Rochelle', '3126298421', '1702447039', 'PROV9764');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Giles', 'Gyer', '8869157583', '5147186725', 'PROV9292');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Catha', 'Treacy', '303919245', '5874639938', 'PROV9589');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Woodrow', 'Milius', '2200593614', '581840331', 'PROV4692');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Mamie', 'Corteney', '1866371014', '8339758833', 'PROV9505');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Catherine', 'Olley', '521785770', '5961513731', 'PROV6107');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Jannel', 'Sijmons', '3126112083', '9155646628', 'PROV3007');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Kris', 'Uzzell', '9818066599', '2916698439', 'PROV5116');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Crysta', 'Duffill', '2547338625', '1990983428', 'PROV3895');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Perle', 'Eustes', '5036957672', '4282501985', 'PROV4877');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Burnard', 'Willgoss', '5664701024', '941058703', 'PROV8437');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Mignonne', 'Gooders', '9328557595', '3598874896', 'PROV9612');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Deerdre', 'Flockhart', '5772706671', '7796754610', 'PROV6213');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Ivory', 'Bewshea', '6399262880', '2100599914', 'PROV2338');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Valene', 'Loveridge', '254541454', '2173357140', 'PROV7857');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Emlyn', 'Gibbie', '3677271097', '2933174997', 'PROV1535');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Barry', 'Gillbee', '7978602875', '7793874141', 'PROV9679');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Nonie', 'Senecaux', '6146533800', '8783851828', 'PROV6650');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Sianna', 'Imore', '8533906731', '6936495252', 'PROV6348');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Amil', 'Statefield', '4762582669', '9778911474', 'PROV2129');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Jarret', 'Toombs', '8322833960', '1370602755', 'PROV1056');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Sinclair', 'Bullocke', '919246778', '2469109670', 'PROV1722');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Andy', 'Elms', '9068603792', '6602477725', 'PROV2243');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Sigismond', 'Marnes', '4670378999', '4196296128', 'PROV2257');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Tilly', 'Neaverson', '8351671306', '4709480136', 'PROV8030');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Robbie', 'Seys', '824852428', '742284201', 'PROV7601');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Fidelio', 'Brizell', '9697347210', '8698816415', 'PROV5945');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Lucretia', 'Lyne', '3941153266', '7955554736', 'PROV5488');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Woodman', 'Clohissy', '5817418611', '7637427293', 'PROV8630');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Galvin', 'Larroway', '5821942039', '8547496012', 'PROV4221');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Talbert', 'McAndrew', '6530191011', '7943840601', 'PROV3784');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Donal', 'Robyns', '9163333532', '1176919573', 'PROV9317');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Fleming', 'MacAlroy', '3938757935', '1796033101', 'PROV1500');
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Mildrid', 'MacWhan', '984698736', '8561114746', 'PROV5288');



/*POBLAR EMPRESA*/
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Skinder', '5361148873', 'PROV1041', '944 Loeprich Avenue', 'ApiaÃ­', '18320-000');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Reallinks', '5555350715', 'PROV5949', '0790 Barby Center', 'Sang-e ChÄ�rak', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Skajo', '5267377185', 'PROV7227', '2 Golf Course Plaza', 'VÃ¥rby', '143 31');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Skivee', '3390070094', 'PROV2266', '28821 Hoard Trail', 'Wolfville', 'B4P');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Demizz', '5713088262', 'PROV4653', '903 Sage Avenue', 'Kalininskiy', '646626');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Zoozzy', '9705336836', 'PROV6861', '683 Hauk Trail', 'Momanalu', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Kazio', '8961511471', 'PROV6163', '66 Drewry Street', 'Tejakalapa', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Jabbersphere', '1933727229', 'PROV6072', '3 Cascade Street', 'Coutada', '4910-035');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Shufflebeat', '9789489739', 'PROV8170', '1 Warbler Center', 'Alverca do Ribatejo', '2615-009');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Buzzdog', '1328799533', 'PROV4653', '72 Leroy Trail', 'Huping', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Yombu', '2893088592', 'PROV1596', '11 Doe Crossing Place', 'North Little Rock', '72118');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Flashspan', '6890596625', 'PROV3115', '05612 Crowley Alley', 'Cruces', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Zoonoodle', '2544922078', 'PROV2747', '3380 Caliangt Circle', 'Yefremov', '301871');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Skinix', '4074109215', 'PROV4881', '80 Prentice Circle', 'Lere', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Photospace', '9471117726', 'PROV5533', '10 Crescent Oaks Way', 'La Quebrada', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Zoozzy', '4496295673', 'PROV8453', '045 Park Meadow Court', 'Orzech', '41-922');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Jetwire', '6600549551', 'PROV3740', '60 Vernon Street', 'Beauvais', '60006 CEDEX');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Jatri', '5979074342', 'PROV4037', '24489 Anniversary Avenue', 'Ciheras', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('LiveZ', '7629213480', 'PROV8884', '5 Gale Drive', 'Barreiros', '4615-492');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Eadel', '3998428849', 'PROV3961', '976 Lerdahl Trail', 'TarÄ«m', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Browsetype', '1880384437', 'PROV1692', '97647 Lake View Crossing', 'Toshloq', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Fiveclub', '7564499830', 'PROV3117', '72719 Forster Park', 'Los Angeles', '90094');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Devbug', '6996713720', 'PROV7784', '335 Kingsford Place', 'Fuzhai', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Flipstorm', '5526270160', 'PROV7696', '4 Hovde Lane', 'Pedro Leopoldo', '33600-000');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Quaxo', '7407002103', 'PROV6349', '48047 Hoard Street', 'Salta', '4400');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Fliptune', '7659353610', 'PROV1204', '3590 Bluestem Pass', 'VelkÃ© Opatovice', '679 63');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Feedbug', '3092803790', 'PROV2460', '0 Springs Hill', 'Santa BÃ¡rbara', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Zoonder', '4817269288', 'PROV6293', '49691 Arizona Alley', 'Ashgabat', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Blogtag', '5095652104', 'PROV5998', '46 Crescent Oaks Pass', 'Dongpu', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Tagfeed', '1419036755', 'PROV4863', '80347 Mesta Drive', 'Mikhaylovsk', '243421');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Feedfire', '9803182251', 'PROV9359', '21702 Rowland Plaza', 'Honglin', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Eidel', '8458922581', 'PROV7294', '455 Dapin Hill', 'Pontevedra', '36005');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Zoovu', '9703371265', 'PROV7736', '465 Florence Street', 'Aksu', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Skyble', '2551927022', 'PROV6729', '28837 La Follette Drive', 'Erniusuokou', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Realpoint', '3209410691', 'PROV8194', '7 Mariners Cove Trail', 'Santo AntÃ³nio da Charneca', '2835-496');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Quinu', '6154288736', 'PROV4014', '37 5th Drive', 'Lidong', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Fanoodle', '1544459037', 'PROV4282', '55 Onsgard Place', 'Quzhou', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Edgeclub', '2970498950', 'PROV3885', '6 Morningstar Point', 'BoconÃ³', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Browsebug', '9277503515', 'PROV2162', '03839 Hoepker Place', 'Calibutbut', '1470');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Voolith', '7299973661', 'PROV7295', '1683 Forest Run Park', 'Sicheng', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Abata', '1972567702', 'PROV7583', '1254 Grasskamp Drive', 'Tver', '182647');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Thoughtmix', '5720963041', 'PROV7311', '96053 Burning Wood Park', 'Nokaneng', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Avamba', '2820183818', 'PROV6984', '3 Victoria Junction', 'Starobaltachevo', '452988');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Skinte', '2991015919', 'PROV3892', '89185 Jenifer Point', 'Potoci', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Dazzlesphere', '6248962543', 'PROV9449', '3962 Dawn Trail', 'Brok', '07-306');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Linklinks', '4603437089', 'PROV3535', '32369 Mitchell Hill', 'BafoulabÃ©', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Izio', '5798566555', 'PROV2977', '99551 Redwing Plaza', 'Tianhe', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Blogspan', '4234570585', 'PROV1589', '7 Red Cloud Avenue', 'Shcherbinka', '142720');
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Eamia', '9325591898', 'PROV3469', '3 Esker Circle', 'Wumahe', null);
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Twitterlist', '9101377365', 'PROV5105', '357 Milwaukee Junction', 'Embalse', '5856');

/*poblar provee*/
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV4938', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV8167', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV5860', 'Bodega Central');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV3830', 'Bodega Central');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV3851', 'Bodega San Martin');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV2721', 'Bodega La Esperanza');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV2994', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV9474', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV3501', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV3821', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV4935', 'Bodega San Martin');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV4504', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV5317', 'Bodega Central');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV7912', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV6907', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV1516', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV6465', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV9554', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV3109', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV8533', 'Bodega Central');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV6911', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV6082', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV9347', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV9903', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV6617', 'Bodega San Martin');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV2793', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV2888', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV4482', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV8295', 'Bodega La Esperanza');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV3123', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV7054', 'Bodega Central');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV5646', 'Bodega San Martin');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV2024', 'Bodega Central');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV6711', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV3999', 'Bodega La Esperanza');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV8318', 'Bodega La Esperanza');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV2796', 'Bodega Central');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV2764', 'Bodega La Esperanza');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV8372', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV7545', 'Bodega San Martin');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV1329', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV7221', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV5543', 'Bodega San Martin');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV9644', 'Bodega La Esperanza');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV8580', 'Bodega Central');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV4361', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV9249', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV3472', 'Bodega Chichimene 1');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV7582', 'Bodega San Juan 3');
insert into provee (codigo_proveedor, nombre_bodega) values ('PROV5941', 'Bodega San Juan 3');


/*poblar bodega*/
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Martin', 'Acacias', 'Meta');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Esperanza', 'Villavicencio', 'Meta');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene 1', 'Acacias', 'Meta');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 3', 'Villavicencio', 'Meta');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Central', 'Villavicencio', 'Meta');


/*poblar inventario*/




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
