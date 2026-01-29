CREATE TABLE habilidades (
    habilidad_id INT PRIMARY KEY AUTO_INCREMENT,
    jugador_id INT NOT NULL,
    categoria ENUM('agricultura', 'combate', 'supervivencia', 
                  'artesania', 'exploracion', 'social', 'ciencia') DEFAULT 'agricultura',
    nombre_habilidad VARCHAR(50) NOT NULL,
    nivel_actual TINYINT DEFAULT 1 COMMENT '1-100',
    nivel_maximo TINYINT DEFAULT 100,
    experiencia INT DEFAULT 0,
    exp_siguiente INT DEFAULT 100,
    exp_total INT DEFAULT 0,
    ultimo_uso DATETIME NULL,
    usos_totales INT DEFAULT 0,
    eficiencia DECIMAL(3,2) DEFAULT 1.00 COMMENT '0.50-2.00',
    bonus_activos JSON DEFAULT ('[]'),
    desbloqueado BOOLEAN DEFAULT TRUE,
    
    -- Indices
    INDEX idx_jugador (jugador_id),
    INDEX idx_categoria (categoria),
    INDEX idx_nombre (nombre_habilidad),
    INDEX idx_nivel_actual (nivel_actual DESC),
    UNIQUE INDEX idx_jugador_habilidad (jugador_id, nombre_habilidad),
    
    -- Claves foraneas
    FOREIGN KEY (jugador_id) 
        REFERENCES jugadores(jugador_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    -- Restricciones
    CONSTRAINT chk_nivel CHECK (nivel_actual >= 1 AND nivel_actual <= nivel_maximo),
    CONSTRAINT chk_experiencia CHECK (experiencia >= 0),
    CONSTRAINT chk_eficiencia CHECK (eficiencia >= 0.5 AND eficiencia <= 2.0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
