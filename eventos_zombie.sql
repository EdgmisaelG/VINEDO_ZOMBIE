CREATE TABLE eventos_zombie (
    evento_id INT PRIMARY KEY AUTO_INCREMENT,
    zona_id INT NULL,
    vinedo_id INT NOT NULL,
    tipo_evento ENUM('ataque', 'infestacion', 'asedio', 'incursion', 
                    'aparicion', 'jefe', 'noche_especial') DEFAULT 'ataque',
    subtipo VARCHAR(50) NULL,
    inicio DATETIME DEFAULT CURRENT_TIMESTAMP,
    fin DATETIME NULL,
    severidad TINYINT DEFAULT 1 COMMENT '1-10',
    intensidad TINYINT DEFAULT 1 COMMENT '1-10',
    cantidad_zombies INT DEFAULT 1,
    composicion JSON DEFAULT ('{}'),
    motivo ENUM('luna_llena', 'ruido', 'olor', 'infeccion', 
               'aleatorio', 'scripted', 'jugador') DEFAULT 'aleatorio',
    estado ENUM('activo', 'resuelto', 'fallado', 'escapado', 
               'neutralizado', 'cancelado') DEFAULT 'activo',
    dano_infligido DECIMAL(10,2) DEFAULT 0.00,
    recursos_perdidos JSON DEFAULT ('{}'),
    plantas_afectadas JSON DEFAULT ('[]'),
    experiencia_ganada INT DEFAULT 0,
    
    -- Indices
    INDEX idx_zona (zona_id),
    INDEX idx_vinedo (vinedo_id),
    INDEX idx_inicio (inicio DESC),
    INDEX idx_estado (estado),
    INDEX idx_severidad (severidad DESC),
    INDEX idx_tipo_evento (tipo_evento),
    
    -- Claves foraneas
    FOREIGN KEY (zona_id) 
        REFERENCES zonas_vinedo(zona_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    
    FOREIGN KEY (vinedo_id) 
        REFERENCES vinedos(vinedo_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    -- Restricciones
    CONSTRAINT chk_severidad CHECK (severidad >= 1 AND severidad <= 10),
    CONSTRAINT chk_intensidad CHECK (intensidad >= 1 AND intensidad <= 10),
    CONSTRAINT chk_cantidad_zombies CHECK (cantidad_zombies >= 0),
    CONSTRAINT chk_fecha_logica CHECK (fin IS NULL OR fin > inicio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
