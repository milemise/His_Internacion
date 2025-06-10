-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 10-06-2025 a las 18:34:12
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `his_internacion`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `admisiones`
--

CREATE TABLE `admisiones` (
  `id_admision` int(11) NOT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `fecha_ingreso` datetime NOT NULL,
  `fecha_alta` datetime DEFAULT NULL,
  `motivo_internacion` text DEFAULT NULL,
  `es_emergencia` tinyint(1) NOT NULL DEFAULT 0,
  `estado_admision` enum('Activa','En Proceso','Dada de Alta','Cancelada') NOT NULL DEFAULT 'Activa',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `ala`
--

CREATE TABLE `ala` (
  `id_ala` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `altas`
--

CREATE TABLE `altas` (
  `id_alta` int(11) NOT NULL,
  `id_admision` int(11) NOT NULL,
  `id_medico` int(11) NOT NULL,
  `fecha_alta_real` datetime NOT NULL,
  `diagnostico_final` text NOT NULL,
  `tratamiento_indicado` text NOT NULL,
  `medicamentos_recetados` text NOT NULL,
  `fecha_control_sugerido` date DEFAULT NULL,
  `observaciones_alta` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `asignacion_cama`
--

CREATE TABLE `asignacion_cama` (
  `id_asignacion_cama` int(11) NOT NULL,
  `id_admision` int(11) NOT NULL,
  `id_cama` int(11) NOT NULL,
  `fecha_asignacion` datetime NOT NULL,
  `fecha_liberacion` datetime DEFAULT NULL,
  `es_actual` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cama`
--

CREATE TABLE `cama` (
  `id_cama` int(11) NOT NULL,
  `id_habitacion` int(11) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `estado` enum('Libre','Ocupada','En Limpieza','Fuera de Servicio') NOT NULL DEFAULT 'Libre',
  `genero_asignado` enum('M','F') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `especialidad`
--

CREATE TABLE `especialidad` (
  `id_especialidad` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `descripcion` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `evaluaciones`
--

CREATE TABLE `evaluaciones` (
  `id_evaluacion` int(11) NOT NULL,
  `id_admision` int(11) NOT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `id_medico` int(11) NOT NULL,
  `fecha_evaluacion` datetime NOT NULL,
  `diagnostico` text DEFAULT NULL,
  `observaciones_medicas` text DEFAULT NULL,
  `signos_vitales` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`signos_vitales`)),
  `plan_cuidados` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `habitaciones`
--

CREATE TABLE `habitaciones` (
  `id_habitacion` int(11) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `tipo` enum('Individual','Compartida','Suite') NOT NULL,
  `estado` enum('Disponible','Ocupada','Mantenimiento','Limpieza') NOT NULL DEFAULT 'Disponible',
  `id_ala` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `medicos`
--

CREATE TABLE `medicos` (
  `id_medico` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) DEFAULT NULL,
  `id_especialidad` int(11) NOT NULL,
  `matricula` varchar(50) NOT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `activo` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `obras_sociales`
--

CREATE TABLE `obras_sociales` (
  `id_obra_social` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `codigo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pacientes`
--

CREATE TABLE `pacientes` (
  `id_paciente` int(11) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `dni` varchar(20) NOT NULL,
  `fecha_nacimiento` date NOT NULL,
  `genero` enum('Masculino','Femenino','Otro','No especificado') DEFAULT 'No especificado',
  `telefono` varchar(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `grupo_sanguineo` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
  `alergias` text DEFAULT NULL,
  `medicamentos_actuales` text DEFAULT NULL,
  `id_obra_social` int(11) DEFAULT NULL,
  `numero_afiliado` varchar(50) DEFAULT NULL,
  `activo` tinyint(1) DEFAULT 1,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sessions`
--

CREATE TABLE `sessions` (
  `sid` varchar(36) NOT NULL,
  `expires` datetime DEFAULT NULL,
  `data` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `sessions`
--

INSERT INTO `sessions` (`sid`, `expires`, `data`, `created_at`, `updated_at`) VALUES
('5rVMMrJqosUXqOO8MgjPckhpdzOxDw59', '2025-06-11 01:26:25', '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2025-06-11T01:26:25.551Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}', '2025-06-09 23:00:55', '2025-06-10 01:26:25'),
('b4R4IDV_Pdl9VGoJ8DkM5L6ZMC-HERe5', '2025-06-10 20:09:43', '{\"cookie\":{\"originalMaxAge\":86399999,\"expires\":\"2025-06-10T20:09:43.696Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{\"error\":[\"Por favor, inicia sesión para acceder.\"]}}', '2025-06-09 20:09:43', '2025-06-09 20:09:43'),
('M98vCx4LNadjTE07u_zemBseLAAx8vzN', '2025-06-10 21:54:15', '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2025-06-10T21:54:07.153Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}', '2025-06-09 20:09:44', '2025-06-09 21:54:15'),
('r8neTyg2jR3LyzY4iNGHvu8maUq8yG-D', '2025-06-11 03:47:24', '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2025-06-11T03:45:14.365Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}', '2025-06-10 03:45:14', '2025-06-10 03:47:24'),
('wHnDTXEeT5P6EJ3Ssrfd6Fuyl31JacVT', '2025-06-11 16:30:40', '{\"cookie\":{\"originalMaxAge\":86399997,\"expires\":\"2025-06-11T16:30:39.242Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{}}', '2025-06-10 03:22:55', '2025-06-10 16:30:40'),
('Ww0MhX0JKt2Gh6Ic36Wz6X9Gmwe_81wH', '2025-06-11 03:22:55', '{\"cookie\":{\"originalMaxAge\":86400000,\"expires\":\"2025-06-11T03:22:55.170Z\",\"secure\":false,\"httpOnly\":true,\"path\":\"/\"},\"flash\":{\"error\":[\"Por favor, inicia sesión para acceder.\"]}}', '2025-06-10 03:22:55', '2025-06-10 03:22:55');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `turnos`
--

CREATE TABLE `turnos` (
  `id_turno` int(11) NOT NULL,
  `id_paciente` int(11) DEFAULT NULL,
  `id_medico` int(11) DEFAULT NULL,
  `fecha_hora` datetime NOT NULL,
  `estado` enum('pendiente','confirmado','cancelado','finalizado') NOT NULL DEFAULT 'pendiente'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuario` int(11) NOT NULL,
  `nombre_usuario` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `rol` enum('admin','medico','enfermero','recepcion') NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `admisiones`
--
ALTER TABLE `admisiones`
  ADD PRIMARY KEY (`id_admision`),
  ADD KEY `id_paciente` (`id_paciente`);

--
-- Indices de la tabla `ala`
--
ALTER TABLE `ala`
  ADD PRIMARY KEY (`id_ala`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `nombre_2` (`nombre`),
  ADD UNIQUE KEY `nombre_3` (`nombre`),
  ADD UNIQUE KEY `nombre_4` (`nombre`),
  ADD UNIQUE KEY `nombre_5` (`nombre`),
  ADD UNIQUE KEY `nombre_6` (`nombre`),
  ADD UNIQUE KEY `nombre_7` (`nombre`);

--
-- Indices de la tabla `altas`
--
ALTER TABLE `altas`
  ADD PRIMARY KEY (`id_alta`),
  ADD UNIQUE KEY `id_admision` (`id_admision`),
  ADD KEY `id_medico` (`id_medico`);

--
-- Indices de la tabla `asignacion_cama`
--
ALTER TABLE `asignacion_cama`
  ADD PRIMARY KEY (`id_asignacion_cama`),
  ADD KEY `id_admision` (`id_admision`),
  ADD KEY `id_cama` (`id_cama`);

--
-- Indices de la tabla `cama`
--
ALTER TABLE `cama`
  ADD PRIMARY KEY (`id_cama`),
  ADD KEY `id_habitacion` (`id_habitacion`);

--
-- Indices de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  ADD PRIMARY KEY (`id_especialidad`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `nombre_2` (`nombre`),
  ADD UNIQUE KEY `nombre_3` (`nombre`),
  ADD UNIQUE KEY `nombre_4` (`nombre`),
  ADD UNIQUE KEY `nombre_5` (`nombre`),
  ADD UNIQUE KEY `nombre_6` (`nombre`),
  ADD UNIQUE KEY `nombre_7` (`nombre`),
  ADD UNIQUE KEY `nombre_8` (`nombre`),
  ADD UNIQUE KEY `nombre_9` (`nombre`),
  ADD UNIQUE KEY `nombre_10` (`nombre`),
  ADD UNIQUE KEY `nombre_11` (`nombre`),
  ADD UNIQUE KEY `nombre_12` (`nombre`),
  ADD UNIQUE KEY `nombre_13` (`nombre`),
  ADD UNIQUE KEY `nombre_14` (`nombre`),
  ADD UNIQUE KEY `nombre_15` (`nombre`),
  ADD UNIQUE KEY `nombre_16` (`nombre`),
  ADD UNIQUE KEY `nombre_17` (`nombre`),
  ADD UNIQUE KEY `nombre_18` (`nombre`),
  ADD UNIQUE KEY `nombre_19` (`nombre`),
  ADD UNIQUE KEY `nombre_20` (`nombre`),
  ADD UNIQUE KEY `nombre_21` (`nombre`),
  ADD UNIQUE KEY `nombre_22` (`nombre`),
  ADD UNIQUE KEY `nombre_23` (`nombre`),
  ADD UNIQUE KEY `nombre_24` (`nombre`),
  ADD UNIQUE KEY `nombre_25` (`nombre`),
  ADD UNIQUE KEY `nombre_26` (`nombre`),
  ADD UNIQUE KEY `nombre_27` (`nombre`),
  ADD UNIQUE KEY `nombre_28` (`nombre`),
  ADD UNIQUE KEY `nombre_29` (`nombre`),
  ADD UNIQUE KEY `nombre_30` (`nombre`),
  ADD UNIQUE KEY `nombre_31` (`nombre`),
  ADD UNIQUE KEY `nombre_32` (`nombre`),
  ADD UNIQUE KEY `nombre_33` (`nombre`),
  ADD UNIQUE KEY `nombre_34` (`nombre`),
  ADD UNIQUE KEY `nombre_35` (`nombre`),
  ADD UNIQUE KEY `nombre_36` (`nombre`),
  ADD UNIQUE KEY `nombre_37` (`nombre`),
  ADD UNIQUE KEY `nombre_38` (`nombre`);

--
-- Indices de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD PRIMARY KEY (`id_evaluacion`),
  ADD KEY `id_admision` (`id_admision`),
  ADD KEY `id_paciente` (`id_paciente`),
  ADD KEY `id_medico` (`id_medico`);

--
-- Indices de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD PRIMARY KEY (`id_habitacion`),
  ADD KEY `id_ala` (`id_ala`);

--
-- Indices de la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD PRIMARY KEY (`id_medico`),
  ADD UNIQUE KEY `matricula` (`matricula`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `matricula_2` (`matricula`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `matricula_3` (`matricula`),
  ADD UNIQUE KEY `email_3` (`email`),
  ADD UNIQUE KEY `matricula_4` (`matricula`),
  ADD UNIQUE KEY `email_4` (`email`),
  ADD UNIQUE KEY `matricula_5` (`matricula`),
  ADD UNIQUE KEY `email_5` (`email`),
  ADD UNIQUE KEY `matricula_6` (`matricula`),
  ADD UNIQUE KEY `email_6` (`email`),
  ADD UNIQUE KEY `matricula_7` (`matricula`),
  ADD UNIQUE KEY `email_7` (`email`),
  ADD KEY `id_especialidad` (`id_especialidad`);

--
-- Indices de la tabla `obras_sociales`
--
ALTER TABLE `obras_sociales`
  ADD PRIMARY KEY (`id_obra_social`),
  ADD UNIQUE KEY `nombre` (`nombre`),
  ADD UNIQUE KEY `codigo` (`codigo`),
  ADD UNIQUE KEY `nombre_2` (`nombre`),
  ADD UNIQUE KEY `codigo_2` (`codigo`),
  ADD UNIQUE KEY `nombre_3` (`nombre`),
  ADD UNIQUE KEY `codigo_3` (`codigo`),
  ADD UNIQUE KEY `nombre_4` (`nombre`),
  ADD UNIQUE KEY `codigo_4` (`codigo`),
  ADD UNIQUE KEY `nombre_5` (`nombre`),
  ADD UNIQUE KEY `codigo_5` (`codigo`),
  ADD UNIQUE KEY `nombre_6` (`nombre`),
  ADD UNIQUE KEY `codigo_6` (`codigo`),
  ADD UNIQUE KEY `nombre_7` (`nombre`),
  ADD UNIQUE KEY `codigo_7` (`codigo`),
  ADD UNIQUE KEY `nombre_8` (`nombre`),
  ADD UNIQUE KEY `codigo_8` (`codigo`);

--
-- Indices de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD PRIMARY KEY (`id_paciente`),
  ADD UNIQUE KEY `dni` (`dni`),
  ADD UNIQUE KEY `dni_2` (`dni`),
  ADD UNIQUE KEY `dni_3` (`dni`),
  ADD UNIQUE KEY `dni_4` (`dni`),
  ADD UNIQUE KEY `dni_5` (`dni`),
  ADD UNIQUE KEY `dni_6` (`dni`),
  ADD UNIQUE KEY `dni_7` (`dni`),
  ADD UNIQUE KEY `dni_8` (`dni`),
  ADD UNIQUE KEY `dni_9` (`dni`),
  ADD UNIQUE KEY `dni_10` (`dni`),
  ADD UNIQUE KEY `dni_11` (`dni`),
  ADD UNIQUE KEY `dni_12` (`dni`),
  ADD UNIQUE KEY `dni_13` (`dni`),
  ADD UNIQUE KEY `dni_14` (`dni`),
  ADD UNIQUE KEY `dni_15` (`dni`),
  ADD UNIQUE KEY `dni_16` (`dni`),
  ADD UNIQUE KEY `dni_17` (`dni`),
  ADD UNIQUE KEY `dni_18` (`dni`),
  ADD UNIQUE KEY `dni_19` (`dni`),
  ADD UNIQUE KEY `dni_20` (`dni`),
  ADD UNIQUE KEY `dni_21` (`dni`),
  ADD UNIQUE KEY `dni_22` (`dni`),
  ADD UNIQUE KEY `dni_23` (`dni`),
  ADD UNIQUE KEY `dni_24` (`dni`),
  ADD UNIQUE KEY `dni_25` (`dni`),
  ADD UNIQUE KEY `dni_26` (`dni`),
  ADD UNIQUE KEY `dni_27` (`dni`),
  ADD UNIQUE KEY `dni_28` (`dni`),
  ADD UNIQUE KEY `dni_29` (`dni`),
  ADD UNIQUE KEY `dni_30` (`dni`),
  ADD UNIQUE KEY `dni_31` (`dni`),
  ADD UNIQUE KEY `dni_32` (`dni`),
  ADD UNIQUE KEY `dni_33` (`dni`),
  ADD UNIQUE KEY `dni_34` (`dni`),
  ADD UNIQUE KEY `dni_35` (`dni`),
  ADD UNIQUE KEY `dni_36` (`dni`),
  ADD UNIQUE KEY `dni_37` (`dni`),
  ADD UNIQUE KEY `dni_38` (`dni`),
  ADD KEY `id_obra_social` (`id_obra_social`);

--
-- Indices de la tabla `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`sid`);

--
-- Indices de la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD PRIMARY KEY (`id_turno`),
  ADD KEY `id_paciente` (`id_paciente`),
  ADD KEY `id_medico` (`id_medico`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `email_2` (`email`),
  ADD UNIQUE KEY `email_3` (`email`),
  ADD UNIQUE KEY `email_4` (`email`),
  ADD UNIQUE KEY `email_5` (`email`),
  ADD UNIQUE KEY `email_6` (`email`),
  ADD UNIQUE KEY `email_7` (`email`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `admisiones`
--
ALTER TABLE `admisiones`
  MODIFY `id_admision` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `ala`
--
ALTER TABLE `ala`
  MODIFY `id_ala` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `altas`
--
ALTER TABLE `altas`
  MODIFY `id_alta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `asignacion_cama`
--
ALTER TABLE `asignacion_cama`
  MODIFY `id_asignacion_cama` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `cama`
--
ALTER TABLE `cama`
  MODIFY `id_cama` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `especialidad`
--
ALTER TABLE `especialidad`
  MODIFY `id_especialidad` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  MODIFY `id_evaluacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  MODIFY `id_habitacion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `medicos`
--
ALTER TABLE `medicos`
  MODIFY `id_medico` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `obras_sociales`
--
ALTER TABLE `obras_sociales`
  MODIFY `id_obra_social` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `pacientes`
--
ALTER TABLE `pacientes`
  MODIFY `id_paciente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `turnos`
--
ALTER TABLE `turnos`
  MODIFY `id_turno` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuario` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `admisiones`
--
ALTER TABLE `admisiones`
  ADD CONSTRAINT `admisiones_ibfk_1` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `altas`
--
ALTER TABLE `altas`
  ADD CONSTRAINT `altas_ibfk_73` FOREIGN KEY (`id_admision`) REFERENCES `admisiones` (`id_admision`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `altas_ibfk_74` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `asignacion_cama`
--
ALTER TABLE `asignacion_cama`
  ADD CONSTRAINT `asignacion_cama_ibfk_75` FOREIGN KEY (`id_admision`) REFERENCES `admisiones` (`id_admision`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `asignacion_cama_ibfk_76` FOREIGN KEY (`id_cama`) REFERENCES `cama` (`id_cama`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `cama`
--
ALTER TABLE `cama`
  ADD CONSTRAINT `cama_ibfk_1` FOREIGN KEY (`id_habitacion`) REFERENCES `habitaciones` (`id_habitacion`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `evaluaciones`
--
ALTER TABLE `evaluaciones`
  ADD CONSTRAINT `evaluaciones_ibfk_109` FOREIGN KEY (`id_admision`) REFERENCES `admisiones` (`id_admision`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluaciones_ibfk_110` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `evaluaciones_ibfk_111` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `habitaciones`
--
ALTER TABLE `habitaciones`
  ADD CONSTRAINT `habitaciones_ibfk_1` FOREIGN KEY (`id_ala`) REFERENCES `ala` (`id_ala`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `medicos`
--
ALTER TABLE `medicos`
  ADD CONSTRAINT `medicos_ibfk_1` FOREIGN KEY (`id_especialidad`) REFERENCES `especialidad` (`id_especialidad`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Filtros para la tabla `pacientes`
--
ALTER TABLE `pacientes`
  ADD CONSTRAINT `pacientes_ibfk_1` FOREIGN KEY (`id_obra_social`) REFERENCES `obras_sociales` (`id_obra_social`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Filtros para la tabla `turnos`
--
ALTER TABLE `turnos`
  ADD CONSTRAINT `turnos_ibfk_73` FOREIGN KEY (`id_paciente`) REFERENCES `pacientes` (`id_paciente`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `turnos_ibfk_74` FOREIGN KEY (`id_medico`) REFERENCES `medicos` (`id_medico`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
