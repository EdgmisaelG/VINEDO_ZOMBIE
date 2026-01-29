CREATE TABLE plantas (
    planta_id INT PRIMARY KEY AUTO_INCREMENT,
    zona_id INT NOT NULL,
    tipo_uva ENUM('tempranillo', 'garnacha', 'cabernet', 'merlot', 
                  'chardonnay', 'sauvignon', 'riesling', 'syrah') DEFAULT 'tempranillo',
    variedad VARCHAR(50) NULL,
    fecha_plantacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    edad_dias INT GENERATED ALWAYS AS (DATEDIFF(CURRENT_DATE, fecha_plantacion)) STORED,
    etapa_crecimiento ENUM('semilla', 'brote', 'crecimiento', 'maduracion', 
                          'cosecha', 'dormancia', 'muerta') DEFAULT 'semilla',
    progreso_etapa TINYINT DEFAULT 0 COMMENT '0-100',
    salud TINYINT DEFAULT 100 COMMENT '0-100',
    calidad_potencial TINYINT DEFAULT 50 COMMENT '0-100',
    calidad_actual TINYINT DEFAULT 0 COMMENT '0-100',
    infectada BOOLEAN DEFAULT FALSE,
    etapa_infeccion TINYINT DEFAULT 0 COMMENT '0-3: 0=sana, 1=iniciando, 2=avanzada, 3=zombie',
    resistencia TINYINT DEFAULT 0 COMMENT '0-100',
    proximo_cuidado DATETIME NULL,
    proxima_cosecha DATETIME NULL,
    coordenadas VARCHAR(10) COMMENT 'x,y dentro de zona',
    metadata JSON DEFAULT ('{}'),
    
    -- Indices
    INDEX idx_zona (zona_id),
    INDEX idx_etapa_crecimiento (etapa_crecimiento),
    INDEX idx_proximo_cuidado (proximo_cuidado),
    INDEX idx_proxima_cosecha (proxima_cosecha),
    INDEX idx_infectada (infectada),
    INDEX idx_salud (salud),
    INDEX idx_tipo_uva (tipo_uva),
    
    -- Claves foraneas
    FOREIGN KEY (zona_id) 
        REFERENCES zonas_vinedo(zona_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    -- Restricciones
    CONSTRAINT chk_salud CHECK (salud >= 0 AND salud <= 100),
    CONSTRAINT chk_calidad CHECK (calidad_actual >= 0 AND calidad_actual <= 100),
    CONSTRAINT chk_progreso CHECK (progreso_etapa >= 0 AND progreso_etapa <= 100),
    CONSTRAINT chk_resistencia CHECK (resistencia >= 0 AND resistencia <= 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
