-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Tempo de geração: 20/07/2021 às 15:46
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
-- Estrutura para tabela `iphocell_client`
--

CREATE TABLE `iphocell_client` (
  `ipc_client_id` int NOT NULL,
  `ipc_client_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ipc_client_cpf` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `ipc_client_birthday` date NOT NULL,
  `ipc_client_exclude` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `iphocell_client`
--

INSERT INTO `iphocell_client` (`ipc_client_id`, `ipc_client_name`, `ipc_client_cpf`, `ipc_client_birthday`, `ipc_client_exclude`) VALUES
(32, 'Leonardo Leles Alves', '05063839118', '2026-09-17', 0),
(33, 'A Maria betânica', '05063839118', '2021-07-13', 0),
(35, 'José Alves', '12312321321', '2021-07-17', 0),
(36, 'Joana silve', '12312331313', '2021-07-22', 0),
(37, 'Leonardo Leles Alves', '12312321321', '2021-07-20', 0);

-- --------------------------------------------------------

--
-- Estrutura para tabela `iphocell_order_status`
--

CREATE TABLE `iphocell_order_status` (
  `ipc_os_id` int NOT NULL,
  `ipc_os_name` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `ipc_os_exclude` int DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `iphocell_order_status`
--

INSERT INTO `iphocell_order_status` (`ipc_os_id`, `ipc_os_name`, `ipc_os_exclude`) VALUES
(1, 'Aguardando aparelho', 0),
(2, 'Em andamento', 0),
(3, 'Finalizado', 0),
(4, 'Entregue', 0);

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

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_access_log`
--

CREATE TABLE `system_access_log` (
  `id` int NOT NULL,
  `sessionid` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `login` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `login_time` timestamp NULL DEFAULT NULL,
  `login_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `login_month` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `login_day` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `logout_time` timestamp NULL DEFAULT NULL,
  `impersonated` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `access_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `system_access_log`
--

INSERT INTO `system_access_log` (`id`, `sessionid`, `login`, `login_time`, `login_year`, `login_month`, `login_day`, `logout_time`, `impersonated`, `access_ip`) VALUES
(1, '30e4decadd1500f46e5ade120d833d25', 'admin', '2021-07-17 20:42:37', '2021', '07', '17', '2021-07-17 20:43:54', 'N', '172.23.0.1'),
(2, '566b37ae8c1e4b3f93c35b4ddce82ef7', 'admin', '2021-07-17 20:43:57', '2021', '07', '17', '2021-07-17 20:44:09', 'N', '172.23.0.1'),
(3, '16c55dda6619838d73e31b30db441ab3', 'admin', '2021-07-17 20:44:15', '2021', '07', '17', '2021-07-17 20:45:09', 'N', '172.23.0.1'),
(4, 'fd195d841bcc6298bc5b416a232f57cd', 'admin', '2021-07-17 20:45:12', '2021', '07', '17', NULL, 'N', '172.23.0.1'),
(5, 'ba41da01d080c56d693683ff5b6a3769', 'admin', '2021-07-18 12:21:47', '2021', '07', '18', '2021-07-18 12:22:24', 'N', '172.23.0.1'),
(6, '0ac8e94d639bc7c9b7552e9d55b771c9', 'admin', '2021-07-18 12:26:24', '2021', '07', '18', '2021-07-18 12:28:41', 'N', '172.23.0.1'),
(7, '1e4bf4d4dc91d8d73b1d7ee02a8ffae7', 'admin', '2021-07-18 12:28:45', '2021', '07', '18', '2021-07-18 12:28:48', 'N', '172.23.0.1'),
(8, '25996f1ce29896aaab01701b2bf309d1', 'admin', '2021-07-18 12:28:53', '2021', '07', '18', '2021-07-18 12:29:51', 'N', '172.23.0.1'),
(9, '52df5385fbf94453f91c8d80cdc81465', 'admin', '2021-07-18 12:46:58', '2021', '07', '18', '2021-07-18 13:05:16', 'N', '172.23.0.1'),
(10, '2c46ef7d24bbecd37b8e0d6ad415ae55', 'admin', '2021-07-18 13:05:29', '2021', '07', '18', '2021-07-18 13:10:31', 'N', '172.23.0.1'),
(11, 'a46e48b79e67a1e9303e9dd21dc3a129', 'admin', '2021-07-18 13:10:35', '2021', '07', '18', NULL, 'N', '172.23.0.1'),
(12, '73c65eb15472cf54254db92af99a49be', 'user', '2021-07-18 13:13:36', '2021', '07', '18', '2021-07-18 13:13:50', 'Y', '172.23.0.1'),
(13, 'c079b4d07b0edb4b34ae876c3c7716dd', 'admin', '2021-07-18 13:13:55', '2021', '07', '18', '2021-07-18 13:55:23', 'N', '172.23.0.1'),
(14, '99df5877fc4f6d2a58f3c5ddd98a0d4a', 'admin', '2021-07-18 13:55:28', '2021', '07', '18', '2021-07-18 15:10:37', 'N', '172.23.0.1'),
(15, '9ac54e1fbfac44feb698e03cdae76a82', 'admin', '2021-07-18 15:10:42', '2021', '07', '18', '2021-07-18 15:19:21', 'N', '172.23.0.1'),
(16, '256ff0484dd6fcd6d91ca9b17ab1b6d2', 'admin', '2021-07-18 15:19:27', '2021', '07', '18', NULL, 'N', '172.23.0.1'),
(17, 'd93a05d63895965f16a68c126e312958', 'admin', '2021-07-18 18:39:43', '2021', '07', '18', '2021-07-18 19:15:36', 'N', '172.23.0.1'),
(18, 'b871087c5c3b559a54168fb1fcdd8ca2', 'admin', '2021-07-18 19:16:07', '2021', '07', '18', NULL, 'N', '172.23.0.1'),
(19, 'e5046c8611d8837d1ecd1b635e800073', 'admin', '2021-07-19 23:26:57', '2021', '07', '19', NULL, 'N', '172.18.0.1'),
(20, 'fdc97f9599c0cf4dcbfc8977e8106de8', 'admin', '2021-07-20 08:26:00', '2021', '07', '20', '2021-07-20 09:11:14', 'N', '172.18.0.1'),
(21, 'cbd2e0222db7e4495aa3b878a967fc8b', 'admin', '2021-07-20 09:11:28', '2021', '07', '20', '2021-07-20 09:11:56', 'N', '172.18.0.1'),
(22, '61071bc2c0482c0e2acdbce4ee3a7045', 'admin', '2021-07-20 09:22:39', '2021', '07', '20', '2021-07-20 09:26:33', 'N', '172.18.0.1'),
(23, '9c6e694c9208b479f6d8cedfd716709d', 'admin', '2021-07-20 09:29:47', '2021', '07', '20', '2021-07-20 10:05:46', 'N', '172.18.0.1'),
(24, 'ea481e628f083b2d968d3368dcaab032', 'admin', '2021-07-20 10:05:48', '2021', '07', '20', '2021-07-20 12:05:50', 'N', '172.18.0.1'),
(25, '19563d2921e92db17e0a96b3dce157de', 'admin', '2021-07-20 12:05:52', '2021', '07', '20', NULL, 'N', '172.18.0.1');

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_change_log`
--

CREATE TABLE `system_change_log` (
  `id` int NOT NULL,
  `logdate` timestamp NULL DEFAULT NULL,
  `login` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `tablename` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `primarykey` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `pkvalue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `operation` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `columnname` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `oldvalue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `newvalue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `access_ip` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `transaction_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `log_trace` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `session_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `class_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `php_sapi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `log_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `log_month` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `log_day` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_document`
--

CREATE TABLE `system_document` (
  `id` int NOT NULL,
  `system_user_id` int DEFAULT NULL,
  `title` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `category_id` int DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `archive_date` date DEFAULT NULL,
  `filename` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_document_category`
--

CREATE TABLE `system_document_category` (
  `id` int NOT NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `system_document_category`
--

INSERT INTO `system_document_category` (`id`, `name`) VALUES
(1, 'Documentação');

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_document_group`
--

CREATE TABLE `system_document_group` (
  `id` int NOT NULL,
  `document_id` int DEFAULT NULL,
  `system_group_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_document_user`
--

CREATE TABLE `system_document_user` (
  `id` int NOT NULL,
  `document_id` int DEFAULT NULL,
  `system_user_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_group`
--

CREATE TABLE `system_group` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `system_group`
--

INSERT INTO `system_group` (`id`, `name`) VALUES
(1, 'Administrador'),
(2, 'Funcionário');

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_group_program`
--

CREATE TABLE `system_group_program` (
  `id` int NOT NULL,
  `system_group_id` int DEFAULT NULL,
  `system_program_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `system_group_program`
--

INSERT INTO `system_group_program` (`id`, `system_group_id`, `system_program_id`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 6),
(7, 1, 8),
(8, 1, 9),
(9, 1, 11),
(10, 1, 14),
(11, 1, 15),
(12, 1, 21),
(13, 1, 26),
(14, 1, 27),
(15, 1, 28),
(16, 1, 29),
(17, 1, 31),
(18, 1, 32),
(19, 1, 33),
(20, 1, 34),
(21, 1, 35),
(22, 1, 36),
(23, 1, 37),
(24, 1, 38),
(25, 1, 39),
(26, 1, 40),
(27, 1, 62),
(28, 2, 62),
(29, 1, 63),
(30, 2, 63),
(31, 1, 65),
(32, 2, 65);

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_message`
--

CREATE TABLE `system_message` (
  `id` int NOT NULL,
  `system_user_id` int DEFAULT NULL,
  `system_user_to_id` int DEFAULT NULL,
  `subject` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `dt_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `checked` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_notification`
--

CREATE TABLE `system_notification` (
  `id` int NOT NULL,
  `system_user_id` int DEFAULT NULL,
  `system_user_to_id` int DEFAULT NULL,
  `subject` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `dt_message` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `action_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `action_label` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `icon` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `checked` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_preference`
--

CREATE TABLE `system_preference` (
  `id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_program`
--

CREATE TABLE `system_program` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `controller` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `system_program`
--

INSERT INTO `system_program` (`id`, `name`, `controller`) VALUES
(1, 'System Group Form', 'SystemGroupForm'),
(2, 'System Group List', 'SystemGroupList'),
(3, 'System Program Form', 'SystemProgramForm'),
(4, 'System Program List', 'SystemProgramList'),
(5, 'System User Form', 'SystemUserForm'),
(6, 'System User List', 'SystemUserList'),
(7, 'Common Page', 'CommonPage'),
(8, 'System PHP Info', 'SystemPHPInfoView'),
(9, 'System ChangeLog View', 'SystemChangeLogView'),
(10, 'Welcome View', 'WelcomeView'),
(11, 'System Sql Log', 'SystemSqlLogList'),
(12, 'System Profile View', 'SystemProfileView'),
(13, 'System Profile Form', 'SystemProfileForm'),
(14, 'System SQL Panel', 'SystemSQLPanel'),
(15, 'System Access Log', 'SystemAccessLogList'),
(16, 'System Message Form', 'SystemMessageForm'),
(17, 'System Message List', 'SystemMessageList'),
(18, 'System Message Form View', 'SystemMessageFormView'),
(19, 'System Notification List', 'SystemNotificationList'),
(20, 'System Notification Form View', 'SystemNotificationFormView'),
(21, 'System Document Category List', 'SystemDocumentCategoryFormList'),
(22, 'System Document Form', 'SystemDocumentForm'),
(23, 'System Document Upload Form', 'SystemDocumentUploadForm'),
(24, 'System Document List', 'SystemDocumentList'),
(25, 'System Shared Document List', 'SystemSharedDocumentList'),
(26, 'System Unit Form', 'SystemUnitForm'),
(27, 'System Unit List', 'SystemUnitList'),
(28, 'System Access stats', 'SystemAccessLogStats'),
(29, 'System Preference form', 'SystemPreferenceForm'),
(30, 'System Support form', 'SystemSupportForm'),
(31, 'System PHP Error', 'SystemPHPErrorLogView'),
(32, 'System Database Browser', 'SystemDatabaseExplorer'),
(33, 'System Table List', 'SystemTableList'),
(34, 'System Data Browser', 'SystemDataBrowser'),
(35, 'System Menu Editor', 'SystemMenuEditor'),
(36, 'System Request Log', 'SystemRequestLogList'),
(37, 'System Request Log View', 'SystemRequestLogView'),
(38, 'System Administration Dashboard', 'SystemAdministrationDashboard'),
(39, 'System Log Dashboard', 'SystemLogDashboard'),
(40, 'System Session dump', 'SystemSessionDumpView'),
(41, 'System ChangeLog View', 'SystemChangeLogView'),
(42, 'Welcome View', 'WelcomeView'),
(43, 'System Sql Log', 'SystemSqlLogList'),
(44, 'System Profile View', 'SystemProfileView'),
(45, 'System Profile Form', 'SystemProfileForm'),
(46, 'System SQL Panel', 'SystemSQLPanel'),
(47, 'System Access Log', 'SystemAccessLogList'),
(48, 'System Message List', 'SystemMessageList'),
(49, 'System Message Form View', 'SystemMessageFormView'),
(50, 'System Notification List', 'SystemNotificationList'),
(51, 'System Notification Form View', 'SystemNotificationFormView'),
(52, 'System Document Category List', 'SystemDocumentCategoryFormList'),
(53, 'System Document Form', 'SystemDocumentForm'),
(54, 'System Document Upload Form', 'SystemDocumentUploadForm'),
(55, 'System Document List', 'SystemDocumentList'),
(56, 'System Shared Document List', 'SystemSharedDocumentList'),
(57, 'System Unit Form', 'SystemUnitForm'),
(58, 'System Unit List', 'SystemUnitList'),
(59, 'System Access stats', 'SystemAccessLogStats'),
(60, 'System Preference form', 'SystemPreferenceForm'),
(61, 'System Support form', 'SystemSupportForm'),
(62, 'Listagem de Clientes', 'IphoCellClientList'),
(63, 'Formulário de cliente', 'IphoCellClientForm'),
(64, 'Consulta de Serviço', 'IphoCellConsultService'),
(65, 'Manutenções', 'IphoCellServiceOrderList');

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_request_log`
--

CREATE TABLE `system_request_log` (
  `id` int NOT NULL,
  `endpoint` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `logdate` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `log_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `log_month` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `log_day` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `session_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `login` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `access_ip` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `class_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `http_host` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `server_port` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `request_uri` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `request_method` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `query_string` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `request_headers` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `request_body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `request_duration` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_sql_log`
--

CREATE TABLE `system_sql_log` (
  `id` int NOT NULL,
  `logdate` timestamp NULL DEFAULT NULL,
  `login` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `database_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `sql_command` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `statement_type` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `access_ip` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `transaction_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `log_trace` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `session_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `class_name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `php_sapi` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `request_id` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci,
  `log_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `log_month` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `log_day` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_unit`
--

CREATE TABLE `system_unit` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `connection_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_user`
--

CREATE TABLE `system_user` (
  `id` int NOT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `login` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `frontpage_id` int DEFAULT NULL,
  `system_unit_id` int DEFAULT NULL,
  `active` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `system_user`
--

INSERT INTO `system_user` (`id`, `name`, `login`, `password`, `email`, `frontpage_id`, `system_unit_id`, `active`) VALUES
(1, 'Administrator', 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@admin.net', 38, NULL, 'Y');

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_user_group`
--

CREATE TABLE `system_user_group` (
  `id` int NOT NULL,
  `system_user_id` int DEFAULT NULL,
  `system_group_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `system_user_group`
--

INSERT INTO `system_user_group` (`id`, `system_user_id`, `system_group_id`) VALUES
(1, 1, 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_user_program`
--

CREATE TABLE `system_user_program` (
  `id` int NOT NULL,
  `system_user_id` int DEFAULT NULL,
  `system_program_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `system_user_unit`
--

CREATE TABLE `system_user_unit` (
  `id` int NOT NULL,
  `system_user_id` int DEFAULT NULL,
  `system_unit_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `iphocell_client`
--
ALTER TABLE `iphocell_client`
  ADD PRIMARY KEY (`ipc_client_id`);

--
-- Índices de tabela `iphocell_order_status`
--
ALTER TABLE `iphocell_order_status`
  ADD PRIMARY KEY (`ipc_os_id`);

--
-- Índices de tabela `iphocell_service_order`
--
ALTER TABLE `iphocell_service_order`
  ADD PRIMARY KEY (`ipc_so_id`),
  ADD KEY `fk_order_status` (`ipc_so_status_id`),
  ADD KEY `fk_client` (`ipc_so_client_id`);

--
-- Índices de tabela `system_access_log`
--
ALTER TABLE `system_access_log`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_change_log`
--
ALTER TABLE `system_change_log`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_document`
--
ALTER TABLE `system_document`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_document_category`
--
ALTER TABLE `system_document_category`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_document_group`
--
ALTER TABLE `system_document_group`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_document_user`
--
ALTER TABLE `system_document_user`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_group`
--
ALTER TABLE `system_group`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_group_program`
--
ALTER TABLE `system_group_program`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sys_group_program_program_idx` (`system_program_id`),
  ADD KEY `sys_group_program_group_idx` (`system_group_id`);

--
-- Índices de tabela `system_message`
--
ALTER TABLE `system_message`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_notification`
--
ALTER TABLE `system_notification`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_program`
--
ALTER TABLE `system_program`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_request_log`
--
ALTER TABLE `system_request_log`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_sql_log`
--
ALTER TABLE `system_sql_log`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_unit`
--
ALTER TABLE `system_unit`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `system_user`
--
ALTER TABLE `system_user`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sys_user_program_idx` (`frontpage_id`);

--
-- Índices de tabela `system_user_group`
--
ALTER TABLE `system_user_group`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sys_user_group_group_idx` (`system_group_id`),
  ADD KEY `sys_user_group_user_idx` (`system_user_id`);

--
-- Índices de tabela `system_user_program`
--
ALTER TABLE `system_user_program`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sys_user_program_program_idx` (`system_program_id`),
  ADD KEY `sys_user_program_user_idx` (`system_user_id`);

--
-- Índices de tabela `system_user_unit`
--
ALTER TABLE `system_user_unit`
  ADD PRIMARY KEY (`id`),
  ADD KEY `system_user_id` (`system_user_id`),
  ADD KEY `system_unit_id` (`system_unit_id`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `iphocell_client`
--
ALTER TABLE `iphocell_client`
  MODIFY `ipc_client_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de tabela `iphocell_order_status`
--
ALTER TABLE `iphocell_order_status`
  MODIFY `ipc_os_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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

--
-- Restrições para tabelas `system_group_program`
--
ALTER TABLE `system_group_program`
  ADD CONSTRAINT `system_group_program_ibfk_1` FOREIGN KEY (`system_group_id`) REFERENCES `system_group` (`id`),
  ADD CONSTRAINT `system_group_program_ibfk_2` FOREIGN KEY (`system_program_id`) REFERENCES `system_program` (`id`);

--
-- Restrições para tabelas `system_user`
--
ALTER TABLE `system_user`
  ADD CONSTRAINT `system_user_ibfk_1` FOREIGN KEY (`frontpage_id`) REFERENCES `system_program` (`id`);

--
-- Restrições para tabelas `system_user_group`
--
ALTER TABLE `system_user_group`
  ADD CONSTRAINT `system_user_group_ibfk_1` FOREIGN KEY (`system_user_id`) REFERENCES `system_user` (`id`),
  ADD CONSTRAINT `system_user_group_ibfk_2` FOREIGN KEY (`system_group_id`) REFERENCES `system_group` (`id`);

--
-- Restrições para tabelas `system_user_program`
--
ALTER TABLE `system_user_program`
  ADD CONSTRAINT `system_user_program_ibfk_1` FOREIGN KEY (`system_user_id`) REFERENCES `system_user` (`id`),
  ADD CONSTRAINT `system_user_program_ibfk_2` FOREIGN KEY (`system_program_id`) REFERENCES `system_program` (`id`);

--
-- Restrições para tabelas `system_user_unit`
--
ALTER TABLE `system_user_unit`
  ADD CONSTRAINT `system_user_unit_ibfk_1` FOREIGN KEY (`system_user_id`) REFERENCES `system_user` (`id`),
  ADD CONSTRAINT `system_user_unit_ibfk_2` FOREIGN KEY (`system_unit_id`) REFERENCES `system_unit` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
