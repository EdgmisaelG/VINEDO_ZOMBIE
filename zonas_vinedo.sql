CREATE TABLE zonas_vinedo (
    zona_id INT PRIMARY KEY AUTO_INCREMENT,
    vinedo_id INT NOT NULL,
    nombre_zona VARCHAR(50) DEFAULT 'Zona sin nombre',
    tipo_zona ENUM('cultivo', 'defensa', 'almacen', 'produccion', 'ocio', 'investigacion') DEFAULT 'cultivo',
    tamano_celdas INT DEFAULT 100,
    calidad_suelo DECIMAL(3,2) DEFAULT 0.50 COMMENT '0.00-1.00',
    ph_suelo DECIMAL(3,2) DEFAULT 6.50,
    humedad DECIMAL(3,2) DEFAULT 0.50,
    nutrientes JSON DEFAULT ('{"nitrogeno": 0.5, "fosforo": 0.5, "potasio": 0.5}'),
    nivel_infeccion TINYINT DEFAULT 0 COMMENT '0-100',
    defensas JSON DEFAULT ('[]'),
    coordenadas_rel VARCHAR(20) COMMENT 'x,y,ancho,alto',
    
    -- Indices
    INDEX idx_vinedo (vinedo_id),
    INDEX idx_tipo_zona (tipo_zona),
    INDEX idx_calidad_suelo (calidad_suelo DESC),
    INDEX idx_nivel_infeccion (nivel_infeccion DESC),
    
    -- Claves foraneas
    FOREIGN KEY (vinedo_id) 
        REFERENCES vinedos(vinedo_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    -- Restricciones
    CONSTRAINT chk_calidad_suelo CHECK (calidad_suelo >= 0 AND calidad_suelo <= 1),
    CONSTRAINT chk_ph_suelo CHECK (ph_suelo >= 0 AND ph_suelo <= 14),
    CONSTRAINT chk_humedad CHECK (humedad >= 0 AND humedad <= 1),
    CONSTRAINT chk_tamano_celdas CHECK (tamano_celdas > 0 AND tamano_celdas <= 1000)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
