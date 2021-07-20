-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Tempo de geração: 20/07/2021 às 13:16
-- Versão do servidor: 8.0.26
-- Versão do PHP: 7.4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `iphocellservices`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `iphocell_service_order`
--

CREATE TABLE `iphocell_service_order` (
  `ipc_so_id` int NOT NULL,
  `ipc_so_title` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `ipc_so_description` text COLLATE utf8mb4_general_ci NOT NULL,
  `ipc_so_opening_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ipc_so_prediction_date` datetime DEFAULT NULL,
  `ipc_so_status_id` int NOT NULL,
  `ipc_so_client_id` int NOT NULL,
  `ipc_so_exclude` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `iphocell_service_order`
--

INSERT INTO `iphocell_service_order` (`ipc_so_id`, `ipc_so_title`, `ipc_so_description`, `ipc_so_opening_date`, `ipc_so_prediction_date`, `ipc_so_status_id`, `ipc_so_client_id`, `ipc_so_exclude`) VALUES
(3, 'Xiomi Redmi 5', '- Trocar tela e outros periféricos;', '2021-07-20 13:02:48', '2021-07-30 10:02:16', 1, 32, 0);

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `iphocell_service_order`
--
ALTER TABLE `iphocell_service_order`
  ADD PRIMARY KEY (`ipc_so_id`),
  ADD KEY `fk_order_status` (`ipc_so_status_id`),
  ADD KEY `fk_client` (`ipc_so_client_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `iphocell_service_order`
--
ALTER TABLE `iphocell_service_order`
  MODIFY `ipc_so_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `iphocell_service_order`
--
ALTER TABLE `iphocell_service_order`
  ADD CONSTRAINT `fk_client` FOREIGN KEY (`ipc_so_client_id`) REFERENCES `iphocell_client` (`ipc_client_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_order_status` FOREIGN KEY (`ipc_so_status_id`) REFERENCES `iphocell_order_status` (`ipc_os_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
