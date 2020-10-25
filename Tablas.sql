/*CREACION DE TABLAS*/

CREATE TABLE proveedor (
    codigo     VARCHAR(8) NOT NULL,
    telefono   VARCHAR(10) NOT NULL,
    correo     VARCHAR(250) NOT NULL
);

CREATE TABLE persona_juridica (
    nombre     VARCHAR(50) NOT NULL,
    apellido   VARCHAR(50) NOT NULL,
    cedula     VARCHAR(10) NOT NULL,
    nit        VARCHAR(10) NOT NULL,
    codigo     VARCHAR(8) NOT NULL
);

CREATE TABLE empresa (
    nombre             VARCHAR(100) NOT NULL,
    nit                VARCHAR(10) NOT NULL,
    codigo             VARCHAR(8) NOT NULL,
    direccion          VARCHAR(250) NOT NULL,
    ciudad             VARCHAR(50) NOT NULL,
    direccion_postal   VARCHAR(20)
);

CREATE TABLE provee (
    codigo_proveedor   VARCHAR(8) NOT NULL,
    nombre_bodega      VARCHAR(100) NOT NULL
    
);
CREATE TABLE bodega (
    nombre_bodega        VARCHAR(100) NOT NULL,
    municipio            VARCHAR(100) NOT NULL,
    departamento         VARCHAR(100) NOT NULL
);

CREATE TABLE inventario (
    nombre_bodega           VARCHAR(100) NOT NULL,   
    numero_serie_pieza      NUMBER(6) NOT NULL,
    id_inventarios          VARCHAR(6) NOT NULL,
    disponibilidad          VARCHAR(13) NOT NULL
);

CREATE TABLE revisa (
    id_empleado     VARCHAR(7) NOT NULL,
    id_inventario   VARCHAR(6) NOT NULL
);

CREATE TABLE empleado (
    nombre                 VARCHAR(100) NOT NULL,
    apellido               VARCHAR(100) NOT NULL,
    id                     VARCHAR(7) NOT NULL,
    cargo                  VARCHAR(100) NOT NULL,
    correo                 VARCHAR(250) NOT NULL,
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
    dimensiones    VARCHAR(50) NOT NULL
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

ALTER TABLE empleado
    ADD CONSTRAINT ck_cargo CHECK ( cargo IN (
        'TECNICO ERA 1',
        'TECNICO ERA 2',
        'OPERADOR POZO',
        'RECORREDOR POZO',
        'INGENIERO PETROLERO POZO'
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
    ADD CONSTRAINT ck_empleado_telefono CHECK ( length(numero_telefonico) = 10 ); /*Restriccion de numero de empleado*/

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
insert into empresa (nombre, nit, codigo, direccion, ciudad, direccion_postal) values ('Reallinks', '5555350715', 'PROV5949', '0790 Barby Center', 'Sang-e ChÄ?rak', null);
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
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 946516, 'SAM946', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 125605, 'ESP125', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 984987, 'CHI984', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 362768, 'JUA362', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 337878, 'CEN337', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 465296, 'SAM465', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 489544, 'ESP489', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 513603, 'CHI513', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 293195, 'JUA293', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 215278, 'CEN215', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 596417, 'SAM596', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 376338, 'ESP376', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 481519, 'CHI481', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 924577, 'JUA924', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 862218, 'CEN862', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 882518, 'SAM882', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 166629, 'ESP166', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 720420, 'CHI720', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 528016, 'JUA528', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 258343, 'CEN258', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 228777, 'SAM228', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 826756, 'ESP826', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 332636, 'CHI332', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 416563, 'JUA416', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 487864, 'CEN487', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 415538, 'SAM415', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 814811, 'ESP814', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 236740, 'CHI236', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 201114, 'JUA201', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 765432, 'CEN765', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 868597, 'SAM868', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 592126, 'ESP592', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 131991, 'CHI131', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 242300, 'JUA242', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 634243, 'CEN634', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 810661, 'SAM810', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 399668, 'ESP399', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 104360, 'CHI104', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 504739, 'JUA504', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 422152, 'CEN422', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 854625, 'SAM854', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 637843, 'ESP637', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 430958, 'CHI430', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 360318, 'JUA360', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 248072, 'CEN248', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 155215, 'SAM155', 'No Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 298140, 'ESP298', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 979714, 'CHI979', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 913522, 'JUA913', 'Disponible');
    insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 628153, 'CEN628', 'Disponible');

/*poblar revisa*/
insert into revisa (id_empleado, id_inventario) values ('0006293', 'CEN628');
insert into revisa (id_empleado, id_inventario) values ('0004906', 'JUA913');
insert into revisa (id_empleado, id_inventario) values ('0002182', 'CHI979');
insert into revisa (id_empleado, id_inventario) values ('0009154', 'ESP298');
insert into revisa (id_empleado, id_inventario) values ('0007500', 'SAM155');
insert into revisa (id_empleado, id_inventario) values ('0007731', 'CEN248');
insert into revisa (id_empleado, id_inventario) values ('0006893', 'JUA360');
insert into revisa (id_empleado, id_inventario) values ('0001860', 'CHI430');
insert into revisa (id_empleado, id_inventario) values ('0005180', 'ESP637');
insert into revisa (id_empleado, id_inventario) values ('0001854', 'SAM854');
insert into revisa (id_empleado, id_inventario) values ('0005376', 'CEN422');
insert into revisa (id_empleado, id_inventario) values ('0009289', 'JUA504');
insert into revisa (id_empleado, id_inventario) values ('0005279', 'JUA905');
insert into revisa (id_empleado, id_inventario) values ('0004786', 'CEN987');
insert into revisa (id_empleado, id_inventario) values ('0002369', 'CHI456');
insert into revisa (id_empleado, id_inventario) values ('0003554', 'ESP322');
insert into revisa (id_empleado, id_inventario) values ('0005132', 'SAM523');
insert into revisa (id_empleado, id_inventario) values ('0001304', 'CHI951');
insert into revisa (id_empleado, id_inventario) values ('0002303', 'CEN615');
insert into revisa (id_empleado, id_inventario) values ('0002500', 'JUA639');

/*poblar empleado*/
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Viviyan', 'Gladding', '0001942', 'RECORREDOR POZO', 'ViviyanGladding@petrolinventories.com.co', '3852382727', 'Pozos Petroleros', 1718450976);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Son', 'Franek', '0008853', 'TECNICO ERA 1', 'SonFranek@petrolinventories.com.co', '3122819922', 'Pozos Petroleros', 5285573065);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Regen', 'Knightly', '0005074', 'OPERADOR POZO', 'RegenKnightly@petrolinventories.com.co', '3794344472', 'Pozos Petroleros', 2164189008);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Melisandra', 'Pottberry', '0001537', 'TECNICO ERA 1', 'MelisandraPottberry@petrolinventories.com.co', '3311177339', 'Pozos Petroleros', 4639359135);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Rodge', 'Vittle', '0005674', 'INGENIERO PETROLERO POZO', 'RodgeVittle@petrolinventories.com.co', '3264494056', 'Pozos Petroleros', 5612910279);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Pippa', 'Mees', '0007892', 'TECNICO ERA 1', 'PippaMees@petrolinventories.com.co', '3135328019', 'Pozos Petroleros', 8944603443);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Marji', 'Geri', '0005908', 'TECNICO ERA 1', 'MarjiGeri@petrolinventories.com.co', '3751356880', 'Pozos Petroleros', 967222405);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Modestine', 'Liebermann', '0001034', 'TECNICO ERA 1', 'ModestineLiebermann@petrolinventories.com.co', '3951321721', 'Pozos Petroleros', 2844275606);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Foss', 'Week', '0001466', 'RECORREDOR POZO', 'FossWeek@petrolinventories.com.co', '3683180543', 'Pozos Petroleros', 3759747616);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Thorn', 'Merrington', '0003879', 'TECNICO ERA 2', 'ThornMerrington@petrolinventories.com.co', '3960075492', 'Pozos Petroleros', 5134716524);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Curt', 'Durdy', '0003886', 'TECNICO ERA 2', 'CurtDurdy@petrolinventories.com.co', '3980855536', 'Pozos Petroleros', 8569103013);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Udell', 'Kulicke', '0002749', 'TECNICO ERA 2', 'UdellKulicke@petrolinventories.com.co', '3310767547', 'Pozos Petroleros', 4167066642);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Randy', 'Frodsham', '0009069', 'OPERADOR POZO', 'RandyFrodsham@petrolinventories.com.co', '3331826111', 'Pozos Petroleros', 4398189651);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Dulciana', 'Bulle', '0005327', 'TECNICO ERA 1', 'DulcianaBulle@petrolinventories.com.co', '3474789533', 'Pozos Petroleros', 7191655759);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Ansley', 'Hallford', '0009711', 'TECNICO ERA 1', 'AnsleyHallford@petrolinventories.com.co', '3149117079', 'Pozos Petroleros', 3301350680);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Cicely', 'Snelman', '0007802', 'OPERADOR POZO', 'CicelySnelman@petrolinventories.com.co', '3873301064', 'Pozos Petroleros', 2828224019);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Chaddie', 'Yeskin', '0001136', 'TECNICO ERA 2', 'ChaddieYeskin@petrolinventories.com.co', '3218149602', 'Pozos Petroleros', 2509873259);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Boycey', 'Gough', '0006641', 'OPERADOR POZO', 'BoyceyGough@petrolinventories.com.co', '3314994379', 'Pozos Petroleros', 7760288912);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Aloisia', 'Dreelan', '0007275', 'RECORREDOR POZO', 'AloisiaDreelan@petrolinventories.com.co', '3128954172', 'Pozos Petroleros', 7501186520);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Ronny', 'De Michetti', '0004975', 'TECNICO ERA 1', 'RonnyDe Michetti@petrolinventories.com.co', '3667093038', 'Pozos Petroleros', 9089700608);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Bobbette', 'Kellen', '0009561', 'OPERADOR POZO', 'BobbetteKellen@petrolinventories.com.co', '3864392173', 'Pozos Petroleros', 1905563139);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Arvin', 'Rusk', '0001667', 'OPERADOR POZO', 'ArvinRusk@petrolinventories.com.co', '3871759952', 'Pozos Petroleros', 8733277163);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Cal', 'Rosborough', '0006174', 'INGENIERO PETROLERO POZO', 'CalRosborough@petrolinventories.com.co', '3137838632', 'Pozos Petroleros', 8101712684);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Patty', 'Bachshell', '0001944', 'INGENIERO PETROLERO POZO', 'PattyBachshell@petrolinventories.com.co', '3660580942', 'Pozos Petroleros', 738563919);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Gweneth', 'Grishukhin', '0005916', 'RECORREDOR POZO', 'GwenethGrishukhin@petrolinventories.com.co', '3140065381', 'Pozos Petroleros', 7040378517);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Pinchas', 'Sutherby', '0005934', 'OPERADOR POZO', 'PinchasSutherby@petrolinventories.com.co', '3881188840', 'Pozos Petroleros', 8755791383);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Chilton', 'Cantor', '0006321', 'RECORREDOR POZO', 'ChiltonCantor@petrolinventories.com.co', '3334347113', 'Pozos Petroleros', 2060176268);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Silvain', 'O''Downe', '0009218', 'TECNICO ERA 1', 'SilvainO''Downe@petrolinventories.com.co', '3407518899', 'Pozos Petroleros', 1599416737);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Sarine', 'Bremond', '0006084', 'OPERADOR POZO', 'SarineBremond@petrolinventories.com.co', '3726147567', 'Pozos Petroleros', 9564648158);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Kaylee', 'Metson', '0001873', 'OPERADOR POZO', 'KayleeMetson@petrolinventories.com.co', '3875189820', 'Pozos Petroleros', 4893527265);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Chery', 'Proger', '0004962', 'TECNICO ERA 1', 'CheryProger@petrolinventories.com.co', '3241407145', 'Pozos Petroleros', 4347238146);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Vikky', 'McQuaide', '0001641', 'INGENIERO PETROLERO POZO', 'VikkyMcQuaide@petrolinventories.com.co', '3781900090', 'Pozos Petroleros', 5771689526);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Vasily', 'Doveston', '0003363', 'TECNICO ERA 1', 'VasilyDoveston@petrolinventories.com.co', '3857399024', 'Pozos Petroleros', 9177768285);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Jenilee', 'Glazer', '0001859', 'RECORREDOR POZO', 'JenileeGlazer@petrolinventories.com.co', '3704514033', 'Pozos Petroleros', 8735573701);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Leelah', 'Harbisher', '0006921', 'OPERADOR POZO', 'LeelahHarbisher@petrolinventories.com.co', '3934297129', 'Pozos Petroleros', 9679452702);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Herschel', 'Browne', '0007953', 'TECNICO ERA 1', 'HerschelBrowne@petrolinventories.com.co', '3960465348', 'Pozos Petroleros', 1698367113);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Zia', 'Haskayne', '0002923', 'INGENIERO PETROLERO POZO', 'ZiaHaskayne@petrolinventories.com.co', '3626726503', 'Pozos Petroleros', 9128434453);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Hollie', 'Klassman', '0001161', 'INGENIERO PETROLERO POZO', 'HollieKlassman@petrolinventories.com.co', '3625976027', 'Pozos Petroleros', 2052315337);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Keelby', 'Becom', '0005678', 'INGENIERO PETROLERO POZO', 'KeelbyBecom@petrolinventories.com.co', '3374187021', 'Pozos Petroleros', 2743029979);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Jefferson', 'Augustus', '0003750', 'OPERADOR POZO', 'JeffersonAugustus@petrolinventories.com.co', '3343103963', 'Pozos Petroleros', 2021524299);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Kimbell', 'Symmers', '0003354', 'INGENIERO PETROLERO POZO', 'KimbellSymmers@petrolinventories.com.co', '3323704344', 'Pozos Petroleros', 8935814179);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Louella', 'Normanton', '0005941', 'OPERADOR POZO', 'LouellaNormanton@petrolinventories.com.co', '3193950711', 'Pozos Petroleros', 8557714359);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Ker', 'McCluskey', '0004502', 'OPERADOR POZO', 'KerMcCluskey@petrolinventories.com.co', '3257020434', 'Pozos Petroleros', 954946253);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Carr', 'Worwood', '0001682', 'RECORREDOR POZO', 'CarrWorwood@petrolinventories.com.co', '3680505737', 'Pozos Petroleros', 4073288813);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Bonnie', 'Kilcullen', '0004109', 'OPERADOR POZO', 'BonnieKilcullen@petrolinventories.com.co', '3207260930', 'Pozos Petroleros', 1933893186);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Issi', 'Vardie', '0003671', 'INGENIERO PETROLERO POZO', 'IssiVardie@petrolinventories.com.co', '3486159158', 'Pozos Petroleros', 2453425072);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Leticia', 'Fortin', '0001679', 'INGENIERO PETROLERO POZO', 'LeticiaFortin@petrolinventories.com.co', '3971157439', 'Pozos Petroleros', 2264014292);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Guillema', 'BURWIN', '0006744', 'RECORREDOR POZO', 'GuillemaBURWIN@petrolinventories.com.co', '3270249581', 'Pozos Petroleros', 5977092091);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Jonas', 'Hagan', '0009724', 'TECNICO ERA 2', 'JonasHagan@petrolinventories.com.co', '3823789120', 'Pozos Petroleros', 7669119474);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values ('Gabi', 'Kynforth', '0009102', 'TECNICO ERA 1', 'GabiKynforth@petrolinventories.com.co', '3401348361', 'Pozos Petroleros', 5147526184);


/*poblar experto*/
insert into experto (id, departamento_experiencia) values ('0012962', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0017893', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0017102', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0012543', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0019863', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0015750', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0017687', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0011626', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0011575', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0012767', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0016277', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0015260', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0015414', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0011429', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0015056', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0018153', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0012723', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0012460', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0013516', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0011930', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0016749', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0017957', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0017413', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0015674', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0011159', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0015892', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0014265', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0017175', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0011047', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0016287', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0013019', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0012211', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0013969', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0014883', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0019245', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0017770', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0018146', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0011155', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0017571', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0019891', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0019642', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0019784', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0019822', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0016693', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0012986', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0016346', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0015867', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0013148', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0016213', 'Pozos Petroleros');
insert into experto (id, departamento_experiencia) values ('0013959', 'Pozos Petroleros');

/*poblar estado*/
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (2463534, '0012316', 483448, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (7907234, '0014536', 714615, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (4798948, '0013992', 375192, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (9829122, '0011811', 343472, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (2794125, '0011252', 849711, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (8700289, '0017830', 693460, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (6691414, '0014689', 101354, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (2587405, '0017736', 824929, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (4397592, '0015256', 522087, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (1905168, '0018780', 658486, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (1017654, '0018894', 306339, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (5821441, '0018787', 304400, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (6914016, '0015101', 212727, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (2157745, '0017047', 534956, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (5926659, '0018329', 657937, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (6489401, '0017518', 663502, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (8445716, '0019899', 425985, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (5068185, '0013000', 858996, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (7432137, '0016641', 354834, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (4114127, '0016076', 339791, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (4540732, '0014299', 910639, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (2589777, '0015320', 229335, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (9210209, '0019843', 730482, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (5292593, '0016510', 600365, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (1251047, '0019520', 910734, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (1073696, '0019743', 742184, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (9686922, '0014331', 563968, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (4939655, '0011850', 960027, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (3504752, '0016908', 686267, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (5772700, '0019407', 897996, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (8388087, '0014741', 631757, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (8047742, '0013165', 469887, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (6911561, '0011932', 917580, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (5576361, '0013116', 227693, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (8710011, '0018679', 363105, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (3722842, '0013511', 453850, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (3913086, '0015043', 182786, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (7929436, '0018074', 172928, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (6545665, '0013996', 694573, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (2450051, '0017278', 317096, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (9961438, '0011360', 387208, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (6691790, '0018796', 434308, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (2163114, '0018365', 590735, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (7457780, '0017148', 960352, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (8722889, '0017558', 504136, 'P', 'No se puede usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (3042165, '0012348', 954782, 'E', 'Esta en excelente estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (8983186, '0014714', 728241, 'B', 'Esta en buen estado');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (7678894, '0014333', 801979, 'R', 'Tiene algunas falencias');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (6603222, '0013318', 405000, 'M', 'No es recomendable usar');
insert into estado (numero_revision, revisado_por, numero_pieza, calidad, observaciones) values (6179659, '0018912', 305379, 'P', 'No se puede usar');

/*poblar permiso*/
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (4243020, 1248809, 695269, 'se necesita para extraccion', 'No Aceptado', 7932019);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (4480326, 7975063, 245313, 'necesidad urgente para el pozo norte', 'Aceptado', 6341875);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (4726387, 9706066, 538036, 'se necesita para extraccion', 'Aceptado', 3832013);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1796363, 7595204, 217861, 'pieza baja necesidad', 'No Aceptado', 2300247);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (7324526, 8319287, 949435, 'pieza baja necesidad', 'Aceptado', 4901366);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5012119, 3773525, 866247, 'se necesita para extraccion', 'Aceptado', 7984956);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (4806711, 4347440, 538919, 'pieza baja necesidad', 'No Aceptado', 9678353);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (2806017, 8776068, 858665, 'se necesita para extraccion', 'No Aceptado', 8530762);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (8832110, 6167822, 266543, 'se necesita para extraccion', 'No Aceptado', 5640840);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (6150450, 9242742, 709345, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 6953852);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (4344247, 9291127, 917179, 'se necesita para extraccion', 'No Aceptado', 9408532);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5537308, 1531436, 279628, 'pieza baja necesidad', 'Aceptado', 6298801);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (9679295, 7588947, 802613, 'pieza necesitada para maquinaria pesada', 'Aceptado', 6476244);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (6406994, 4205795, 647909, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 6706836);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5671630, 7822503, 148621, 'pieza baja necesidad', 'No Aceptado', 1656936);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5759463, 4792722, 830024, 'pieza baja necesidad', 'Aceptado', 2115787);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1595566, 6308420, 250702, 'se necesita para extraccion', 'No Aceptado', 7245871);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (6524304, 4816160, 343046, 'pieza baja necesidad', 'No Aceptado', 2322084);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (7615940, 1959619, 190220, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 9995071);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (7090673, 1369567, 644895, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 1832855);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5376297, 1985711, 347901, 'se necesita para extraccion', 'Aceptado', 3948741);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (3614418, 1348247, 440992, 'necesidad urgente para el pozo norte', 'Aceptado', 7770467);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (2215299, 7461743, 383484, 'pieza baja necesidad', 'Aceptado', 1618037);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5447216, 1389776, 274308, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 7093609);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1935035, 2427764, 296656, 'se necesita para extraccion', 'Aceptado', 2681884);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1008159, 8403875, 530784, 'pieza baja necesidad', 'Aceptado', 9757950);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (7528386, 5097576, 948060, 'se necesita para extraccion', 'Aceptado', 4261279);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5537210, 1281637, 858799, 'pieza necesitada para maquinaria pesada', 'Aceptado', 9804889);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (2555382, 4404765, 452619, 'pieza necesitada para maquinaria pesada', 'Aceptado', 9003411);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (3607568, 3593351, 944079, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 7480465);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (2847448, 6642621, 907070, 'necesidad urgente para el pozo norte', 'No Aceptado', 4582782);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1176697, 1850072, 822585, 'se necesita para extraccion', 'Aceptado', 3699319);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (7360980, 8847195, 998768, 'pieza baja necesidad', 'Aceptado', 1480927);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (8645739, 2222369, 851329, 'pieza necesitada para maquinaria pesada', 'Aceptado', 9185098);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1256397, 1298920, 238102, 'se necesita para extraccion', 'No Aceptado', 1589792);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (3884416, 7006666, 928044, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 9563507);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1378333, 7273636, 591596, 'pieza baja necesidad', 'Aceptado', 7576484);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (7361422, 1393073, 325626, 'necesidad urgente para el pozo norte', 'No Aceptado', 4941309);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (7614385, 7028958, 145404, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 7993724);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1067371, 6934671, 413736, 'pieza baja necesidad', 'Aceptado', 3477999);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5637775, 8658810, 965688, 'pieza necesitada para maquinaria pesada', 'No Aceptado', 6061898);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (2661675, 1929807, 145470, 'se necesita para extraccion', 'Aceptado', 1671420);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1156483, 4939422, 749101, 'pieza baja necesidad', 'Aceptado', 4407818);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (9856208, 1664256, 168071, 'pieza necesitada para maquinaria pesada', 'Aceptado', 4609620);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1124322, 8466244, 991380, 'necesidad urgente para el pozo norte', 'No Aceptado', 5259528);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5544275, 9004009, 451768, 'necesidad urgente para el pozo norte', 'Aceptado', 4103246);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (7578218, 1443599, 831286, 'pieza necesitada para maquinaria pesada', 'Aceptado', 8891440);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (2356627, 4418979, 329302, 'se necesita para extraccion', 'Aceptado', 7277959);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (1140515, 5338777, 209214, 'pieza baja necesidad', 'No Aceptado', 3909681);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (5385928, 7675362, 865336, 'pieza baja necesidad', 'No Aceptado', 3281560);


/*poblar pedido pieza*/
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (2013533, 3446602, 'Pozos petroleros', 6509, 'Bodega La Esperanza');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (8788426, 9667659, 'Pozos petroleros', 5035, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5145469, 7445978, 'Pozos petroleros', 6200, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (1797027, 5456158, 'Pozos petroleros', 5416, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5490920, 3204842, 'Pozos petroleros', 2483, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5966434, 7179026, 'Pozos petroleros', 2931, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5645795, 7859202, 'Pozos petroleros', 4177, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5847629, 7126387, 'Pozos petroleros', 5747, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (7482496, 9151069, 'Pozos petroleros', 530, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (9008573, 2450360, 'Pozos petroleros', 4891, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (3434393, 4757510, 'Pozos petroleros', 4333, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5552234, 9131586, 'Pozos petroleros', 1865, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (1027805, 8935352, 'Pozos petroleros', 1195, 'Bodega La Esperanza');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6964334, 9286574, 'Pozos petroleros', 3054, 'Bodega San Martin');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (9529072, 4381642, 'Pozos petroleros', 2739, 'Bodega San Martin');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (9864348, 5238175, 'Pozos petroleros', 1157, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (1176987, 2263046, 'Pozos petroleros', 7693, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5735663, 6097388, 'Pozos petroleros', 9371, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (4944793, 3510891, 'Pozos petroleros', 1337, 'Bodega La Esperanza');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6933384, 3845300, 'Pozos petroleros', 5527, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (3486801, 5108353, 'Pozos petroleros', 1959, 'Bodega La Esperanza');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5980745, 9406608, 'Pozos petroleros', 6155, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (3854910, 7917236, 'Pozos petroleros', 6028, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (7210227, 2754005, 'Pozos petroleros', 8117, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (9211244, 9997913, 'Pozos petroleros', 8825, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (9256944, 8591928, 'Pozos petroleros', 2982, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (3903481, 7087605, 'Pozos petroleros', 7505, 'Bodega La Esperanza');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (8499204, 9787734, 'Pozos petroleros', 6060, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (4352251, 4326408, 'Pozos petroleros', 51, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (2262323, 1534577, 'Pozos petroleros', 1545, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (8993562, 4880771, 'Pozos petroleros', 5040, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6613438, 9532440, 'Pozos petroleros', 8797, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6057451, 7000803, 'Pozos petroleros', 9852, 'Bodega La Esperanza');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (1154374, 2299007, 'Pozos petroleros', 5977, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6716353, 4147595, 'Pozos petroleros', 739, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5582701, 8088905, 'Pozos petroleros', 7213, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (9735943, 5914432, 'Pozos petroleros', 8412, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (8876454, 9534797, 'Pozos petroleros', 8051, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6716644, 6876538, 'Pozos petroleros', 1626, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6327618, 5766079, 'Pozos petroleros', 1533, 'Bodega La Esperanza');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (8535151, 2005391, 'Pozos petroleros', 6172, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (3968389, 9379078, 'Pozos petroleros', 4581, 'Bodega San Martin');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (5411879, 2472878, 'Pozos petroleros', 7947, 'Bodega La Esperanza');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (7109425, 8055423, 'Pozos petroleros', 4941, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6225528, 5365627, 'Pozos petroleros', 2651, 'Bodega Central');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (1564031, 2276635, 'Pozos petroleros', 9001, 'Bodega Chichimene');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (3062024, 7044112, 'Pozos petroleros', 6325, 'Bodega San Martin');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (7516099, 9574143, 'Pozos petroleros', 7635, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (6263057, 1898196, 'Pozos petroleros', 1450, 'Bodega San Juan');
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (9261090, 1400980, 'Pozos petroleros', 8708, 'Bodega San Juan');

/*poblar pieza petrolera*/
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (997459, 'Soldadoras', '10000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (994525, 'Tubos', '200 mm x 500 mm x 100 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (992285, 'Tubos', '100 mm x 200 mm x 100 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (955452, 'Engranajes', '10 dientes ');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (786525, 'Soldadoras', '50000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (156528, 'Soldadoras', '60000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (357281, 'Tornillos', '20 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (641265, 'Tornillos', '50 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (941565, 'Soldadoras', '3000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (512565, 'Tornillos', '30 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (357251, 'Tubos', '300 mm x 500 mm x 200 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (455265, 'Soldadoras', '5000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (382118, 'Tubos', '200 mm x 360 mm x 200 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (825651, 'Tornillos', '40 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (465465, 'Engranajes', '30 dientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (261541, 'Tornillos', '20 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (181748, 'Tornillos', '60 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (418556, 'Soldadoras', '3000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (845341, 'Tornillos', '40 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (412656, 'Tubos', '100 mm x 250 mm x 120 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (315248, 'Soldadoras', '10000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (684578, 'Soldadoras', '9000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (684154, 'Tubos', '500 mm x 2000 mm x 150 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (305415, 'Tubos', '200 mm x 500 mm x 100 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (465185, 'Tornillos', '50 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (751643, 'Engranajes', '20 dientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (985425, 'Tornillos', '40 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (298652, 'Soldadoras', '5000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (548951, 'Engranajes', '5 dientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (132848, 'Engranajes', '8 dientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (123456, 'Perforadoras', '600 mm x 1500 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (987654, 'Tornillos', '20 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (974613, 'Tornillos', '70 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (821553, 'Engranajes', '16 dientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (999991, 'Engranajes', '17 sientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (999992, 'Tubos', '100 mm x 300 mm x 90 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100000, 'Tubos', '600 mm x 1000 mm x 200 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100001, 'Soldadoras', '8000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100002, 'Perforadoras', ' 300 mm x 1000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100003, 'Perforadoras', '200 mm x 4000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100004, 'Engranajes', '13 dientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100005, 'Tubos', '200 mm x 800 mm x 100 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100006, 'Perforadoras', '600 mm x 2000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100007, 'Engranajes', '10 dientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100008, 'Perforadoras', '400 mm x 600 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100009, 'Soldadoras', '2000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100010, 'Engranajes', '30 dientes');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100011, 'Perforadoras', '200 mm x 3000 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100012, 'Perforadoras', '200 mm x 100 mm');
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values (100013, 'Tubos', '100 mm x 400 mm x 100 mm');

/*POBLAR NoOK*/
/*DATOS INCORRECTOS PROVEEDOR*/
insert into proveedor (codigo, telefono, correo) values (965915858, '958 123 4622', 'spennicard0@bbb.org');
insert into proveedor (codigo, telefono, correo) values (129657445, '608 230 8920', 'lweatherley1@i2i.jp');
insert into proveedor (codigo, telefono, correo) values (793554951, '244 539 0434', 'tkullmann2@mtv.com');
insert into proveedor (codigo, telefono, correo) values (101129766, '732 406 7683', 'rvettore3@ehow.com');
insert into proveedor (codigo, telefono, correo) values (602170650, '954 295 6487', 'rhovenden4@reference.com');
insert into proveedor (codigo, telefono, correo) values (809719488, '618 743 8067', 'amayell5@spiegel.de');
insert into proveedor (codigo, telefono, correo) values (321405369, '985 621 5957', 'iblackadder6@foxnews.com');
insert into proveedor (codigo, telefono, correo) values (349469807, '710 135 5958', 'lmuriel7@ucla.edu');
insert into proveedor (codigo, telefono, correo) values (380458087, '227 386 9185', 'ibadsworth8@toplist.cz');
insert into proveedor (codigo, telefono, correo) values (323160802, '972 754 9396', 'bhassan9@tumblr.com');
insert into proveedor (codigo, telefono, correo) values (779487144, '708 125 0572', 'jdarlowa@purevolume.com');
insert into proveedor (codigo, telefono, correo) values (555028965, '942 639 2130', 'citzkovwichb@gov.uk');
insert into proveedor (codigo, telefono, correo) values (102246929, '575 526 3458', 'bpembryc@shop-pro.jp');
insert into proveedor (codigo, telefono, correo) values (981696499, '620 930 8471', 'emuirdend@gizmodo.com');
insert into proveedor (codigo, telefono, correo) values (361833960, '176 577 5847', 'bandrionie@google.ru');
insert into proveedor (codigo, telefono, correo) values (876329521, '247 650 0753', 'dingoldf@sourceforge.net');
insert into proveedor (codigo, telefono, correo) values (949087813, '873 852 2344', 'ggrenfellg@prlog.org');
insert into proveedor (codigo, telefono, correo) values (554445250, '517 297 0436', 'cwatersh@jigsy.com');
insert into proveedor (codigo, telefono, correo) values (399867564, '310 155 2846', 'bmerrywetheri@fda.gov');
insert into proveedor (codigo, telefono, correo) values (883822046, '175 972 9686', 'mtyddj@cocolog-nifty.com');


/*datos incorrectos persona juridica*/
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Garth', 'Counihan', 6422, 73544218670, 87);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Davine', 'Landsborough', 2653, 68575205586, 36);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Phedra', 'Haws', 4727, 46917476794, 66);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Cynthea', 'Brunicke', 6057, 94131539768, 26);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Sibley', 'Bleesing', 2486, 8768292555, 7);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Stacee', 'Pic', 2326, 31377166172, 13);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Celestina', 'Sandison', 8410, 25713656084, 47);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Kathye', 'Casali', 7859, 9553420552, 15);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Claudie', 'Rosenbloom', 3016, 72649583861, 25);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Rachel', 'Urridge', 1374, 43396305858, 83);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Vinnie', 'MacClure', 9841, 28636672842, 65);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Lennard', 'Eccleston', 6610, 93593190040, 61);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Kaine', 'Gill', 5537, 5776311434, 7);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Jeremias', 'Gumb', 8310, 35484979871, 74);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Murdock', 'Fuster', 2038, 22318789221, 16);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Marillin', 'McCarthy', 4707, 91314158375, 23);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Wald', 'Newbatt', 2116, 34419067031, 5);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Wait', 'Devinn', 606, 69058873002, 54);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Cal', 'Ledson', 496, 10234778162, 47);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Teodorico', 'Pockey', 6809, 8843593562, 27);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Cristie', 'Godwin', 7081, 6671762267, 55);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Sax', 'Ennew', 773, 12981446688, 37);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Carolin', 'Dionisetto', 2347, 94799072521, 85);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Joane', 'Nielson', 9484, 61677283110, 7);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Donnie', 'Swinbourne', 3135, 72286937563, 6);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Chuck', 'Roseaman', 6565, 76962069573, 41);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Lemuel', 'Petrasso', 3725, 65828019011, 59);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Revkah', 'Jubb', 2102, 12272810928, 64);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Trenna', 'Messer', 1570, 68884810927, 87);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Albert', 'Kinnaird', 7156, 94101237127, 1);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Ysabel', 'Boays', 9670, 98002972283, 35);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Leslie', 'Domleo', 6848, 76034408887, 87);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Eve', 'Delbergue', 6226, 34341590778, 63);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Marj', 'Devonside', 8488, 48201865268, 50);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Salomo', 'FitzGilbert', 2090, 53090174916, 38);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Eddy', 'Rowdell', 2432, 28727727431, 95);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Normie', 'Bothie', 6784, 61251325330, 77);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Daryle', 'Teers', 9319, 12131138029, 85);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Glad', 'Charer', 4095, 68595884069, 97);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Kikelia', 'Struther', 9061, 66519282091, 96);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Meredith', 'Moffet', 8703, 66878585418, 3);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Annamaria', 'Torrejon', 8804, 63665535655, 72);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Jedidiah', 'Beidebeke', 2353, 25342756575, 54);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Gerik', 'Boothebie', 6227, 6752445829, 70);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Catherin', 'Arenson', 6877, 89007645589, 21);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Wally', 'Feragh', 8370, 93351908381, 81);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Mylo', 'Chattock', 3681, 32155344024, 64);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Freddie', 'Marrable', 7063, 40996162155, 27);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Kimberly', 'Edward', 8695, 72021115394, 13);
insert into persona_juridica (nombre, apellido, cedula, nit, codigo) values ('Barbaraanne', 'Aslam', 8759, 2133981708, 63);


/*datos incorrectos empresa*/
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Katz', 20567125, 85833816, '437 Aberg Avenue', '375 32');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Blogtag', 11082388, 44214930, '47 Columbus Court', '71161');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Eayo', 39133926, 17486504, '77467 Monument Court', null);
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Jaxbean', 14994592, 73748063, '8 Arapahoe Place', '442153');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Meeveo', 55062224, 94020055, '1 Sachs Street', '679 11');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Photospace', 15946491, 95246407, '29262 Lien Crossing', '8305');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Aimbo', 44315278, 98319457, '574 Gale Hill', null);
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Youopia', 56137237, 31791930, '86619 Oneill Point', null);
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Gigaclub', 77698288, 55427063, '81 Mcbride Point', null);
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Tagpad', 50941326, 37026762, '85792 Acker Place', null);
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Quire', 69263137, 57467411, '79 American Ash Crossing', '69405-000');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Zoonoodle', 82934382, 25098630, '9 Debra Plaza', '34108');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Centizu', 48107850, 39063184, '23016 Mendota Crossing', '391 65');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Fanoodle', 92305036, 45828024, '53096 Holmberg Way', '60652');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Vimbo', 80862737, 13229849, '964 Scott Hill', null);
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Oyoyo', 19194487, 56290780, '53417 Briar Crest Drive', '40013 CEDEX');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Talane', 41635399, 16177770, '21316 Cordelia Plaza', null);
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Dablist', 19556113, 80736536, '24703 Main Drive', '51950');
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Riffpedia', 94117667, 25761262, '6850 Comanche Hill', null);
insert into empresa (nombre, nit, codigo, direccion, direccion_postal) values ('Flipopia', 97538921, 77826820, '7949 Heffernan Street', '86200-000');



/*datos incorrectos provee*/
insert into provee (codigo_proveedor, nombre_bodega) values (7791800, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (5899033, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (6642409, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (2444424, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (2116514, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (2343732, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (8231202, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (9200833, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (6417960, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (5145568, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (9476456, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (6028271, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (4094641, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (8004790, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (5066485, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (4204026, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (1643140, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (8220416, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (7430361, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (8008489, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (5910690, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (7290505, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (3662867, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (7806758, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (9379909, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (5045069, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (9037092, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (4523493, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (3569035, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (6173149, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (6738746, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (2195000, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (4033661, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (5431444, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (6747435, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (9894365, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (1962539, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (8325799, 'Bodega Chichimene');
insert into provee (codigo_proveedor, nombre_bodega) values (7994944, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (6798763, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (9030564, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (3732402, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (4076486, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (7368445, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (9448874, 'Bodega La Carmelita');
insert into provee (codigo_proveedor, nombre_bodega) values (1856204, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (7446152, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (1796500, 'Bodega San Juan 10');
insert into provee (codigo_proveedor, nombre_bodega) values (5179392, 'Bodega San Luis');
insert into provee (codigo_proveedor, nombre_bodega) values (6314862, 'Bodega La Carmelita');

/*Datos incorrectos bodega*/
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 8629398, 'Wuxia');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 4293010, 'Durham');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 3802120, 'Tralee');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 3806252, 'Dukhovshchina');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 4686768, 'TanguiÃ©ta');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 2501655, 'Dongkeng');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 6845834, 'Cholpon-Ata');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 5071550, 'Spas-Klepiki');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 8681176, 'Pampanito');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 3171041, 'Roissy Charles-de-Gaulle');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 8902612, 'Nor Gyugh');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 8741741, 'Jianghu');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 2665127, 'Yara');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 8313787, 'JÃ¤rfÃ¤lla');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 5033963, 'ProboÅ¡tov');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 5911280, 'Quinipot');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 9391236, 'Palmas De Gran Canaria, Las');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 7663696, 'Viligili');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 6186719, 'Taranovskoye');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 2298013, 'Minanga Norte');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 9667468, 'Kamifukuoka');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 9988417, 'Jagodnjak');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 6202463, 'ZbÄ…szynek');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 9201773, 'ÄŒervenÃ© PeÄ?ky');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 8342679, 'Barru');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 1521442, 'Ã…lesund');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 2919471, 'Sukoanyar');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 2556198, 'Kobilje');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 7233230, 'Siteki');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 9593761, 'AlÃ©m');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 9908933, 'Binhailu');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 2226667, 'Rechitsy');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 2478672, 'Makuyuni');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 1926288, 'Kos');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 5255161, 'OshnavÄ«yeh');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 2523768, 'Wuppertal');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 4583515, 'Dangchang Chengguanzhen');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 4896132, 'Czerwin');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 2659786, 'Salt Lake City');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 4953210, 'Caen');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 2403300, 'Szczaniec');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 4582823, 'Yelizavetino');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 9001446, 'Quá»‘c Oai');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 4420501, 'Nanbin');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Juan 10', 2348186, 'Taquaritinga');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 3956774, 'Banyupoh');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 9213564, 'Al BÄ?Å£inah');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega La Carmelita', 9283706, 'La Gloria');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega Chichimene', 9643681, 'Gondar');
insert into bodega (nombre_bodega, municipio, departamento) values ('Bodega San Luis', 9741353, 'HacÄ±hÃ¼seynli');


/*datos incorrectos inventario*/
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 66375440, 15745581, 28197532);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 30345083, 60745220, 24711934);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega La Esperanza', 65908073, 67933874, 92375752);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 45235307, 58699537, 29374231);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 51316877, 23223981, 38500075);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 53162022, 56094823, 88192867);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 25192390, 11345545, 13017326);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 91763171, 20498875, 28529846);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 26182176, 25795722, 20387190);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 14893548, 55563717, 61767696);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 85643558, 84193155, 10911019);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 59686132, 55316954, 24161354);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 12798173, 93532846, 13155446);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 39208116, 72013244, 20941375);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 80276175, 91816406, 44504048);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Central', 87863928, 29112414, 98091259);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega Chichimene 1', 92357192, 53453941, 37131591);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 92996822, 45130760, 18863005);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Juan 3', 94785746, 51329644, 54627449);
insert into inventario (nombre_bodega, numero_serie_pieza, id_inventarios, disponibilidad) values ('Bodega San Martin', 71044243, 24104674, 98325562);



/*datos incorrectos revisa*/
insert into revisa (id_empleado, id_inventario) values (7357557, 1856602);
insert into revisa (id_empleado, id_inventario) values (4724961, 3180908);
insert into revisa (id_empleado, id_inventario) values (8987854, 8964139);
insert into revisa (id_empleado, id_inventario) values (3651839, 4409599);
insert into revisa (id_empleado, id_inventario) values (9629475, 8970638);
insert into revisa (id_empleado, id_inventario) values (4445137, 4624113);
insert into revisa (id_empleado, id_inventario) values (9076541, 8191433);
insert into revisa (id_empleado, id_inventario) values (4248550, 6885401);
insert into revisa (id_empleado, id_inventario) values (8090190, 6042415);
insert into revisa (id_empleado, id_inventario) values (6519506, 1769227);
insert into revisa (id_empleado, id_inventario) values (6266416, 6612888);
insert into revisa (id_empleado, id_inventario) values (3019640, 2082453);
insert into revisa (id_empleado, id_inventario) values (4806028, 2431467);
insert into revisa (id_empleado, id_inventario) values (9181245, 1231710);
insert into revisa (id_empleado, id_inventario) values (6643372, 3533396);
insert into revisa (id_empleado, id_inventario) values (9859493, 8401796);
insert into revisa (id_empleado, id_inventario) values (3457279, 9803634);
insert into revisa (id_empleado, id_inventario) values (9558960, 7109932);
insert into revisa (id_empleado, id_inventario) values (8260822, 9152614);
insert into revisa (id_empleado, id_inventario) values (8210984, 7136983);
insert into revisa (id_empleado, id_inventario) values (2691111, 1829711);
insert into revisa (id_empleado, id_inventario) values (7650375, 9760422);
insert into revisa (id_empleado, id_inventario) values (2239370, 4316994);
insert into revisa (id_empleado, id_inventario) values (2808163, 1027847);
insert into revisa (id_empleado, id_inventario) values (3578740, 9420682);
insert into revisa (id_empleado, id_inventario) values (4104154, 6071058);
insert into revisa (id_empleado, id_inventario) values (4000359, 7485286);
insert into revisa (id_empleado, id_inventario) values (1620698, 4678950);
insert into revisa (id_empleado, id_inventario) values (1253754, 2338525);
insert into revisa (id_empleado, id_inventario) values (3713118, 6132525);
insert into revisa (id_empleado, id_inventario) values (4370903, 8542415);
insert into revisa (id_empleado, id_inventario) values (4285687, 7602627);
insert into revisa (id_empleado, id_inventario) values (3370132, 5375746);
insert into revisa (id_empleado, id_inventario) values (2209206, 7647101);
insert into revisa (id_empleado, id_inventario) values (8809061, 7128787);
insert into revisa (id_empleado, id_inventario) values (5847189, 7439527);
insert into revisa (id_empleado, id_inventario) values (5536709, 7340963);
insert into revisa (id_empleado, id_inventario) values (5781844, 6344088);
insert into revisa (id_empleado, id_inventario) values (6379362, 6882512);
insert into revisa (id_empleado, id_inventario) values (3990280, 7380813);
insert into revisa (id_empleado, id_inventario) values (4652101, 9240048);
insert into revisa (id_empleado, id_inventario) values (4207860, 8818066);
insert into revisa (id_empleado, id_inventario) values (3251001, 3203502);
insert into revisa (id_empleado, id_inventario) values (3287427, 1984950);
insert into revisa (id_empleado, id_inventario) values (9538268, 9964461);
insert into revisa (id_empleado, id_inventario) values (8225216, 7337032);
insert into revisa (id_empleado, id_inventario) values (1834551, 4934146);
insert into revisa (id_empleado, id_inventario) values (3154338, 5875275);
insert into revisa (id_empleado, id_inventario) values (9029132, 8257557);
insert into revisa (id_empleado, id_inventario) values (7925927, 4100890);


/*datos incorrectos empleado*/
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (8235, 'Merryfield', 3741, 2952687, 'lmerryfield0@simplemachines.org', 'de.vu', 8947114, 3794315);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (6942, 'Fere', 8850, 3490166, 'tfere1@uol.com.br', 'edublogs.org', 7556202, 2730836);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5066, 'Hawkey', 9647, 9893381, 'ehawkey2@vkontakte.ru', 'ameblo.jp', 5424010, 7177132);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5002, 'Briddle', 8561, 4832372, 'pbriddle3@desdev.cn', 'microsoft.com', 3309702, 7459655);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (4516, 'Stubbe', 3014, 4002307, 'gstubbe4@naver.com', 'mlb.com', 4283096, 2158585);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5531, 'Proby', 1257, 3909448, 'cproby5@npr.org', 'ifeng.com', 4296238, 7733847);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (979, 'Hoppner', 6157, 5634787, 'rhoppner6@java.com', 'chicagotribune.com', 3635360, 4892242);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (3683, 'Kerkham', 4889, 1168186, 'mkerkham7@amazon.de', 'chicagotribune.com', 4922003, 2477120);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (4024, 'Abatelli', 2719, 6642933, 'sabatelli8@goo.gl', 'pen.io', 1961395, 9394198);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (7766, 'Cristoferi', 8343, 2200231, 'rcristoferi9@1688.com', 'si.edu', 5098604, 3053177);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (1440, 'Keighley', 3465, 5292933, 'bkeighleya@hostgator.com', 'oracle.com', 5016732, 4899341);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (2871, 'Bamborough', 5363, 7996427, 'nbamboroughb@vkontakte.ru', 'dell.com', 7466095, 1893048);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (7970, 'Crosio', 268, 7806024, 'acrosioc@jugem.jp', 'surveymonkey.com', 8917018, 6864538);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (7293, 'McCrum', 7071, 3399110, 'fmccrumd@ameblo.jp', 'npr.org', 8286362, 3030082);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (1781, 'McArte', 140, 8763446, 'tmcartee@live.com', 'amazon.de', 3108866, 2174081);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (9649, 'Savin', 1503, 8218814, 'usavinf@salon.com', 'unicef.org', 6828014, 4146523);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (9572, 'Ioan', 1808, 3420776, 'mioang@nydailynews.com', 'altervista.org', 5109021, 1614198);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (2335, 'Kestle', 5798, 6610715, 'akestleh@cloudflare.com', 'bbc.co.uk', 3413692, 2192721);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (2452, 'Weddeburn', 3756, 8988901, 'aweddeburni@auda.org.au', 'amazon.com', 9006389, 5024147);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (1314, 'Greenard', 3811, 1613910, 'bgreenardj@archive.org', 'washingtonpost.com', 3441486, 1517359);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (6688, 'Wash', 4724, 3601716, 'lwashk@usgs.gov', 'creativecommons.org', 3016056, 2893821);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (1160, 'Bonsul', 4255, 6438573, 'rbonsull@jugem.jp', 'cafepress.com', 3428871, 9007348);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5537, 'Pluck', 799, 4624530, 'lpluckm@pen.io', 'telegraph.co.uk', 7250398, 8671654);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5251, 'Moiser', 3089, 6307400, 'cmoisern@digg.com', 'psu.edu', 7792802, 4494153);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (1395, 'Pfaff', 4100, 6858186, 'tpfaffo@tamu.edu', 'nyu.edu', 8094300, 3250427);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (3724, 'Jayne', 8711, 9970929, 'bjaynep@army.mil', 'shutterfly.com', 4639509, 8739785);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (2368, 'Harbar', 688, 5396126, 'aharbarq@youku.com', 'statcounter.com', 9473970, 3368473);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5118, 'Keats', 6923, 6723867, 'lkeatsr@gmpg.org', 'icio.us', 7382067, 9573715);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (9790, 'Bayns', 9942, 3293843, 'mbaynss@hc360.com', 'a8.net', 6686107, 8579741);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (6849, 'Elger', 1535, 8543089, 'belgert@wiley.com', 'spotify.com', 9623317, 2915200);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (7617, 'Allsup', 2926, 5075269, 'zallsupu@icq.com', 'themeforest.net', 9306874, 4669499);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (9725, 'Garnham', 9339, 9030877, 'lgarnhamv@about.com', 'usatoday.com', 4932951, 6732070);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (4002, 'Mattedi', 8425, 5135638, 'zmattediw@amazon.com', 'xrea.com', 8446249, 1093270);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (450, 'Durkin', 7082, 7631820, 'adurkinx@issuu.com', 'hao123.com', 3371186, 1541191);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (9573, 'Hardson', 4422, 7788889, 'ghardsony@amazon.co.uk', 'cmu.edu', 7406756, 8642597);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (6481, 'Coy', 2749, 5857071, 'mcoyz@miibeian.gov.cn', 'yolasite.com', 8198307, 5631974);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (1946, 'Seamons', 7239, 8195471, 'mseamons10@tamu.edu', 'purevolume.com', 6174231, 8825688);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5263, 'Pamment', 4048, 4949827, 'mpamment11@google.co.uk', 'accuweather.com', 2887240, 7112730);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5026, 'Bellringer', 8981, 6340640, 'jbellringer12@wisc.edu', 'booking.com', 5205660, 3871895);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (9116, 'Grinval', 8069, 3873042, 'jgrinval13@walmart.com', 'wix.com', 4164805, 8756339);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (4110, 'Rizzelli', 9152, 2312603, 'drizzelli14@spiegel.de', 'newyorker.com', 3496787, 5997658);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (4290, 'Sallenger', 7992, 6380663, 'rsallenger15@issuu.com', 'economist.com', 9319715, 8169302);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (5256, 'Bradnock', 571, 6869496, 'mbradnock16@symantec.com', 'jigsy.com', 1325295, 9243942);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (6669, 'Kellick', 3234, 5325888, 'bkellick17@imdb.com', 'blogspot.com', 3810628, 9825444);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (4929, 'Penner', 6762, 3978800, 'fpenner18@joomla.org', 'reference.com', 4890536, 1600886);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (7208, 'Hallan', 7914, 6811194, 'fhallan19@issuu.com', 'economist.com', 1065850, 4251156);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (8300, 'Maruszewski', 523, 6099185, 'gmaruszewski1a@scientificamerican.com', 'abc.net.au', 2019465, 2477803);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (1763, 'Keepin', 7745, 3007103, 'vkeepin1b@hatena.ne.jp', 'xing.com', 5693684, 2343282);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (6333, 'Seamarke', 4174, 1796148, 'oseamarke1c@businesswire.com', 'cbslocal.com', 8437636, 5020583);
insert into empleado (nombre, apellido, id, cargo, correo, numero_telefonico, departamento_trabajo, cedula) values (1256, 'Ungaretti', 8179, 1172011, 'eungaretti1d@ovh.net', 'accuweather.com', 9924040, 4339226);


/*datos incorrectos experto*/
insert into experto (id, departamento_experiencia) values (14061009, 'control de calidad');
insert into experto (id, departamento_experiencia) values (56938168, 'resistencia de materiales');
insert into experto (id, departamento_experiencia) values (48987088, 'ingeniero de petroleos');
insert into experto (id, departamento_experiencia) values (37732258, 'control de calidad');
insert into experto (id, departamento_experiencia) values (59513908, 'ingeniero de petroleos');
insert into experto (id, departamento_experiencia) values (76238684, 'resistencia de materiales');
insert into experto (id, departamento_experiencia) values (32573129, 'control de calidad');
insert into experto (id, departamento_experiencia) values (50885739, 'control de calidad');
insert into experto (id, departamento_experiencia) values (20719862, 'ingeniero de petroleos');
insert into experto (id, departamento_experiencia) values (23753411, 'resistencia de materiales');
insert into experto (id, departamento_experiencia) values (90825089, 'ingeniero de petroleos');
insert into experto (id, departamento_experiencia) values (55408012, 'resistencia de materiales');
insert into experto (id, departamento_experiencia) values (25579092, 'ingeniero de petroleos');
insert into experto (id, departamento_experiencia) values (10052657, 'control de calidad');
insert into experto (id, departamento_experiencia) values (43705754, 'ingeniero de petroleos');
insert into experto (id, departamento_experiencia) values (84897276, 'ingeniero de petroleos');
insert into experto (id, departamento_experiencia) values (63873629, 'control de calidad');
insert into experto (id, departamento_experiencia) values (61251741, 'resistencia de materiales');
insert into experto (id, departamento_experiencia) values (13844841, 'control de calidad');
insert into experto (id, departamento_experiencia) values (68578991, 'ingeniero de petroleos');


/*datos incorrectos permiso*/
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (25320261, 38379854, 327055, '10/15/2019', 1, 52221860);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (23824675, 67112193, 477074, '6/11/2020', 2, 47597804);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (98488644, 16933120, 475864, '1/1/2020', 3, 99730450);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (25008930, 53669694, 538467, '7/19/2020', 4, 63411941);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (99677409, 16858189, 362404, '6/5/2020', 5, 46050861);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (88952313, 83254625, 366328, '5/16/2020', 6, 59835958);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (66468109, 19802007, 841459, '5/7/2020', 7, 30861949);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (82514716, 49065854, 380787, '1/21/2020', 8, 91251558);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (73544093, 26967673, 240007, '7/14/2020', 9, 74832969);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (80430933, 41083481, 245453, '5/19/2020', 10, 97805534);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (78711122, 32240618, 108767, '3/16/2020', 11, 79751645);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (24273680, 52550042, 868580, '1/15/2020', 12, 21101614);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (58078334, 37045169, 226847, '10/16/2019', 13, 43059431);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (10406766, 58929405, 148500, '1/18/2020', 14, 74816095);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (28448430, 89939362, 668275, '7/18/2020', 15, 35096698);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (30277583, 40355565, 782037, '9/10/2020', 16, 43800701);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (17587594, 13910680, 755585, '12/10/2019', 17, 98223356);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (68324368, 89690213, 594752, '8/15/2020', 18, 81139880);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (22967973, 43321872, 671870, '3/4/2020', 19, 38766564);
insert into permiso (numero_permiso, id_autor, numero_pieza, detalle, estado, pedido) values (77448332, 54772327, 528389, '1/28/2020', 20, 17600422);

/*datos incorrectos pedido*/
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (11372542, 86811098, 929097, '9/5/2020', 1);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (42395300, 10976989, 704467, '7/16/2020', 2);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (26446623, 64973528, 122282, '2/13/2020', 3);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (11027118, 21741731, 889982, '8/14/2020', 4);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (43787550, 51729492, 532456, '7/3/2020', 5);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (71809091, 92147011, 462221, '1/22/2020', 6);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (58803718, 42663943, 332454, '10/27/2019', 7);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (58202793, 14259058, 595863, '11/15/2019', 8);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (23819864, 62994249, 196155, '2/21/2020', 9);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (71997043, 87918724, 133041, '3/28/2020', 10);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (88868058, 97044791, 124049, '10/23/2019', 11);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (32133404, 54633230, 315104, '5/8/2020', 12);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (69852709, 60411117, 288055, '10/31/2019', 13);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (52537729, 85689230, 278845, '1/18/2020', 14);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (22264700, 51411750, 523613, '5/12/2020', 15);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (25022726, 82613503, 921034, '7/8/2020', 16);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (44317134, 49039293, 831604, '3/23/2020', 17);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (57047073, 18953344, 408409, '12/3/2019', 18);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (55612191, 89427638, 979522, '3/10/2020', 19);
insert into pedido_pieza (numero_pedido, id_autor, departamento_trabajo, cantidad_piezas, bodega_reclamo) values (89599064, 56606655, 124761, '2/1/2020', 20);

/*datos incorrectos pieza*/
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('hao123.com', 2813, 8243);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('newyorker.com', 7034, 6525);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('discuz.net', 9576, 1654);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('ask.com', 3446, 4853);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('pbs.org', 6302, 4784);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('berkeley.edu', 8791, 9943);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('npr.org', 4329, 8219);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('hhs.gov', 7047, 7406);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('dedecms.com', 1329, 6079);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('patch.com', 8457, 8076);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('blog.com', 4669, 2608);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('i2i.jp', 6632, 1799);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('altervista.org', 793, 7550);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('marriott.com', 6030, 7737);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('senate.gov', 5339, 8998);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('shinystat.com', 6679, 3839);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('forbes.com', 4833, 9352);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('so-net.ne.jp', 6539, 486);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('com.com', 1786, 7183);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('census.gov', 5646, 2955);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('ted.com', 6119, 1668);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('bbc.co.uk', 2327, 7101);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('scribd.com', 4800, 2472);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('timesonline.co.uk', 2493, 1966);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('spiegel.de', 2928, 8133);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('epa.gov', 4609, 6807);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('e-recht24.de', 7807, 6725);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('bluehost.com', 942, 3674);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('discovery.com', 1278, 6692);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('ustream.tv', 6945, 117);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('nba.com', 7999, 6240);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('webeden.co.uk', 3103, 739);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('java.com', 8756, 4809);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('epa.gov', 7780, 3463);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('ehow.com', 9565, 9324);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('berkeley.edu', 3943, 7583);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('msu.edu', 9290, 6027);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('weather.com', 6175, 8823);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('goo.gl', 3716, 4305);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('blogspot.com', 7957, 9757);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('rakuten.co.jp', 9831, 7750);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('columbia.edu', 1000, 7206);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('apple.com', 8406, 5103);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('businessweek.com', 7067, 1980);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('unc.edu', 8981, 7734);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('youtube.com', 2957, 8203);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('addtoany.com', 5444, 4241);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('chronoengine.com', 3076, 822);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('imdb.com', 2727, 6574);
insert into pieza_extraccion_petrolera (numero_serie, tipo, dimensiones) values ('wordpress.org', 151, 7096);



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
