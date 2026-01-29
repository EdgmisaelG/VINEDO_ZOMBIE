CREATE TABLE cuidados_planta (
    cuidado_id INT PRIMARY KEY AUTO_INCREMENT,
    planta_id INT NOT NULL,
    jugador_id INT NULL,
    tipo_cuidado ENUM('riego', 'fertilizante', 'poda', 'pesticida', 
                     'tratamiento', 'entutorado', 'desinfeccion') DEFAULT 'riego',
    fecha_cuidado DATETIME DEFAULT CURRENT_TIMESTAMP,
    hora_cuidado TIME GENERATED ALWAYS AS (TIME(fecha_cuidado)) STORED,
    herramienta_usada VARCHAR(50) NULL,
    recurso_usado VARCHAR(50) NULL,
    cantidad_recurso DECIMAL(8,2) DEFAULT 0.00,
    efectividad DECIMAL(3,2) DEFAULT 1.00 COMMENT '0.00-1.00',
    clima_momento VARCHAR(50) NULL,
    resultado ENUM('excelente', 'bueno', 'regular', 'malo', 'desastre') DEFAULT 'regular',
    experiencia_ganada INT DEFAULT 0,
    nota TEXT NULL,
    
    -- Indices
    INDEX idx_planta (planta_id),
    INDEX idx_jugador (jugador_id),
    INDEX idx_fecha_cuidado (fecha_cuidado DESC),
    INDEX idx_tipo_cuidado (tipo_cuidado),
    INDEX idx_resultado (resultado),
    
    -- Claves foraneas
    FOREIGN KEY (planta_id) 
        REFERENCES plantas(planta_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    FOREIGN KEY (jugador_id) 
        REFERENCES jugadores(jugador_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE,
    
    -- Restricciones
    CONSTRAINT chk_efectividad CHECK (efectividad >= 0 AND efectividad <= 1),
    CONSTRAINT chk_cantidad_recurso CHECK (cantidad_recurso >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
