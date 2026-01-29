CREATE TABLE jugadores (
    jugador_id INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    pass_hash VARCHAR(255) NOT NULL,
    salt VARCHAR(32) NOT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_login DATETIME NULL,
    ultimo_logout DATETIME NULL,
    region CHAR(2) DEFAULT 'ES',
    idioma CHAR(2) DEFAULT 'es',
    online_status TINYINT DEFAULT 0 COMMENT '0=offline,1=online,2=ausente',
    modo_dificultad ENUM('pacífico', 'normal', 'hardcore', 'pesadilla') DEFAULT 'normal',
    configuracion JSON DEFAULT ('{}'),
    metadata JSON DEFAULT ('{}'),
    
    -- Índices
    INDEX idx_usuario (usuario),
    INDEX idx_email (email),
    INDEX idx_ultimo_login (ultimo_login DESC),
    INDEX idx_region (region),
    INDEX idx_online_status (online_status),
    
    -- Restricciones
    CONSTRAINT chk_email CHECK (email LIKE '%@%.%'),
    CONSTRAINT chk_region_length CHECK (CHAR_LENGTH(region) = 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
