CREATE TABLE acciones_defensa (
    accion_id INT PRIMARY KEY AUTO_INCREMENT,
    evento_id INT NOT NULL,
    jugador_id INT NOT NULL,
    tipo_accion ENUM('barricada', 'trampa', 'arma', 'explosivo', 
                    'distraccion', 'fuga', 'encubierto', 'alianza', 
                    'sniper', 'melee') DEFAULT 'arma',
    arma_usada VARCHAR(50) NULL,
    hora_accion DATETIME DEFAULT CURRENT_TIMESTAMP,
    posicion VARCHAR(20) NULL,
    objetivo VARCHAR(100) NULL,
    zombies_afectados INT DEFAULT 0,
    zombies_eliminados INT DEFAULT 0,
    precision DECIMAL(3,2) DEFAULT 0.00 COMMENT '0.00-1.00',
    dano_infligido DECIMAL(8,2) DEFAULT 0.00,
    recursos_usados JSON DEFAULT ('{}'),
    costo_estamina INT DEFAULT 0,
    resultado ENUM('exito', 'fracaso', 'parcial', 'critico', 
                  'fallo_critico', 'bloqueado') DEFAULT 'parcial',
    experiencia_ganada INT DEFAULT 0,
    
    -- Indices
    INDEX idx_evento (evento_id),
    INDEX idx_jugador (jugador_id),
    INDEX idx_hora_accion (hora_accion DESC),
    INDEX idx_resultado (resultado),
    INDEX idx_tipo_accion (tipo_accion),
    
    -- Claves foraneas
    FOREIGN KEY (evento_id) 
        REFERENCES eventos_zombie(evento_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    FOREIGN KEY (jugador_id) 
        REFERENCES jugadores(jugador_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    
    -- Restricciones
    CONSTRAINT chk_precision CHECK (precision >= 0 AND precision <= 1),
    CONSTRAINT chk_dano CHECK (dano_infligido >= 0),
    CONSTRAINT chk_zombies CHECK (zombies_eliminados <= zombies_afectados)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
