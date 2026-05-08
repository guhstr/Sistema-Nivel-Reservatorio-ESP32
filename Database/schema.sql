-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: bxtupvdxfjdabxfarhib-mysql.services.clever-cloud.com:3306
-- Tempo de geração: 06/05/2026 às 12:23
-- Versão do servidor: 8.0.22-13
-- Versão do PHP: 8.2.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `bxtupvdxfjdabxfarhib`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `clima_saopaulo`
--

CREATE TABLE `clima_saopaulo` (
  `id` int NOT NULL,
  `temperatura` float NOT NULL COMMENT 'Temperatura externa em C',
  `sensacao` float NOT NULL COMMENT 'Sensacao termica em C',
  `umidade` int NOT NULL COMMENT 'Umidade relativa em %',
  `descricao` varchar(100) NOT NULL COMMENT 'Descricao do clima',
  `vento` float NOT NULL COMMENT 'Velocidade do vento em m/s',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `clima_saopaulo`
--

INSERT INTO `clima_saopaulo` (`id`, `temperatura`, `sensacao`, `umidade`, `descricao`, `vento`, `criado_em`) VALUES
(1, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:10:20'),
(2, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:10:28'),
(3, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:11:20'),
(4, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:11:43'),
(5, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:11:44'),
(6, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:12:43'),
(7, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:13:43'),
(8, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:14:43'),
(9, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:15:43'),
(10, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:16:16'),
(11, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:17:16'),
(12, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:18:16'),
(13, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:19:16'),
(14, 23.21, 23.65, 79, 'clear sky', 2.68, '2026-05-06 12:20:16'),
(15, 22.67, 22.92, 74, 'clear sky', 2.57, '2026-05-06 12:21:16'),
(16, 22.67, 22.92, 74, 'clear sky', 2.57, '2026-05-06 12:22:16'),
(17, 22.67, 22.92, 74, 'clear sky', 2.57, '2026-05-06 12:23:16');

-- --------------------------------------------------------

--
-- Estrutura para tabela `leituras_distancia`
--

CREATE TABLE `leituras_distancia` (
  `id` int NOT NULL,
  `distancia` float NOT NULL COMMENT 'Distancia em centimetros',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `leituras_distancia`
--

INSERT INTO `leituras_distancia` (`id`, `distancia`, `criado_em`) VALUES
(1, 150, '2026-05-06 12:11:01'),
(2, 9, '2026-05-06 12:11:21'),
(3, 15, '2026-05-06 12:12:18');

-- --------------------------------------------------------

--
-- Estrutura para tabela `leituras_temperatura`
--

CREATE TABLE `leituras_temperatura` (
  `id` int NOT NULL,
  `temperatura` float NOT NULL COMMENT 'Temperatura em graus Celsius',
  `criado_em` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Despejando dados para a tabela `leituras_temperatura`
--

INSERT INTO `leituras_temperatura` (`id`, `temperatura`, `criado_em`) VALUES
(1, 15, '2026-05-06 12:12:29'),
(2, 25, '2026-05-06 12:12:32');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `clima_saopaulo`
--
ALTER TABLE `clima_saopaulo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_clima_criado` (`criado_em`);

--
-- Índices de tabela `leituras_distancia`
--
ALTER TABLE `leituras_distancia`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_dist_criado` (`criado_em`);

--
-- Índices de tabela `leituras_temperatura`
--
ALTER TABLE `leituras_temperatura`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_temp_criado` (`criado_em`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `clima_saopaulo`
--
ALTER TABLE `clima_saopaulo`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT de tabela `leituras_distancia`
--
ALTER TABLE `leituras_distancia`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `leituras_temperatura`
--
ALTER TABLE `leituras_temperatura`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
