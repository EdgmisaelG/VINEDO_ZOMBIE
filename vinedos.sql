CREATE TABLE vinedos (
    vinedo_id INT PRIMARY KEY AUTO_INCREMENT,
    jugador_id INT NOT NULL,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT NULL,
    tamaño_hectareas DECIMAL(5,2) DEFAULT 1.00,
    tipo_region ENUM('montana', 'valle', 'colina', 'llano', 'costa') DEFAULT 'valle',
    clima ENUM('seco', 'templado', 'húmedo', 'mediterráneo', 'continental') DEFAULT 'templado',
    fecha_fundacion DATE DEFAULT (CURRENT_DATE),
    infectado BOOLEAN DEFAULT FALSE,
    nivel_infeccion TINYINT DEFAULT 0 COMMENT '0-100',
    reputacion INT DEFAULT 0,
    coordenadas POINT NULL,
    recursos JSON DEFAULT ('{}'),
    estado_actual JSON DEFAULT ('{}'),
    
    -- Índices
    INDEX idx_jugador (jugador_id),
    INDEX idx_nombre (nombre),
    INDEX idx_infectado (infectado),
    SPATIAL INDEX idx_coordenadas (coordenadas),
    INDEX idx_fecha_fundacion (fecha_fundacion DESC),
    
    -- Claves foráneas
    FOREIGN KEY (jugador_id) 
        REFERENCES jugadores(jugador_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    -- Restricciones
    CONSTRAINT chk_tamaño CHECK (tamano_hectareas > 0 AND tamano_hectareas <= 50),
    CONSTRAINT chk_nivel_infeccion CHECK (nivel_infeccion >= 0 AND nivel_infeccion <= 100)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
