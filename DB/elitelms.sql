-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 28, 2023 at 08:15 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `elitelms`
--

-- --------------------------------------------------------

--
-- Table structure for table `category_group_assignment`
--

CREATE TABLE `category_group_assignment` (
  `category_group_assignment_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` int(11) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `category_group_assignment`
--

INSERT INTO `category_group_assignment` (`category_group_assignment_id`, `category_id`, `group_id`, `user_id`, `org_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 1, 1, NULL, 1, 1, 1, NULL, 1, NULL, '2023-04-05 11:18:46'),
(2, 1, 2, NULL, 1, 1, 1, NULL, 1, NULL, '2023-04-05 11:18:46');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_actions_master`
--

CREATE TABLE `lms_actions_master` (
  `actions_id` bigint(20) NOT NULL,
  `action_name` varchar(250) DEFAULT NULL,
  `module_id` bigint(20) DEFAULT NULL,
  `controller_name` varchar(250) NOT NULL,
  `method_name` varchar(250) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_actions_master`
--

INSERT INTO `lms_actions_master` (`actions_id`, `action_name`, `module_id`, `controller_name`, `method_name`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Dashboard', 11, 'manageMenuPermissions', 'getMenuList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(2, 'Manage Action Permissions', 12, 'manageMenuPermissions', 'getMenuList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(3, 'Manage Certificate List', 13, 'manageCertificate', 'getCertificateList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-06-03 15:06:42'),
(4, 'Add New Certificate', 13, 'add', 'addNewCertificate', 1, NULL, '2022-05-13 07:41:59', NULL, '2022-05-13 07:41:59', '2022-06-03 15:06:38'),
(5, 'View Certificate', 13, 'view', 'getCertificateById', 1, NULL, '2022-05-13 07:42:18', NULL, '2022-05-13 07:42:18', '2022-06-03 15:06:35'),
(6, 'Edit Certificate', 13, 'update', 'updateCertificateById', 1, NULL, '2022-05-13 07:42:35', NULL, '2022-05-13 07:42:35', '2022-06-03 15:06:31'),
(7, 'Delete Certificate', 13, 'delete', 'deleteCertificate', 1, NULL, '2022-05-13 07:42:52', NULL, '2022-05-13 07:42:52', '2022-06-03 15:06:26'),
(8, 'Course Library List', 14, 'manageCertificate', 'getCertificateList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-06-03 15:06:42'),
(9, 'Add New Course Library', 14, 'add', 'addNewCertificate', 1, NULL, '2022-05-13 07:41:59', NULL, '2022-05-13 07:41:59', '2022-06-03 15:06:38'),
(10, 'View Course Library', 14, 'view', 'getCertificateById', 1, NULL, '2022-05-13 07:42:18', NULL, '2022-05-13 07:42:18', '2022-06-03 15:06:35'),
(11, 'Edit Course Library', 14, 'update', 'updateCertificateById', 1, NULL, '2022-05-13 07:42:35', NULL, '2022-05-13 07:42:35', '2022-06-03 15:06:31'),
(12, 'Delete Course Library', 14, 'delete', 'deleteCertificate', 1, NULL, '2022-05-13 07:42:52', NULL, '2022-05-13 07:42:52', '2022-06-03 15:06:26'),
(13, 'Generic Category List', 15, 'manageCategory', 'getCategoryList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(14, 'Add New Generic Category', 15, 'add', 'addNewCategory', 1, NULL, '2022-05-13 07:37:41', NULL, '2022-05-13 07:37:41', '2022-05-12 04:27:30'),
(15, 'View Generic Category', 15, 'view', 'getCategoryById', 1, NULL, '2022-05-13 07:38:29', NULL, '2022-05-13 07:38:29', '2022-05-12 04:27:33'),
(16, 'Edit Generic Category', 15, 'update', 'updateCategoryById', 1, NULL, '2022-05-13 07:38:38', NULL, '2022-05-13 07:38:38', '2022-05-12 04:27:36'),
(17, 'Delete Generic Category', 15, 'delete', 'deleteCategory', 1, NULL, '2022-05-13 07:39:03', NULL, '2022-05-13 07:39:03', '2022-05-12 04:27:40'),
(18, 'Generic Group List', 16, 'manageCategory', 'getCategoryList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(19, 'Add New Generic Group', 16, 'add', 'addNewCategory', 1, NULL, '2022-05-13 07:37:41', NULL, '2022-05-13 07:37:41', '2022-05-12 04:27:30'),
(20, 'View Generic Group', 16, 'view', 'getCategoryById', 1, NULL, '2022-05-13 07:38:29', NULL, '2022-05-13 07:38:29', '2022-05-12 04:27:33'),
(21, 'Edit Generic Group', 16, 'update', 'updateCategoryById', 1, NULL, '2022-05-13 07:38:38', NULL, '2022-05-13 07:38:38', '2022-05-12 04:27:36'),
(22, 'Delete Generic Group', 16, 'delete', 'deleteCategory', 1, NULL, '2022-05-13 07:39:03', NULL, '2022-05-13 07:39:03', '2022-05-12 04:27:40'),
(23, 'Media Library List', 17, 'manageCategory', 'getCategoryList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(24, 'Add New Media Library', 17, 'add', 'addNewCategory', 1, NULL, '2022-05-13 07:37:41', NULL, '2022-05-13 07:37:41', '2022-05-12 04:27:30'),
(25, 'View Media Library', 17, 'view', 'getCategoryById', 1, NULL, '2022-05-13 07:38:29', NULL, '2022-05-13 07:38:29', '2022-05-12 04:27:33'),
(26, 'Edit Media Library', 17, 'update', 'updateCategoryById', 1, NULL, '2022-05-13 07:38:38', NULL, '2022-05-13 07:38:38', '2022-05-12 04:27:36'),
(27, 'Delete Media Library', 17, 'delete', 'deleteCategory', 1, NULL, '2022-05-13 07:39:03', NULL, '2022-05-13 07:39:03', '2022-05-12 04:27:40'),
(28, 'Manage Module List', 18, 'manageModule', 'getModuleList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(29, 'Add New Module', 18, 'add', 'addNewModule', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(30, 'View Module', 18, 'view', 'getModuleById', 1, NULL, '2022-05-13 07:27:51', NULL, '2022-05-13 07:27:51', '2022-05-12 03:57:51'),
(31, 'Edit Module', 18, 'update', 'updateModule', 1, NULL, '2022-05-13 07:28:43', NULL, '2022-05-13 07:28:43', '2022-05-12 04:17:12'),
(32, 'Delete Module', 18, 'delete', 'deleteModule', 1, NULL, '2022-05-13 07:30:23', NULL, '2022-05-13 07:30:23', '2022-05-12 04:00:23'),
(33, 'Manage Menu List', 19, 'manageMenu', 'getMenuMasterList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(34, 'Add Menu', 19, 'add', 'addNewMenuMaster', 1, NULL, '2022-05-13 07:32:15', NULL, '2022-05-13 07:32:15', '2022-05-12 04:02:15'),
(35, 'View Menu', 19, 'view', 'getMenuMasterById', 1, NULL, '2022-05-13 07:32:54', NULL, '2022-05-13 07:32:54', '2022-05-12 04:02:54'),
(36, 'Edit Menu', 19, 'update', 'updateMenuMaster', 1, NULL, '2022-05-13 07:33:06', NULL, '2022-05-13 07:33:06', '2022-05-12 04:16:49'),
(37, 'Delete Menu', 19, 'delete', 'deleteMenuMaster', 1, NULL, '2022-05-13 07:33:29', NULL, '2022-05-13 07:33:29', '2022-05-12 04:03:29'),
(38, 'Manage Menu Permissions', 20, 'manageActionPermission', 'getModuleActionsList', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-12 15:44:48'),
(39, 'Manage Notification List', 21, 'manageNotifications', 'getNotificationList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(40, 'Add New Notification', 21, 'addNewNotification', 'addNewNotification', 1, NULL, '2022-05-13 07:35:53', NULL, '2022-05-13 07:35:53', '2022-05-12 04:05:53'),
(41, 'View Notification', 21, 'view', 'getNotificationById', 1, NULL, '2022-05-13 07:36:26', NULL, '2022-05-13 07:36:26', '2022-05-12 04:06:26'),
(42, 'Edit Notification', 21, 'update', 'updateNotificationById', 1, NULL, '2022-05-13 07:36:37', NULL, '2022-05-13 07:36:37', '2022-05-12 04:16:22'),
(43, 'Delete Notification', 21, 'delete', 'deleteNotification', 1, NULL, '2022-05-13 07:36:51', NULL, '2022-05-13 07:36:51', '2022-05-12 04:15:51'),
(44, 'Manage Organization List', 22, 'manageOrganization', 'getCompanyList', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-08-12 09:47:44'),
(45, 'Add New Organization', 22, 'addNewOrganization', 'addNewOrganization', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-08-12 09:47:58'),
(46, 'View Organization', 22, 'view', 'getOrganizationById', 1, NULL, '2022-05-13 07:22:19', NULL, '2022-05-13 07:22:19', '2022-05-12 03:52:19'),
(47, 'Edit Organization', 22, 'edit', 'updateOrganizationById', 1, NULL, '2022-05-13 07:22:56', NULL, '2022-05-13 07:22:56', '2022-05-12 03:52:56'),
(48, 'Manage Roles', 23, 'manageRoles', 'getRoleList', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-12 03:50:42'),
(49, 'Manage Theme', 24, 'manageTheme', 'getThemeList', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-12 15:44:48'),
(50, 'Manage Category List', 28, 'manageCategory', 'getCategoryList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(51, 'Add New Category', 28, 'add', 'addNewCategory', 1, NULL, '2022-05-13 07:37:41', NULL, '2022-05-13 07:37:41', '2022-05-12 04:27:30'),
(52, 'View Category', 28, 'view', 'getCategoryById', 1, NULL, '2022-05-13 07:38:29', NULL, '2022-05-13 07:38:29', '2022-05-12 04:27:33'),
(53, 'Edit Category', 28, 'update', 'updateCategoryById', 1, NULL, '2022-05-13 07:38:38', NULL, '2022-05-13 07:38:38', '2022-05-12 04:27:36'),
(54, 'Delete Category', 28, 'delete', 'deleteCategory', 1, NULL, '2022-05-13 07:39:03', NULL, '2022-05-13 07:39:03', '2022-05-12 04:27:40'),
(55, 'Manage Notification List', 29, 'manageNotifications', 'getNotificationList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(56, 'Add New Notification', 29, 'addNewNotification', 'addNewNotification', 1, NULL, '2022-05-13 07:35:53', NULL, '2022-05-13 07:35:53', '2022-05-12 04:05:53'),
(57, 'View Notification', 29, 'view', 'getNotificationById', 1, NULL, '2022-05-13 07:36:26', NULL, '2022-05-13 07:36:26', '2022-05-12 04:06:26'),
(58, 'Edit Notification', 29, 'update', 'updateNotificationById', 1, NULL, '2022-05-13 07:36:37', NULL, '2022-05-13 07:36:37', '2022-05-12 04:16:22'),
(59, 'Delete Notification', 29, 'delete', 'deleteNotification', 1, NULL, '2022-05-13 07:36:51', NULL, '2022-05-13 07:36:51', '2022-05-12 04:15:51'),
(60, 'Course Library List', 34, 'manageCertificate', 'getCertificateList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-06-03 15:06:42'),
(61, 'Add New Course Library', 34, 'add', 'addNewCertificate', 1, NULL, '2022-05-13 07:41:59', NULL, '2022-05-13 07:41:59', '2022-06-03 15:06:38'),
(62, 'View Course Library', 34, 'view', 'getCertificateById', 1, NULL, '2022-05-13 07:42:18', NULL, '2022-05-13 07:42:18', '2022-06-03 15:06:35'),
(63, 'Edit Course Library', 34, 'update', 'updateCertificateById', 1, NULL, '2022-05-13 07:42:35', NULL, '2022-05-13 07:42:35', '2022-06-03 15:06:31'),
(64, 'Delete Course Library', 34, 'delete', 'deleteCertificate', 1, NULL, '2022-05-13 07:42:52', NULL, '2022-05-13 07:42:52', '2022-06-03 15:06:26'),
(65, 'Group List', 35, 'manageCategory', 'getCategoryList', 1, NULL, '2022-05-13 07:25:39', NULL, '2022-05-13 07:25:39', '2022-05-12 03:55:39'),
(66, 'Add New Group', 35, 'add', 'addNewCategory', 1, NULL, '2022-05-13 07:37:41', NULL, '2022-05-13 07:37:41', '2022-05-12 04:27:30'),
(67, 'View Group', 35, 'view', 'getCategoryById', 1, NULL, '2022-05-13 07:38:29', NULL, '2022-05-13 07:38:29', '2022-05-12 04:27:33'),
(68, 'Edit Group', 35, 'update', 'updateCategoryById', 1, NULL, '2022-05-13 07:38:38', NULL, '2022-05-13 07:38:38', '2022-05-12 04:27:36'),
(69, 'Delete Group', 35, 'delete', 'deleteCategory', 1, NULL, '2022-05-13 07:39:03', NULL, '2022-05-13 07:39:03', '2022-05-12 04:27:40'),
(70, 'User Instructor/Trainer List', 36, 'listUsers', 'getUserList', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-11 22:20:42'),
(71, 'Add New Instructor/Trainer List', 36, 'addNewUser', 'addNewUser', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-11 22:20:42'),
(72, 'View Instructor/Trainer List', 36, 'view', 'getUserById', 1, NULL, '2022-05-13 07:22:19', NULL, '2022-05-13 07:22:19', '2022-05-11 22:22:19'),
(73, 'Edit Instructor/Trainer List', 36, 'edit', 'updateUser', 1, NULL, '2022-05-13 07:22:56', NULL, '2022-05-13 07:22:56', '2022-05-11 22:22:56'),
(74, 'Delete Instructor/Trainer List', 36, 'delete', 'deleteUser', 1, NULL, '2022-05-13 07:22:56', NULL, '2022-05-13 07:22:56', '2022-05-11 22:22:56'),
(75, 'SubAdmin List', 37, 'listUsers', 'getUserList', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-11 22:20:42'),
(76, 'Add New SubAdmin', 37, 'addNewUser', 'addNewUser', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-11 22:20:42'),
(78, 'View SubAdmin', 37, 'view', 'getUserById', 1, NULL, '2022-05-13 07:22:19', NULL, '2022-05-13 07:22:19', '2022-05-11 22:22:19'),
(79, 'Edit SubAdmin', 37, 'edit', 'updateUser', 1, NULL, '2022-05-13 07:22:56', NULL, '2022-05-13 07:22:56', '2022-05-11 22:22:56'),
(80, 'Delete SubAdmin', 37, 'delete', 'deleteUser', 1, NULL, '2022-05-13 07:22:56', NULL, '2022-05-13 07:22:56', '2022-05-11 22:22:56'),
(81, 'User List', 38, 'listUsers', 'getUserList', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-11 22:20:42'),
(82, 'Add New User', 38, 'addNewUser', 'addNewUser', 1, NULL, '2022-05-13 07:20:42', NULL, '2022-05-13 07:20:42', '2022-05-11 22:20:42'),
(83, 'View User', 38, 'view', 'getUserById', 1, NULL, '2022-05-13 07:22:19', NULL, '2022-05-13 07:22:19', '2022-05-11 22:22:19'),
(84, 'Edit User', 38, 'edit', 'updateUser', 1, NULL, '2022-05-13 07:22:56', NULL, '2022-05-13 07:22:56', '2022-05-11 22:22:56'),
(85, 'Delete User', 38, 'delete', 'deleteUser', 1, NULL, '2022-05-13 07:22:56', NULL, '2022-05-13 07:22:56', '2022-05-11 22:22:56');

-- --------------------------------------------------------

--
-- Table structure for table `lms_area`
--

CREATE TABLE `lms_area` (
  `area_id` bigint(20) NOT NULL,
  `area_name` varchar(150) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_area`
--

INSERT INTO `lms_area` (`area_id`, `area_name`, `org_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, '123', 1, 1, 1, '2023-02-28 11:46:37', 1, '2023-02-28 11:46:37', '2023-02-28 11:46:37');

-- --------------------------------------------------------

--
-- Table structure for table `lms_assessment_question`
--

CREATE TABLE `lms_assessment_question` (
  `question_id` int(11) NOT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `question_type_id` int(11) DEFAULT NULL,
  `question` varchar(500) DEFAULT NULL,
  `show_ans_random` tinyint(1) DEFAULT 1,
  `number_of_options` tinyint(1) DEFAULT 1,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_assessment_settings`
--

CREATE TABLE `lms_assessment_settings` (
  `assessment_setting_id` int(11) NOT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `require_passing_score` tinyint(1) DEFAULT 1,
  `passing_percentage` int(11) DEFAULT NULL,
  `randomize_questions` tinyint(1) DEFAULT 1,
  `display_type` tinyint(4) DEFAULT 1,
  `hide_after_completed` tinyint(1) DEFAULT 1,
  `attempt_count` int(11) DEFAULT NULL,
  `learner_can_view_result` tinyint(1) DEFAULT 1,
  `post_quiz_action` tinyint(4) NOT NULL DEFAULT 1,
  `pass_fail_status` tinyint(1) DEFAULT 1,
  `total_score` tinyint(1) DEFAULT 1,
  `correct_incorrect_marked` tinyint(1) DEFAULT 1,
  `correct_incorrect_ans_marked` tinyint(1) DEFAULT 1,
  `timer_on` tinyint(1) DEFAULT 1,
  `hrs` int(11) DEFAULT 1,
  `mins` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_category_master`
--

CREATE TABLE `lms_category_master` (
  `category_id` bigint(20) NOT NULL,
  `category_name` varchar(150) DEFAULT NULL,
  `category_code` char(36) NOT NULL,
  `primary_category_id` bigint(20) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_category_master`
--

INSERT INTO `lms_category_master` (`category_id`, `category_name`, `category_code`, `primary_category_id`, `description`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'test', '', NULL, NULL, 0, NULL, NULL, NULL, '2023-04-25 11:11:27', '2023-04-25 11:11:27'),
(2, 'yy', 'oko', NULL, NULL, 0, NULL, NULL, NULL, '2023-04-25 11:11:27', '2023-04-25 11:11:27'),
(4, 'Education', 'Education', NULL, 'This is Education Category', 0, 1, '2023-04-25 04:44:19', 1, '2023-04-25 11:12:01', '2023-04-25 11:12:01');

-- --------------------------------------------------------

--
-- Table structure for table `lms_certificate_master`
--

CREATE TABLE `lms_certificate_master` (
  `certificate_id` bigint(20) NOT NULL,
  `certificate_code` varchar(255) NOT NULL DEFAULT '',
  `certificate_name` varchar(255) NOT NULL DEFAULT '',
  `description` text NOT NULL,
  `base_language` varchar(255) DEFAULT NULL,
  `cert_structure` text NOT NULL,
  `orientation` enum('P','L') NOT NULL DEFAULT 'P',
  `bgimage` varchar(255) NOT NULL DEFAULT '',
  `meta` tinyint(1) NOT NULL DEFAULT 0,
  `user_release` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_certificate_master`
--

INSERT INTO `lms_certificate_master` (`certificate_id`, `certificate_code`, `certificate_name`, `description`, `base_language`, `cert_structure`, `orientation`, `bgimage`, `meta`, `user_release`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Test1', 'Test', 'Test', '1', '1', 'P', 'tnCoa8wl6T2pdCmModweGnZ0ibN093W63pyD0Xbg.jpg', 1, 1, 1, 1, '2023-04-25 04:51:41', 1, '2023-04-25 04:51:41', '2023-04-25 04:51:41');

-- --------------------------------------------------------

--
-- Table structure for table `lms_company_announcement`
--

CREATE TABLE `lms_company_announcement` (
  `announcement_id` bigint(20) NOT NULL,
  `announcement_title` varchar(250) NOT NULL,
  `where_to_show` tinyint(4) DEFAULT NULL,
  `from_date` datetime DEFAULT NULL,
  `from_time` varchar(2) DEFAULT NULL,
  `to_date` datetime DEFAULT NULL,
  `to_time` varchar(2) DEFAULT NULL,
  `announcement_description` blob DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_content_library`
--

CREATE TABLE `lms_content_library` (
  `content_id` bigint(20) NOT NULL,
  `content_name` varchar(64) NOT NULL,
  `content_version` varchar(50) DEFAULT NULL,
  `content_types_id` bigint(20) DEFAULT NULL,
  `media_id` bigint(20) DEFAULT NULL,
  `parent_content_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `org_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_content_library`
--

INSERT INTO `lms_content_library` (`content_id`, `content_name`, `content_version`, `content_types_id`, `media_id`, `parent_content_id`, `is_active`, `org_id`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Roshan', '1.0', 1, 1, NULL, 1, 2, 1, '2023-02-27 07:02:53', 1, '2023-02-27 07:05:55', '2023-04-21 12:52:32'),
(2, 'test', '1.1', 3, 2, 1, 1, 1, 1, '2023-02-27 07:14:23', 1, '2023-02-27 07:35:00', '2023-02-28 07:48:08'),
(3, 'test', '1.0', 3, 3, NULL, 1, 1, 1, '2023-02-28 12:12:09', 1, '2023-02-28 12:12:09', '2023-02-28 12:12:09'),
(4, 'test', '1.0', 3, 4, NULL, 1, 1, 1, '2023-03-01 05:54:57', 1, '2023-03-01 05:54:57', '2023-03-01 05:54:57'),
(5, 'test', '1.0', 6, 5, NULL, 1, 1, 1, '2023-03-16 11:37:07', 1, '2023-03-16 11:37:07', '2023-03-16 11:37:07'),
(6, 'test', '1.0', 3, 6, NULL, 1, 1, 1, '2023-03-21 04:08:42', 1, '2023-03-21 04:08:42', '2023-03-21 04:08:42'),
(7, 'test', '1.0', 3, 7, NULL, 1, 1, 1, '2023-03-21 04:09:11', 1, '2023-03-21 04:09:11', '2023-03-21 04:09:11'),
(8, 'test', '1.0', 3, 8, NULL, 1, 1, 1, '2023-03-21 04:11:18', 1, '2023-03-21 04:11:18', '2023-03-21 04:11:18'),
(9, 'test', '1.0', 3, 9, NULL, 1, 1, 1, '2023-03-21 04:14:13', 1, '2023-03-21 04:14:13', '2023-03-21 04:14:13'),
(10, 'test', '1.0', 3, 10, NULL, 1, 1, 1, '2023-03-21 04:15:10', 1, '2023-03-21 04:15:10', '2023-03-21 04:15:10'),
(11, 'test', '1.0', 3, 11, NULL, 1, 1, 1, '2023-03-21 04:33:15', 1, '2023-03-21 04:33:15', '2023-03-21 04:33:15'),
(12, 'test', '1.0', 3, 12, NULL, 1, 1, 1, '2023-03-21 04:38:07', 1, '2023-03-21 04:38:07', '2023-03-21 04:38:07'),
(13, 'test', '1.0', 3, 13, NULL, 1, 1, 1, '2023-03-21 04:39:18', 1, '2023-03-21 04:39:18', '2023-03-21 04:39:18'),
(14, 'test', '1.0', 3, 14, NULL, 1, 1, 1, '2023-03-21 04:40:58', 1, '2023-03-21 04:40:58', '2023-03-21 04:40:58'),
(15, 'test', '1.0', 3, 15, NULL, 1, 1, 1, '2023-03-21 04:41:52', 1, '2023-03-21 04:41:52', '2023-03-21 04:41:52'),
(16, 'test', '1.0', 3, 16, NULL, 1, 1, 1, '2023-03-21 04:45:02', 1, '2023-03-21 04:45:02', '2023-03-21 04:45:02'),
(17, 'test', '1.0', 3, 17, NULL, 1, 1, 1, '2023-03-21 06:08:27', 1, '2023-03-21 06:08:27', '2023-03-21 06:08:27'),
(18, 'test', '1.0', 3, 18, NULL, 1, 1, 1, '2023-03-28 07:27:07', 1, '2023-03-28 07:27:07', '2023-03-28 07:27:07'),
(19, 'test', '1.0', 3, 19, NULL, 1, 1, 1, '2023-03-28 09:06:19', 1, '2023-03-28 09:06:19', '2023-03-28 09:06:19'),
(20, 'test', '1.0', 3, 20, NULL, 1, 1, 1, '2023-03-28 09:09:54', 1, '2023-03-28 09:09:54', '2023-03-28 09:09:54');

-- --------------------------------------------------------

--
-- Table structure for table `lms_content_types`
--

CREATE TABLE `lms_content_types` (
  `content_types_id` bigint(20) NOT NULL,
  `content_type` varchar(255) NOT NULL,
  `support_formats` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_content_types`
--

INSERT INTO `lms_content_types` (`content_types_id`, `content_type`, `support_formats`) VALUES
(1, 'Video', '.mp4|.m4v|.flv|.wmv|.mov|.swf'),
(2, 'Audio', '.mp3|.wma|.aac|.m4a'),
(3, 'SCORM', '.zip|.rar'),
(4, 'PDF Viewer (Documents/PDF)', '.doc|.docx|.pdf|.xlsx|.xls|.ppt|.pptx'),
(5, 'Embedded Code', 'all'),
(6, 'Slide Show', '.ppt|.pptx|.doc|.docx|.pdf'),
(7, 'Document', '.doc|.docx|.ppt|.pptx|.xls|.xlsx|.pdf'),
(8, 'Link(URL)', NULL),
(9, 'AICC', '.zip'),
(10, 'AICC - CSV', '.csv');

-- --------------------------------------------------------

--
-- Table structure for table `lms_country_master`
--

CREATE TABLE `lms_country_master` (
  `country_id` int(11) NOT NULL,
  `iso` char(2) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `country` varchar(80) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `is_active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_country_master`
--

INSERT INTO `lms_country_master` (`country_id`, `iso`, `country`, `is_active`) VALUES
(1, 'AF', 'Afghanistan', 1),
(2, 'NL', 'Netherlands', 1),
(3, 'AN', 'Netherlands Antilles', 1),
(4, 'AL', 'Albania', 1),
(5, 'DZ', 'Algeria', 1),
(6, 'AS', 'American Samoa', 1),
(7, 'AN', 'Andorra', 1),
(8, 'AG', 'Angola', 1),
(9, 'AI', 'Anguilla', 1),
(10, 'AT', 'Antigua and Barbuda', 1),
(11, 'AR', 'United Arab Emirates', 1),
(12, 'AR', 'Argentina', 1),
(13, 'AR', 'Armenia', 1),
(14, 'AB', 'Aruba', 1),
(15, 'AU', 'Australia', 1),
(16, 'AZ', 'Azerbaijan', 1),
(17, 'BH', 'Bahamas', 1),
(18, 'BH', 'Bahrain', 1),
(19, 'BG', 'Bangladesh', 1),
(20, 'BR', 'Barbados', 1),
(21, 'BE', 'Belgium', 1),
(22, 'BL', 'Belize', 1),
(23, 'BE', 'Benin', 1),
(24, 'BM', 'Bermuda', 1),
(25, 'BT', 'Bhutan', 1),
(26, 'BO', 'Bolivia', 1),
(27, 'BI', 'Bosnia and Herzegovina', 1),
(28, 'BW', 'Botswana', 1),
(29, 'BR', 'Brazil', 1),
(30, 'GB', 'United Kingdom', 1),
(31, 'VG', 'Virgin Islands, British', 1),
(32, 'BR', 'Brunei', 1),
(33, 'BG', 'Bulgaria', 1),
(34, 'BF', 'Burkina Faso', 1),
(35, 'BD', 'Burundi', 1),
(36, 'CY', 'Cayman Islands', 1),
(37, 'CL', 'Chile', 1),
(38, 'CO', 'Cook Islands', 1),
(39, 'CR', 'Costa Rica', 1),
(40, 'DJ', 'Djibouti', 1),
(41, 'DM', 'Dominica', 1),
(42, 'DO', 'Dominican Republic', 1),
(43, 'EC', 'Ecuador', 1),
(44, 'EG', 'Egypt', 1),
(45, 'SL', 'El Salvador', 1),
(46, 'ER', 'Eritrea', 1),
(47, 'ES', 'Spain', 1),
(48, 'ZA', 'South Africa', 1),
(49, 'ET', 'Ethiopia', 1),
(50, 'FL', 'Falkland Islands', 1),
(51, 'FJ', 'Fiji Islands', 1),
(52, 'PH', 'Philippines', 1),
(53, 'FR', 'Faroe Islands', 1),
(54, 'GA', 'Gabon', 1),
(55, 'GM', 'Gambia', 1),
(56, 'GE', 'Georgia', 1),
(57, 'GH', 'Ghana', 1),
(58, 'GI', 'Gibraltar', 1),
(59, 'GR', 'Grenada', 1),
(60, 'GR', 'Greenland', 1),
(61, 'GL', 'Guadeloupe', 1),
(62, 'GU', 'Guam', 1),
(63, 'GT', 'Guatemala', 1),
(64, 'GI', 'Guinea', 1),
(65, 'GN', 'Guinea-Bissau', 1),
(66, 'GU', 'Guyana', 1),
(67, 'HT', 'Haiti', 1),
(68, 'HN', 'Honduras', 1),
(69, 'HK', 'Hong Kong', 1),
(70, 'SJ', 'Svalbard and Jan Mayen', 1),
(71, 'ID', 'Indonesia', 1),
(72, 'IN', 'India', 1),
(73, 'IR', 'Iraq', 1),
(74, 'IR', 'Iran', 1),
(75, 'IR', 'Ireland', 1),
(76, 'IS', 'Iceland', 1),
(77, 'IS', 'Israel', 1),
(78, 'IT', 'Italy', 1),
(79, 'TM', 'East Timor', 1),
(80, 'AU', 'Austria', 1),
(81, 'JA', 'Jamaica', 1),
(82, 'JP', 'Japan', 1),
(83, 'YE', 'Yemen', 1),
(84, 'JO', 'Jordan', 1),
(85, 'CX', 'Christmas Island', 1),
(86, 'YU', 'Yugoslavia', 1),
(87, 'KH', 'Cambodia', 1),
(88, 'CM', 'Cameroon', 1),
(89, 'CA', 'Canada', 1),
(90, 'CP', 'Cape Verde', 1),
(91, 'KA', 'Kazakstan', 1),
(92, 'KE', 'Kenya', 1),
(93, 'CA', 'Central African Republic', 1),
(94, 'CN', 'China', 1),
(95, 'KG', 'Kyrgyzstan', 1),
(96, 'KI', 'Kiribati', 1),
(97, 'CO', 'Colombia', 1),
(98, 'CO', 'Comoros', 1),
(99, 'CO', 'Congo', 1),
(100, 'CO', 'Congo, The Democratic Republic of the', 1),
(101, 'CC', 'Cocos (Keeling) Islands', 1),
(102, 'PR', 'North Korea', 1),
(103, 'KO', 'South Korea', 1),
(104, 'GR', 'Greece', 1),
(105, 'HR', 'Croatia', 1),
(106, 'CU', 'Cuba', 1),
(107, 'KW', 'Kuwait', 1),
(108, 'CY', 'Cyprus', 1),
(109, 'LA', 'Laos', 1),
(110, 'LV', 'Latvia', 1),
(111, 'LS', 'Lesotho', 1),
(112, 'LB', 'Lebanon', 1),
(113, 'LB', 'Liberia', 1),
(114, 'LB', 'Libyan Arab Jamahiriya', 1),
(115, 'LI', 'Liechtenstein', 1),
(116, 'LT', 'Lithuania', 1),
(117, 'LU', 'Luxembourg', 1),
(118, 'ES', 'Western Sahara', 1),
(119, 'MA', 'Macao', 1),
(120, 'MD', 'Madagascar', 1),
(121, 'MK', 'Macedonia', 1),
(122, 'MW', 'Malawi', 1),
(123, 'MD', 'Maldives', 1),
(124, 'MY', 'Malaysia', 1),
(125, 'ML', 'Mali', 1),
(126, 'ML', 'Malta', 1),
(127, 'MA', 'Morocco', 1),
(128, 'MH', 'Marshall Islands', 1),
(129, 'MT', 'Martinique', 1),
(130, 'MR', 'Mauritania', 1),
(131, 'MU', 'Mauritius', 1),
(132, 'MY', 'Mayotte', 1),
(133, 'ME', 'Mexico', 1),
(134, 'FS', 'Micronesia, Federated States of', 1),
(135, 'MD', 'Moldova', 1),
(136, 'MC', 'Monaco', 1),
(137, 'MN', 'Mongolia', 1),
(138, 'MS', 'Montserrat', 1),
(139, 'MO', 'Mozambique', 1),
(140, 'MM', 'Myanmar', 1),
(141, 'NA', 'Namibia', 1),
(142, 'NR', 'Nauru', 1),
(143, 'NP', 'Nepal', 1),
(144, 'NI', 'Nicaragua', 1),
(145, 'NE', 'Niger', 1),
(146, 'NG', 'Nigeria', 1),
(147, 'NI', 'Niue', 1),
(148, 'NF', 'Norfolk Island', 1),
(149, 'NO', 'Norway', 1),
(150, 'CI', 'Coted\'Ivoire', 1),
(151, 'OM', 'Oman', 1),
(152, 'PA', 'Pakistan', 1),
(153, 'PL', 'Palau', 1),
(154, 'PA', 'Panama', 1),
(155, 'PN', 'Papua New Guinea', 1),
(156, 'PR', 'Paraguay', 1),
(157, 'PE', 'Peru', 1),
(158, 'PC', 'Pitcairn', 1),
(159, 'MN', 'Northern Mariana Islands', 1),
(160, 'PR', 'Portugal', 1),
(161, 'PR', 'Puerto Rico', 1),
(162, 'PO', 'Poland', 1),
(163, 'GN', 'Equatorial Guinea', 1),
(164, 'QA', 'Qatar', 1),
(165, 'FR', 'France', 1),
(166, 'GU', 'French Guiana', 1),
(167, 'PY', 'French Polynesia', 1),
(168, 'RE', 'Reunion', 1),
(169, 'RO', 'Romania', 1),
(170, 'RW', 'Rwanda', 1),
(171, 'SW', 'Sweden', 1),
(172, 'SH', 'Saint Helena', 1),
(173, 'KN', 'Saint Kitts and Nevis', 1),
(174, 'LC', 'Saint Lucia', 1),
(175, 'VC', 'Saint Vincent and the Grenadines', 1),
(176, 'SP', 'Saint Pierre and Miquelon', 1),
(177, 'DE', 'Germany', 1),
(178, 'SL', 'Solomon Islands', 1),
(179, 'ZM', 'Zambia', 1),
(180, 'WS', 'Samoa', 1),
(181, 'SM', 'San Marino', 1),
(182, 'ST', 'Sao Tome and Principe', 1),
(183, 'SA', 'Saudi Arabia', 1),
(184, 'SE', 'Senegal', 1),
(185, 'SY', 'Seychelles', 1),
(186, 'SL', 'Sierra Leone', 1),
(187, 'SG', 'Singapore', 1),
(188, 'SV', 'Slovakia', 1),
(189, 'SV', 'Slovenia', 1),
(190, 'SO', 'Somalia', 1),
(191, 'LK', 'Sri Lanka', 1),
(192, 'SD', 'Sudan', 1),
(193, 'FI', 'Finland', 1),
(194, 'SU', 'Suriname', 1),
(195, 'SW', 'Swaziland', 1),
(196, 'CH', 'Switzerland', 1),
(197, 'SY', 'Syria', 1),
(198, 'TJ', 'Tajikistan', 1),
(199, 'TW', 'Taiwan', 1),
(200, 'TZ', 'Tanzania', 1),
(201, 'DN', 'Denmark', 1),
(202, 'TH', 'Thailand', 1),
(203, 'TG', 'Togo', 1),
(204, 'TK', 'Tokelau', 1),
(205, 'TO', 'Tonga', 1),
(206, 'TT', 'Trinidad and Tobago', 1),
(207, 'TC', 'Chad', 1),
(208, 'CZ', 'Czech Republic', 1),
(209, 'TU', 'Tunisia', 1),
(210, 'TU', 'Turkey', 1),
(211, 'TK', 'Turkmenistan', 1),
(212, 'TC', 'Turks and Caicos Islands', 1),
(213, 'TU', 'Tuvalu', 1),
(214, 'UG', 'Uganda', 1),
(215, 'UK', 'Ukraine', 1),
(216, 'HU', 'Hungary', 1),
(217, 'UR', 'Uruguay', 1),
(218, 'NC', 'New Caledonia', 1),
(219, 'NZ', 'New Zealand', 1),
(220, 'UZ', 'Uzbekistan', 1),
(221, 'BL', 'Belarus', 1),
(222, 'WL', 'Wallis and Futuna', 1),
(223, 'VU', 'Vanuatu', 1),
(224, 'VA', 'Holy See (Vatican City State)', 1),
(225, 'VE', 'Venezuela', 1),
(226, 'RU', 'Russian Federation', 1),
(227, 'VN', 'Vietnam', 1),
(228, 'ES', 'Estonia', 1),
(229, 'US', 'United States', 1),
(230, 'VI', 'Virgin Islands, U.S.', 1),
(231, 'ZW', 'Zimbabwe', 1),
(232, 'PS', 'Palestine', 1),
(233, 'AT', 'Antarctica', 1),
(234, 'BV', 'Bouvet Island', 1),
(235, 'IO', 'British Indian Ocean Territory', 1),
(236, 'SG', 'South Georgia and the South Sandwich Islands', 1),
(237, 'HM', 'Heard Island and McDonald Islands', 1),
(238, 'AT', 'French Southern territories', 1),
(239, 'UM', 'United States Minor Outlying Islands', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_course_catalog`
--

CREATE TABLE `lms_course_catalog` (
  `course_catalog_id` bigint(20) NOT NULL,
  `training_type` tinyint(1) DEFAULT NULL,
  `course_code` varchar(50) DEFAULT NULL,
  `course_name` varchar(255) NOT NULL,
  `course_title` varchar(255) DEFAULT NULL,
  `quiz_type` tinyint(1) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `training_Content` bigint(20) DEFAULT NULL,
  `reference_code` varchar(50) DEFAULT NULL,
  `course_image` varchar(255) DEFAULT NULL,
  `credit` int(11) DEFAULT NULL,
  `credit_visibility` tinyint(1) DEFAULT 1,
  `point` int(11) DEFAULT NULL,
  `point_visibility` tinyint(1) DEFAULT 1,
  `certificate_id` tinyint(1) DEFAULT NULL,
  `ilt_assessment` tinyint(1) DEFAULT NULL,
  `activity_review` tinyint(1) DEFAULT NULL,
  `enrollment_type` tinyint(1) DEFAULT NULL,
  `unenrollment` tinyint(1) DEFAULT NULL,
  `passing_score` varchar(50) DEFAULT NULL,
  `ssl_for_aicc` tinyint(4) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `due_date` datetime DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_course_skill`
--

CREATE TABLE `lms_course_skill` (
  `course_skill_id` bigint(20) NOT NULL,
  `skill_id` tinyint(1) DEFAULT NULL,
  `level` varchar(255) NOT NULL,
  `credit` varchar(255) DEFAULT NULL,
  `course_catalog_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_division`
--

CREATE TABLE `lms_division` (
  `division_id` bigint(20) NOT NULL,
  `division_name` varchar(150) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_domain`
--

CREATE TABLE `lms_domain` (
  `domain_id` bigint(20) NOT NULL,
  `domain_name` varchar(64) NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_production` tinyint(4) DEFAULT 1,
  `is_https` tinyint(1) NOT NULL DEFAULT 0,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_domain`
--

INSERT INTO `lms_domain` (`domain_id`, `domain_name`, `is_active`, `is_production`, `is_https`, `date_created`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'dev.elitelms.com', 1, 2, 0, '2022-04-08 10:27:38', '2022-12-28 08:06:41', '2023-02-09 04:19:22'),
(2, 'dev1.elitelms.com', 1, 2, 0, '2022-08-05 11:14:39', '2022-08-05 11:14:39', '2022-11-09 01:07:40'),
(3, 'dev2.elitelms.com', 1, 2, 0, '2022-08-05 11:18:19', '2022-08-05 11:18:19', '2022-08-05 00:18:19'),
(4, 'dev3.elitelms.com', 1, 2, 0, '2022-08-05 11:21:06', '2022-08-05 11:21:06', '2022-08-05 00:21:06'),
(5, 'dev4.elitelms.com', 1, 2, 0, '2022-08-05 11:22:42', '2022-08-05 11:22:42', '2022-08-05 00:22:42'),
(6, 'dev5.elitelms.com', 1, 2, 0, '2022-08-05 11:22:42', '2022-08-05 11:22:42', '2022-08-05 00:22:42'),
(7, 'frontend.elitelms.com', 1, 1, 0, '2022-08-05 11:12:25', '2022-12-16 11:39:59', '2022-12-16 00:39:59'),
(8, 'v2.elitelms.ml', 1, 2, 1, '2022-04-08 10:27:38', '2022-12-28 08:06:41', '2023-02-09 04:19:22');

-- --------------------------------------------------------

--
-- Table structure for table `lms_dynamic_fields`
--

CREATE TABLE `lms_dynamic_fields` (
  `dynamic_field_id` bigint(20) NOT NULL,
  `dynamic_fields_name` varchar(50) NOT NULL,
  `dynamic_fields_tag` varchar(50) NOT NULL,
  `dynamic_fields_value` varchar(50) NOT NULL,
  `ref_table_name` varchar(50) NOT NULL,
  `table_column_name` varchar(50) NOT NULL,
  `show_notification` tinyint(4) NOT NULL DEFAULT 1,
  `show_certificate` tinyint(4) NOT NULL DEFAULT 1,
  `show_other` tinyint(4) NOT NULL DEFAULT 1,
  `is_active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_dynamic_fields`
--

INSERT INTO `lms_dynamic_fields` (`dynamic_field_id`, `dynamic_fields_name`, `dynamic_fields_tag`, `dynamic_fields_value`, `ref_table_name`, `table_column_name`, `show_notification`, `show_certificate`, `show_other`, `is_active`) VALUES
(1, 'User First Name', '%first_name%', 'first_name', 'lms_user_master', 'first_name', 1, 1, 1, 1),
(2, 'User Last Name', '%last_name%', 'last_name', 'lms_user_master', 'last_name', 1, 1, 1, 1),
(3, 'User Email Id', '%email_id%', 'email_id', 'lms_user_master', 'email_id', 1, 1, 1, 1),
(4, 'User Job Title', '%job_title%', 'job_title', 'lms_user_master', 'job_title', 1, 1, 1, 1),
(5, 'Organization Name', '%organization_name%', 'organization_name', 'lms_org_master', 'organization_name', 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_dynamic_fields2`
--

CREATE TABLE `lms_dynamic_fields2` (
  `dynamic_field_id` bigint(20) NOT NULL,
  `dynamic_fields_name` varchar(50) NOT NULL,
  `dynamic_fields_tag` varchar(50) NOT NULL,
  `dynamic_fields_value` varchar(50) NOT NULL,
  `ref_table_name` varchar(50) NOT NULL,
  `table_column_name` varchar(50) NOT NULL,
  `show_notification` tinyint(4) NOT NULL DEFAULT 1,
  `show_certificate` tinyint(4) NOT NULL DEFAULT 1,
  `show_other` tinyint(4) NOT NULL DEFAULT 1,
  `is_active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_dynamic_fields2`
--

INSERT INTO `lms_dynamic_fields2` (`dynamic_field_id`, `dynamic_fields_name`, `dynamic_fields_tag`, `dynamic_fields_value`, `ref_table_name`, `table_column_name`, `show_notification`, `show_certificate`, `show_other`, `is_active`) VALUES
(1, 'User First Name', '%first_name%', 'first_name', 'lms_user_master', 'first_name', 1, 1, 1, 1),
(2, 'User Last Name', '%last_name%', 'last_name', 'lms_user_master', 'last_name', 1, 1, 1, 1),
(3, 'User Email Id', '%email_id%', 'email_id', 'lms_user_master', 'email_id', 1, 1, 1, 1),
(4, 'User Job Title', '%job_title%', 'job_title', 'lms_user_master', 'job_title', 1, 1, 1, 1),
(5, 'Organization Name', '%organization_name%', 'organization_name', 'lms_org_master', 'organization_name', 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_dynamic_fields3`
--

CREATE TABLE `lms_dynamic_fields3` (
  `dynamic_field_id` int(11) NOT NULL,
  `dynamic_fields_name` varchar(50) NOT NULL,
  `dynamic_fields_tag` varchar(50) NOT NULL,
  `dynamic_fields_value` varchar(50) NOT NULL,
  `notification_event_id` varchar(100) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_dynamic_fields3`
--

INSERT INTO `lms_dynamic_fields3` (`dynamic_field_id`, `dynamic_fields_name`, `dynamic_fields_tag`, `dynamic_fields_value`, `notification_event_id`, `is_active`) VALUES
(1, 'Related User Name', '#%RelatedUserName%#', 'Related User Name', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16', 1),
(2, 'Related User Login', '#%RelatedUserLogin%#', 'Related User Login', '16', 1),
(3, 'Related User Password', '#%RelatedUserPassword%#', 'Related User Password', '16', 1),
(4, 'Recipient Name', '#%RecipientName%#', 'Recipient Name', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15', 1),
(5, 'Company Name', '#%CompanyName%#', 'Company Name', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16', 1),
(6, 'Supervisor Name', '#%SupervisorName%#', 'Supervisor Name', '1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16', 1),
(7, 'My Requirements Link', '#%MyRequirementsLink%#', 'My Requirements Link', '1,2,3,4,5,16', 1),
(8, 'Assignment Name', '#%AssignmentName%#', 'Assignment Name', '1,2,3,14', 1),
(9, 'Learning Plan Name', '#%LearningPlanName%#', 'Learning Plan Name', '4,5,15', 1),
(10, 'Learning Plan Requirement Names', '#%LearningPlanRequirementNames%#', 'Learning Plan Requirement Names', '4,5', 1),
(11, 'Total Learning Plan Time', '#%TotalLearningPlanTime%#', 'Total Learning Plan Time', '4,5', 1),
(12, 'Training Name', '#%TrainingName%#', 'Training Name', '6,7,8,13', 1),
(13, 'Credential Name', '#%CredentialName%#', 'Credential Name', '9', 1),
(14, 'Due Date', '#%DueDate%#', 'Due Date', '1,2,3,4,5', 1),
(15, 'Class Name', '#%ClassName%#', 'Class Name', '10,11,12', 1),
(16, 'Classroom Course', '#%ClassroomCourse%#', 'Classroom Course', '10,11,12', 1),
(17, 'Class Start Time', '#%ClassStartTime%#', 'Class Start Time', '10,11,12', 1),
(18, 'Class Date', '#%ClassDate%#', 'Class Date', '10,11,12', 1),
(19, 'LMS URL', '#%LMSURL%#', 'LMS URL', '16', 1),
(20, 'eLearning Link', '#%eLearningLink%#', 'eLearning Link', '6,7,8,13', 1),
(21, 'Location Name', '#%LocationName%#', 'Location Name', '10,11,12', 1),
(22, 'Details Link', '#%DetailsLink%#', 'Details Link', '10,11,12', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_dynamic_links`
--

CREATE TABLE `lms_dynamic_links` (
  `dynamic_link_id` bigint(20) NOT NULL,
  `dynamic_link_name` varchar(50) NOT NULL,
  `dynamic_link_tag` varchar(50) NOT NULL,
  `dynamic_link_value` varchar(50) NOT NULL,
  `ref_table_name` varchar(50) NOT NULL,
  `table_column_name` varchar(50) NOT NULL,
  `show_notification` tinyint(4) NOT NULL DEFAULT 1,
  `show_certificate` tinyint(4) NOT NULL DEFAULT 1,
  `show_other` tinyint(4) NOT NULL DEFAULT 1,
  `is_active` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_dynamic_links`
--

INSERT INTO `lms_dynamic_links` (`dynamic_link_id`, `dynamic_link_name`, `dynamic_link_tag`, `dynamic_link_value`, `ref_table_name`, `table_column_name`, `show_notification`, `show_certificate`, `show_other`, `is_active`) VALUES
(1, 'Forgot Password', 'http://dev.elitelms.com/auth/forgot-password', 'http://dev.elitelms.com/auth/forgot-password', 'lms_user_master', 'first_name', 1, 1, 1, 1),
(2, 'Profile', 'http://dev.elitelms.com/admin/profile/overview', 'http://dev.elitelms.com/admin/profile/overview', 'lms_user_master', 'last_name', 1, 1, 1, 1),
(3, 'Dashboard', 'http://dev.elitelms.com/student/dashboard', 'http://dev.elitelms.com/student/dashboard', 'lms_user_master', 'email_id', 1, 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_enrollment`
--

CREATE TABLE `lms_enrollment` (
  `enrollment_id` bigint(20) NOT NULL,
  `training_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `org_id` bigint(20) NOT NULL,
  `date_assigned` datetime DEFAULT NULL,
  `date_completed` datetime DEFAULT NULL,
  `credit_points` varchar(50) DEFAULT NULL,
  `certificate_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_group_master`
--

CREATE TABLE `lms_group_master` (
  `group_id` bigint(20) NOT NULL,
  `group_name` varchar(150) DEFAULT NULL,
  `group_code` char(36) NOT NULL,
  `primary_group_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_auto` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_group_master`
--

INSERT INTO `lms_group_master` (`group_id`, `group_name`, `group_code`, `primary_group_id`, `org_id`, `description`, `is_auto`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Retest', '1000000001', 0, 1, 'Retesting', 0, 0, 1, '2023-04-03 05:57:04', 1, '2023-04-27 08:33:44', '2023-04-27 08:33:44'),
(3, 'Retest', '1000000002', 0, 1, 'Retesting', 0, 1, 1, '2023-04-03 05:57:59', 1, '2023-04-03 05:57:59', '2023-04-03 05:57:59'),
(5, 'Retest', '1000000003', 0, 1, 'Retesting', 0, 1, 1, '2023-04-03 05:58:29', 1, '2023-04-03 05:58:29', '2023-04-03 05:58:29'),
(7, 'Retest', '1000000004', 0, 1, 'Retesting', 0, 1, 1, '2023-04-03 05:59:55', 1, '2023-04-03 05:59:55', '2023-04-03 05:59:55'),
(8, 'Roshan', '1000000005', 0, 1, 'Retesting', 0, 1, 1, '2023-04-03 06:00:18', 1, '2023-04-03 06:00:18', '2023-04-03 06:00:18'),
(9, 'Roshan1', '1000000006', 8, 1, 'Retesting', 0, 1, 1, '2023-04-03 06:00:59', 1, '2023-04-03 06:00:59', '2023-04-03 06:00:59'),
(10, 'Roshan1', '1000000007', 8, 1, 'Retesting', 0, 1, 1, '2023-04-03 06:07:57', 1, '2023-04-03 06:07:57', '2023-04-03 06:07:57'),
(11, 'AAA ', '1000000008', 8, 1, 'AAA', 0, 1, 1, '2023-04-03 06:07:57', 1, '2023-04-03 06:07:57', '2023-04-03 06:07:57');

-- --------------------------------------------------------

--
-- Table structure for table `lms_group_org`
--

CREATE TABLE `lms_group_org` (
  `group_id` bigint(20) NOT NULL,
  `group_name` varchar(150) DEFAULT NULL,
  `group_code` char(36) NOT NULL,
  `primary_group_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_auto` tinyint(1) DEFAULT 0,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_group_org`
--

INSERT INTO `lms_group_org` (`group_id`, `group_name`, `group_code`, `primary_group_id`, `org_id`, `description`, `is_auto`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'test', '', NULL, 1, NULL, 0, 1, NULL, NULL, NULL, NULL, '2023-04-05 12:03:11'),
(2, 'test2', '1', NULL, 1, NULL, 0, 0, NULL, NULL, NULL, '2023-04-27 08:33:15', '2023-04-27 08:33:15');

-- --------------------------------------------------------

--
-- Table structure for table `lms_group_org_settings`
--

CREATE TABLE `lms_group_org_settings` (
  `group_org_setting_id` bigint(20) NOT NULL,
  `org_code` char(36) NOT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `group_setting_id` int(11) NOT NULL,
  `group_setting_value` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_group_settings`
--

CREATE TABLE `lms_group_settings` (
  `group_setting_id` int(11) NOT NULL,
  `group_setting_name` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `order` int(11) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_group_settings`
--

INSERT INTO `lms_group_settings` (`group_setting_id`, `group_setting_name`, `order`, `is_active`) VALUES
(1, 'Job Title First Word', 1, 1),
(2, 'Job Title Second Word', 2, 1),
(3, 'Exact Job Title', 3, 1),
(4, 'Company Name', 4, 1),
(5, 'Division Name', 5, 1),
(6, 'Area Name', 6, 1),
(7, 'Location Name', 7, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_icons`
--

CREATE TABLE `lms_icons` (
  `icon_id` int(11) NOT NULL,
  `icon_name` varchar(50) DEFAULT NULL,
  `icon_path` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_icons`
--

INSERT INTO `lms_icons` (`icon_id`, `icon_name`, `icon_path`, `is_active`) VALUES
(192, 'abs001.svg', '/media/icon/abs001.svg', 1),
(193, 'abs002.svg', '/media/icon/abs002.svg', 1),
(194, 'abs003.svg', '/media/icon/abs003.svg', 1),
(195, 'abs004.svg', '/media/icon/abs004.svg', 1),
(196, 'abs005.svg', '/media/icon/abs005.svg', 1),
(197, 'abs006.svg', '/media/icon/abs006.svg', 1),
(198, 'abs007.svg', '/media/icon/abs007.svg', 1),
(199, 'abs008.svg', '/media/icon/abs008.svg', 1),
(200, 'abs009.svg', '/media/icon/abs009.svg', 1),
(201, 'abs010.svg', '/media/icon/abs010.svg', 1),
(202, 'abs011.svg', '/media/icon/abs011.svg', 1),
(203, 'abs012.svg', '/media/icon/abs012.svg', 1),
(204, 'abs013.svg', '/media/icon/abs013.svg', 1),
(205, 'abs014.svg', '/media/icon/abs014.svg', 1),
(206, 'abs015.svg', '/media/icon/abs015.svg', 1),
(207, 'abs016.svg', '/media/icon/abs016.svg', 1),
(208, 'abs017.svg', '/media/icon/abs017.svg', 1),
(209, 'abs018.svg', '/media/icon/abs018.svg', 1),
(210, 'abs019.svg', '/media/icon/abs019.svg', 1),
(211, 'abs020.svg', '/media/icon/abs020.svg', 1),
(212, 'abs021.svg', '/media/icon/abs021.svg', 1),
(213, 'abs022.svg', '/media/icon/abs022.svg', 1),
(214, 'abs023.svg', '/media/icon/abs023.svg', 1),
(215, 'abs024.svg', '/media/icon/abs024.svg', 1),
(216, 'abs025.svg', '/media/icon/abs025.svg', 1),
(217, 'abs026.svg', '/media/icon/abs026.svg', 1),
(218, 'abs027.svg', '/media/icon/abs027.svg', 1),
(219, 'abs028.svg', '/media/icon/abs028.svg', 1),
(220, 'abs029.svg', '/media/icon/abs029.svg', 1),
(221, 'abs030.svg', '/media/icon/abs030.svg', 1),
(222, 'abs031.svg', '/media/icon/abs031.svg', 1),
(223, 'abs032.svg', '/media/icon/abs032.svg', 1),
(224, 'abs033.svg', '/media/icon/abs033.svg', 1),
(225, 'abs034.svg', '/media/icon/abs034.svg', 1),
(226, 'abs035.svg', '/media/icon/abs035.svg', 1),
(227, 'abs036.svg', '/media/icon/abs036.svg', 1),
(228, 'abs037.svg', '/media/icon/abs037.svg', 1),
(229, 'abs038.svg', '/media/icon/abs038.svg', 1),
(230, 'abs039.svg', '/media/icon/abs039.svg', 1),
(231, 'abs040.svg', '/media/icon/abs040.svg', 1),
(232, 'abs041.svg', '/media/icon/abs041.svg', 1),
(233, 'abs042.svg', '/media/icon/abs042.svg', 1),
(234, 'abs043.svg', '/media/icon/abs043.svg', 1),
(235, 'abs044.svg', '/media/icon/abs044.svg', 1),
(236, 'abs045.svg', '/media/icon/abs045.svg', 1),
(237, 'abs046.svg', '/media/icon/abs046.svg', 1),
(238, 'abs047.svg', '/media/icon/abs047.svg', 1),
(239, 'abs048.svg', '/media/icon/abs048.svg', 1),
(240, 'abs049.svg', '/media/icon/abs049.svg', 1),
(244, 'arr001.svg', '/media/icon/arr001.svg', 1),
(245, 'arr002.svg', '/media/icon/arr002.svg', 1),
(246, 'arr003.svg', '/media/icon/arr003.svg', 1),
(247, 'arr004.svg', '/media/icon/arr004.svg', 1),
(248, 'arr005.svg', '/media/icon/arr005.svg', 1),
(249, 'arr006.svg', '/media/icon/arr006.svg', 1),
(250, 'arr007.svg', '/media/icon/arr007.svg', 1),
(251, 'arr008.svg', '/media/icon/arr008.svg', 1),
(252, 'arr009.svg', '/media/icon/arr009.svg', 1),
(253, 'arr010.svg', '/media/icon/arr010.svg', 1),
(254, 'arr011.svg', '/media/icon/arr011.svg', 1),
(255, 'arr012.svg', '/media/icon/arr012.svg', 1),
(256, 'arr013.svg', '/media/icon/arr013.svg', 1),
(257, 'arr014.svg', '/media/icon/arr014.svg', 1),
(258, 'arr015.svg', '/media/icon/arr015.svg', 1),
(259, 'arr016.svg', '/media/icon/arr016.svg', 1),
(260, 'arr017.svg', '/media/icon/arr017.svg', 1),
(261, 'arr018.svg', '/media/icon/arr018.svg', 1),
(262, 'arr019.svg', '/media/icon/arr019.svg', 1),
(263, 'arr020.svg', '/media/icon/arr020.svg', 1),
(264, 'arr021.svg', '/media/icon/arr021.svg', 1),
(265, 'arr022.svg', '/media/icon/arr022.svg', 1),
(266, 'arr023.svg', '/media/icon/arr023.svg', 1),
(267, 'arr024.svg', '/media/icon/arr024.svg', 1),
(268, 'arr025.svg', '/media/icon/arr025.svg', 1),
(269, 'arr026.svg', '/media/icon/arr026.svg', 1),
(270, 'arr027.svg', '/media/icon/arr027.svg', 1),
(271, 'arr028.svg', '/media/icon/arr028.svg', 1),
(272, 'arr029.svg', '/media/icon/arr029.svg', 1),
(273, 'arr030.svg', '/media/icon/arr030.svg', 1),
(274, 'arr031.svg', '/media/icon/arr031.svg', 1),
(275, 'arr032.svg', '/media/icon/arr032.svg', 1),
(276, 'arr033.svg', '/media/icon/arr033.svg', 1),
(277, 'arr034.svg', '/media/icon/arr034.svg', 1),
(278, 'arr035.svg', '/media/icon/arr035.svg', 1),
(279, 'arr036.svg', '/media/icon/arr036.svg', 1),
(280, 'arr037.svg', '/media/icon/arr037.svg', 1),
(281, 'arr038.svg', '/media/icon/arr038.svg', 1),
(282, 'arr039.svg', '/media/icon/arr039.svg', 1),
(283, 'arr040.svg', '/media/icon/arr040.svg', 1),
(284, 'arr041.svg', '/media/icon/arr041.svg', 1),
(285, 'arr042.svg', '/media/icon/arr042.svg', 1),
(286, 'arr043.svg', '/media/icon/arr043.svg', 1),
(287, 'arr044.svg', '/media/icon/arr044.svg', 1),
(288, 'arr045.svg', '/media/icon/arr045.svg', 1),
(289, 'arr046.svg', '/media/icon/arr046.svg', 1),
(290, 'arr047.svg', '/media/icon/arr047.svg', 1),
(291, 'arr048.svg', '/media/icon/arr048.svg', 1),
(296, 'arr049.svg', '/media/icon/arr049.svg', 1),
(297, 'arr050.svg', '/media/icon/arr050.svg', 1),
(298, 'arr051.svg', '/media/icon/arr051.svg', 1),
(299, 'arr052.svg', '/media/icon/arr052.svg', 1),
(300, 'arr053.svg', '/media/icon/arr053.svg', 1),
(301, 'arr054.svg', '/media/icon/arr054.svg', 1),
(302, 'arr055.svg', '/media/icon/arr055.svg', 1),
(303, 'arr056.svg', '/media/icon/arr056.svg', 1),
(304, 'arr057.svg', '/media/icon/arr057.svg', 1),
(305, 'arr058.svg', '/media/icon/arr058.svg', 1),
(306, 'arr059.svg', '/media/icon/arr059.svg', 1),
(307, 'arr060.svg', '/media/icon/arr060.svg', 1),
(308, 'arr061.svg', '/media/icon/arr061.svg', 1),
(309, 'arr062.svg', '/media/icon/arr062.svg', 1),
(310, 'arr061.svg', '/media/icon/arr061.svg', 1),
(311, 'arr062.svg', '/media/icon/arr062.svg', 1),
(312, 'arr063.svg', '/media/icon/arr063.svg', 1),
(313, 'arr064.svg', '/media/icon/arr064.svg', 1),
(314, 'arr065.svg', '/media/icon/arr065.svg', 1),
(315, 'arr066.svg', '/media/icon/arr066.svg', 1),
(316, 'arr067.svg', '/media/icon/arr067.svg', 1),
(317, 'arr068.svg', '/media/icon/arr068.svg', 1),
(318, 'arr069.svg', '/media/icon/arr069.svg', 1),
(319, 'arr070.svg', '/media/icon/arr070.svg', 1),
(320, 'arr071.svg', '/media/icon/arr071.svg', 1),
(321, 'arr072.svg', '/media/icon/arr072.svg', 1),
(322, 'arr073.svg', '/media/icon/arr073.svg', 1),
(323, 'arr074.svg', '/media/icon/arr074.svg', 1),
(324, 'arr075.svg', '/media/icon/arr075.svg', 1),
(325, 'arr076.svg', '/media/icon/arr076.svg', 1),
(326, 'arr077.svg', '/media/icon/arr077.svg', 1),
(327, 'arr078.svg', '/media/icon/arr078.svg', 1),
(328, 'arr079.svg', '/media/icon/arr079.svg', 1),
(329, 'arr080.svg', '/media/icon/arr080.svg', 1),
(330, 'arr081.svg', '/media/icon/arr081.svg', 1),
(331, 'arr082.svg', '/media/icon/arr082.svg', 1),
(333, 'arr084.svg', '/media/icon/arr084.svg', 1),
(334, 'arr085.svg', '/media/icon/arr085.svg', 1),
(335, 'arr086.svg', '/media/icon/arr086.svg', 1),
(336, 'arr087.svg', '/media/icon/arr087.svg', 1),
(337, 'arr088.svg', '/media/icon/arr088.svg', 1),
(338, 'arr089.svg', '/media/icon/arr089.svg', 1),
(339, 'arr090.svg', '/media/icon/arr090.svg', 1),
(340, 'arr091.svg', '/media/icon/arr091.svg', 1),
(341, 'arr092.svg', '/media/icon/arr082.svg', 1),
(342, 'arr093.svg', '/media/icon/arr083.svg', 1),
(343, 'arr094.svg', '/media/icon/arr084.svg', 1),
(344, 'arr095.svg', '/media/icon/arr085.svg', 1),
(345, 'art001.svg', '/media/icon/art001.svg', 1),
(346, 'art002.svg', '/media/icon/art002.svg', 1),
(347, 'art003.svg', '/media/icon/art003.svg', 1),
(348, 'art004.svg', '/media/icon/art004.svg', 1),
(349, 'art005.svg', '/media/icon/art005.svg', 1),
(350, 'art006.svg', '/media/icon/art006.svg', 1),
(351, 'art007.svg', '/media/icon/art007.svg', 1),
(352, 'art008.svg', '/media/icon/art008.svg', 1),
(353, 'art009.svg', '/media/icon/art009.svg', 1),
(354, 'art010.svg', '/media/icon/art010.svg', 1),
(355, 'cod001.svg', '/media/icon/cod001.svg', 1),
(356, 'cod002.svg', '/media/icon/cod002.svg', 1),
(357, 'cod003.svg', '/media/icon/cod003.svg', 1),
(358, 'cod004.svg', '/media/icon/cod004.svg', 1),
(359, 'cod005.svg', '/media/icon/cod005.svg', 1),
(360, 'cod006.svg', '/media/icon/cod006.svg', 1),
(361, 'cod007.svg', '/media/icon/cod007.svg', 1),
(362, 'cod008.svg', '/media/icon/cod008.svg', 1),
(363, 'cod009.svg', '/media/icon/cod009.svg', 1),
(364, 'cod010.svg', '/media/icon/cod010.svg', 1),
(365, 'com001.svg', '/media/icon/com001.svg', 1),
(366, 'com002.svg', '/media/icon/com002.svg', 1),
(367, 'com003.svg', '/media/icon/com003.svg', 1),
(368, 'com004.svg', '/media/icon/com004.svg', 1),
(369, 'com005.svg', '/media/icon/com005.svg', 1),
(370, 'com006.svg', '/media/icon/com006.svg', 1),
(371, 'com007.svg', '/media/icon/com007.svg', 1),
(372, 'com008.svg', '/media/icon/com008.svg', 1),
(373, 'com009.svg', '/media/icon/com009.svg', 1),
(374, 'com010.svg', '/media/icon/com010.svg', 1),
(375, 'com011.svg', '/media/icon/com011.svg', 1),
(376, 'com012.svg', '/media/icon/com012.svg', 1),
(377, 'com013.svg', '/media/icon/com013.svg', 1),
(378, 'com014.svg', '/media/icon/com014.svg', 1),
(390, 'elc001.svg', '/media/icon/elc001.svg', 1),
(391, 'elc002.svg', '/media/icon/elc002.svg', 1),
(392, 'elc003.svg', '/media/icon/elc003.svg', 1),
(393, 'elc004.svg', '/media/icon/elc004.svg', 1),
(394, 'elc005.svg', '/media/icon/elc005.svg', 1),
(395, 'elc006.svg', '/media/icon/elc006.svg', 1),
(396, 'elc007.svg', '/media/icon/elc007.svg', 1),
(397, 'elc008.svg', '/media/icon/elc008.svg', 1),
(398, 'elc009.svg', '/media/icon/elc009.svg', 1),
(399, 'elc010.svg', '/media/icon/elc010.svg', 1),
(400, 'fil001.svg', '/media/icon/fil001.svg', 1),
(401, 'fil002.svg', '/media/icon/fil002.svg', 1),
(402, 'fil003.svg', '/media/icon/fil003.svg', 1),
(403, 'fil004.svg', '/media/icon/fil004.svg', 1),
(404, 'fil005.svg', '/media/icon/fil005.svg', 1),
(405, 'fil006.svg', '/media/icon/fil006.svg', 1),
(406, 'fil007.svg', '/media/icon/fil007.svg', 1),
(407, 'fil008.svg', '/media/icon/fil008.svg', 1),
(408, 'fil009.svg', '/media/icon/fil009.svg', 1),
(409, 'fil010.svg', '/media/icon/fil010.svg', 1),
(410, 'fil011.svg', '/media/icon/fil011.svg', 1),
(411, 'fil012.svg', '/media/icon/fil012.svg', 1),
(412, 'fil013.svg', '/media/icon/fil013.svg', 1),
(413, 'fil014.svg', '/media/icon/fil014.svg', 1),
(414, 'fil015.svg', '/media/icon/fil015.svg', 1),
(415, 'fil016.svg', '/media/icon/fil016.svg', 1),
(416, 'fil017.svg', '/media/icon/fil017.svg', 1),
(417, 'fil018.svg', '/media/icon/fil018.svg', 1),
(418, 'fil019.svg', '/media/icon/fil019.svg', 1),
(419, 'fil020.svg', '/media/icon/fil020.svg', 1),
(420, 'fil021.svg', '/media/icon/fil021.svg', 1),
(421, 'fil022.svg', '/media/icon/fil022.svg', 1),
(422, 'fil023.svg', '/media/icon/fil023.svg', 1),
(423, 'fil024.svg', '/media/icon/fil024.svg', 1),
(424, 'fil025.svg', '/media/icon/fil025.svg', 1),
(425, 'fin001.svg', '/media/icon/fin001.svg', 1),
(426, 'fin002.svg', '/media/icon/fin002.svg', 1),
(427, 'fin003.svg', '/media/icon/fin003.svg', 1),
(428, 'fin004.svg', '/media/icon/fin004.svg', 1),
(429, 'fin005.svg', '/media/icon/fin005.svg', 1),
(430, 'fin006.svg', '/media/icon/fin006.svg', 1),
(431, 'fin007.svg', '/media/icon/fin007.svg', 1),
(432, 'fin008.svg', '/media/icon/fin008.svg', 1),
(433, 'fin009.svg', '/media/icon/fin009.svg', 1),
(434, 'fin010.svg', '/media/icon/fin010.svg', 1),
(435, 'gen001.svg', '/media/icon/gen001.svg', 1),
(436, 'gen002.svg', '/media/icon/gen002.svg', 1),
(437, 'gen003.svg', '/media/icon/gen003.svg', 1),
(438, 'gen004.svg', '/media/icon/gen004.svg', 1),
(439, 'gen005.svg', '/media/icon/gen005.svg', 1),
(440, 'gen006.svg', '/media/icon/gen006.svg', 1),
(441, 'gen007.svg', '/media/icon/gen007.svg', 1),
(442, 'gen008.svg', '/media/icon/gen008.svg', 1),
(443, 'gen009.svg', '/media/icon/gen009.svg', 1),
(444, 'gen010.svg', '/media/icon/gen010.svg', 1),
(445, 'gen011.svg', '/media/icon/gen011.svg', 1),
(446, 'gen012.svg', '/media/icon/gen012.svg', 1),
(447, 'gen013.svg', '/media/icon/gen013.svg', 1),
(448, 'gen014.svg', '/media/icon/gen014.svg', 1),
(449, 'gen015.svg', '/media/icon/gen015.svg', 1),
(450, 'gen016.svg', '/media/icon/gen016.svg', 1),
(451, 'gen017.svg', '/media/icon/gen017.svg', 1),
(452, 'gen018.svg', '/media/icon/gen018.svg', 1),
(453, 'gen019.svg', '/media/icon/gen019.svg', 1),
(454, 'gen020.svg', '/media/icon/gen020.svg', 1),
(455, 'gen021.svg', '/media/icon/gen021.svg', 1),
(456, 'gen022.svg', '/media/icon/gen022.svg', 1),
(457, 'gen023.svg', '/media/icon/gen023.svg', 1),
(458, 'gen024.svg', '/media/icon/gen024.svg', 1),
(459, 'gen025.svg', '/media/icon/gen025.svg', 1),
(460, 'gen026.svg', '/media/icon/gen026.svg', 1),
(461, 'gen027.svg', '/media/icon/gen027.svg', 1),
(462, 'gen028.svg', '/media/icon/gen028.svg', 1),
(463, 'gen029.svg', '/media/icon/gen029.svg', 1),
(464, 'gen030.svg', '/media/icon/gen030.svg', 1),
(465, 'gen031.svg', '/media/icon/gen031.svg', 1),
(466, 'gen032.svg', '/media/icon/gen032.svg', 1),
(467, 'gen033.svg', '/media/icon/gen033.svg', 1),
(468, 'gen034.svg', '/media/icon/gen034.svg', 1),
(469, 'gen035.svg', '/media/icon/gen035.svg', 1),
(470, 'gen036.svg', '/media/icon/gen036.svg', 1),
(471, 'gen037.svg', '/media/icon/gen037.svg', 1),
(472, 'gen038.svg', '/media/icon/gen038.svg', 1),
(473, 'gen039.svg', '/media/icon/gen039.svg', 1),
(474, 'gen040.svg', '/media/icon/gen040.svg', 1),
(475, 'gen041.svg', '/media/icon/gen041.svg', 1),
(476, 'gen042.svg', '/media/icon/gen042.svg', 1),
(477, 'gen043.svg', '/media/icon/gen043.svg', 1),
(478, 'gen044.svg', '/media/icon/gen044.svg', 1),
(479, 'gen045.svg', '/media/icon/gen045.svg', 1),
(480, 'gen046.svg', '/media/icon/gen046.svg', 1),
(481, 'gen047.svg', '/media/icon/gen047.svg', 1),
(482, 'gen048.svg', '/media/icon/gen048.svg', 1),
(483, 'gen049.svg', '/media/icon/gen049.svg', 1),
(484, 'gen050.svg', '/media/icon/gen050.svg', 1),
(485, 'gen051.svg', '/media/icon/gen051.svg', 1),
(486, 'gen052.svg', '/media/icon/gen052.svg', 1),
(487, 'gen053.svg', '/media/icon/gen053.svg', 1),
(488, 'gen054.svg', '/media/icon/gen054.svg', 1),
(489, 'gen055.svg', '/media/icon/gen055.svg', 1),
(490, 'gen056.svg', '/media/icon/gen056.svg', 1),
(491, 'gen057.svg', '/media/icon/gen057.svg', 1),
(492, 'gen058.svg', '/media/icon/gen058.svg', 1),
(493, 'gen059.svg', '/media/icon/gen059.svg', 1),
(494, 'gra001.svg', '/media/icon/gra001.svg', 1),
(495, 'gra002.svg', '/media/icon/gra002.svg', 1),
(496, 'gra003.svg', '/media/icon/gra003.svg', 1),
(497, 'gra004.svg', '/media/icon/gra004.svg', 1),
(498, 'gra005.svg', '/media/icon/gra005.svg', 1),
(499, 'gra006.svg', '/media/icon/gra006.svg', 1),
(500, 'gra007.svg', '/media/icon/gra007.svg', 1),
(501, 'gra008.svg', '/media/icon/gra008.svg', 1),
(502, 'gra009.svg', '/media/icon/gra009.svg', 1),
(503, 'gra010.svg', '/media/icon/gra010.svg', 1),
(504, 'gra011.svg', '/media/icon/gra011.svg', 1),
(505, 'gra012.svg', '/media/icon/gra012.svg', 1),
(506, 'lay001.svg', '/media/icon/lay001.svg', 1),
(507, 'lay002.svg', '/media/icon/lay002.svg', 1),
(508, 'lay003.svg', '/media/icon/lay003.svg', 1),
(509, 'lay004.svg', '/media/icon/lay004.svg', 1),
(510, 'lay005.svg', '/media/icon/lay005.svg', 1),
(511, 'lay006.svg', '/media/icon/lay006.svg', 1),
(512, 'lay007.svg', '/media/icon/lay007.svg', 1),
(513, 'lay008.svg', '/media/icon/lay008.svg', 1),
(514, 'lay009.svg', '/media/icon/lay009.svg', 1),
(515, 'lay010.svg', '/media/icon/lay010.svg', 1),
(516, 'map001.svg', '/media/icon/map001.svg', 1),
(517, 'map002.svg', '/media/icon/map002.svg', 1),
(518, 'map003.svg', '/media/icon/map003.svg', 1),
(519, 'map004.svg', '/media/icon/map004.svg', 1),
(520, 'map005.svg', '/media/icon/map005.svg', 1),
(521, 'map006.svg', '/media/icon/map006.svg', 1),
(522, 'map007.svg', '/media/icon/map007.svg', 1),
(523, 'map008.svg', '/media/icon/map008.svg', 1),
(524, 'map009.svg', '/media/icon/map009.svg', 1),
(525, 'map010.svg', '/media/icon/map010.svg', 1),
(526, 'med001.svg', '/media/icon/med001.svg', 1),
(527, 'med002.svg', '/media/icon/med002.svg', 1),
(528, 'med003.svg', '/media/icon/med003.svg', 1),
(529, 'med004.svg', '/media/icon/med004.svg', 1),
(530, 'med005.svg', '/media/icon/med005.svg', 1),
(531, 'med006.svg', '/media/icon/med006.svg', 1),
(532, 'med007.svg', '/media/icon/med007.svg', 1),
(533, 'med008.svg', '/media/icon/med008.svg', 1),
(534, 'med009.svg', '/media/icon/med009.svg', 1),
(535, 'med010.svg', '/media/icon/med010.svg', 1),
(536, 'soc001.svg', '/media/icon/soc001.svg', 1),
(537, 'soc002.svg', '/media/icon/soc002.svg', 1),
(538, 'soc003.svg', '/media/icon/soc003.svg', 1),
(539, 'soc004.svg', '/media/icon/soc004.svg', 1),
(540, 'soc005.svg', '/media/icon/soc005.svg', 1),
(541, 'soc006.svg', '/media/icon/soc006.svg', 1),
(542, 'soc007.svg', '/media/icon/soc007.svg', 1),
(543, 'soc008.svg', '/media/icon/soc008.svg', 1),
(544, 'soc009.svg', '/media/icon/soc009.svg', 1),
(545, 'soc010.svg', '/media/icon/soc010.svg', 1),
(546, 'teh001.svg', '/media/icon/teh001.svg', 1),
(547, 'teh002.svg', '/media/icon/teh002.svg', 1),
(548, 'teh003.svg', '/media/icon/teh003.svg', 1),
(549, 'teh004.svg', '/media/icon/teh004.svg', 1),
(550, 'teh005.svg', '/media/icon/teh005.svg', 1),
(551, 'teh006.svg', '/media/icon/teh006.svg', 1),
(552, 'teh007.svg', '/media/icon/teh007.svg', 1),
(553, 'teh008.svg', '/media/icon/teh008.svg', 1),
(554, 'teh009.svg', '/media/icon/teh009.svg', 1),
(555, 'teh010.svg', '/media/icon/teh010.svg', 1),
(556, 'txt001.svg', '/media/icon/txt001.svg', 1),
(557, 'txt002.svg', '/media/icon/txt002.svg', 1),
(558, 'txt003.svg', '/media/icon/txt003.svg', 1),
(559, 'txt004.svg', '/media/icon/txt004.svg', 1),
(560, 'txt005.svg', '/media/icon/txt005.svg', 1),
(561, 'txt006.svg', '/media/icon/txt006.svg', 1),
(562, 'txt007.svg', '/media/icon/txt007.svg', 1),
(563, 'txt008.svg', '/media/icon/txt008.svg', 1),
(564, 'txt009.svg', '/media/icon/txt009.svg', 1),
(565, 'txt010.svg', '/media/icon/txt010.svg', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_ilt_enrollment`
--

CREATE TABLE `lms_ilt_enrollment` (
  `ilt_enrollment_id` bigint(20) NOT NULL,
  `enrollment_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_ilt_enrollment`
--

INSERT INTO `lms_ilt_enrollment` (`ilt_enrollment_id`, `enrollment_type`) VALUES
(1, 'User/Learner Self Enrollment'),
(2, 'Supervisor Enrollment'),
(3, 'Instructor Enrollment'),
(4, 'Instructor & Supervisor Enrollement');

-- --------------------------------------------------------

--
-- Table structure for table `lms_image`
--

CREATE TABLE `lms_image` (
  `image_id` bigint(20) NOT NULL,
  `image_name` varchar(64) NOT NULL,
  `image_size` varchar(64) NOT NULL,
  `image_type` varchar(64) NOT NULL,
  `image_url` varchar(256) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_image`
--

INSERT INTO `lms_image` (`image_id`, `image_name`, `image_size`, `image_type`, `image_url`, `is_active`, `org_id`, `user_id`, `created_id`, `date_created`) VALUES
(1, '', '', '', '', 1, 1, 1, 1, '2023-02-15 07:54:30'),
(2, '', '', '', '', 1, 1, 1, 1, '2023-02-15 07:54:47'),
(3, '', '', '', '', 1, 1, 1, 1, '2023-02-15 07:54:54'),
(4, '', '', '', '', 1, 1, 1, 1, '2023-02-15 07:55:12');

-- --------------------------------------------------------

--
-- Table structure for table `lms_job_title`
--

CREATE TABLE `lms_job_title` (
  `job_title_id` bigint(20) NOT NULL,
  `job_title_name` varchar(150) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_job_title`
--

INSERT INTO `lms_job_title` (`job_title_id`, `job_title_name`, `org_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Test', 1, 1, NULL, NULL, NULL, NULL, '2023-04-19 06:49:48');

-- --------------------------------------------------------

--
-- Table structure for table `lms_location`
--

CREATE TABLE `lms_location` (
  `location_id` bigint(20) NOT NULL,
  `location_name` varchar(150) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_location`
--

INSERT INTO `lms_location` (`location_id`, `location_name`, `org_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, '123', 1, 1, 1, '2023-02-28 11:46:53', 1, '2023-02-28 11:46:53', '2023-02-28 11:46:53');

-- --------------------------------------------------------

--
-- Table structure for table `lms_login_otp`
--

CREATE TABLE `lms_login_otp` (
  `login_otp_id` bigint(20) NOT NULL,
  `login_id` bigint(20) DEFAULT NULL,
  `otp` varchar(10) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 0,
  `date_created` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_media`
--

CREATE TABLE `lms_media` (
  `media_id` bigint(20) NOT NULL,
  `media_name` longtext NOT NULL,
  `media_size` varchar(64) NOT NULL,
  `media_type` varchar(64) NOT NULL,
  `media_url` longtext NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `org_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_media`
--

INSERT INTO `lms_media` (`media_id`, `media_name`, `media_size`, `media_type`, `media_url`, `is_active`, `org_id`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Dhaaga _ Nilutpal Bora _ Yeh Meri Family _ TVF.m4a', '3720786', 'mp4', 'l2BpM8UR48emWqbSG2Z6iGxQobl6OypurWu4wv7L.mp4', 1, 1, 1, '2023-02-27 07:02:53', 1, '2023-02-27 07:05:55', '2023-02-27 07:05:55'),
(2, 'SequencingPostTestRollup4thEd_SCORM20044thEdition2.zip', '404465', 'zip', 'ltgAiV7RqyGzpSqEiBd7DNDZoxvkFzf3KmwedxtB', 1, 1, 1, '2023-02-27 07:14:23', 1, '2023-02-27 07:35:00', '2023-02-27 07:35:00'),
(3, 'SequencingPostTestRollup4thEd_SCORM20044thEdition2.zip', '404465', 'zip', '3g3wg7J9QpH9H0WUi5nFO9qZBgDrSFIyTXOl5COW', 1, 1, 1, '2023-02-28 12:12:09', 1, '2023-02-28 12:12:09', '2023-02-28 12:12:09'),
(4, 'SequencingPostTestRollup4thEd_SCORM20044thEdition2.zip', '404465', 'zip', 'foYJxcB2Cc7LoosXxnsbTDbcZndc4pgAMUSqeul5', 1, 1, 1, '2023-03-01 05:54:57', 1, '2023-03-01 05:54:57', '2023-03-01 05:54:57'),
(5, '', '', '', 'https://www.google.com/search?q=assigned&sxsrf=AJOqlzVVxcGObL86-TnUtDPvg1fnCA_cTw%3A1678965930899&ei=qvwSZMvENpqbz7sPlpKTSA&oq=assigne&gs_lcp=Cgxnd3Mtd2l6LXNlcnAQARgAMgsIABCABBCxAxCDATIFCAAQgAQyCwgAEIAEELEDEIMBMgUIABCABDILCAAQgAQQsQMQgwEyCwgAEIAEELEDEIMBMg', 1, 1, 1, '2023-03-16 11:37:07', 1, '2023-03-16 11:37:07', '2023-03-16 11:37:07'),
(6, 'RuntimeBasicCalls_SCORM20043rdEdition.zip', '408328', 'zip', '1xJMQmnOvCGAO6Q7Sw5qm5N2oG3lQNWC8NPmnL9n', 1, 1, 1, '2023-03-21 04:08:42', 1, '2023-03-21 04:08:42', '2023-03-21 04:08:42'),
(7, 'RuntimeBasicCalls_SCORM20043rdEdition.zip', '408328', 'zip', 'GeGFvQbs7YIkH5SP2gaVOokOMabHyCBnS2any4g2', 1, 1, 1, '2023-03-21 04:09:11', 1, '2023-03-21 04:09:11', '2023-03-21 04:09:11'),
(8, 'RuntimeBasicCalls_SCORM20043rdEdition.zip', '408328', 'zip', 'aq1xFNZjXAkRP2kt9G5VR06olC4ezWx8AIzAfr3o', 1, 1, 1, '2023-03-21 04:11:18', 1, '2023-03-21 04:11:18', '2023-03-21 04:11:18'),
(9, 'RuntimeBasicCalls_SCORM20043rdEdition.zip', '408328', 'zip', 'UF3JufjchzqflzxpVsvLhmnQSazAsrkPePzqJBMJ', 1, 1, 1, '2023-03-21 04:14:13', 1, '2023-03-21 04:14:13', '2023-03-21 04:14:13'),
(10, 'RuntimeBasicCalls_SCORM20043rdEdition.zip', '408328', 'zip', 'jQAo5dVatAzGkdFJlDLfc4fW7Pd5rjLBRXplEeDL', 1, 1, 1, '2023-03-21 04:15:10', 1, '2023-03-21 04:15:10', '2023-03-21 04:15:10'),
(11, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', 'rMi1jbTKGyRguc9IxZsHnxtzBf6Gw4osPs73icOk', 1, 1, 1, '2023-03-21 04:33:15', 1, '2023-03-21 04:33:15', '2023-03-21 04:33:15'),
(12, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', '0GD58Esd58fL7EXMa4uhsoVSsjJiOEUDJsLKFq7D', 1, 1, 1, '2023-03-21 04:38:07', 1, '2023-03-21 04:38:07', '2023-03-21 04:38:07'),
(13, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', 'jPeIu9L1pWrS7fUug9XwvHAEfhas0vRi0TK5OLtl', 1, 1, 1, '2023-03-21 04:39:18', 1, '2023-03-21 04:39:18', '2023-03-21 04:39:18'),
(14, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', '4jc2ikIjPxHuwj8oAdwMj2e5DyoOWstjtr6EtMbx', 1, 1, 1, '2023-03-21 04:40:58', 1, '2023-03-21 04:40:58', '2023-03-21 04:40:58'),
(15, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', 'sjZqUVChzXiLUxuMhj79q2bAhWEClGZhQClAISmb', 1, 1, 1, '2023-03-21 04:41:52', 1, '2023-03-21 04:41:52', '2023-03-21 04:41:52'),
(16, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', 'E2NQ5DASEg76sNFi3zaGbOHFpSOyqFYD7WoLsBWx', 1, 1, 1, '2023-03-21 04:45:02', 1, '2023-03-21 04:45:02', '2023-03-21 04:45:02'),
(17, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', 'K4hrBVB3D784EpN0xVzaE8Nr1kASqWhbB63bzPuF', 1, 1, 1, '2023-03-21 06:08:27', 1, '2023-03-21 06:08:27', '2023-03-21 06:08:27'),
(18, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', 'sTvaxMlWtamwE73Z0kBP65rPqtDqdPuNhi7JxwfG', 1, 1, 1, '2023-03-28 07:27:07', 1, '2023-03-28 07:27:07', '2023-03-28 07:27:07'),
(19, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', 'BSwrqHDitI3NDo2C79ckmvHSOGAz05KJdV1MckHc', 1, 1, 1, '2023-03-28 09:06:19', 1, '2023-03-28 09:06:19', '2023-03-28 09:06:19'),
(20, 'SequencingPostTestRollup4thEd_SCORM20044thEdition (1).zip', '404465', 'zip', 'Jwz4aKI8gCjpmRbqrzHxC7vUgkGr8xGhPXdXoFNb', 1, 1, 1, '2023-03-28 09:09:54', 1, '2023-03-28 09:09:54', '2023-03-28 09:09:54');

-- --------------------------------------------------------

--
-- Table structure for table `lms_menu`
--

CREATE TABLE `lms_menu` (
  `menu_id` int(11) NOT NULL,
  `display_name` varchar(255) NOT NULL,
  `menu_master_id` bigint(20) DEFAULT NULL,
  `module_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_menu`
--

INSERT INTO `lms_menu` (`menu_id`, `display_name`, `menu_master_id`, `module_id`, `org_id`, `role_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Dashboard', 1, 1, 1, 1, 1, 1, '2023-02-14 13:57:50', 1, '2023-02-14 13:57:50', '2023-02-14 13:57:50'),
(2, 'Dashboard', 1, 1, 1, 2, 1, 1, '2023-02-14 13:57:50', 1, '2023-02-14 13:57:50', '2023-02-14 13:57:50'),
(3, 'Dashboard', 1, 1, 1, 3, 1, 1, '2023-02-14 13:57:50', 1, '2023-02-14 13:57:50', '2023-02-14 13:57:50'),
(4, 'Dashboard', 1, 1, 1, 4, 1, 1, '2023-02-14 13:57:50', 1, '2023-02-14 13:57:50', '2023-02-14 13:57:50'),
(5, 'Dashboard', 1, 1, 1, 5, 1, 1, '2023-02-14 13:57:50', 1, '2023-02-14 13:57:50', '2023-02-14 13:57:50'),
(6, 'Dashboard', 1, 1, 1, 6, 1, 1, '2023-02-14 13:57:50', 1, '2023-02-14 13:57:50', '2023-02-14 13:57:50'),
(7, 'Credit Management', 2, 2, 1, 1, 1, 1, '2023-02-14 14:00:20', 1, '2023-02-14 14:00:20', '2023-02-14 14:00:20'),
(8, 'Credit Management', 2, 2, 1, 2, 1, 1, '2023-02-14 14:00:20', 1, '2023-02-14 14:00:20', '2023-02-14 14:00:20'),
(9, 'Credit Management', 2, 2, 1, 3, 1, 1, '2023-02-14 14:00:20', 1, '2023-02-14 14:00:20', '2023-02-14 14:00:20'),
(10, 'Credit Management', 2, 2, 1, 4, 1, 1, '2023-02-14 14:00:20', 1, '2023-02-14 14:00:20', '2023-02-14 14:00:20'),
(11, 'Credit Management', 2, 2, 1, 5, 1, 1, '2023-02-14 14:00:20', 1, '2023-02-14 14:00:20', '2023-02-14 14:00:20'),
(12, 'Credit Management', 2, 2, 1, 6, 1, 1, '2023-02-14 14:00:20', 1, '2023-02-14 14:00:20', '2023-02-14 14:00:20'),
(13, 'System Management', 3, 3, 1, 1, 1, 1, '2023-02-14 14:01:06', 1, '2023-02-14 14:01:06', '2023-02-14 14:01:06'),
(14, 'System Management', 3, 3, 1, 2, 1, 1, '2023-02-14 14:01:06', 1, '2023-02-14 14:01:06', '2023-02-14 14:01:06'),
(15, 'System Management', 3, 3, 1, 3, 1, 1, '2023-02-14 14:01:06', 1, '2023-02-14 14:01:06', '2023-02-14 14:01:06'),
(16, 'System Management', 3, 3, 1, 4, 1, 1, '2023-02-14 14:01:06', 1, '2023-02-14 14:01:06', '2023-02-14 14:01:06'),
(17, 'System Management', 3, 3, 1, 5, 1, 1, '2023-02-14 14:01:06', 1, '2023-02-14 14:01:06', '2023-02-14 14:01:06'),
(18, 'System Management', 3, 3, 1, 6, 1, 1, '2023-02-14 14:01:06', 1, '2023-02-14 14:01:06', '2023-02-14 14:01:06'),
(19, 'Training Management', 4, 4, 1, 1, 1, 1, '2023-02-14 14:02:19', 1, '2023-02-14 14:02:19', '2023-02-14 14:02:19'),
(20, 'Training Management', 4, 4, 1, 2, 1, 1, '2023-02-14 14:02:19', 1, '2023-02-14 14:02:19', '2023-02-14 14:02:19'),
(21, 'Training Management', 4, 4, 1, 3, 1, 1, '2023-02-14 14:02:19', 1, '2023-02-14 14:02:19', '2023-02-14 14:02:19'),
(22, 'Training Management', 4, 4, 1, 4, 1, 1, '2023-02-14 14:02:19', 1, '2023-02-14 14:02:19', '2023-02-14 14:02:19'),
(23, 'Training Management', 4, 4, 1, 5, 1, 1, '2023-02-14 14:02:19', 1, '2023-02-14 14:02:19', '2023-02-14 14:02:19'),
(24, 'Training Management', 4, 4, 1, 6, 1, 1, '2023-02-14 14:02:19', 1, '2023-02-14 14:02:19', '2023-02-14 14:02:19'),
(25, 'User Management', 5, 5, 1, 1, 1, 1, '2023-02-14 14:03:05', 1, '2023-02-14 14:03:05', '2023-02-14 14:03:05'),
(26, 'User Management', 5, 5, 1, 2, 1, 1, '2023-02-14 14:03:05', 1, '2023-02-14 14:03:05', '2023-02-14 14:03:05'),
(27, 'User Management', 5, 5, 1, 3, 1, 1, '2023-02-14 14:03:05', 1, '2023-02-14 14:03:05', '2023-02-14 14:03:05'),
(28, 'User Management', 5, 5, 1, 4, 1, 1, '2023-02-14 14:03:05', 1, '2023-02-14 14:03:05', '2023-02-14 14:03:05'),
(29, 'User Management', 5, 5, 1, 5, 1, 1, '2023-02-14 14:03:05', 1, '2023-02-14 14:03:05', '2023-02-14 14:03:05'),
(30, 'User Management', 5, 5, 1, 6, 1, 1, '2023-02-14 14:03:05', 1, '2023-02-14 14:03:05', '2023-02-14 14:03:05'),
(31, 'Dashboard', 6, 6, 1, 1, 1, 1, '2023-02-14 14:04:26', 1, '2023-02-14 14:04:26', '2023-02-14 14:04:26'),
(32, 'Dashboard', 6, 6, 1, 2, 1, 1, '2023-02-14 14:04:26', 1, '2023-02-14 14:04:26', '2023-02-14 14:04:26'),
(33, 'Dashboard', 6, 6, 1, 3, 1, 1, '2023-02-14 14:04:26', 1, '2023-02-14 14:04:26', '2023-02-14 14:04:26'),
(34, 'Dashboard', 6, 6, 1, 4, 1, 1, '2023-02-14 14:04:26', 1, '2023-02-14 14:04:26', '2023-02-14 14:04:26'),
(35, 'Dashboard', 6, 6, 1, 5, 1, 1, '2023-02-14 14:04:26', 1, '2023-02-14 14:04:26', '2023-02-14 14:04:26'),
(36, 'Dashboard', 6, 6, 1, 6, 1, 1, '2023-02-14 14:04:26', 1, '2023-02-14 14:04:26', '2023-02-14 14:04:26'),
(41, 'Documents', 7, 7, 1, 1, 1, 1, '2023-02-14 14:05:04', 1, '2023-02-14 14:05:04', '2023-02-14 14:11:50'),
(42, 'Documents', 7, 7, 1, 7, 1, 1, '2023-02-14 14:05:04', 1, '2023-02-14 14:05:04', '2023-02-14 14:11:46'),
(43, 'Enrollments', 8, 8, 1, 1, 1, 1, '2023-02-14 14:05:32', 1, '2023-02-14 14:05:32', '2023-02-14 14:05:32'),
(44, 'Enrollments', 8, 8, 1, 7, 1, 1, '2023-02-14 14:05:32', 1, '2023-02-14 14:05:32', '2023-02-14 14:11:58'),
(49, 'Transcripts', 9, 9, 1, 1, 1, 1, '2023-02-14 14:06:19', 1, '2023-02-14 14:06:19', '2023-02-14 14:06:19'),
(50, 'Transcripts', 9, 9, 1, 7, 1, 1, '2023-02-14 14:06:19', 1, '2023-02-14 14:06:19', '2023-02-14 14:06:19'),
(51, 'Requirements', 10, 10, 1, 1, 1, 1, '2023-02-14 14:06:50', 1, '2023-02-14 14:06:50', '2023-02-14 14:06:50'),
(52, 'Requirements', 10, 10, 1, 7, 1, 1, '2023-02-14 14:06:50', 1, '2023-02-14 14:06:50', '2023-02-14 14:06:50'),
(53, 'Dashboard', 11, 11, 1, 1, 1, 1, '2023-02-14 14:14:10', 1, '2023-02-14 14:14:10', '2023-02-14 14:14:10'),
(54, 'Action Permission', 12, 12, 1, 1, 1, 1, '2023-02-14 14:15:27', 1, '2023-02-14 14:15:27', '2023-02-14 14:15:27'),
(55, 'Certificate', 13, 13, 1, 1, 1, 1, '2023-02-14 14:16:55', 1, '2023-02-14 14:16:55', '2023-02-14 14:16:55'),
(56, 'Course Library', 14, 14, 1, 1, 1, 1, '2023-02-14 14:17:37', 1, '2023-02-14 14:17:37', '2023-02-14 14:17:37'),
(57, 'Generic Category', 15, 15, 1, 1, 1, 1, '2023-02-14 14:18:44', 1, '2023-02-14 14:18:44', '2023-02-14 14:18:44'),
(58, 'Generic Group', 16, 16, 1, 1, 1, 1, '2023-02-14 14:19:09', 1, '2023-02-14 14:19:09', '2023-02-14 14:19:09'),
(59, 'Media Library', 17, 17, 1, 1, 1, 1, '2023-02-14 14:19:36', 1, '2023-02-14 14:19:36', '2023-02-14 14:19:36'),
(60, 'Module', 18, 18, 1, 1, 1, 1, '2023-02-14 14:20:08', 1, '2023-02-14 14:20:08', '2023-03-02 10:52:26'),
(61, 'Menu', 19, 19, 1, 1, 1, 1, '2023-02-14 14:21:14', 1, '2023-02-14 14:21:14', '2023-02-14 14:21:14'),
(62, 'Menu Permissions', 20, 20, 1, 1, 1, 1, '2023-02-14 14:24:03', 1, '2023-02-14 14:24:03', '2023-02-14 14:24:03'),
(63, 'Notifications', 21, 21, 1, 1, 1, 1, '2023-02-14 14:24:20', 1, '2023-02-14 14:24:20', '2023-02-14 14:24:20'),
(64, 'Organization', 22, 22, 1, 1, 1, 1, '2023-02-14 14:24:52', 1, '2023-02-14 14:24:52', '2023-02-14 14:24:52'),
(65, 'Role', 23, 23, 1, 1, 1, 1, '2023-02-14 14:25:21', 1, '2023-02-14 14:25:21', '2023-02-14 14:25:21'),
(66, 'Theme', 24, 24, 1, 1, 1, 1, '2023-02-14 14:26:14', 1, '2023-02-14 14:26:14', '2023-02-14 14:26:14'),
(67, 'Team Credit', 25, 25, 1, 1, 1, 1, '2023-02-14 14:29:45', 1, '2023-02-14 14:29:45', '2023-02-14 14:29:45'),
(68, 'Team Approval', 26, 26, 1, 1, 1, 1, '2023-02-14 14:30:53', 1, '2023-02-14 14:30:53', '2023-02-14 14:30:53'),
(69, 'User Credit', 27, 27, 1, 1, 1, 1, '2023-02-14 14:31:15', 1, '2023-02-14 14:31:15', '2023-02-14 14:31:15'),
(70, 'Category', 28, 28, 1, 1, 1, 1, '2023-02-14 14:34:10', 1, '2023-02-14 14:34:10', '2023-02-14 14:34:10'),
(71, 'Category', 28, 28, 1, 2, 1, 1, '2023-02-14 14:34:10', 1, '2023-02-14 14:34:10', '2023-02-14 14:34:10'),
(72, 'Category', 28, 28, 1, 3, 1, 1, '2023-02-14 14:34:10', 1, '2023-02-14 14:34:10', '2023-02-14 14:34:10'),
(73, 'Category', 28, 28, 1, 4, 1, 1, '2023-02-14 14:34:10', 1, '2023-02-14 14:34:10', '2023-02-14 14:34:10'),
(74, 'Category', 28, 28, 1, 5, 1, 1, '2023-02-14 14:34:10', 1, '2023-02-14 14:34:10', '2023-02-14 14:34:10'),
(75, 'Category', 28, 28, 1, 6, 1, 1, '2023-02-14 14:34:10', 1, '2023-02-14 14:34:10', '2023-02-14 14:34:10'),
(76, 'Notifications', 29, 29, 1, 1, 1, 1, '2023-02-14 14:34:34', 1, '2023-02-14 14:34:34', '2023-02-14 14:34:34'),
(77, 'Notifications', 29, 29, 1, 2, 1, 1, '2023-02-14 14:34:34', 1, '2023-02-14 14:34:34', '2023-02-14 14:34:34'),
(78, 'Notifications', 29, 29, 1, 3, 1, 1, '2023-02-14 14:34:34', 1, '2023-02-14 14:34:34', '2023-02-14 14:34:34'),
(79, 'Notifications', 29, 29, 1, 4, 1, 1, '2023-02-14 14:34:34', 1, '2023-02-14 14:34:34', '2023-02-14 14:34:34'),
(80, 'Notifications', 29, 29, 1, 5, 1, 1, '2023-02-14 14:34:34', 1, '2023-02-14 14:34:34', '2023-02-14 14:34:34'),
(81, 'Notifications', 29, 29, 1, 6, 1, 1, '2023-02-14 14:34:34', 1, '2023-02-14 14:34:34', '2023-02-14 14:34:34'),
(82, 'Skill', 30, 30, 1, 1, 1, 1, '2023-02-14 14:34:48', 1, '2023-02-14 14:34:48', '2023-02-14 14:34:48'),
(83, 'Skill', 30, 30, 1, 2, 1, 1, '2023-02-14 14:34:48', 1, '2023-02-14 14:34:48', '2023-02-14 14:34:48'),
(84, 'Skill', 30, 30, 1, 3, 1, 1, '2023-02-14 14:34:48', 1, '2023-02-14 14:34:48', '2023-02-14 14:34:48'),
(85, 'Skill', 30, 30, 1, 4, 1, 1, '2023-02-14 14:34:48', 1, '2023-02-14 14:34:48', '2023-02-14 14:34:48'),
(86, 'Skill', 30, 30, 1, 5, 1, 1, '2023-02-14 14:34:48', 1, '2023-02-14 14:34:48', '2023-02-14 14:34:48'),
(87, 'Skill', 30, 30, 1, 6, 1, 1, '2023-02-14 14:34:48', 1, '2023-02-14 14:34:48', '2023-02-14 14:34:48'),
(88, 'Course Catalog', 31, 31, 1, 1, 1, 1, '2023-02-14 14:36:04', 1, '2023-02-14 14:36:04', '2023-02-14 14:36:04'),
(89, 'Course Catalog', 31, 31, 1, 2, 1, 1, '2023-02-14 14:36:04', 1, '2023-02-14 14:36:04', '2023-02-14 14:36:04'),
(90, 'Course Catalog', 31, 31, 1, 3, 1, 1, '2023-02-14 14:36:04', 1, '2023-02-14 14:36:04', '2023-02-14 14:36:04'),
(91, 'Course Catalog', 31, 31, 1, 4, 1, 1, '2023-02-14 14:36:04', 1, '2023-02-14 14:36:04', '2023-02-14 14:36:04'),
(92, 'Course Catalog', 31, 31, 1, 5, 1, 1, '2023-02-14 14:36:04', 1, '2023-02-14 14:36:04', '2023-02-14 14:36:04'),
(93, 'Course Catalog', 31, 31, 1, 6, 1, 1, '2023-02-14 14:36:04', 1, '2023-02-14 14:36:04', '2023-02-14 14:36:04'),
(94, 'Credentials', 32, 32, 1, 1, 1, 1, '2023-02-14 14:36:21', 1, '2023-02-14 14:36:21', '2023-02-14 14:36:21'),
(95, 'Credentials', 32, 32, 1, 2, 1, 1, '2023-02-14 14:36:21', 1, '2023-02-14 14:36:21', '2023-02-14 14:36:21'),
(96, 'Credentials', 32, 32, 1, 3, 1, 1, '2023-02-14 14:36:21', 1, '2023-02-14 14:36:21', '2023-02-14 14:36:21'),
(97, 'Credentials', 32, 32, 1, 4, 1, 1, '2023-02-14 14:36:21', 1, '2023-02-14 14:36:21', '2023-02-14 14:36:21'),
(98, 'Credentials', 32, 32, 1, 5, 1, 1, '2023-02-14 14:36:21', 1, '2023-02-14 14:36:21', '2023-02-14 14:36:21'),
(99, 'Credentials', 32, 32, 1, 6, 1, 1, '2023-02-14 14:36:21', 1, '2023-02-14 14:36:21', '2023-02-14 14:36:21'),
(100, 'Learning Plan', 33, 33, 1, 1, 1, 1, '2023-02-14 14:36:37', 1, '2023-02-14 14:36:37', '2023-02-14 14:36:37'),
(101, 'Learning Plan', 33, 33, 1, 2, 1, 1, '2023-02-14 14:36:38', 1, '2023-02-14 14:36:38', '2023-02-14 14:36:38'),
(102, 'Learning Plan', 33, 33, 1, 3, 1, 1, '2023-02-14 14:36:38', 1, '2023-02-14 14:36:38', '2023-02-14 14:36:38'),
(103, 'Learning Plan', 33, 33, 1, 4, 1, 1, '2023-02-14 14:36:38', 1, '2023-02-14 14:36:38', '2023-02-14 14:36:38'),
(104, 'Learning Plan', 33, 33, 1, 5, 1, 1, '2023-02-14 14:36:38', 1, '2023-02-14 14:36:38', '2023-02-14 14:36:38'),
(105, 'Learning Plan', 33, 33, 1, 6, 1, 1, '2023-02-14 14:36:38', 1, '2023-02-14 14:36:38', '2023-02-14 14:36:38'),
(106, 'Training Library', 34, 34, 1, 1, 1, 1, '2023-02-14 14:36:59', 1, '2023-02-14 14:36:59', '2023-02-14 14:36:59'),
(107, 'Training Library', 34, 34, 1, 2, 1, 1, '2023-02-14 14:36:59', 1, '2023-02-14 14:36:59', '2023-02-14 14:36:59'),
(108, 'Training Library', 34, 34, 1, 3, 1, 1, '2023-02-14 14:36:59', 1, '2023-02-14 14:36:59', '2023-02-14 14:36:59'),
(109, 'Training Library', 34, 34, 1, 4, 1, 1, '2023-02-14 14:36:59', 1, '2023-02-14 14:36:59', '2023-02-14 14:36:59'),
(110, 'Training Library', 34, 34, 1, 5, 1, 1, '2023-02-14 14:36:59', 1, '2023-02-14 14:36:59', '2023-02-14 14:36:59'),
(111, 'Training Library', 34, 34, 1, 6, 1, 1, '2023-02-14 14:36:59', 1, '2023-02-14 14:36:59', '2023-02-14 14:36:59'),
(112, 'Group List', 35, 35, 1, 1, 1, 1, '2023-02-14 14:37:46', 1, '2023-02-14 14:37:46', '2023-02-14 14:37:46'),
(113, 'Group List', 35, 35, 1, 2, 1, 1, '2023-02-14 14:37:46', 1, '2023-02-14 14:37:46', '2023-02-14 14:37:46'),
(114, 'Group List', 35, 35, 1, 3, 1, 1, '2023-02-14 14:37:46', 1, '2023-02-14 14:37:46', '2023-02-14 14:37:46'),
(115, 'Group List', 35, 35, 1, 4, 1, 1, '2023-02-14 14:37:46', 1, '2023-02-14 14:37:46', '2023-02-14 14:37:46'),
(116, 'Group List', 35, 35, 1, 5, 1, 1, '2023-02-14 14:37:46', 1, '2023-02-14 14:37:46', '2023-02-14 14:37:46'),
(117, 'Group List', 35, 35, 1, 6, 1, 1, '2023-02-14 14:37:46', 1, '2023-02-14 14:37:46', '2023-02-14 14:37:46'),
(118, 'Instructor/Trainer List', 36, 36, 1, 1, 1, 1, '2023-02-14 14:38:15', 1, '2023-02-14 14:38:15', '2023-02-14 14:38:15'),
(119, 'Instructor/Trainer List', 36, 36, 1, 2, 1, 1, '2023-02-14 14:38:15', 1, '2023-02-14 14:38:15', '2023-02-14 14:38:15'),
(120, 'Instructor/Trainer List', 36, 36, 1, 3, 1, 1, '2023-02-14 14:38:15', 1, '2023-02-14 14:38:15', '2023-02-14 14:38:15'),
(121, 'Instructor/Trainer List', 36, 36, 1, 4, 1, 1, '2023-02-14 14:38:15', 1, '2023-02-14 14:38:15', '2023-02-14 14:38:15'),
(122, 'Instructor/Trainer List', 36, 36, 1, 5, 1, 1, '2023-02-14 14:38:15', 1, '2023-02-14 14:38:15', '2023-02-14 14:38:15'),
(123, 'Instructor/Trainer List', 36, 36, 1, 6, 1, 1, '2023-02-14 14:38:15', 1, '2023-02-14 14:38:15', '2023-02-14 14:38:15'),
(124, 'SubAdmin', 37, 37, 1, 1, 1, 1, '2023-02-14 14:38:47', 1, '2023-02-14 14:38:47', '2023-02-14 14:38:47'),
(125, 'SubAdmin', 37, 37, 1, 2, 1, 1, '2023-02-14 14:38:47', 1, '2023-02-14 14:38:47', '2023-02-14 14:38:47'),
(126, 'SubAdmin', 37, 37, 1, 3, 1, 1, '2023-02-14 14:38:47', 1, '2023-02-14 14:38:47', '2023-02-14 14:38:47'),
(127, 'SubAdmin', 37, 37, 1, 4, 1, 1, '2023-02-14 14:38:47', 1, '2023-02-14 14:38:47', '2023-02-14 14:38:47'),
(128, 'SubAdmin', 37, 37, 1, 5, 1, 1, '2023-02-14 14:38:47', 1, '2023-02-14 14:38:47', '2023-02-14 14:38:47'),
(129, 'SubAdmin', 37, 37, 1, 6, 1, 1, '2023-02-14 14:38:47', 1, '2023-02-14 14:38:47', '2023-02-14 14:38:47'),
(130, 'User List', 38, 38, 1, 1, 1, 1, '2023-02-14 14:39:02', 1, '2023-02-14 14:39:02', '2023-02-14 14:39:02'),
(131, 'User List', 38, 38, 1, 2, 1, 1, '2023-02-14 14:39:02', 1, '2023-02-14 14:39:02', '2023-02-14 14:39:02'),
(132, 'User List', 38, 38, 1, 3, 1, 1, '2023-02-14 14:39:02', 1, '2023-02-14 14:39:02', '2023-02-14 14:39:02'),
(133, 'User List', 38, 38, 1, 4, 1, 1, '2023-02-14 14:39:02', 1, '2023-02-14 14:39:02', '2023-02-14 14:39:02'),
(134, 'User List', 38, 38, 1, 5, 1, 1, '2023-02-14 14:39:02', 1, '2023-02-14 14:39:02', '2023-02-14 14:39:02'),
(135, 'User List', 38, 38, 1, 6, 1, 1, '2023-02-14 14:39:02', 1, '2023-02-14 14:39:02', '2023-02-14 14:39:02'),
(136, 'Team Credit', 25, 25, 1, 2, 1, 1, '2023-02-14 14:29:45', 1, '2023-02-14 14:29:45', '2023-02-14 08:59:45'),
(137, 'Team Credit', 25, 25, 1, 3, 1, 1, '2023-02-14 14:29:45', 1, '2023-02-14 14:29:45', '2023-02-14 08:59:45'),
(138, 'Team Credit', 25, 25, 1, 4, 1, 1, '2023-02-14 14:29:45', 1, '2023-02-14 14:29:45', '2023-02-14 08:59:45'),
(139, 'Team Credit', 25, 25, 1, 5, 1, 1, '2023-02-14 14:29:45', 1, '2023-02-14 14:29:45', '2023-02-14 08:59:45'),
(140, 'Team Credit', 25, 25, 1, 6, 1, 1, '2023-02-14 14:29:45', 1, '2023-02-14 14:29:45', '2023-02-14 08:59:45'),
(141, 'Team Approval', 26, 26, 1, 2, 1, 1, '2023-02-14 14:30:53', 1, '2023-02-14 14:30:53', '2023-02-14 09:00:53'),
(142, 'Team Approval', 26, 26, 1, 3, 1, 1, '2023-02-14 14:30:53', 1, '2023-02-14 14:30:53', '2023-02-14 09:00:53'),
(143, 'Team Approval', 26, 26, 1, 4, 1, 1, '2023-02-14 14:30:53', 1, '2023-02-14 14:30:53', '2023-02-14 09:00:53'),
(144, 'Team Approval', 26, 26, 1, 5, 1, 1, '2023-02-14 14:30:53', 1, '2023-02-14 14:30:53', '2023-02-14 09:00:53'),
(145, 'Team Approval', 26, 26, 1, 6, 1, 1, '2023-02-14 14:30:53', 1, '2023-02-14 14:30:53', '2023-02-14 09:00:53'),
(146, 'User Credit', 27, 27, 1, 2, 1, 1, '2023-02-14 14:31:15', 1, '2023-02-14 14:31:15', '2023-02-14 09:01:15'),
(147, 'User Credit', 27, 27, 1, 3, 1, 1, '2023-02-14 14:31:15', 1, '2023-02-14 14:31:15', '2023-02-14 09:01:15'),
(148, 'User Credit', 27, 27, 1, 4, 1, 1, '2023-02-14 14:31:15', 1, '2023-02-14 14:31:15', '2023-02-14 09:01:15'),
(149, 'User Credit', 27, 27, 1, 5, 1, 1, '2023-02-14 14:31:15', 1, '2023-02-14 14:31:15', '2023-02-14 09:01:15'),
(150, 'User Credit', 27, 27, 1, 6, 1, 1, '2023-02-14 14:31:15', 1, '2023-02-14 14:31:15', '2023-02-14 09:01:15'),
(151, 'Catalog', 39, 39, 1, 1, 1, 1, '2023-03-28 12:10:21', 1, '2023-03-28 12:10:21', '2023-03-28 06:41:01'),
(152, 'Media', 40, 40, 1, 1, 1, NULL, NULL, NULL, NULL, '2023-04-22 05:09:44');

-- --------------------------------------------------------

--
-- Table structure for table `lms_menu_master`
--

CREATE TABLE `lms_menu_master` (
  `menu_master_id` bigint(20) NOT NULL,
  `menu_name` varchar(64) NOT NULL,
  `route_url` longtext NOT NULL,
  `font_icon_name` varchar(64) NOT NULL,
  `parent_menu_master_id` bigint(20) DEFAULT NULL,
  `position` enum('Header','LeftNav','Footer') NOT NULL DEFAULT 'LeftNav',
  `order` int(11) NOT NULL,
  `type` enum('1-Menu','2-SubMenu','3-Tab') NOT NULL DEFAULT '1-Menu',
  `menu_role` varchar(100) DEFAULT NULL,
  `is_admin` tinyint(4) DEFAULT 1,
  `is_superadmin` tinyint(4) DEFAULT 1,
  `is_student` tinyint(4) DEFAULT 1,
  `roles` varchar(20) DEFAULT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_menu_master`
--

INSERT INTO `lms_menu_master` (`menu_master_id`, `menu_name`, `route_url`, `font_icon_name`, `parent_menu_master_id`, `position`, `order`, `type`, `menu_role`, `is_admin`, `is_superadmin`, `is_student`, `roles`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Dashboard', '/admin/dashboard', '/media/icon/art002.svg', NULL, 'LeftNav', 100, '1-Menu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 13:57:50', 1, '2023-02-14 13:57:50', '2023-02-14 13:57:50'),
(2, 'Credit Management', '/admin/creditManagement/myTeamCreditReport', '/media/icon/gen020.svg', NULL, 'LeftNav', 200, '1-Menu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:00:20', 1, '2023-02-14 14:00:20', '2023-02-14 14:00:20'),
(3, 'System Management', '/admin/systemManagement/category', '/media/icon/cod001.svg', NULL, 'LeftNav', 300, '1-Menu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:01:06', 1, '2023-02-14 14:01:06', '2023-02-14 14:01:06'),
(4, 'Training Management', '/admin/trainingManagement/courseCatalog', '/media/icon/art009.svg', NULL, 'LeftNav', 400, '1-Menu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:02:19', 1, '2023-02-14 14:02:19', '2023-02-14 14:02:19'),
(5, 'User Management', '/admin/usermanagement/grouplist', '/media/icon/art002.svg', NULL, 'LeftNav', 500, '1-Menu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:03:05', 1, '2023-02-14 14:03:05', '2023-02-16 04:51:28'),
(6, 'Dashboard', '/student/dashboard', '/media/icon/art002.svg', NULL, 'LeftNav', 600, '1-Menu', NULL, 1, 1, 1, '1,2,7', 1, 1, '2023-02-14 14:04:26', 1, '2023-02-14 14:04:26', '2023-04-27 06:09:10'),
(7, 'Documents', '/student/document', '/media/icon/fil012.svg', NULL, 'LeftNav', 700, '1-Menu', NULL, 1, 1, 1, '1,2,7', 1, 1, '2023-02-14 14:05:04', 1, '2023-02-14 14:05:04', '2023-04-27 06:09:10'),
(8, 'Enrollments', '/student/enrollment', '/media/icon/fil012.svg', NULL, 'LeftNav', 800, '1-Menu', NULL, 1, 1, 1, '1,2,7', 1, 1, '2023-02-14 14:05:32', 1, '2023-02-14 14:05:32', '2023-04-27 06:09:10'),
(9, 'Transcripts', '/student/transcripts', '/media/icon/fil012.svg', NULL, 'LeftNav', 900, '1-Menu', NULL, 1, 1, 1, '1,2,7', 1, 1, '2023-02-14 14:06:19', 1, '2023-02-14 14:06:19', '2023-04-27 06:09:10'),
(10, 'Requirements', '/student/requirement', '/media/icon/fil012.svg', NULL, 'LeftNav', 1000, '1-Menu', NULL, 1, 1, 1, '1,2,7', 1, 1, '2023-02-14 14:06:50', 1, '2023-02-14 14:06:50', '2023-04-27 06:09:10'),
(11, 'Dashboard', '/superAdmin/dashboard', '/media/icon/art002.svg', NULL, 'LeftNav', 2000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:14:10', 1, '2023-02-14 14:14:10', '2023-02-14 14:22:26'),
(12, 'Action Permission', '/superAdmin/manageActionPermission', '/media/icon/com006.svg', NULL, 'LeftNav', 3000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:15:27', 1, '2023-02-14 14:15:27', '2023-02-14 14:22:30'),
(13, 'Certificate', '/superAdmin/manageCertificate', '/media/icon/fil012.svg', NULL, 'LeftNav', 4000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:16:55', 1, '2023-02-14 14:16:55', '2023-02-14 14:22:34'),
(14, 'Course Library', '/superAdmin/manageCourseLibrary', '/media/icon/fil012.svg', NULL, 'LeftNav', 5000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:17:37', 1, '2023-02-14 14:17:37', '2023-02-14 14:22:38'),
(15, 'Generic Category', '/superAdmin/manageCategory', '/media/icon/fil012.svg', NULL, 'LeftNav', 6000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:18:44', 1, '2023-02-14 14:18:44', '2023-02-14 14:22:41'),
(16, 'Generic Group', '/superAdmin/manageGroups', '/media/icon/fil012.svg', NULL, 'LeftNav', 7000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:19:09', 1, '2023-02-14 14:19:09', '2023-02-14 14:22:44'),
(17, 'Media Library', '/superAdmin/manageMediaLibrary', '/media/icon/fil012.svg', NULL, 'LeftNav', 8000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:19:36', 1, '2023-02-14 14:19:36', '2023-02-14 14:22:48'),
(18, 'Manage Module', '/superAdmin/manageModule', '/media/icon/fil012.svg', NULL, 'LeftNav', 9000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:20:08', 1, '2023-02-14 14:20:08', '2023-03-02 10:48:05'),
(19, 'Menu', '/superAdmin/manageMenu', '/media/icon/fil012.svg', NULL, 'LeftNav', 10000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:21:14', 1, '2023-02-14 14:21:14', '2023-02-14 14:23:10'),
(20, 'Menu Permissions', '/superAdmin/manageMenuPermissions', '/media/icon/fil012.svg', NULL, 'LeftNav', 20000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:24:03', 1, '2023-02-14 14:24:03', '2023-02-14 14:24:03'),
(21, 'Notifications', '/superAdmin/manageNotifications', '/media/icon/fil012.svg', NULL, 'LeftNav', 30000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:24:20', 1, '2023-02-14 14:24:20', '2023-02-14 14:24:20'),
(22, 'Organization', '/superAdmin/manageOrganization', '/media/icon/fil012.svg', NULL, 'LeftNav', 40000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:24:52', 1, '2023-02-14 14:24:52', '2023-02-14 14:24:52'),
(23, 'Role', '/superAdmin/manageRoles', '/media/icon/fil012.svg', NULL, 'LeftNav', 50000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:25:21', 1, '2023-02-14 14:25:21', '2023-02-14 14:25:21'),
(24, 'Theme', '/superAdmin/manageTheme', '/media/icon/fil012.svg', NULL, 'LeftNav', 60000, '1-Menu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:26:14', 1, '2023-02-14 14:26:14', '2023-02-14 14:26:14'),
(25, 'Team Credit', '/admin/creditManagement/myTeamCreditReport', '/media/icon/fil012.svg', 2, 'LeftNav', 100, '2-SubMenu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:29:45', 1, '2023-02-14 14:29:45', '2023-02-14 14:30:17'),
(26, 'Team Approval', '/admin/creditManagement/teamApprovalReport', '/media/icon/fil012.svg', 2, 'LeftNav', 200, '2-SubMenu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:30:53', 1, '2023-02-14 14:30:53', '2023-02-14 14:30:53'),
(27, 'User Credit', '/admin/creditManagement/userCreditReport', '/media/icon/fil012.svg', 2, 'LeftNav', 300, '2-SubMenu', NULL, 1, 1, 1, '1', 1, 1, '2023-02-14 14:31:15', 1, '2023-02-14 14:31:15', '2023-02-14 14:31:15'),
(28, 'Category', '/admin/systemManagement/category', '/media/icon/fil012.svg', 3, 'LeftNav', 100, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:34:10', 1, '2023-02-14 14:34:10', '2023-02-14 14:34:10'),
(29, 'Notifications', '/admin/systemManagement/notifications', '/media/icon/fil012.svg', 3, 'LeftNav', 200, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:34:34', 1, '2023-02-14 14:34:34', '2023-02-14 14:34:34'),
(30, 'Skill', '/admin/systemManagement/skill', '/media/icon/fil012.svg', 3, 'LeftNav', 300, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:34:48', 1, '2023-02-14 14:34:48', '2023-02-14 14:34:48'),
(31, 'Course Catalog', '/admin/trainingManagement/courseCatalog', '/media/icon/fil012.svg', 4, 'LeftNav', 100, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:36:04', 1, '2023-02-14 14:36:04', '2023-02-14 14:36:04'),
(32, 'Credentials', '/admin/trainingManagement/credentials', '/media/icon/fil012.svg', 4, 'LeftNav', 200, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:36:21', 1, '2023-02-14 14:36:21', '2023-02-14 14:36:21'),
(33, 'Learning Plan', '/admin/trainingManagement/learningPlan', '/media/icon/fil012.svg', 4, 'LeftNav', 300, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:36:37', 1, '2023-02-14 14:36:37', '2023-02-14 14:36:37'),
(34, 'Training Library', '/admin/trainingManagement/trainingLibrary', '/media/icon/fil012.svg', 4, 'LeftNav', 400, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:36:59', 1, '2023-02-14 14:36:59', '2023-02-14 14:36:59'),
(35, 'Group List', '/admin/userManagement/groupList', '/media/icon/fil012.svg', 5, 'LeftNav', 100, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:37:46', 1, '2023-02-14 14:37:46', '2023-02-14 14:37:46'),
(36, 'Instructor/Trainer List', '/admin/userManagement/instructorTrainerList', '/media/icon/fil012.svg', 5, 'LeftNav', 200, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:38:15', 1, '2023-02-14 14:38:15', '2023-02-14 14:38:15'),
(37, 'SubAdmin', '/admin/userManagement/subAdmin', '/media/icon/fil012.svg', 5, 'LeftNav', 300, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:38:47', 1, '2023-02-14 14:38:47', '2023-02-14 14:38:47'),
(38, 'User List', '/admin/userManagement/listUsers', '/media/icon/fil012.svg', 5, 'LeftNav', 400, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, 1, '2023-02-14 14:39:02', 1, '2023-02-14 14:39:02', '2023-02-14 14:39:02'),
(39, 'Catalog', '/student/catalog', '/media/icon/fil012.svg', NULL, 'LeftNav', 601, '1-Menu', NULL, 1, 1, 1, '1,2,7', 1, 1, '2022-03-31 14:18:19', 1, '2023-03-28 11:39:48', '2023-04-27 06:09:10'),
(40, 'Media', '', '', 4, 'LeftNav', 600, '2-SubMenu', NULL, 1, 1, 1, '1,2,3,4,5,6', 1, NULL, NULL, NULL, NULL, '2023-04-21 11:39:55');

-- --------------------------------------------------------

--
-- Table structure for table `lms_module_master`
--

CREATE TABLE `lms_module_master` (
  `module_id` bigint(20) NOT NULL,
  `module_name` varchar(250) DEFAULT NULL,
  `route_url` varchar(800) NOT NULL,
  `controller_name` varchar(250) NOT NULL,
  `method_name` varchar(250) NOT NULL,
  `description` text DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT NULL,
  `parent_module_id` bigint(20) DEFAULT NULL,
  `menu_master_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_module_master`
--

INSERT INTO `lms_module_master` (`module_id`, `module_name`, `route_url`, `controller_name`, `method_name`, `description`, `is_primary`, `parent_module_id`, `menu_master_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Dashboard', '/admin/dashboard ', '/admin/dashboard', '/admin/dashboard', NULL, NULL, 0, 1, 1, 1, '2023-02-14 13:57:50', 1, '2023-02-14 13:57:50', '2023-04-04 10:41:03'),
(2, 'Credit Management', '/admin/creditManagement/myTeamCreditReport', '/admin/creditManagement/myTeamCreditReport', '/admin/creditManagement/myTeamCreditReport', NULL, NULL, 0, 2, 1, 1, '2023-02-14 14:00:20', 1, '2023-02-14 14:00:20', '2023-02-14 14:00:20'),
(3, 'System Management', '/admin/systemManagement/category', '/admin/systemManagement/category', '/admin/systemManagement/category', NULL, NULL, 0, 3, 1, 1, '2023-02-14 14:01:06', 1, '2023-02-14 14:01:06', '2023-02-14 14:01:06'),
(4, 'Training Management', '/admin/trainingManagement/courseCatalog', '/admin/trainingManagement/courseCatalog', '/admin/trainingManagement/courseCatalog', NULL, NULL, 0, 4, 1, 1, '2023-02-14 14:02:19', 1, '2023-02-14 14:02:19', '2023-02-14 14:02:19'),
(5, 'User Management', '/admin/userManagement/groupList', '/admin/userManagement/groupList', '/admin/userManagement/groupList', NULL, NULL, 0, 5, 1, 1, '2023-02-14 14:03:05', 1, '2023-02-14 14:03:05', '2023-02-14 14:03:05'),
(6, 'Dashboard', '/student/dashboard', '/student/dashboard', '/student/dashboard', NULL, NULL, 0, 6, 1, 1, '2023-02-14 14:04:26', 1, '2023-02-14 14:04:26', '2023-02-14 14:04:26'),
(7, 'Documents', '/student/document', '/student/documents', '/student/documents', NULL, NULL, 0, 7, 1, 1, '2023-02-14 14:05:04', 1, '2023-02-14 14:05:04', '2023-02-16 04:33:52'),
(8, 'Enrollments', '/student/enrollments', '/student/enrollments', '/student/enrollments', NULL, NULL, 0, 8, 1, 1, '2023-02-14 14:05:32', 1, '2023-02-14 14:05:32', '2023-02-14 14:05:32'),
(9, 'Transcripts', '/student/transcripts', '/student/transcripts', '/student/transcripts', NULL, NULL, 0, 9, 1, 1, '2023-02-14 14:06:19', 1, '2023-02-14 14:06:19', '2023-02-14 14:06:19'),
(10, 'Requirements', '/student/requirements', '/student/requirements', '/student/requirements', NULL, NULL, 0, 10, 1, 1, '2023-02-14 14:06:50', 1, '2023-02-14 14:06:50', '2023-02-14 14:06:50'),
(11, 'Dashboard', '/superAdmin/dashboard', '/superAdmin/dashboard', '/superAdmin/dashboard', NULL, NULL, 0, 11, 1, 1, '2023-02-14 14:14:10', 1, '2023-02-14 14:14:10', '2023-02-14 14:14:10'),
(12, 'Action Permission', '/superAdmin/manageActionPermission', '/superAdmin/manageActionPermission', '/superAdmin/manageActionPermission', NULL, NULL, 0, 12, 1, 1, '2023-02-14 14:15:27', 1, '2023-02-14 14:15:27', '2023-02-14 14:15:27'),
(13, 'Certificate', '/superAdmin/manageCertificate', '/superAdmin/manageCertificate', '/superAdmin/manageCertificate', NULL, NULL, 0, 13, 1, 1, '2023-02-14 14:16:55', 1, '2023-02-14 14:16:55', '2023-02-14 14:16:55'),
(14, 'Course Library', '/superAdmin/manageCourseLibrary', '/superAdmin/manageCourseLibrary', '/superAdmin/manageCourseLibrary', NULL, NULL, 0, 14, 1, 1, '2023-02-14 14:17:37', 1, '2023-02-14 14:17:37', '2023-02-14 14:17:37'),
(15, 'Generic Category', '/superAdmin/manageCategory', '/superAdmin/manageCategory', '/superAdmin/manageCategory', NULL, NULL, 0, 15, 1, 1, '2023-02-14 14:18:44', 1, '2023-02-14 14:18:44', '2023-02-14 14:18:44'),
(16, 'Generic Group', '/superAdmin/manageGroups', '/superAdmin/manageGroups', '/superAdmin/manageGroups', NULL, NULL, 0, 16, 1, 1, '2023-02-14 14:19:09', 1, '2023-02-14 14:19:09', '2023-02-14 14:19:09'),
(17, 'Media Library', '/superAdmin/manageMediaLibrary', '/superAdmin/manageMediaLibrary', '/superAdmin/manageMediaLibrary', NULL, NULL, 0, 17, 1, 1, '2023-02-14 14:19:36', 1, '2023-02-14 14:19:36', '2023-02-14 14:19:36'),
(18, 'Manage Module', '/superAdmin/manageModule', '/superAdmin/manageModule', '/superAdmin/manageModule', NULL, NULL, 0, 18, 1, 1, '2023-02-14 14:20:08', 1, '2023-02-14 14:20:08', '2023-02-14 14:20:08'),
(19, 'Menu', '/superAdmin/manageMenu', '/superAdmin/manageMenu', '/superAdmin/manageMenu', NULL, NULL, 0, 19, 1, 1, '2023-02-14 14:21:14', 1, '2023-02-14 14:21:14', '2023-02-14 14:21:14'),
(20, 'Menu Permissions', '/superAdmin/manageMenuPermissions', '/superAdmin/manageMenuPermissions', '/superAdmin/manageMenuPermissions', NULL, NULL, 0, 20, 1, 1, '2023-02-14 14:24:03', 1, '2023-02-14 14:24:03', '2023-02-14 14:24:03'),
(21, 'Notifications', '/superAdmin/manageNotifications', '/superAdmin/manageNotifications', '/superAdmin/manageNotifications', NULL, NULL, 0, 21, 1, 1, '2023-02-14 14:24:20', 1, '2023-02-14 14:24:20', '2023-02-14 14:24:20'),
(22, 'Organization', '/superAdmin/manageOrganization', '/superAdmin/manageOrganization', '/superAdmin/manageOrganization', NULL, NULL, 0, 22, 1, 1, '2023-02-14 14:24:52', 1, '2023-02-14 14:24:52', '2023-02-14 14:24:52'),
(23, 'Role', '/superAdmin/manageRoles', '/superAdmin/manageRoles', '/superAdmin/manageRoles', NULL, NULL, 0, 23, 1, 1, '2023-02-14 14:25:21', 1, '2023-02-14 14:25:21', '2023-02-14 14:25:21'),
(24, 'Theme', '/superAdmin/manageTheme', '/superAdmin/manageTheme', '/superAdmin/manageTheme', NULL, NULL, 0, 24, 1, 1, '2023-02-14 14:26:14', 1, '2023-02-14 14:26:14', '2023-02-14 14:26:14'),
(25, 'Team Credit', '/admin/myTeamCreditReport', '/admin/myTeamCreditReport', '/admin/myTeamCreditReport', NULL, NULL, 2, 25, 1, 1, '2023-02-14 14:29:45', 1, '2023-02-14 14:29:45', '2023-02-14 14:29:45'),
(26, 'Team Approval', '/admin/creditManagement/teamApprovalReport', '/admin/creditManagement/teamApprovalReport', '/admin/creditManagement/teamApprovalReport', NULL, NULL, 2, 26, 1, 1, '2023-02-14 14:30:53', 1, '2023-02-14 14:30:53', '2023-02-14 14:30:53'),
(27, 'User Credit', '/admin/creditManagement/userCreditReport', '/admin/creditManagement/userCreditReport', '/admin/creditManagement/userCreditReport', NULL, NULL, 2, 27, 1, 1, '2023-02-14 14:31:15', 1, '2023-02-14 14:31:15', '2023-02-14 14:31:15'),
(28, 'Category', '/admin/systemManagement/category', '/admin/systemManagement/category', '/admin/systemManagement/category', NULL, NULL, 3, 28, 1, 1, '2023-02-14 14:34:10', 1, '2023-02-14 14:34:10', '2023-02-14 14:34:10'),
(29, 'Notifications', '/admin/systemManagement/notifications', '/admin/systemManagement/notifications', '/admin/systemManagement/notifications', NULL, NULL, 3, 29, 1, 1, '2023-02-14 14:34:34', 1, '2023-02-14 14:34:34', '2023-02-14 14:34:34'),
(30, 'Skill', '/admin/systemManagement/skill', '/admin/systemManagement/skill', '/admin/systemManagement/skill', NULL, NULL, 3, 30, 1, 1, '2023-02-14 14:34:48', 1, '2023-02-14 14:34:48', '2023-02-14 14:34:48'),
(31, 'Course Catalog', '/admin/trainingManagement/courseCatalog', '/admin/trainingManagement/courseCatalog', '/admin/trainingManagement/courseCatalog', NULL, NULL, 4, 31, 1, 1, '2023-02-14 14:36:04', 1, '2023-02-14 14:36:04', '2023-02-14 14:36:04'),
(32, 'Credentials', '/admin/trainingManagement/credentials', '/admin/trainingManagement/credentials', '/admin/trainingManagement/credentials', NULL, NULL, 4, 32, 1, 1, '2023-02-14 14:36:21', 1, '2023-02-14 14:36:21', '2023-02-14 14:36:21'),
(33, 'Learning Plan', '/admin/trainingManagement/learningPlan', '/admin/trainingManagement/learningPlan', '/admin/trainingManagement/learningPlan', NULL, NULL, 4, 33, 1, 1, '2023-02-14 14:36:37', 1, '2023-02-14 14:36:37', '2023-02-14 14:36:37'),
(34, 'Training Library', '/admin/trainingManagement/trainingLibrary', '/admin/trainingManagement/trainingLibrary', '/admin/trainingManagement/trainingLibrary', NULL, NULL, 4, 34, 1, 1, '2023-02-14 14:36:59', 1, '2023-02-14 14:36:59', '2023-02-14 14:36:59'),
(35, 'Group List', '/admin/userManagement/groupList', '/admin/userManagement/groupList', '/admin/userManagement/groupList', NULL, NULL, 5, 35, 1, 1, '2023-02-14 14:37:46', 1, '2023-02-14 14:37:46', '2023-02-14 14:37:46'),
(36, 'Instructor/Trainer List', '/admin/userManagement/instructorTrainerList', '/admin/userManagement/instructorTrainerList', '/admin/userManagement/instructorTrainerList', NULL, NULL, 5, 36, 1, 1, '2023-02-14 14:38:15', 1, '2023-02-14 14:38:15', '2023-02-14 14:38:15'),
(37, 'SubAdmin', '/admin/userManagement/subAdmin', '/admin/userManagement/subAdmin', '/admin/userManagement/subAdmin', NULL, NULL, 5, 37, 1, 1, '2023-02-14 14:38:47', 1, '2023-02-14 14:38:47', '2023-02-14 14:38:47'),
(38, 'User List', '/admin/userManagement/listUsers', '/admin/userManagement/listUsers', '/admin/userManagement/listUsers', NULL, NULL, 5, 38, 1, 1, '2023-02-14 14:39:02', 1, '2023-02-14 14:39:02', '2023-02-14 14:39:02'),
(39, 'Catalog', '', '', '', NULL, NULL, NULL, 39, 1, 1, '2022-03-31 14:18:19', 1, '2022-03-31 14:18:19', '2023-03-28 06:13:38'),
(40, 'Media', '', '', '', NULL, NULL, 4, 40, 1, NULL, NULL, NULL, NULL, '2023-04-21 11:28:31'),
(41, 'User Notifications', '/notifications/usernotificationsdisplay', 'common/Notification/UserNotificationDisplay', 'GetUserNotifications', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-04-22 05:08:40'),
(42, 'AddCredentials', '/admin/trainingmanagement/addcredentials', 'admin/TrainingManagement/Credentials/AddCredentials', 'AddNewCredentials', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-04-22 05:08:40'),
(43, 'ArchivedCredentials', '/admin/trainingmanagement/archivedlist', 'admin/TrainingManagement/Credentials/ArchivedList', 'ArchivedCredentials', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-04-22 05:08:40'),
(44, 'DeletedCredentials', '/admin/trainingmanagement/deletedlist', 'admin/TrainingManagement/Credentials/DeletedList', 'DeletedCredentials', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-04-22 05:08:40'),
(45, 'EditCredentials', '/admin/trainingmanagement/editcredentials', 'admin/TrainingManagement/Credentials/EditCredentials', 'EditCredentials', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-04-22 05:08:40'),
(46, 'ViewCredentials', '/admin/trainingmanagement/viewcredentials', 'admin/TrainingManagement/Credentials/ViewCredentials', 'ViewCredentials', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-04-22 05:08:40'),
(47, 'Credentials', '/admin/trainingmanagement/credentials', 'admin/TrainingManagement/Credentials/Credentials', 'Credentials', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-04-22 05:08:40'),
(48, 'UserProfile', '/userprofile', 'admin/UserManagement/User/UserProfile', 'UserProfile', NULL, NULL, NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-04-27 09:41:52');

-- --------------------------------------------------------

--
-- Table structure for table `lms_notifications`
--

CREATE TABLE `lms_notifications` (
  `notification_id` int(11) NOT NULL,
  `notification_name` varchar(255) DEFAULT NULL,
  `notification_category_id` int(11) DEFAULT NULL,
  `notification_event_id` int(11) DEFAULT NULL,
  `tracked_user_group` tinyint(4) NOT NULL DEFAULT 1,
  `user_id` varchar(50) DEFAULT NULL,
  `group_id` varchar(50) DEFAULT NULL,
  `recipient_id` int(11) DEFAULT NULL,
  `define_days` int(11) DEFAULT NULL,
  `notification_subject` varchar(100) DEFAULT NULL,
  `notification_content` text DEFAULT NULL,
  `training_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_notification_category`
--

CREATE TABLE `lms_notification_category` (
  `notification_category_id` int(11) NOT NULL,
  `notification_category_name` varchar(150) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_notification_category`
--

INSERT INTO `lms_notification_category` (`notification_category_id`, `notification_category_name`, `is_active`, `date_created`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Assignment', 1, '2022-09-08 08:54:11', '2022-09-08 08:54:11', '2022-09-08 01:24:27'),
(2, 'Learning Plan', 1, '2022-09-08 08:54:30', '2022-09-08 08:54:30', '2022-09-08 01:24:44'),
(3, 'Expiration', 1, '2022-09-08 08:54:53', '2022-09-08 08:54:53', '2022-09-08 01:24:59'),
(4, 'Classroom', 1, '2022-09-08 08:55:08', '2022-09-08 08:55:08', '2022-09-08 01:25:14'),
(5, 'Completion', 1, '2022-09-08 08:55:22', '2022-09-08 08:55:22', '2022-09-08 01:25:28'),
(6, 'New User', 1, '2022-09-08 08:55:40', '2022-09-08 08:55:40', '2022-09-08 01:25:46');

-- --------------------------------------------------------

--
-- Table structure for table `lms_notification_events`
--

CREATE TABLE `lms_notification_events` (
  `notification_event_id` int(11) NOT NULL,
  `notification_event_name` varchar(100) DEFAULT NULL,
  `notification_category_id` int(11) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_notification_events`
--

INSERT INTO `lms_notification_events` (`notification_event_id`, `notification_event_name`, `notification_category_id`, `is_active`, `date_created`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'New Assignment', 1, 1, '2022-09-09 07:38:15', '2022-09-09 07:38:15', '2022-09-08 13:09:36'),
(2, 'Assignment Reminder – Automated', 1, 1, '2022-09-09 07:38:15', '2022-09-09 07:38:15', '2022-09-08 13:09:36'),
(3, 'Assignment Reminder – Manual', 1, 1, '2022-09-09 07:38:15', '2022-09-09 07:38:15', '2022-09-08 13:09:36'),
(4, 'New Learning Plan', 2, 1, '2022-09-09 07:40:33', '2022-09-09 07:40:33', '2022-09-08 13:10:54'),
(5, 'New Learning Plan Assignment', 2, 1, '2022-09-09 07:40:33', '2022-09-09 07:40:33', '2022-09-08 13:10:54'),
(6, 'Expired Training', 3, 1, '2022-09-09 07:41:30', '2022-09-09 07:41:30', '2022-09-08 13:12:02'),
(7, 'Expired Credential', 3, 1, '2022-09-09 07:41:30', '2022-09-09 07:41:30', '2022-09-08 13:12:02'),
(8, 'Expires Soon Training', 3, 1, '2022-09-09 07:41:30', '2022-09-09 07:41:30', '2022-09-08 13:12:02'),
(9, 'Expires Soon Credential', 3, 1, '2022-09-09 07:41:30', '2022-09-09 07:41:30', '2022-09-08 13:12:02'),
(10, 'New Enrollment', 4, 1, '2022-09-09 08:25:02', '2022-09-09 08:25:02', '2022-09-08 13:55:54'),
(11, 'Classroom Reminder', 4, 1, '2022-09-09 08:25:02', '2022-09-09 08:25:02', '2022-09-08 13:55:54'),
(12, 'Classroom Details Updated', 4, 1, '2022-09-09 08:25:02', '2022-09-09 08:25:02', '2022-09-08 13:55:54'),
(13, 'eLearning Completion', 5, 1, '2022-09-09 08:26:02', '2022-09-09 08:26:02', '2022-09-08 13:56:27'),
(14, 'Assignment Completion', 5, 1, '2022-09-09 08:26:02', '2022-09-09 08:26:02', '2022-09-08 13:56:27'),
(15, 'Learning Plan Completed', 5, 1, '2022-09-09 08:26:02', '2022-09-09 08:26:02', '2022-09-08 13:56:27'),
(16, 'Welcome Notification', 6, 1, '2022-09-09 08:26:29', '2022-09-09 08:26:29', '2022-09-08 13:56:40');

-- --------------------------------------------------------

--
-- Table structure for table `lms_notification_master`
--

CREATE TABLE `lms_notification_master` (
  `notification_id` bigint(20) NOT NULL,
  `notification_name` varchar(255) NOT NULL,
  `notification_type` enum('text','email') NOT NULL,
  `subject` varchar(255) NOT NULL,
  `notification_content` text NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `notification_date` datetime DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_notification_master`
--

INSERT INTO `lms_notification_master` (`notification_id`, `notification_name`, `notification_type`, `subject`, `notification_content`, `is_active`, `notification_date`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Welcome to User', 'text', 'Welcome to User', 'Welcome to User', 0, '2023-02-20 11:58:58', NULL, NULL, NULL, '2023-04-27 08:34:28', '2023-04-27 08:34:28'),
(2, 'Welcome to Admin', 'text', 'Welcome to Admin', 'Welcome to Admin', 1, NULL, NULL, NULL, NULL, NULL, '2023-04-05 10:20:32'),
(3, 'Welcome to SuperAdmin', 'text', 'Welcome to SuperAdmin', 'Welcome to SuperAdmin', 1, NULL, NULL, NULL, NULL, NULL, '2023-04-05 10:20:53');

-- --------------------------------------------------------

--
-- Table structure for table `lms_organization_type`
--

CREATE TABLE `lms_organization_type` (
  `organization_type_id` bigint(20) NOT NULL,
  `organization_type` varchar(50) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_organization_type`
--

INSERT INTO `lms_organization_type` (`organization_type_id`, `organization_type`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'IT', 1, NULL, '2022-04-19 08:02:55', NULL, '2022-04-19 08:02:55', '2022-04-19 06:03:18'),
(2, 'Manufacturing', 1, NULL, '2022-04-19 08:03:21', NULL, '2022-04-19 08:03:21', '2022-04-19 06:03:34'),
(3, 'Health', 1, NULL, '2022-04-19 08:03:37', NULL, '2022-04-19 08:03:37', '2022-04-19 06:04:03'),
(4, 'Construction', 1, NULL, '2022-04-20 12:24:56', NULL, '2022-04-20 12:24:56', '2022-04-20 10:25:00'),
(5, 'Real Estate', 1, NULL, '2022-04-20 12:25:13', NULL, '2022-04-20 12:25:13', '2022-04-20 10:25:16'),
(6, 'Auto Mobile', 1, NULL, '2022-04-20 12:25:29', NULL, '2022-04-20 12:25:29', '2022-04-20 10:25:32'),
(7, 'Trading', 1, NULL, '2022-04-20 12:25:42', NULL, '2022-04-20 12:25:42', '2022-04-20 10:25:44'),
(8, 'Others', 1, NULL, '2022-04-20 12:25:52', NULL, '2022-04-20 12:25:52', '2022-04-20 10:25:54'),
(9, 'tag1,tag2', 1, 1, '2023-02-03 07:01:57', 1, '2023-02-03 07:01:57', '2023-02-03 07:01:57'),
(10, '123', 1, 1, '2023-02-28 11:41:21', 1, '2023-02-28 11:41:21', '2023-02-28 11:41:21'),
(11, '123', 1, 1, '2023-02-28 11:41:27', 1, '2023-02-28 11:41:27', '2023-02-28 11:41:27');

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_assessment_question`
--

CREATE TABLE `lms_org_assessment_question` (
  `question_id` int(11) NOT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `question_type_id` int(11) DEFAULT NULL,
  `question` varchar(500) DEFAULT NULL,
  `show_ans_random` tinyint(1) DEFAULT 1,
  `number_of_options` tinyint(1) DEFAULT 1,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_assessment_settings`
--

CREATE TABLE `lms_org_assessment_settings` (
  `assessment_setting_id` int(11) NOT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `require_passing_score` tinyint(1) DEFAULT 1,
  `passing_percentage` int(11) DEFAULT NULL,
  `randomize_questions` tinyint(1) DEFAULT 1,
  `display_type` tinytext DEFAULT '1',
  `hide_after_completed` tinyint(1) DEFAULT 1,
  `attempt_count` int(11) DEFAULT NULL,
  `learner_can_view_result` tinyint(1) DEFAULT 1,
  `post_quiz_action` tinyint(4) NOT NULL DEFAULT 1,
  `pass_fail_status` tinyint(1) DEFAULT 1,
  `total_score` tinyint(1) DEFAULT 1,
  `correct_incorrect_marked` tinyint(1) DEFAULT 1,
  `correct_incorrect_ans_marked` tinyint(1) DEFAULT 1,
  `timer_on` tinyint(1) DEFAULT 1,
  `hrs` int(11) DEFAULT 1,
  `mins` int(11) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_assign_training_library`
--

CREATE TABLE `lms_org_assign_training_library` (
  `org_assign_training_id` bigint(20) NOT NULL,
  `training_id` bigint(20) NOT NULL,
  `org_id` varchar(100) NOT NULL,
  `is_modified` tinyint(4) DEFAULT 0,
  `su_assigned` tinyint(4) DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_org_assign_training_library`
--

INSERT INTO `lms_org_assign_training_library` (`org_assign_training_id`, `training_id`, `org_id`, `is_modified`, `su_assigned`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 2, '1', NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-03-16 10:57:49'),
(2, 1, '1', NULL, NULL, 1, NULL, NULL, NULL, NULL, '2023-03-16 11:05:30');

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_category`
--

CREATE TABLE `lms_org_category` (
  `category_id` bigint(20) NOT NULL,
  `category_name` varchar(150) DEFAULT NULL,
  `category_code` char(36) NOT NULL,
  `primary_category_id` bigint(20) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `org_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_org_category`
--

INSERT INTO `lms_org_category` (`category_id`, `category_name`, `category_code`, `primary_category_id`, `description`, `is_active`, `org_id`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Education', 'Education', NULL, 'This is Education Category', 1, 1, 1, '2023-04-25 12:19:43', 1, '2023-04-25 12:46:17', '2023-04-25 12:58:03'),
(2, 'PHP', 'PHP', 1, 'This is Education Category', 1, 1, 1, '2023-04-25 12:28:05', 1, '2023-04-25 12:46:17', '2023-04-25 12:57:01'),
(3, 'Education', 'nnn', 2, 'This is Education Category', 1, 1, 1, '2023-04-25 12:48:31', 1, '2023-04-25 12:58:24', '2023-04-25 12:58:24');

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_category_group_assignment`
--

CREATE TABLE `lms_org_category_group_assignment` (
  `category_group_assignment_id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `group_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` int(11) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lms_org_category_group_assignment`
--

INSERT INTO `lms_org_category_group_assignment` (`category_group_assignment_id`, `category_id`, `group_id`, `user_id`, `org_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 1, 1, NULL, 1, 1, 1, NULL, 1, NULL, '2023-04-05 11:18:46'),
(3, 1, 1, 1, 1, 1, 1, '2023-04-27 10:36:02', 1, '2023-04-27 10:36:02', '2023-04-27 10:36:02'),
(4, 1, 2, 1, 1, 1, 1, '2023-04-27 10:36:02', 1, '2023-04-27 10:36:02', '2023-04-27 10:36:02');

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_course_catalog`
--

CREATE TABLE `lms_org_course_catalog` (
  `org_course_catalog_id` bigint(20) NOT NULL,
  `training_type` tinyint(1) DEFAULT NULL,
  `course_code` varchar(50) DEFAULT NULL,
  `course_name` varchar(255) NOT NULL,
  `course_title` varchar(255) DEFAULT NULL,
  `quiz_type` tinyint(1) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `training_Content` bigint(20) DEFAULT NULL,
  `reference_code` varchar(50) DEFAULT NULL,
  `course_image` varchar(255) DEFAULT NULL,
  `credit` int(11) DEFAULT NULL,
  `credit_visibility` tinyint(1) DEFAULT 1,
  `point` int(11) DEFAULT NULL,
  `point_visibility` tinyint(1) DEFAULT 1,
  `certificate_id` tinyint(1) DEFAULT NULL,
  `ilt_assessment` tinyint(1) DEFAULT NULL,
  `activity_review` tinyint(1) DEFAULT NULL,
  `enrollment_type` tinyint(1) DEFAULT NULL,
  `unenrollment` tinyint(1) DEFAULT NULL,
  `passing_score` varchar(50) DEFAULT NULL,
  `ssl_for_aicc` tinyint(4) NOT NULL DEFAULT 1,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `org_id` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `time` int(11) DEFAULT NULL,
  `due_date` datetime DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_credentials`
--

CREATE TABLE `lms_org_credentials` (
  `id` int(11) NOT NULL,
  `credential_title` varchar(50) DEFAULT NULL,
  `credential_code` varchar(50) DEFAULT NULL,
  `category_id` varchar(50) DEFAULT NULL,
  `credential_note` varchar(255) DEFAULT NULL,
  `credential_description` varchar(255) DEFAULT NULL,
  `expiration_time` varchar(50) DEFAULT NULL,
  `days_till_expiration` int(11) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `created_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` int(11) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lms_org_credentials`
--

INSERT INTO `lms_org_credentials` (`id`, `credential_title`, `credential_code`, `category_id`, `credential_note`, `credential_description`, `expiration_time`, `days_till_expiration`, `status`, `org_id`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'qqq', 'qqq', '1,2', 'jhbhjmj@gvhg.ghy', '878668', '2023-10', 1, 1, 1, 1, '2023-04-20 09:03:12', 1, '2023-04-20 09:03:12', '2023-04-20 09:03:12'),
(2, 'qqq', 'qqq', '1,2', 'jhbhjmj@gvhg.ghy', '878668', '2023-10', 1, 1, 1, 1, '2023-04-20 09:13:00', 1, '2023-04-20 09:13:00', '2023-04-20 09:13:00');

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_master`
--

CREATE TABLE `lms_org_master` (
  `org_id` bigint(20) NOT NULL,
  `domain_id` bigint(20) DEFAULT NULL,
  `org_code` int(11) NOT NULL,
  `organization_name` varchar(64) NOT NULL,
  `organization_notes` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `is_primary` tinyint(4) DEFAULT 1,
  `parent_org_id` int(11) DEFAULT NULL,
  `email_id` varchar(255) NOT NULL,
  `phone_number` varchar(255) DEFAULT NULL,
  `address` varchar(255) NOT NULL,
  `zip_code` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `web` varchar(255) DEFAULT NULL,
  `logo_image` varchar(100) DEFAULT NULL,
  `logo_text` varchar(255) DEFAULT NULL,
  `organization_type_id` bigint(20) DEFAULT NULL,
  `contact_number` varchar(255) NOT NULL,
  `contact_person` varchar(255) NOT NULL,
  `contact_email` varchar(255) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_org_master`
--

INSERT INTO `lms_org_master` (`org_id`, `domain_id`, `org_code`, `organization_name`, `organization_notes`, `is_active`, `is_primary`, `parent_org_id`, `email_id`, `phone_number`, `address`, `zip_code`, `country`, `state`, `web`, `logo_image`, `logo_text`, `organization_type_id`, `contact_number`, `contact_person`, `contact_email`, `user_id`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 1, 110001, 'Dev', '', 1, 1, NULL, 'dev@gmail.com', '8234453342', 'Goa', '494550', '1', 'CG', NULL, 'whYvqusXri2zaEprYGJ0KVXFCpI4qkxHmAnS4WNJ.jpg', 'Dev', NULL, '8234453342', 'Dev', 'dev@gmail.com', 1, NULL, '2022-04-08 05:50:31', NULL, '2023-01-14 16:47:12', '2023-02-09 04:21:47'),
(2, 2, 110002, 'Dev1', '', 1, 1, 1, 'dev1@gmail.com', '5643543456', 'india', '6543450', '72', 'india', NULL, 'lb2WamqXBRWZfDy2kdrmYI8xzI9lZxBdfaxBntOY.png', 'Dev1', NULL, '5643543456', 'Dev1', 'dev1@gmail.com', 2, 1, '2022-08-05 11:12:25', 2, '2022-12-16 11:26:50', '2023-02-09 08:00:33'),
(3, 3, 110003, 'Dev2', '', 1, 1, 1, 'dev2@gmail.com', '5643543456', 'india', '6543450', '72', 'india', NULL, 'lb2WamqXBRWZfDy2kdrmYI8xzI9lZxBdfaxBntOY.png', 'Dev2', NULL, '5643543456', 'Dev2', 'dev2@gmail.com', 3, 1, '2022-08-05 11:12:25', 2, '2022-12-16 11:26:50', '2023-02-09 04:21:54'),
(4, 4, 110004, 'Dev3', NULL, 1, 1, 1, 'dev3@gmail.com', '7654545343', 'india', '765456', '72', 'india', NULL, 'lb2WamqXBRWZfDy2kdrmYI8xzI9lZxBdfaxBntOY.png', 'Dev3', NULL, '7654545343', 'Dev3', 'dev3@gmail.com', 4, 1, '2022-08-05 11:14:39', 1, '2022-08-05 11:14:39', '2023-02-09 04:21:58'),
(5, 5, 110005, 'Dev4', NULL, 1, 1, 1, 'dev4@gmail.com', '8765456543', 'india', '765456', '72', 'india', NULL, 'lb2WamqXBRWZfDy2kdrmYI8xzI9lZxBdfaxBntOY.png', 'Dev4', NULL, '8765456543', 'Dev4', 'dev4@gmail.com', 5, 1, '2022-08-05 11:18:19', 1, '2022-08-05 11:18:19', '2023-02-09 04:22:02'),
(6, 6, 110006, 'Dev5', NULL, 1, 1, 1, 'dev5@gmail.com', '7654343232', 'india', '765434', '72', 'india', NULL, 'lb2WamqXBRWZfDy2kdrmYI8xzI9lZxBdfaxBntOY.png', 'Dev5', NULL, '7654343232', 'Dev5', 'dev5@gmail.com', 6, 1, '2022-08-05 11:21:06', 1, '2022-08-05 11:21:06', '2023-02-09 04:22:06'),
(7, 7, 110007, 'Frontend', NULL, 1, 1, 1, 'frontend@gmail.com', '7654343232', 'india', '765434', '72', 'india', NULL, 'lb2WamqXBRWZfDy2kdrmYI8xzI9lZxBdfaxBntOY.png', 'Frontend', NULL, '7654343232', 'Frontend', 'frontend@gmail.com', 7, 1, '2022-08-05 11:21:06', 1, '2022-08-05 11:21:06', '2023-02-09 04:22:09'),
(8, 8, 110008, 'Elitelms', '', 1, 1, 1, 'elitelms@gmail.com', '8806745683', 'india', '403107', '72', 'induia', NULL, 'lb2WamqXBRWZfDy2kdrmYI8xzI9lZxBdfaxBntOY.png', 'Elitelms', NULL, '8806745683', 'Elitelms', 'elitelms@gmail.com', 8, 1, '2022-08-05 11:12:25', 1, '2022-08-05 11:12:25', '2023-02-09 04:21:50');

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_notification`
--

CREATE TABLE `lms_org_notification` (
  `org_notification_id` bigint(20) NOT NULL,
  `notification_id` bigint(20) DEFAULT NULL,
  `org_notification_name` varchar(255) NOT NULL,
  `org_notification_type` enum('text','email') NOT NULL DEFAULT 'text',
  `org_subject` varchar(255) NOT NULL,
  `org_notification_content` text NOT NULL,
  `is_default` tinyint(1) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `notification_date` datetime DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_org_notification`
--

INSERT INTO `lms_org_notification` (`org_notification_id`, `notification_id`, `org_notification_name`, `org_notification_type`, `org_subject`, `org_notification_content`, `is_default`, `org_id`, `is_active`, `notification_date`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, NULL, 'Admin Login1', 'text', 'Welcom To Admin', 'Welcom To Admin', NULL, 1, 1, '2023-10-10 00:00:00', 1, '2023-04-25 10:31:57', 1, '2023-04-27 08:34:20', '2023-04-28 05:53:03'),
(2, NULL, 'Admin Login', 'email', 'Welcom To Admin', 'Welcom To Admin', NULL, 1, 1, '2023-10-10 00:00:00', 1, '2023-04-25 10:32:59', 1, '2023-04-25 10:32:59', '2023-04-25 10:32:59'),
(3, NULL, 'Admin Login1', 'text', 'Welcom To Admin', 'Welcom To Admin', NULL, 1, 1, '2023-10-10 00:00:00', 1, '2023-04-25 11:01:24', 1, '2023-04-25 11:01:54', '2023-04-28 05:53:07');

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_question_answer`
--

CREATE TABLE `lms_org_question_answer` (
  `answer_id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `options` varchar(500) DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  `text_ans` text DEFAULT NULL,
  `numberic_ans` int(11) DEFAULT NULL,
  `text_box` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_skills`
--

CREATE TABLE `lms_org_skills` (
  `org_skill_id` bigint(20) NOT NULL,
  `org_skill_name` varchar(45) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `org_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_training_handouts`
--

CREATE TABLE `lms_org_training_handouts` (
  `training_handout_id` bigint(20) NOT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_training_library`
--

CREATE TABLE `lms_org_training_library` (
  `training_id` bigint(20) NOT NULL,
  `training_type_id` bigint(20) DEFAULT NULL,
  `training_name` varchar(150) DEFAULT NULL,
  `training_code` char(36) NOT NULL,
  `reference_code` varchar(100) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `content_type` int(11) DEFAULT NULL,
  `image_id` bigint(20) DEFAULT NULL,
  `credits` double(10,2) DEFAULT 0.00,
  `credits_visible` tinyint(1) NOT NULL DEFAULT 1,
  `points` int(11) DEFAULT NULL,
  `points_visible` tinyint(1) NOT NULL DEFAULT 1,
  `enrollment_type` varchar(50) DEFAULT NULL,
  `activity_reviews` tinyint(4) NOT NULL DEFAULT 1,
  `unenrollment` tinyint(4) NOT NULL DEFAULT 1,
  `quiz_type` enum('Servey','Quiz') NOT NULL,
  `category_id` varchar(20) DEFAULT NULL,
  `certificate_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `ilt_enrollment_id` bigint(20) DEFAULT NULL,
  `training_status_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_modified` tinyint(4) DEFAULT 0,
  `su_assigned` tinyint(4) DEFAULT 0,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_org_training_library`
--

INSERT INTO `lms_org_training_library` (`training_id`, `training_type_id`, `training_name`, `training_code`, `reference_code`, `description`, `content_type`, `image_id`, `credits`, `credits_visible`, `points`, `points_visible`, `enrollment_type`, `activity_reviews`, `unenrollment`, `quiz_type`, `category_id`, `certificate_id`, `is_active`, `ilt_enrollment_id`, `training_status_id`, `org_id`, `is_modified`, `su_assigned`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 1, 'Test', '1234', NULL, '', NULL, NULL, 0.00, 1, NULL, 1, NULL, 1, 1, '', '2', 1, 1, NULL, 1, 1, NULL, NULL, NULL, NULL, NULL, '2023-04-27 07:20:01', '2023-04-27 07:20:01');

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_training_media`
--

CREATE TABLE `lms_org_training_media` (
  `training_media_id` bigint(20) NOT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `media_id` bigint(20) DEFAULT NULL,
  `passing_score` int(11) DEFAULT NULL,
  `ssl_on_off` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_org_training_notifications_settings`
--

CREATE TABLE `lms_org_training_notifications_settings` (
  `training_notification_setting_id` bigint(20) NOT NULL,
  `training_notification_id` bigint(20) DEFAULT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `notification_on` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_permission`
--

CREATE TABLE `lms_permission` (
  `permission_id` bigint(20) NOT NULL,
  `module_id` bigint(20) DEFAULT NULL,
  `actions_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `read_access` tinyint(1) NOT NULL DEFAULT 1,
  `write_access` tinyint(1) NOT NULL DEFAULT 1,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_question_answer`
--

CREATE TABLE `lms_question_answer` (
  `answer_id` int(11) NOT NULL,
  `question_id` int(11) DEFAULT NULL,
  `options` varchar(500) DEFAULT NULL,
  `is_correct` tinyint(1) DEFAULT NULL,
  `text_ans` text DEFAULT NULL,
  `numberic_ans` int(11) DEFAULT NULL,
  `text_box` varchar(500) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_question_types`
--

CREATE TABLE `lms_question_types` (
  `question_type_id` int(11) NOT NULL,
  `question_type` varchar(150) DEFAULT NULL,
  `description` varchar(150) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_question_types`
--

INSERT INTO `lms_question_types` (`question_type_id`, `question_type`, `description`, `is_active`) VALUES
(1, 'Multiple Choice', 'Check box with multiselect', 1),
(2, 'Multiple Select', 'Radio Button', 1),
(3, 'True/False', 'True or False', 1),
(4, 'Yes/No', 'Yes or No', 1),
(5, 'Text Answer', 'Text Area', 1),
(6, 'Numeric Response', 'Text Box with Number', 1),
(7, 'Fill in the Blanks', 'Text Box allow comma', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_resources`
--

CREATE TABLE `lms_resources` (
  `resource_id` bigint(20) NOT NULL,
  `resource_name` varchar(64) NOT NULL,
  `resource_size` varchar(64) NOT NULL,
  `resource_type` varchar(64) NOT NULL,
  `resource_url` varchar(256) NOT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_resources`
--

INSERT INTO `lms_resources` (`resource_id`, `resource_name`, `resource_size`, `resource_type`, `resource_url`, `is_active`, `org_id`, `user_id`, `created_id`, `date_created`) VALUES
(1, '', '', '', 'IFxakBufIa8fAKYJ7TwtIRNZUugAW0X1oMUyuUUQ.png', 1, 1, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lms_roles`
--

CREATE TABLE `lms_roles` (
  `role_id` bigint(20) NOT NULL,
  `role_name` varchar(40) CHARACTER SET latin1 COLLATE latin1_general_ci NOT NULL DEFAULT '',
  `role_type` varchar(60) NOT NULL,
  `description` varchar(255) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_roles`
--

INSERT INTO `lms_roles` (`role_id`, `role_name`, `role_type`, `description`, `is_active`) VALUES
(1, 'Super Admin', 'role_super_admin', 'User has access to everything in the system as superadmin', 1),
(2, 'Administrator', 'role_system_admin', 'Users who manages the organization and domain as admin', 1),
(3, 'SubAdmin', 'role_sub_admin', 'User has limited access with in the organization as subadmin', 1),
(4, 'Supervisor', 'role_team_supervisor', 'User manages the team in the organization as leaders', 1),
(5, 'Instructors', 'role_training_instructors', 'User manages the trainings in organization as Instructors', 1),
(6, 'HR Manager', 'role_hr_managers', 'User manages the users in organization as managers', 1),
(7, 'Students', 'role_user_students', 'User who has to take training', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_skills_master`
--

CREATE TABLE `lms_skills_master` (
  `skill_id` bigint(20) NOT NULL,
  `skill_name` varchar(45) DEFAULT NULL,
  `description` varchar(512) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_tag`
--

CREATE TABLE `lms_tag` (
  `tag_id` bigint(20) NOT NULL,
  `tag_name` text NOT NULL,
  `ref_table_name` varchar(50) NOT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_team_approvals`
--

CREATE TABLE `lms_team_approvals` (
  `team_approval_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `course_id` int(11) NOT NULL,
  `team_approval_status` tinyint(4) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` int(11) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_team_approvals`
--

INSERT INTO `lms_team_approvals` (`team_approval_id`, `user_id`, `course_id`, `team_approval_status`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 1, 1, 2, 1, NULL, NULL, NULL, '2023-04-19 07:12:14', '2023-04-18 10:57:03');

-- --------------------------------------------------------

--
-- Table structure for table `lms_team_credit`
--

CREATE TABLE `lms_team_credit` (
  `team_credit_id` bigint(20) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `training_id` int(11) DEFAULT NULL,
  `credit_score` varchar(50) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lms_team_credit`
--

INSERT INTO `lms_team_credit` (`team_credit_id`, `user_id`, `org_id`, `training_id`, `credit_score`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 1, 1, 1, '10', 1, 1, '2023-03-14 00:00:00', 1, '2023-03-14 12:31:58', '2023-03-14 06:09:02'),
(2, 2, 1, 2, '20', 1, 1, '2023-03-14 12:33:09', 1, '2023-03-14 00:00:00', '2023-03-14 07:02:41'),
(3, 1, 1, 3, '30', 1, 1, '2023-03-14 12:33:09', 1, '2023-03-14 12:33:09', '2023-03-14 07:03:04');

-- --------------------------------------------------------

--
-- Table structure for table `lms_theme_master`
--

CREATE TABLE `lms_theme_master` (
  `theme_id` bigint(20) NOT NULL,
  `theme_name` varchar(100) NOT NULL,
  `theme_code` varchar(100) NOT NULL,
  `image_icon` varchar(100) NOT NULL,
  `theme_base_color` varchar(100) NOT NULL,
  `text_color` varchar(100) DEFAULT NULL,
  `background_color` varchar(100) NOT NULL,
  `theme_foreground_color` varchar(100) NOT NULL,
  `theme_property` longtext NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `is_deafult` int(11) NOT NULL DEFAULT 0,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_theme_master`
--

INSERT INTO `lms_theme_master` (`theme_id`, `theme_name`, `theme_code`, `image_icon`, `theme_base_color`, `text_color`, `background_color`, `theme_foreground_color`, `theme_property`, `is_active`, `is_deafult`, `date_created`, `date_modified`, `on_update_date_modified`) VALUES
(1, 'Aliceblue', 'Aliceblue', 'DGsU0Drd1Ch9Z76L34VtEKyvz4qNfhbXqDOX0dRg.png', 'Aliceblue', '#fff', '#0d6efd', 'Aliceblue', '{\"main\":{\"type\":\"default\",\"primaryColor\":\"#009EF7\",\"darkSkinEnabled\":true},\"loader\":{\"display\":true,\"type\":\"default\"},\"scrolltop\":{\"display\":true},\"header\":{\"display\":true,\"width\":\"fluid\",\"left\":\"menu\",\"fixed\":{\"desktop\":true,\"tabletAndMobile\":true},\"menuIcon\":\"svg\"},\"megaMenu\":{\"display\":true},\"aside\":{\"display\":true,\"theme\":\"dark\",\"menu\":\"main\",\"fixed\":true,\"minimized\":false,\"minimize\":true,\"hoverable\":true,\"menuIcon\":\"svg\"},\"content\":{\"width\":\"fixed\",\"layout\":\"default\"},\"toolbar\":{\"display\":true,\"width\":\"fluid\",\"fixed\":{\"desktop\":true,\"tabletAndMobileMode\":true},\"layout\":\"toolbar1\",\"layouts\":{\"toolbar1\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar2\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar3\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar4\":{\"height\":\"65px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar5\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"}}},\"footer\":{\"width\":\"fluid\"},\"pageTitle\":{\"display\":true,\"breadCrumbs\":true,\"description\":false,\"layout\":\"default\",\"direction\":\"row\",\"responsive\":true,\"responsiveBreakpoint\":\"lg\",\"responsiveTarget\":\"#kt_toolbar_container\"}}', 1, 1, '2022-04-13 15:49:18', '2022-12-16 06:39:24', '2023-04-19 00:42:45'),
(2, 'Light', 'Light', 'eGkjuXdLwVPgDzA66GCZsgdiopTnilpjRbpQOeDL.png', 'Light', '#000', '#f8f9fa', 'Light', '{\"main\":{\"type\":\"default\",\"primaryColor\":\"#009EF7\",\"darkSkinEnabled\":true},\"loader\":{\"display\":true,\"type\":\"default\"},\"scrolltop\":{\"display\":true},\"header\":{\"display\":true,\"width\":\"fluid\",\"left\":\"menu\",\"fixed\":{\"desktop\":true,\"tabletAndMobile\":true},\"menuIcon\":\"svg\"},\"megaMenu\":{\"display\":true},\"aside\":{\"display\":true,\"theme\":\"light\",\"menu\":\"main\",\"fixed\":true,\"minimized\":false,\"minimize\":true,\"hoverable\":true,\"menuIcon\":\"svg\"},\"content\":{\"width\":\"fixed\",\"layout\":\"default\"},\"toolbar\":{\"display\":true,\"width\":\"fluid\",\"fixed\":{\"desktop\":true,\"tabletAndMobileMode\":true},\"layout\":\"toolbar1\",\"layouts\":{\"toolbar1\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar2\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar3\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar4\":{\"height\":\"65px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar5\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"}}},\"footer\":{\"width\":\"fluid\"},\"pageTitle\":{\"display\":true,\"breadCrumbs\":true,\"description\":false,\"layout\":\"default\",\"direction\":\"row\",\"responsive\":true,\"responsiveBreakpoint\":\"lg\",\"responsiveTarget\":\"#kt_toolbar_container\"}}', 1, 0, '2022-04-13 15:49:51', '2022-11-21 05:13:45', '2023-04-19 00:42:49'),
(3, 'Dark', 'Dark', 'Qi6a3yVeEUjKYiHUJ8sUS7JxDOfkdHinJb2MsUhi.png', 'Dark', '#fff', '#212529', 'Dark', '{\"main\":{\"type\":\"default\",\"primaryColor\":\"#009EF7\",\"darkSkinEnabled\":true},\"loader\":{\"display\":true,\"type\":\"default\"},\"scrolltop\":{\"display\":true},\"header\":{\"display\":true,\"width\":\"fluid\",\"left\":\"menu\",\"fixed\":{\"desktop\":true,\"tabletAndMobile\":true},\"menuIcon\":\"svg\"},\"megaMenu\":{\"display\":true},\"aside\":{\"display\":true,\"theme\":\"aliceblue\",\"menu\":\"main\",\"fixed\":true,\"minimized\":false,\"minimize\":true,\"hoverable\":true,\"menuIcon\":\"svg\"},\"content\":{\"width\":\"fixed\",\"layout\":\"default\"},\"toolbar\":{\"display\":true,\"width\":\"fluid\",\"fixed\":{\"desktop\":true,\"tabletAndMobileMode\":true},\"layout\":\"toolbar1\",\"layouts\":{\"toolbar1\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar2\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar3\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar4\":{\"height\":\"65px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar5\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"}}},\"footer\":{\"width\":\"fluid\"},\"pageTitle\":{\"display\":true,\"breadCrumbs\":true,\"description\":false,\"layout\":\"default\",\"direction\":\"row\",\"responsive\":true,\"responsiveBreakpoint\":\"lg\",\"responsiveTarget\":\"#kt_toolbar_container\"}}', 1, 0, '2022-04-13 16:49:12', '2022-12-16 06:39:24', '2023-04-19 00:42:53'),
(4, 'LightBlue', 'LightBlue', 'Qi6a3yVeEUjKYiHUJ8sUS7JxDOfkdHinJb2MsUhi.png', 'LightBlue', '#fff', '#0dcaf0', 'LightBlue', '{\"main\":{\"type\":\"default\",\"primaryColor\":\"#009EF7\",\"darkSkinEnabled\":true},\"loader\":{\"display\":true,\"type\":\"default\"},\"scrolltop\":{\"display\":true},\"header\":{\"display\":true,\"width\":\"fluid\",\"left\":\"menu\",\"fixed\":{\"desktop\":true,\"tabletAndMobile\":true},\"menuIcon\":\"svg\"},\"megaMenu\":{\"display\":true},\"aside\":{\"display\":true,\"theme\":\"aliceblue\",\"menu\":\"main\",\"fixed\":true,\"minimized\":false,\"minimize\":true,\"hoverable\":true,\"menuIcon\":\"svg\"},\"content\":{\"width\":\"fixed\",\"layout\":\"default\"},\"toolbar\":{\"display\":true,\"width\":\"fluid\",\"fixed\":{\"desktop\":true,\"tabletAndMobileMode\":true},\"layout\":\"toolbar1\",\"layouts\":{\"toolbar1\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar2\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar3\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar4\":{\"height\":\"65px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar5\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"}}},\"footer\":{\"width\":\"fluid\"},\"pageTitle\":{\"display\":true,\"breadCrumbs\":true,\"description\":false,\"layout\":\"default\",\"direction\":\"row\",\"responsive\":true,\"responsiveBreakpoint\":\"lg\",\"responsiveTarget\":\"#kt_toolbar_container\"}}', 1, 0, NULL, NULL, '2023-04-19 00:52:44'),
(5, 'Grey', 'Grey', 'Qi6a3yVeEUjKYiHUJ8sUS7JxDOfkdHinJb2MsUhi.png', 'Grey', '#fff', '#6c757d', 'Grey', '{\"main\":{\"type\":\"default\",\"primaryColor\":\"#009EF7\",\"darkSkinEnabled\":true},\"loader\":{\"display\":true,\"type\":\"default\"},\"scrolltop\":{\"display\":true},\"header\":{\"display\":true,\"width\":\"fluid\",\"left\":\"menu\",\"fixed\":{\"desktop\":true,\"tabletAndMobile\":true},\"menuIcon\":\"svg\"},\"megaMenu\":{\"display\":true},\"aside\":{\"display\":true,\"theme\":\"aliceblue\",\"menu\":\"main\",\"fixed\":true,\"minimized\":false,\"minimize\":true,\"hoverable\":true,\"menuIcon\":\"svg\"},\"content\":{\"width\":\"fixed\",\"layout\":\"default\"},\"toolbar\":{\"display\":true,\"width\":\"fluid\",\"fixed\":{\"desktop\":true,\"tabletAndMobileMode\":true},\"layout\":\"toolbar1\",\"layouts\":{\"toolbar1\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar2\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar3\":{\"height\":\"55px\",\"heightAndTabletMobileMode\":\"55px\"},\"toolbar4\":{\"height\":\"65px\",\"heightAndTabletMobileMode\":\"65px\"},\"toolbar5\":{\"height\":\"75px\",\"heightAndTabletMobileMode\":\"65px\"}}},\"footer\":{\"width\":\"fluid\"},\"pageTitle\":{\"display\":true,\"breadCrumbs\":true,\"description\":false,\"layout\":\"default\",\"direction\":\"row\",\"responsive\":true,\"responsiveBreakpoint\":\"lg\",\"responsiveTarget\":\"#kt_toolbar_container\"}}', 1, 0, NULL, NULL, '2023-04-19 00:52:49');

-- --------------------------------------------------------

--
-- Table structure for table `lms_training_handouts`
--

CREATE TABLE `lms_training_handouts` (
  `training_handout_id` bigint(20) NOT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `resource_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_training_handouts`
--

INSERT INTO `lms_training_handouts` (`training_handout_id`, `training_id`, `resource_id`, `is_active`) VALUES
(1, 2, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_training_library`
--

CREATE TABLE `lms_training_library` (
  `training_id` bigint(20) NOT NULL,
  `training_type_id` bigint(20) DEFAULT NULL,
  `training_name` varchar(150) DEFAULT NULL,
  `training_code` char(36) NOT NULL,
  `reference_code` varchar(100) DEFAULT NULL,
  `description` text NOT NULL,
  `content_type` int(11) DEFAULT NULL,
  `image_id` bigint(20) DEFAULT NULL,
  `credits` double(10,2) DEFAULT 0.00,
  `credits_visible` tinyint(1) NOT NULL DEFAULT 1,
  `points` int(11) DEFAULT NULL,
  `points_visible` tinyint(1) NOT NULL DEFAULT 1,
  `enrollment_type` varchar(50) DEFAULT NULL,
  `activity_reviews` tinyint(1) DEFAULT 1,
  `unenrollment` tinyint(1) NOT NULL DEFAULT 1,
  `quiz_type` enum('Servey','Quiz') DEFAULT NULL,
  `category_id` varchar(20) DEFAULT NULL,
  `certificate_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `ilt_enrollment_id` bigint(20) DEFAULT NULL,
  `training_status_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_training_library`
--

INSERT INTO `lms_training_library` (`training_id`, `training_type_id`, `training_name`, `training_code`, `reference_code`, `description`, `content_type`, `image_id`, `credits`, `credits_visible`, `points`, `points_visible`, `enrollment_type`, `activity_reviews`, `unenrollment`, `quiz_type`, `category_id`, `certificate_id`, `is_active`, `ilt_enrollment_id`, `training_status_id`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 1, 'PHP', '110001', '789', 'PHP', 1, 2, 0.99, 1, 18, 1, NULL, 1, 1, NULL, '', 1, 1, NULL, 1, 1, '2023-02-15 07:54:47', 1, '2023-04-27 11:44:29', '2023-04-27 11:44:53'),
(2, 1, 'PHP', '110002', '789', 'PHP', 1, 3, 0.99, 1, 18, 1, NULL, 1, 1, NULL, '', 1, 1, NULL, 1, 1, '2023-02-15 07:54:54', 1, '2023-04-27 11:44:29', '2023-04-27 11:44:57'),
(3, 1, 'PHP', '110003', '789', 'PHP', 1, 4, 1233.67, 1, 18, 1, NULL, 1, 1, NULL, '3', 1, 1, NULL, 1, 1, '2023-02-15 07:55:12', 1, '2023-04-26 07:58:34', '2023-04-27 06:57:18');

-- --------------------------------------------------------

--
-- Table structure for table `lms_training_media`
--

CREATE TABLE `lms_training_media` (
  `training_media_id` bigint(20) NOT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `media_id` bigint(20) DEFAULT NULL,
  `passing_score` int(11) DEFAULT NULL,
  `ssl_on_off` tinyint(1) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_training_media`
--

INSERT INTO `lms_training_media` (`training_media_id`, `training_id`, `media_id`, `passing_score`, `ssl_on_off`, `is_active`) VALUES
(1, 1, 1, NULL, 0, 1),
(2, 1, 2, NULL, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_training_notifications`
--

CREATE TABLE `lms_training_notifications` (
  `training_notification_id` bigint(20) NOT NULL,
  `notification_name` varchar(150) DEFAULT NULL,
  `notification_type` varchar(150) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_training_notifications`
--

INSERT INTO `lms_training_notifications` (`training_notification_id`, `notification_name`, `notification_type`, `is_active`) VALUES
(1, 'Send message to users when properties are updated.', 'User Notifications', 1),
(2, 'Notify Users of enrollment status changes.', 'User Notifications', 1),
(3, 'Send enrolled users reminder email the day before each class.', 'User Notifications', 1),
(4, 'Send enrolled users reminder email the day before virtual class.', 'User Notifications', 1),
(5, 'Require supervisor approval for this course.', 'Supervisor Notifications', 1),
(6, 'Notify supervisor at enrollment.', 'Supervisor Notifications', 1),
(7, 'Notify supervisor at completion.', 'Supervisor Notifications', 1),
(8, 'User enrolled in a class.', 'Instructor Notifications', 1),
(9, 'User Dropped a class.', 'Instructor Notifications', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lms_training_notifications_settings`
--

CREATE TABLE `lms_training_notifications_settings` (
  `training_notification_setting_id` bigint(20) NOT NULL,
  `training_notification_id` bigint(20) DEFAULT NULL,
  `training_id` bigint(20) DEFAULT NULL,
  `notification_on` tinyint(1) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_training_status`
--

CREATE TABLE `lms_training_status` (
  `training_status_id` bigint(20) NOT NULL,
  `training_status` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_training_status`
--

INSERT INTO `lms_training_status` (`training_status_id`, `training_status`) VALUES
(1, 'Draft'),
(2, 'Published'),
(3, 'Unpublished'),
(4, 'Archived'),
(5, 'Deleted');

-- --------------------------------------------------------

--
-- Table structure for table `lms_training_types`
--

CREATE TABLE `lms_training_types` (
  `training_type_id` bigint(20) NOT NULL,
  `training_type` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_training_types`
--

INSERT INTO `lms_training_types` (`training_type_id`, `training_type`) VALUES
(1, 'eLearning'),
(2, 'Classroom'),
(3, 'Assessments');

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_category`
--

CREATE TABLE `lms_user_category` (
  `user_category_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_group`
--

CREATE TABLE `lms_user_group` (
  `user_group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_user_group`
--

INSERT INTO `lms_user_group` (`user_group_id`, `user_id`, `group_id`, `org_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 77, 1, 1, 0, NULL, NULL, NULL, '2023-04-27 08:33:44', '2023-04-27 08:33:44');

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_login`
--

CREATE TABLE `lms_user_login` (
  `login_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `domain_id` bigint(20) DEFAULT NULL,
  `user_name` varchar(48) DEFAULT NULL,
  `user_password` varchar(128) DEFAULT NULL,
  `password_date` datetime NOT NULL,
  `login_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `login_non_locked` tinyint(1) NOT NULL DEFAULT 1,
  `login_non_expired` tinyint(1) NOT NULL DEFAULT 1,
  `ip_restrictions` varchar(512) DEFAULT NULL,
  `ip_address` varchar(255) DEFAULT NULL,
  `mac_address` varchar(255) DEFAULT NULL,
  `session_id` varchar(255) DEFAULT NULL,
  `last_login_date` datetime DEFAULT NULL,
  `failed_login_attempts` int(11) NOT NULL DEFAULT 0,
  `last_failed_login_date` datetime DEFAULT NULL,
  `authentication_phone` varchar(24) DEFAULT NULL,
  `authentication_email` varchar(256) DEFAULT NULL,
  `authenticator_secret` varchar(16) DEFAULT NULL,
  `previous_password_1` varchar(128) DEFAULT NULL,
  `previous_password_2` varchar(128) DEFAULT NULL,
  `previous_password_3` varchar(128) DEFAULT NULL,
  `previous_password_4` varchar(128) DEFAULT NULL,
  `password_reset_code` varchar(48) DEFAULT NULL,
  `password_reset_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_user_login`
--

INSERT INTO `lms_user_login` (`login_id`, `user_id`, `org_id`, `domain_id`, `user_name`, `user_password`, `password_date`, `login_enabled`, `login_non_locked`, `login_non_expired`, `ip_restrictions`, `ip_address`, `mac_address`, `session_id`, `last_login_date`, `failed_login_attempts`, `last_failed_login_date`, `authentication_phone`, `authentication_email`, `authenticator_secret`, `previous_password_1`, `previous_password_2`, `previous_password_3`, `previous_password_4`, `password_reset_code`, `password_reset_date`) VALUES
(1, 1, 1, 1, 'dev', 'MTIzNDU2Nzg=', '2022-04-08 05:50:31', 1, 1, 1, '127.0.0.1', '127.0.0.1', 'A4-6B-B6-08-D7-6B', '60fnykrcvuZtUqW9GNd9ouqpqxdVYwhL0etkZeoD', '2023-04-25 04:41:10', 0, NULL, '8234453342', 'dev@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(2, 2, 2, 2, 'dev1', 'MTIzNDU2Nzg=', '0000-00-00 00:00:00', 1, 1, 1, NULL, '127.0.0.1', 'A4-6B-B6-08-D7-6B', '6Gl2oU6zaeW1wGYRqH03qeDtG5MXdLLGRq9LrUZa', '2023-02-09 08:03:50', 0, NULL, '1234567898', 'dev1@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(3, 3, 3, 3, 'dev2', 'MTIzNDU2Nzg=', '0000-00-00 00:00:00', 1, 1, 1, NULL, '127.0.0.1', 'A4-6B-B6-08-D7-6B', '1NDvcUVZqWL9f0ipK3waKIXChNy5r2amaiVAhKNV', '2023-02-09 08:03:55', 0, NULL, '1234567898', 'dev2@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(4, 4, 4, 4, 'dev3', 'MTIzNDU2Nzg=', '0000-00-00 00:00:00', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, '1234567898', 'dev3@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(5, 5, 5, 5, 'dev4', 'MTIzNDU2Nzg=', '0000-00-00 00:00:00', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, '1234567898', 'dev4@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(6, 6, 6, 6, 'dev5', 'MTIzNDU2Nzg=', '0000-00-00 00:00:00', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, '1234567898', 'dev5@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(7, 7, 7, 7, 'frontend', 'MTIzNDU2Nzg=', '0000-00-00 00:00:00', 1, 1, 1, NULL, NULL, NULL, NULL, NULL, 0, NULL, '1234567898', 'frontend@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL),
(8, 8, 8, 8, 'elitelms', 'MTIzNDU2Nzg=', '0000-00-00 00:00:00', 1, 1, 1, NULL, '127.0.0.1', 'A4-6B-B6-08-D7-6B', 'ysiclMgaZ5IGvtqlVV0qR6dDPnKQ8pBqgh3Ox0bB', '2023-02-09 08:04:28', 0, NULL, '1234567898', 'elitelms@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_master`
--

CREATE TABLE `lms_user_master` (
  `user_id` bigint(20) NOT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `user_guid` char(36) NOT NULL,
  `first_name` varchar(32) DEFAULT NULL,
  `last_name` varchar(32) DEFAULT NULL,
  `email_id` varchar(256) DEFAULT NULL,
  `phone_number` varchar(24) DEFAULT NULL,
  `job_title` varchar(64) DEFAULT NULL,
  `divisions` varchar(64) DEFAULT NULL,
  `area` varchar(64) DEFAULT NULL,
  `location` varchar(64) DEFAULT NULL,
  `barcode` varchar(100) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_user_master`
--

INSERT INTO `lms_user_master` (`user_id`, `org_id`, `role_id`, `user_guid`, `first_name`, `last_name`, `email_id`, `phone_number`, `job_title`, `divisions`, `area`, `location`, `barcode`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 1, 1, '111221', 'Dev', 'Infipre', 'dev@gmail.com', '8234453342', '1', '1', '1', '1', '65756', 1, NULL, '2022-04-08 05:50:31', 1, '2023-01-14 16:47:12', '2023-02-13 15:30:13'),
(2, 2, 1, '111222', 'Dev1', 'Infipre', 'dev1@gmail.com', '1234567898', NULL, NULL, NULL, NULL, NULL, 1, 1, '2023-01-04 17:20:28', 1, '2023-02-27 08:32:45', '2023-02-27 08:37:24'),
(3, 3, 1, '111223', 'Dev2', 'Infipre', 'dev2@gmail.com', '1234567898', NULL, NULL, NULL, NULL, NULL, 1, 1, '2023-01-04 17:24:29', 1, '2023-02-27 08:37:11', '2023-02-27 08:37:11'),
(4, 4, 1, '111224', 'Dev3', 'Infipre', 'dev3@gmail.com', '1234567898', NULL, NULL, NULL, NULL, NULL, 1, 1, '2023-01-04 17:25:34', 1, '2023-01-04 17:25:34', '2023-01-04 11:55:56'),
(5, 5, 1, '111225', 'Dev4', 'Infipre', 'dev4@gmail.com', '1234567898', NULL, NULL, NULL, NULL, NULL, 1, 1, '2023-01-04 17:26:20', 1, '2023-01-14 17:19:29', '2023-02-09 08:00:02'),
(6, 6, 1, '111226', 'Dev5', 'Infipre', 'dev5@gmail.com', '1234567898', NULL, NULL, NULL, NULL, NULL, 1, 1, '2023-01-04 17:26:43', 1, '2023-01-04 17:26:43', '2023-01-04 11:58:42'),
(7, 7, 1, '111227', 'Frontend', 'Infipre', 'frontend@gmail.com', '1234567898', NULL, NULL, NULL, NULL, NULL, 1, 1, '2023-01-04 17:26:43', 1, '2023-01-04 17:26:43', '2023-01-04 11:58:42'),
(8, 8, 1, '111228', 'Elitelms', 'Infipre', 'elitelms@gmail.com', '1234567898', NULL, NULL, NULL, NULL, NULL, 1, 1, '2023-01-04 17:20:28', 1, '2023-01-14 17:31:41', '2023-02-09 07:59:58'),
(77, 1, 3, '111229', 'Richa ', 'Gaonkar', 'riccha@elitelms.com', '9090909090', 'Code Ignitor', 'code ', 'Marschelle', 'Saquelim', '403609', 1, 1, '2023-03-07 04:40:45', 1, '2023-04-19 05:54:42', '2023-04-19 05:54:42'),
(78, 1, 5, '111230', 'Raunak', 'Srivasta', 'raunak@elitelms.com', '1234567890', 'PHP Developer', 'wertf', 'Belgaum', 'Bangalore', '40307', 1, 1, '2023-03-07 04:40:45', 1, '2023-03-07 04:40:45', '2023-04-19 05:11:05');

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_media`
--

CREATE TABLE `lms_user_media` (
  `user_media_id` bigint(20) NOT NULL,
  `media_name` varchar(64) NOT NULL,
  `media_size` varchar(64) NOT NULL,
  `media_type` varchar(64) NOT NULL,
  `media_url` varchar(256) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `user_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_notification`
--

CREATE TABLE `lms_user_notification` (
  `user_notification_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `notification_id` bigint(20) DEFAULT NULL,
  `notification_type` enum('0','1') NOT NULL DEFAULT '1',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_notification_assignment`
--

CREATE TABLE `lms_user_notification_assignment` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `notification_id` int(11) DEFAULT NULL,
  `org_id` int(11) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_id` int(11) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` int(11) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_org_group`
--

CREATE TABLE `lms_user_org_group` (
  `user_group_id` bigint(20) NOT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `group_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lms_user_org_group`
--

INSERT INTO `lms_user_org_group` (`user_group_id`, `user_id`, `group_id`, `org_id`, `is_active`, `created_id`, `date_created`, `modified_id`, `date_modified`, `on_update_date_modified`) VALUES
(1, 77, 1, 1, 1, NULL, NULL, NULL, NULL, '2023-04-18 10:10:31'),
(2, 77, 2, 1, 1, NULL, NULL, NULL, NULL, '2023-04-18 10:10:44');

-- --------------------------------------------------------

--
-- Table structure for table `lms_user_requirement_courses`
--

CREATE TABLE `lms_user_requirement_courses` (
  `user_requirement_course_id` bigint(20) NOT NULL,
  `org_training_id` bigint(20) DEFAULT NULL,
  `org_assign_training_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `org_id` bigint(20) DEFAULT NULL,
  `role_id` bigint(20) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_id` bigint(20) DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `modified_id` bigint(20) DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  `on_update_date_modified` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('05c308bae190c50327cc3a028073754dc10a4f9a1306c21e00f622d2a6335080eff624604ad3546a', 1, 11, 'PassportLMS', '[]', 0, '2023-03-14 00:41:25', '2023-03-14 00:41:25', '2024-03-14 06:11:25'),
('0a116d8e3263015c2c8bdd758a19449ca50ea981c8d7c7af771f5d0e460e4048eacbe5ecd6f5894e', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 05:56:12', '2023-01-13 05:56:13', '2024-01-13 11:26:12'),
('0b9c0117445e4c8b068a999f87ee16fd698e85658116b440be0fb765ab0fde58d5b6618742635459', 1, 11, 'PassportLMS', '[]', 0, '2023-02-28 02:07:12', '2023-02-28 02:07:12', '2024-02-28 07:37:12'),
('0c0d48e681620e79fb41fa3b5fd0c377cf76ac2fc05efc451d09af72b27c2a95a2f44889531a2582', 1, 11, 'PassportLMS', '[]', 0, '2023-02-14 01:15:28', '2023-02-14 01:15:28', '2024-02-14 06:45:28'),
('0c3ddfd8f49178a3e104db8e8a3407d82b0158e2f94981ee81b18386cc99358a0110d445ed89c455', 1, 7, 'PassportLMS', '[]', 0, '2023-01-03 23:09:19', '2023-01-03 23:09:19', '2024-01-04 04:39:19'),
('0d55cb38dc72e4d373f49999d37c9a7c7bd8eff6a7b131be8d84ace1aab88721dd71e4b7b10a3369', 1, 9, 'PassportLMS', '[]', 0, '2023-01-17 03:28:39', '2023-01-17 03:28:39', '2024-01-17 08:58:39'),
('10af0c12ccb18b7c467d53e85419f5d332daa69b3342f7323d1b6782381ca77c21fd84b036088b07', 1, 9, 'PassportLMS', '[]', 0, '2023-01-19 01:40:50', '2023-01-19 01:40:50', '2024-01-19 07:10:50'),
('13d1677a73a8b0204ea670e784de79b501686e47daa948f1af1cdcc77ee2976857eece52489db6af', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:06:48', '2023-01-02 23:06:48', '2024-01-03 04:36:48'),
('15e513797af52adfd0baa9bde7a9c67e0ada0dd3546f9cabe3aa92fca315272a032813621164efe3', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 14:33:11', '2022-12-27 14:33:11', '2023-12-27 14:33:11'),
('190d7a33587fcaee27a8caab8e8058861b38d7a1d39c2c00dfe13f3d8479c73c88d04c3a95f5299f', 1, 11, 'PassportLMS', '[]', 0, '2023-04-05 05:46:58', '2023-04-05 05:46:58', '2024-04-05 11:16:58'),
('1b9ebf03810bb7226c5b6afed3b3bec4724d0b5fb38569235f18b6ae917dd90dadb7b4c4bd3127d9', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 05:59:26', '2023-01-13 05:59:26', '2024-01-13 11:29:26'),
('1cb14f1b73c205f31ddf7554c4d485e639520d5a7a9ac68ae3a05ce086437a3b5333df5b839196bb', 3, 7, 'PassportLMS', '[]', 0, '2022-12-30 04:57:32', '2022-12-30 04:57:32', '2023-12-30 04:57:32'),
('1d13098be57a372f1bc731fdb40b5dc6f3b13259a2ae19fa86305e93289230a7ad38b86ade807005', 1, 11, 'PassportLMS', '[]', 0, '2023-02-26 23:16:42', '2023-02-26 23:16:42', '2024-02-27 04:46:42'),
('1d22112233185b6edaa5716d0742001b063adb6a7778a44bab9b1f6423aac23a0457ba772cba6dd5', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 05:59:08', '2023-01-13 05:59:08', '2024-01-13 11:29:08'),
('1d9cfe827213d1f39ca176cdd7cc83c8512596ad9826d8a7880bc2872682fd67bc45b6968760b60a', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:05:20', '2023-01-02 23:05:20', '2024-01-03 04:35:20'),
('1ef1353fb7fe0f7e1c8b6a6404bb55510ddb6128e4fc7f9aac91872d6fdbb0700277c79e4cd39e11', 1, 11, 'PassportLMS', '[]', 0, '2023-03-06 23:09:53', '2023-03-06 23:09:53', '2024-03-07 04:39:53'),
('1f1f4b1ff8f62a92eee5196864edad40b249d50a2a320d13a71d815d65daba558e7995b31e1e4a2a', 1, 11, 'PassportLMS', '[]', 0, '2023-03-27 07:04:34', '2023-03-27 07:04:35', '2024-03-27 12:34:34'),
('2080e0c948b47bb5f0279f0d931d8a0936c862edc13667717c3e1fb545db5a53d8635527702411d5', 1, 7, 'PassportLMS', '[]', 0, '2022-12-30 10:16:28', '2022-12-30 10:16:29', '2023-12-30 10:16:28'),
('212462da8f92921da674886ba8ce7dc76d31183664e9e22eafa082f4d2aa6b54d8e39d3e886e7542', 2, 7, 'PassportLMS', '[]', 0, '2022-12-27 13:57:12', '2022-12-27 13:57:12', '2023-12-27 13:57:12'),
('2364e8b3e11b41a802d7bc54712233d5a68f2595d2d88319c7c0e9efbbcf787aff667325591cc348', 2, 7, 'PassportLMS', '[]', 0, '2023-01-04 12:00:55', '2023-01-04 12:00:56', '2024-01-04 17:30:55'),
('24870929cb5027a58029d6bbb94b473b9f00009059ed6f66d7a22563852d70aea4ecf95dca651100', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 07:44:38', '2023-01-02 07:44:38', '2024-01-02 07:44:38'),
('25ea29a84d08e70caf1d44447aaec68af30b06613e7e5ddd8213e78259a4a788be82442a90012493', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 08:13:37', '2023-01-16 08:13:37', '2024-01-16 13:43:37'),
('2aab06705f6050e3f6380d46d6c4381b12464f36df06bd1273514322429b9e686a09f068b3ee678c', 1, 9, 'PassportLMS', '[]', 0, '2023-01-29 22:49:11', '2023-01-29 22:49:11', '2024-01-30 04:19:11'),
('2b097366595738157008b85b87d04ae2ae7838e64332de13024e49414f84c4b7272dbb7dee5f8b57', 2, 7, 'PassportLMS', '[]', 0, '2022-12-30 04:40:51', '2022-12-30 04:40:51', '2023-12-30 04:40:51'),
('2d5a875cd11eb4d77d8ddf577ef8df1b44bee001e5ec8d8946ec4cda66584e09146d21c1c4ad2d23', 1, 11, 'PassportLMS', '[]', 0, '2023-02-19 23:55:07', '2023-02-19 23:55:07', '2024-02-20 05:25:07'),
('30fc366da5adbd879f066b0713f0703eadcad13bcba6782a6c04489b0b1aa4d3cd808604b80d7856', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 06:01:34', '2023-01-13 06:01:34', '2024-01-13 11:31:34'),
('320cf1f66e1904549a448e188ab2450cdba37daf006b31ca7ce3220c65f43db6339f3757861ad01e', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 10:15:10', '2022-12-27 10:15:10', '2023-12-27 10:15:10'),
('32d12e8ba8ea830b7fbe32c28902523bb5683bb5b997e38422a6ad95832425f51f984a7aa5bba94e', 1, 11, 'PassportLMS', '[]', 0, '2023-04-21 05:58:50', '2023-04-21 05:58:51', '2024-04-21 11:28:50'),
('33f452c84b5e0d056bb78003c221501b1ef64e6d7e4aa73746e5a623ef46b2b34fed236586072055', 2, 7, 'PassportLMS', '[]', 0, '2022-12-31 07:44:39', '2022-12-31 07:44:39', '2023-12-31 07:44:39'),
('357f8c59ac4aa3a7ffb7a97fd5be8bf5050280cefafa91673530bfd792ac85e809bbcf69497098f5', 1, 9, 'PassportLMS', '[]', 0, '2023-02-05 23:26:09', '2023-02-05 23:26:09', '2024-02-06 04:56:09'),
('35884b43b2fa36a4d943f43a106b9e1bc2ee941a95dbecc262aa35b52d9292070761788fd67ccb23', 1, 11, 'PassportLMS', '[]', 0, '2023-02-13 07:18:32', '2023-02-13 07:18:32', '2024-02-13 12:48:32'),
('36148a13a9a7745da3ee43a2b8951d665cdd46ddcd936ddf9e158527e832be39a2bb63a6e89b5b5e', 4, 3, 'PassportLMS', '[]', 0, '2022-12-20 15:48:30', '2022-12-20 15:48:30', '2023-12-20 15:48:30'),
('36e011472b2115f09de29dcfea31168935823cac9365c0372eb1e7474b7de57043e0e72ab2626bc1', 1, 11, 'PassportLMS', '[]', 0, '2023-04-06 01:20:27', '2023-04-06 01:20:27', '2024-04-06 06:50:27'),
('3875a4516f5166fe6819b31e068f61c73428ad6d153e6fa8fed02ae75ac7e09f1402972d9a7dab52', 1, 7, 'PassportLMS', '[]', 0, '2022-12-30 05:20:55', '2022-12-30 05:20:55', '2023-12-30 05:20:55'),
('3948bfb3d27537504b7a3fd062f234036b336de61e76af22a1d616e8ef8bb69cdd9d72f0613d4810', 2, 7, 'PassportLMS', '[]', 0, '2023-01-03 03:56:39', '2023-01-03 03:56:40', '2024-01-03 09:26:39'),
('3afc6e39dae379f535692add848332cb51aee9dce735f10c7e2b450ab712586753e5aaa079dfb3ec', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 04:32:57', '2023-01-16 04:32:57', '2024-01-16 10:02:57'),
('3b5c48d53f1b1a8ed7c0112bd43f7f978e496602cb0b9c29bb1ec2651db5f3c7c8bf288a3eefcbc5', 2, 7, 'PassportLMS', '[]', 0, '2023-01-03 05:54:36', '2023-01-03 05:54:36', '2024-01-03 11:24:36'),
('3b5d4b1a86f01a38b6009e43b8d7e0df33411b04d742d9960f6001bf95a9d066f6b71df16c7b8998', 1, 11, 'PassportLMS', '[]', 0, '2023-03-02 01:11:09', '2023-03-02 01:11:09', '2024-03-02 06:41:09'),
('3d1aaeeff2f912e35a45a4a33ebeaf3342cb2751fc86677807828d70fbba038a8c8b9cc1692c32b8', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 05:06:12', '2023-01-16 05:06:12', '2024-01-16 10:36:12'),
('3e5e962696273e29aed42ddd42992add779e587a7d3ea4de9d14d3e0f104dc280660e8af29b567f0', 1, 11, 'PassportLMS', '[]', 0, '2023-03-16 05:18:28', '2023-03-16 05:18:28', '2024-03-16 10:48:28'),
('3fc063b07b28121757010c9d2bd89cfb591176d7c12563a4fec45761ab0388b0d71d5bb81b748f33', 1, 11, 'PassportLMS', '[]', 0, '2023-04-18 01:03:40', '2023-04-18 01:03:40', '2024-04-18 06:33:40'),
('41b6a9ba45b3a4f90c8a57f1cc757900552cf3614a700ebe2e800ba99504b6ae7f0211b8779492f2', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 06:03:52', '2023-01-13 06:03:52', '2024-01-13 11:33:52'),
('43de33f970e2320021897ff7784e0f7bc16c200a9e8f0b3a5fe8159d2a19a1a838314d9c385af9d2', 1, 11, 'PassportLMS', '[]', 0, '2023-03-20 02:41:43', '2023-03-20 02:41:43', '2024-03-20 08:11:43'),
('47f4f59bed545ce21c14f5492e28d36c01bdee8bed73585adc8e8c71dff95f5e88c21f12c48f598f', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:04:21', '2023-01-02 23:04:22', '2024-01-03 04:34:21'),
('48683a87881e8a05b57755416153a587dcb42bd4611cfa464ef3697ba6d7e81403aa8d6111f84c9a', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 06:04:20', '2023-01-13 06:04:20', '2024-01-13 11:34:20'),
('497fbc16821f80e80498295034d97ac4efb49d92e4a33a796118e60cfeb0212f7b329eeffae015ab', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:06:06', '2023-01-02 23:06:06', '2024-01-03 04:36:06'),
('4a10ae8eb193183527c615e429222d9c526da6c526003fcb480e6bc112805736280a912013e86ed7', 1, 7, 'PassportLMS', '[]', 0, '2023-01-16 00:07:39', '2023-01-16 00:07:39', '2024-01-16 05:37:39'),
('4ba08eccf9e8213bd734a23ff4a5bd18645c9f4b83e61e2065374fb44c28554fe1c32af360a1a781', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 15:29:36', '2022-12-27 15:29:36', '2023-12-27 15:29:36'),
('4c0c60e0c8aa56f337b44168b2feadfcd4db469c8124353f27d6dcb40d45a991ab4e58e77b567f2f', 46, 3, 'PassportLMS', '[]', 0, '2022-12-20 15:04:13', '2022-12-20 15:04:13', '2023-12-20 15:04:13'),
('4c3fb575d177558601dec1c30a612c60fde400a713cbfbf33947c250bc73d69a37c26bebda59c5aa', 1, 11, 'PassportLMS', '[]', 0, '2023-02-07 06:39:36', '2023-02-07 06:39:37', '2024-02-07 12:09:36'),
('4c972c9e1407bcbb5ac3801e4ddc506294541eacf1a50559be50e855d84eec2ce154fe9810349b61', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 04:34:42', '2022-12-27 04:34:42', '2023-12-27 04:34:42'),
('4f8608faf1485bc849eec4ca75bce1ad876c02976f40d3bc63e573e2746dee7023d7863b6cbfdb55', 1, 7, 'PassportLMS', '[]', 0, '2022-12-28 09:25:02', '2022-12-28 09:25:02', '2023-12-28 09:25:02'),
('506e228b82889f6d1b6d6f981cacbd4936cbe1ed297d935467ffe52224e7b249408cfb61e1cefaf8', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 10:11:53', '2023-01-13 10:11:53', '2024-01-13 15:41:53'),
('507b6cb25773c3c8e8e6fb2a661b51c74d7a3738ae205dcc52168ad3ab7003f7da24f26e0129f62d', 1, 7, 'PassportLMS', '[]', 0, '2022-12-26 16:53:29', '2022-12-26 16:53:29', '2023-12-26 16:53:29'),
('5092855db35b6dd6b1e28c45cf4e345ca3a2d608a9270a2a00875785f7cc94ec49dae7e2d2014fc2', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 04:35:20', '2023-01-16 04:35:20', '2024-01-16 10:05:20'),
('52f11974e4a804ceed4e5586f01e1c6f98d885dae719c217feae593a649f38d222c0d756bd4827c7', 1, 11, 'PassportLMS', '[]', 0, '2023-02-26 23:09:42', '2023-02-26 23:09:42', '2024-02-27 04:39:42'),
('53506806b33f9a735b970af5e62ad1d9288888882f23be013e5c17a212eb24e3276f6b207deb8dd6', 1, 7, 'PassportLMS', '[]', 0, '2023-01-02 07:35:22', '2023-01-02 07:35:22', '2024-01-02 07:35:22'),
('5549155ea4a640216f9bb8a574e33bd536e658547c3073c14b0aaa127c03819592441aa86f49f199', 1, 11, 'PassportLMS', '[]', 0, '2023-03-20 22:35:16', '2023-03-20 22:35:17', '2024-03-21 04:05:16'),
('59d22fdc86c96e7d310ffb6bf1ffafc6d8b0b3f1cb9a1ed186f867663e7a398c21b3d64ee73123da', 2, 7, 'PassportLMS', '[]', 0, '2022-12-30 04:57:33', '2022-12-30 04:57:34', '2023-12-30 04:57:33'),
('5b8f2879d55987c9bfa2613887ef027f92904b35bd0711a224bb4971d4528c8b7a04267365c9be83', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 15:32:13', '2022-12-27 15:32:13', '2023-12-27 15:32:13'),
('5c1491b5525332045b7cae79cf5420d82effb0637bb807551c0b709b62f43fd994eb6df862edf7f7', 2, 7, 'PassportLMS', '[]', 0, '2023-01-03 05:52:30', '2023-01-03 05:52:30', '2024-01-03 11:22:30'),
('5dd9d2342bdd049ed76d2b5f5658fa23fce40c799c758ed7439dfe257ed207249ca7f52e556bd051', 1, 11, 'PassportLMS', '[]', 0, '2023-04-24 23:11:10', '2023-04-24 23:11:10', '2024-04-25 04:41:10'),
('61b14c4c5f6afaee96c091c3301cf3bf948bedf8177ec8a20174163232dfccecac9613c2a3bf3a68', 2, 7, 'PassportLMS', '[]', 0, '2023-01-03 03:57:52', '2023-01-03 03:57:52', '2024-01-03 09:27:52'),
('61fef9bab86dfc3dba6253ada12446f265997024e241feca1a43e10e8018d32afe24dbe7928bc492', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 08:06:10', '2023-01-16 08:06:10', '2024-01-16 13:36:10'),
('6379f20c733f475ae5a79c3d15aadb5bcb778be8ddcc9be8600ac7e12e265a2a292c3b44885d039d', 1, 11, 'PassportLMS', '[]', 0, '2023-03-03 05:36:03', '2023-03-03 05:36:03', '2024-03-03 11:06:03'),
('6506e9f7e40ac823aa4aa4415783df7541124cf3ad43d9d8877305f160ca2aefb41640157cebe81c', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 05:58:44', '2023-01-13 05:58:44', '2024-01-13 11:28:44'),
('673de299b8357a7eb689236c556ab5e7e8559e1ea6a65aaa47a9ed185195f5217cc8ec4cf3aa1356', 1, 11, 'PassportLMS', '[]', 0, '2023-02-09 02:33:44', '2023-02-09 02:33:44', '2024-02-09 08:03:44'),
('6d0329081aea24e0377e4b4aefd15125e304ca86976ead1464d9d1af884fa98ed4fb483cab9eb32b', 1, 11, 'PassportLMS', '[]', 0, '2023-03-29 00:03:57', '2023-03-29 00:03:57', '2024-03-29 05:33:57'),
('6f9783ba7e829b6a4414675af4569e4d86b68fa712d01e7f0f46cbd833754fa3dcedcc8e65a486c7', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 07:07:11', '2023-01-16 07:07:11', '2024-01-16 12:37:11'),
('70957db5e6e566e4d4ba292bb6a8528c9a2ffc02248083fbe6220abc242f94b49e739e4976fa96c5', 2, 3, 'PassportLMS', '[]', 0, '2022-12-24 11:59:28', '2022-12-24 11:59:28', '2023-12-24 11:59:28'),
('71d8e64f1d084991a8ba66cd531b08302220208c14438f4c0987a840ad72798d3d88d2a87bcca99c', 1, 7, 'PassportLMS', '[]', 0, '2023-01-04 07:22:08', '2023-01-04 07:22:08', '2024-01-04 12:52:08'),
('740e6a4ef287a04576077670b06d8890fbdb09e4b1bf4a2167442845a052b8a8cbdc5d4bd149bb55', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 06:27:24', '2023-01-02 06:27:24', '2024-01-02 11:57:24'),
('75bce11db6020915815a6f983990b6709cf8a1824c28d74d3fc8cca2eb69caccf6134b46049a1d64', 4, 7, 'PassportLMS', '[]', 0, '2022-12-30 05:23:10', '2022-12-30 05:23:10', '2023-12-30 05:23:10'),
('7ebcb545f270b502cbe2c7f34995a13fbe1bbe103788a3cd2d634c01efa01500e082a5966678a1a3', 1, 11, 'PassportLMS', '[]', 0, '2023-02-07 01:39:54', '2023-02-07 01:39:54', '2024-02-07 07:09:54'),
('7f17b6773aa722a3dfe0fc465b90783161a4feeb271792a3885dfbf2adf106814af2a5f367bbc29e', 2, 7, 'PassportLMS', '[]', 0, '2022-12-29 09:40:49', '2022-12-29 09:40:49', '2023-12-29 09:40:49'),
('7f42ec972a158649c586aeebb925498b22a305d92cb12079a2ecf6bcd88c2cbccb32bde19dac55cd', 1, 7, 'PassportLMS', '[]', 0, '2022-12-29 09:39:34', '2022-12-29 09:39:34', '2023-12-29 09:39:34'),
('8176a662190ef0d0aa66856b01f9921d504b8697f988febf1f59498b0aefcbdde683ff1713abda74', 2, 7, 'PassportLMS', '[]', 0, '2023-01-03 03:57:09', '2023-01-03 03:57:09', '2024-01-03 09:27:09'),
('8819066e72e868531f6425561b7fa69546134e3a35aba0b901c13da2374454f310567102f61f5011', 1, 11, 'PassportLMS', '[]', 0, '2023-04-11 23:12:06', '2023-04-11 23:12:06', '2024-04-12 04:42:06'),
('89289e7c7c65269ce87e77a7219cbae997864b3d34b2e9287a067689396a70603e3f46c993336d7e', 1, 11, 'PassportLMS', '[]', 0, '2023-02-07 00:42:11', '2023-02-07 00:42:11', '2024-02-07 06:12:11'),
('8b7d370b7f58be892fd55495552b3739f33b59a81ff52c805d0ee7441da002a6ae5262a64bef86c9', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:05:48', '2023-01-02 23:05:48', '2024-01-03 04:35:48'),
('8bd087122a8fa0f6c9a4e5ce114a2f3f5d1e3d64ade54449eae26e29523039c014cf537117b4522a', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 10:15:41', '2022-12-27 10:15:41', '2023-12-27 10:15:41'),
('8cb77df78dd9cc7bcb79786dfdb3f2c76bf37d496c7fbde02dee7cc175d55ada55362d886f102037', 1, 11, 'PassportLMS', '[]', 0, '2023-02-17 06:00:37', '2023-02-17 06:00:37', '2024-02-17 11:30:37'),
('91fc89335cb3f41fde5a42e4155016f58370b2654e907566bc518651c9934b38fc27d442a13479d6', 2, 11, 'PassportLMS', '[]', 0, '2023-02-09 02:33:49', '2023-02-09 02:33:49', '2024-02-09 08:03:49'),
('93260773b1540cc815a4bfe5a7da1f4ab5980d15fc6720606566ac97e0fbac01c0c5936a19269294', 3, 3, 'PassportLMS', '[]', 0, '2022-12-21 06:01:47', '2022-12-21 06:01:47', '2023-12-21 06:01:47'),
('939dd0f593e5770e6c2f3ecc8540d2cda577b7a6e63923cd397646285bd4e8a433dd41936fbfdaab', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:05:03', '2023-01-02 23:05:03', '2024-01-03 04:35:03'),
('986264bdbcbb74e1d84a180e2c74219f8a82dc64f970ba6138d9507681e4b84d1a03375db3dac4d5', 1, 11, 'PassportLMS', '[]', 0, '2023-02-13 22:24:25', '2023-02-13 22:24:25', '2024-02-14 03:54:25'),
('9915ffa2603fa14bcdc07c471666ec086f3516feb2286b88cae349b27d8947ef056451b98e41ebbe', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 05:27:44', '2022-12-27 05:27:44', '2023-12-27 05:27:44'),
('9d92d2647c8c86854882f41ca474487fa3638d3a661bc3a1281a347dc86c33a9b16427601b95793a', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 05:58:30', '2023-01-13 05:58:30', '2024-01-13 11:28:30'),
('a07f6aabdbe37b2fc831474e859bc2b2ca184cc95101776d7f9b84c9f1e9833a7859068c1e292f00', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 06:00:30', '2023-01-13 06:00:30', '2024-01-13 11:30:30'),
('a094fe42e93f48ab6456fe65a4631a8f2037e35f5a67ab087779dacc020e3103c03805ffad73b213', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 05:08:04', '2023-01-16 05:08:04', '2024-01-16 10:38:04'),
('a14a93250516d1eb95faf246feca3c7f1475b6426d79534d662ee7907c72266e0e71c3e5e83d9efc', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 06:02:38', '2022-12-27 06:02:38', '2023-12-27 06:02:38'),
('a215c32e4628bf2e5e51a1eb084c3977379009c27b4ca0bf6603c79aa66a337bc5f8a3ea405b8145', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 10:47:32', '2022-12-27 10:47:32', '2023-12-27 10:47:32'),
('a34456d55c11adee61a62bc6d92cb8f1359166dadb00c427663bdf6a0fbccb24a6ea70ccd66f9362', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 07:06:28', '2023-01-16 07:06:28', '2024-01-16 12:36:28'),
('a5f849866c993ad5bdfdbf8d6b597198ff921c45b690611ba014bd73e29c96addeb5c80ba355a07c', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 08:04:08', '2023-01-16 08:04:08', '2024-01-16 13:34:08'),
('a658a28667cf359e9d530d98661752d9955aeac79b69b8af60a1bad257a761fda5eff516a2a75771', 8, 11, 'PassportLMS', '[]', 0, '2023-02-09 02:34:28', '2023-02-09 02:34:28', '2024-02-09 08:04:28'),
('a6b49d0375d14bfb060eee0b5509565f2f2ec94542761894da3c7350b0953302c14d0426eba176fa', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 06:01:00', '2023-01-13 06:01:00', '2024-01-13 11:31:00'),
('a7f6c2a2ca29eb0aed4b6984475b3f4f21a421b7a3f3476c6b5cdccb1ddea5c3834cf686f9b70287', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:05:51', '2023-01-02 23:05:51', '2024-01-03 04:35:51'),
('a9b2da86c946bcb5eba5f672f1702f335ded6520d2cd6bbc28e1abbff0e576324b6dadb213f34c4f', 1, 11, 'PassportLMS', '[]', 0, '2023-04-02 23:58:14', '2023-04-02 23:58:14', '2024-04-03 05:28:14'),
('abdcbe82903501a004d4fb8f303159b21696cf2b1d41862e70c88d610ad1797379e19cc53cbf581a', 1, 7, 'PassportLMS', '[]', 0, '2023-01-09 05:09:54', '2023-01-09 05:09:54', '2024-01-09 10:39:54'),
('ae195839c3f248265b0c19db860d176b6431e2c821e67bc828b1f135bc06d8a501248ed3a83fb3f1', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 05:58:09', '2023-01-13 05:58:09', '2024-01-13 11:28:09'),
('aeac39342d8488159e5718fed9434d2ccc9a30065a9076f311d1da5dbaccb0806adca25cecb42599', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 04:12:30', '2022-12-27 04:12:30', '2023-12-27 04:12:30'),
('af831b1ed5164d8f6c3e007a64f9549e07295fa7158af5a1425078b10325df94d28f1b3562ad060b', 1, 11, 'PassportLMS', '[]', 0, '2023-03-02 01:09:52', '2023-03-02 01:09:53', '2024-03-02 06:39:52'),
('b22cd975335a84fe387290251b1c105d3f334ee8aac4ce963a6d753afb1193dbe599dc34d8eaf675', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:07:22', '2023-01-02 23:07:22', '2024-01-03 04:37:22'),
('b33deff8ce3d1250c4344a77f15bc55e40ac97c9e5c6d068751680eb85e541a2ba66185b116b9193', 1, 7, 'PassportLMS', '[]', 0, '2023-01-14 11:11:44', '2023-01-14 11:11:44', '2024-01-14 16:41:44'),
('b72974de0dbe46971e91a50e5c805ae8f337370a460545f9232f3204d93fff54bdb883f69d25c04f', 1, 11, 'PassportLMS', '[]', 0, '2023-03-24 01:12:46', '2023-03-24 01:12:46', '2024-03-24 06:42:46'),
('b827abe55cdf28b2d85c2a78ba179868615fb0cf88774fb27dd71dea5a8879810621755ce84da832', 2, 7, 'PassportLMS', '[]', 0, '2022-12-27 15:30:03', '2022-12-27 15:30:03', '2023-12-27 15:30:03'),
('baa5ad1ae732cc69a00a9c916a83040432c773226e92e08e83638370e460bc9e2455327f9475c8b3', 1, 11, 'PassportLMS', '[]', 0, '2023-02-07 06:39:41', '2023-02-07 06:39:41', '2024-02-07 12:09:41'),
('be3504650ad2e79257ad769285eaa3812d8f313fa05bd390076f946a32027766fb2c5809a5fb48df', 3, 7, 'PassportLMS', '[]', 0, '2022-12-30 05:16:56', '2022-12-30 05:16:56', '2023-12-30 05:16:56'),
('bf9d685ff20e375f4160f385ae35f3bfaeaf44f90b8edaeb78c12ece1242a6d85c8c49537b3d78a0', 1, 9, 'PassportLMS', '[]', 0, '2023-02-01 05:33:45', '2023-02-01 05:33:45', '2024-02-01 11:03:45'),
('bfe1b9d4238ee976be30968bdd6a7aa96ec6a5a48ac691261e8c8bb5d334edc00fa992934bbdc7d0', 1, 11, 'PassportLMS', '[]', 0, '2023-03-28 01:08:47', '2023-03-28 01:08:47', '2024-03-28 06:38:47'),
('c185f0b4809a8b8cd9ad4c2861f8ba0f87def97a4aad5f94b9f7321c0121d3b33574cce0743bb84b', 1, 9, 'PassportLMS', '[]', 0, '2023-02-06 23:32:42', '2023-02-06 23:32:42', '2024-02-07 05:02:42'),
('c1be09ecbacb587e5b7e9f1d23455379437f5611e0e75594bba7427e72e5beac73f72c6f2de5fc38', 1, 11, 'PassportLMS', '[]', 0, '2023-02-09 02:34:39', '2023-02-09 02:34:39', '2024-02-09 08:04:39'),
('c60cb98e1392da69f2d9a95d86fea6dec053b8f92dfbc6bb2f4c53ed7039e09c238e81d408630741', 2, 7, 'PassportLMS', '[]', 0, '2022-12-30 04:51:33', '2022-12-30 04:51:33', '2023-12-30 04:51:33'),
('c686464caf7813239e8f2a9fdf6a35ddd5abaafb3c51fa25161357dc3cedc489715fe31a73289a95', 1, 11, 'PassportLMS', '[]', 0, '2023-02-19 23:51:11', '2023-02-19 23:51:11', '2024-02-20 05:21:11'),
('c7592143fa8b6e6f146dc15beca21c58ec63c6295e566a3ec20b8d24d9bab778a8aae1d968798f9d', 1, 7, 'PassportLMS', '[]', 0, '2022-12-28 15:13:40', '2022-12-28 15:13:40', '2023-12-28 15:13:40'),
('c77457dff44ec59dc3dc5bfd41c771a942a0e4853539d2c394ea0949880f50a42f1d711eaddd5ddb', 2, 7, 'PassportLMS', '[]', 0, '2022-12-31 08:00:09', '2022-12-31 08:00:09', '2023-12-31 08:00:09'),
('c8830dda126d94f0a2c5a538834abf903615bb094c8769019a1352a9f6e980466f2aeb9b7715bdf7', 1, 11, 'PassportLMS', '[]', 0, '2023-02-14 08:22:28', '2023-02-14 08:22:28', '2024-02-14 13:52:28'),
('ccca533ff1758fad3f032df2d1f56211e0e7d1d69ff81a898a3f242d24aaef90a25bf82171978ead', 1, 11, 'PassportLMS', '[]', 0, '2023-04-03 00:24:37', '2023-04-03 00:24:37', '2024-04-03 05:54:37'),
('cd92b29148547b503a5064a8bc034885507ff9fdadd4e7c5029c938ed66d9468cb90b357a309928f', 2, 7, 'PassportLMS', '[]', 0, '2022-12-31 07:30:25', '2022-12-31 07:30:25', '2023-12-31 07:30:25'),
('ce3bcefea49ab9cbb17b306c3a5a312d1f8aa352d0ef38aeb3d09c0bfd670c66b61274c5484f2ea4', 2, 7, 'PassportLMS', '[]', 0, '2022-12-31 07:56:49', '2022-12-31 07:56:49', '2023-12-31 07:56:49'),
('ce8e2e9e989ef0903ea34ac97de8b1569e3d97fa66a27c6ba8a45059a1e976e67d5b06532d633cd8', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 07:10:44', '2023-01-16 07:10:44', '2024-01-16 12:40:44'),
('cf996d6eaf7846952b9568aa74b92c7b241a8191165a5de4b0769bc9405bfda4593611822dfeeb44', 3, 11, 'PassportLMS', '[]', 0, '2023-02-09 02:33:55', '2023-02-09 02:33:55', '2024-02-09 08:03:55'),
('d734463c8c500e61a88caf05012645dc7e1a75c74d3358326bb33b6ad5a70c0a68c3379f4aedf086', 23, 9, 'PassportLMS', '[]', 0, '2023-01-19 01:36:46', '2023-01-19 01:36:46', '2024-01-19 07:06:46'),
('db1e4dab04d63ad350aceaf7b2144dcee23b985062d6c9db001600be2ada96e4b0f4219d6bb8f347', 1, 7, 'PassportLMS', '[]', 0, '2022-12-28 14:40:58', '2022-12-28 14:40:58', '2023-12-28 14:40:58'),
('dc7d8a5e777831932ee5ac10c1398d65d8bd18c801d4d59dea7f2b7b675cbad6d7cb2e9da3ebbdf8', 5, 7, 'PassportLMS', '[]', 0, '2022-12-30 06:16:47', '2022-12-30 06:16:47', '2023-12-30 06:16:47'),
('dce1fc968f575cd76ac0c7b0eee3d5aa5a41e26798660053faa52742f6c6669733513e8d4afdd41d', 1, 7, 'PassportLMS', '[]', 0, '2022-12-29 03:45:15', '2022-12-29 03:45:15', '2023-12-29 03:45:15'),
('e5f91e348cae9e3bd12379452494db2234ab42acbcd6df962e697d7242c752cc6ac1856c73a70d00', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 04:10:55', '2023-01-16 04:10:55', '2024-01-16 09:40:55'),
('e92ad7cccb46329650d691ca3e596c7be291c3de3f527cc6ef145159f286af961d2a9b421bb27d13', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 05:57:34', '2023-01-13 05:57:34', '2024-01-13 11:27:34'),
('e99a08d8bc911a400272cb1eb436f8833db1dbfedc13c05d00c42f986548cad8d8a38032242c900b', 1, 9, 'PassportLMS', '[]', 0, '2023-01-18 07:04:30', '2023-01-18 07:04:31', '2024-01-18 12:34:30'),
('ecf9df6898d91c274339b9c35feb6fd6139c71cf57b5a5aec7e0d902cf84e332f92ffde0d2289a2a', 1, 11, 'PassportLMS', '[]', 0, '2023-02-17 06:44:12', '2023-02-17 06:44:13', '2024-02-17 12:14:12'),
('f335a6a18598cf492333cff3081159cef708fa1269cdcc725a2e64766c688375ee92954d288de939', 2, 7, 'PassportLMS', '[]', 0, '2022-12-30 04:59:24', '2022-12-30 04:59:24', '2023-12-30 04:59:24'),
('f4fcc583e5b03eaa0c019d75584175b5f905a31de977ca752476eef76b1b8f9734872e2b012554f7', 2, 7, 'PassportLMS', '[]', 0, '2023-01-03 23:07:47', '2023-01-03 23:07:47', '2024-01-04 04:37:47'),
('f6afc10cd3ad9739758da384cd402ab675df26f5361355f6b388c2bd615a6632e881a68c398e5696', 1, 9, 'PassportLMS', '[]', 0, '2023-02-03 01:17:04', '2023-02-03 01:17:04', '2024-02-03 06:47:04'),
('f991a437cfe594ba6c9e55ede6520b3c60bac769d8092ee947a76394a4b7e56d6e348744361fa60d', 2, 7, 'PassportLMS', '[]', 0, '2023-01-03 03:57:49', '2023-01-03 03:57:49', '2024-01-03 09:27:49'),
('fa01d02e5d71275ee0c303ada85c8eb8de5e1b9efeddbcba9462c46cef2b097b84343d9b94ba35c3', 1, 7, 'PassportLMS', '[]', 0, '2023-01-13 05:55:38', '2023-01-13 05:55:38', '2024-01-13 11:25:38'),
('fa5c5b801140390db66f787cfd7294a067d808c2f257206dfab1b59e61d7f09063f2b2bdeba339dc', 1, 11, 'PassportLMS', '[]', 0, '2023-02-08 22:59:55', '2023-02-08 22:59:55', '2024-02-09 04:29:55'),
('fb9ec76f0199836c803d7ad829f4546dccae4c8af389373d459ad7b45d21ac4a6344cee1647a7a23', 1, 7, 'PassportLMS', '[]', 0, '2022-12-27 10:34:31', '2022-12-27 10:34:31', '2023-12-27 10:34:31'),
('fbc101e77773212898eff56e5d20385a78302a99618213b02ea1a2b8a6110484cee03e75e7a0e0c7', 1, 9, 'PassportLMS', '[]', 0, '2023-01-16 04:31:56', '2023-01-16 04:31:56', '2024-01-16 10:01:56'),
('fcd6d57ad2e91ae36e3b18aab64e870281bbd3cd7ccfbc94c2e95854c79a5daa0ca0d3069e28b30a', 1, 3, 'PassportLMS', '[]', 0, '2022-12-26 07:01:15', '2022-12-26 07:01:15', '2023-12-26 07:01:15'),
('fd01edf5d85bed7924f1b188cf7e1cf8e52cbd1f2531c0b631f4d7c1de340fd3918e375054b16cfd', 3, 7, 'PassportLMS', '[]', 0, '2022-12-27 19:10:04', '2022-12-27 19:10:04', '2023-12-27 19:10:04'),
('ff373fd79c90810c76f4de19396eb2cd0056be5806ead42a7e45d5d7b9b634b51570d1f2aef074c0', 2, 7, 'PassportLMS', '[]', 0, '2023-01-02 23:06:23', '2023-01-02 23:06:23', '2024-01-03 04:36:23'),
('ff9f65d9d332db4042f01cd9af594713bba12799bcd85bbd3084fc8298f3169407458bfc7c4aa0ff', 2, 7, 'PassportLMS', '[]', 0, '2022-12-29 09:40:41', '2022-12-29 09:40:41', '2023-12-29 09:40:41'),
('ffe3f26cf79c8a2622cd78c726f7193e47f881e57cda12eb6a7fedb555c0e48a16048890b152a803', 2, 7, 'PassportLMS', '[]', 0, '2022-12-31 06:59:01', '2022-12-31 06:59:01', '2023-12-31 06:59:01');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'Laravel Personal Access Client', 'FPMciSmbb4ZGHWeSS1cNJAsnGd86ZCW7o87fuQKO', NULL, 'http://localhost', 1, 0, 0, '2022-04-08 17:02:53', '2022-04-08 17:02:53'),
(2, NULL, 'Laravel Password Grant Client', 'BPIeUxCg2GS16bCzfP38UAYryYDGYqzYBTOEkopy', 'users', 'http://localhost', 0, 1, 0, '2022-04-08 17:02:53', '2022-04-08 17:02:53'),
(3, NULL, 'Laravel Personal Access Client', 'N0WBFbO2vf8YqmOhF6Nt4MUbdvOqRUIfvopH6yps', NULL, 'http://localhost', 1, 0, 0, '2022-04-15 16:02:49', '2022-04-15 16:02:49'),
(4, NULL, 'Laravel Password Grant Client', 'Wam4Sd6hxXaaw1e22nAPpkJvAS3wimotLHva8X41', 'users', 'http://localhost', 0, 1, 0, '2022-04-15 16:02:49', '2022-04-15 16:02:49'),
(5, NULL, 'Laravel Personal Access Client', 'w41CWkakBSGaLy3v7WxypTu28F5r5PPppsUunqyQ', NULL, 'http://localhost', 1, 0, 0, '2022-12-26 10:57:00', '2022-12-26 10:57:00'),
(6, NULL, 'Laravel Password Grant Client', 'BpboE0svPGzh48ojfB13icpYQp74gsRsJ0QUq0uH', 'users', 'http://localhost', 0, 1, 0, '2022-12-26 10:57:00', '2022-12-26 10:57:00'),
(7, NULL, 'Laravel Personal Access Client', 'PtJkVp68pcw1mZu2GuzpioqPqC3pbDahRpcSs1Ef', NULL, 'http://localhost', 1, 0, 0, '2022-12-26 10:57:11', '2022-12-26 10:57:11'),
(8, NULL, 'Laravel Password Grant Client', 'MrI0WEjY3QdiG82PGKks2Cgn8ODlNt1LRXry3W83', 'users', 'http://localhost', 0, 1, 0, '2022-12-26 10:57:11', '2022-12-26 10:57:11'),
(9, NULL, 'Laravel Personal Access Client', 'v0zp5HBLtZnxtrSObYEpWCP5qJTtz2ZawBB6OQyI', NULL, 'http://localhost', 1, 0, 0, '2023-01-16 04:10:34', '2023-01-16 04:10:34'),
(10, NULL, 'Laravel Password Grant Client', 'BsCBL5Ezg6bO8jwQTcVjbME9XYfLAm6reaDkZVNf', 'users', 'http://localhost', 0, 1, 0, '2023-01-16 04:10:34', '2023-01-16 04:10:34'),
(11, NULL, 'Laravel Personal Access Client', 'xHD11L0vP5oiWB6VJ9Rba4kmaPfbvoRERm5hUWS7', NULL, 'http://localhost', 1, 0, 0, '2023-02-07 00:42:02', '2023-02-07 00:42:02'),
(12, NULL, 'Laravel Password Grant Client', 'W7UjKOEfrtZKbRqIc5BhrhPPHtW9gMLQPMO3jJO1', 'users', 'http://localhost', 0, 1, 0, '2023-02-07 00:42:02', '2023-02-07 00:42:02');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2022-04-08 17:02:53', '2022-04-08 17:02:53'),
(2, 3, '2022-04-15 16:02:49', '2022-04-15 16:02:49'),
(3, 5, '2022-12-26 10:57:00', '2022-12-26 10:57:00'),
(4, 7, '2022-12-26 10:57:11', '2022-12-26 10:57:11'),
(5, 9, '2023-01-16 04:10:34', '2023-01-16 04:10:34'),
(6, 11, '2023-02-07 00:42:02', '2023-02-07 00:42:02');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0=Active, 1=Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
(1, 'Super Admin', '2022-02-15 00:43:00', '2022-02-15 00:43:00', NULL, '0'),
(2, 'Admin', '2022-02-15 00:43:00', '2022-02-15 00:43:00', NULL, '0'),
(3, 'Trainer', '2022-02-15 00:43:00', '2022-02-15 00:43:00', NULL, '0'),
(4, 'Learner', '2022-02-15 00:43:00', '2022-02-15 00:43:00', NULL, '0'),
(5, 'Human Resource Manager', '2022-02-15 00:43:00', '2022-02-15 00:43:00', NULL, '0');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` text NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('ANCGWI5tSfwKWp4F7YKWGpLwRSQiGYs077jbIPU8', NULL, '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.87 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiaEZsZURORnJPUlFBamMxTEVwWlRhU0Z4MTZwT09KSHpMRFdRSkxJMCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjg6Imh0dHA6Ly9sb2NhbGhvc3QvTE1TMi9wdWJsaWMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1644989011);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1 COMMENT '1=Super Admin, 2=Admin, 3=Trainer, 4=Learner, 5=Human Resource Manager',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '0' COMMENT '0=Active, 1=Inactive'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `phone`, `email_verified_at`, `password`, `remember_token`, `role_id`, `created_at`, `updated_at`, `deleted_at`, `status`) VALUES
(2, 'erere', 'dfd', 'aa1@dfd.dffd', '1234567898', NULL, '$2y$10$tj.qPdJJ8BZgdRGbaUf6tuBcYlAj5.rfkQkB4D7UkEr/2DnVWkl2C', NULL, 2, '2022-02-15 00:43:45', '2022-02-15 00:43:45', NULL, '0'),
(3, 'test', 'test', 'test@gmail.com', '1234567898', NULL, '$2y$10$g8w1BkNf.0T4n73ALkkEFOGfREj10BOqXFnx9JSUTCE761M5e15bG', NULL, 2, '2022-02-16 01:51:18', '2022-02-16 01:51:18', NULL, '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `category_group_assignment`
--
ALTER TABLE `category_group_assignment`
  ADD PRIMARY KEY (`category_group_assignment_id`);

--
-- Indexes for table `lms_actions_master`
--
ALTER TABLE `lms_actions_master`
  ADD PRIMARY KEY (`actions_id`),
  ADD KEY `actions_master_on_update_date_modified` (`on_update_date_modified`),
  ADD KEY `lms_actions_master_users_1` (`created_id`),
  ADD KEY `lms_actions_master_users_2` (`modified_id`);

--
-- Indexes for table `lms_area`
--
ALTER TABLE `lms_area`
  ADD PRIMARY KEY (`area_id`);

--
-- Indexes for table `lms_assessment_question`
--
ALTER TABLE `lms_assessment_question`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `assessment_question_training_index` (`training_id`);

--
-- Indexes for table `lms_assessment_settings`
--
ALTER TABLE `lms_assessment_settings`
  ADD PRIMARY KEY (`assessment_setting_id`),
  ADD KEY `assessment_settings_training_index` (`training_id`);

--
-- Indexes for table `lms_category_master`
--
ALTER TABLE `lms_category_master`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `category_code_unique_index` (`category_code`),
  ADD KEY `category_created_index` (`created_id`),
  ADD KEY `category_modified_index` (`modified_id`),
  ADD KEY `category_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_certificate_master`
--
ALTER TABLE `lms_certificate_master`
  ADD PRIMARY KEY (`certificate_id`),
  ADD KEY `certificate_created_index` (`created_id`),
  ADD KEY `certificate_modified_index` (`modified_id`),
  ADD KEY `certificate_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_company_announcement`
--
ALTER TABLE `lms_company_announcement`
  ADD PRIMARY KEY (`announcement_id`),
  ADD KEY `announcement_created_index` (`created_id`),
  ADD KEY `announcement_modified_index` (`modified_id`),
  ADD KEY `announcement_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_content_library`
--
ALTER TABLE `lms_content_library`
  ADD PRIMARY KEY (`content_id`),
  ADD KEY `content_library_org_index` (`org_id`),
  ADD KEY `content_library_media_index` (`media_id`),
  ADD KEY `content_library_content_types_index` (`content_types_id`),
  ADD KEY `content_library_created_index` (`created_id`),
  ADD KEY `content_library_modified_index` (`modified_id`),
  ADD KEY `content_on_update_date_modified_index` (`on_update_date_modified`);

--
-- Indexes for table `lms_content_types`
--
ALTER TABLE `lms_content_types`
  ADD PRIMARY KEY (`content_types_id`);

--
-- Indexes for table `lms_country_master`
--
ALTER TABLE `lms_country_master`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `lms_course_catalog`
--
ALTER TABLE `lms_course_catalog`
  ADD PRIMARY KEY (`course_catalog_id`),
  ADD KEY `course_catalog_created_index` (`created_id`),
  ADD KEY `course_catalog_modified_index` (`modified_id`),
  ADD KEY `certificate_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_course_skill`
--
ALTER TABLE `lms_course_skill`
  ADD PRIMARY KEY (`course_skill_id`),
  ADD KEY `course_skill_created_index` (`created_id`),
  ADD KEY `course_skill_modified_index` (`modified_id`),
  ADD KEY `course_skill_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_division`
--
ALTER TABLE `lms_division`
  ADD PRIMARY KEY (`division_id`);

--
-- Indexes for table `lms_domain`
--
ALTER TABLE `lms_domain`
  ADD PRIMARY KEY (`domain_id`),
  ADD KEY `on_update_date_modified_index` (`on_update_date_modified`);

--
-- Indexes for table `lms_dynamic_fields`
--
ALTER TABLE `lms_dynamic_fields`
  ADD PRIMARY KEY (`dynamic_field_id`);

--
-- Indexes for table `lms_dynamic_fields3`
--
ALTER TABLE `lms_dynamic_fields3`
  ADD PRIMARY KEY (`dynamic_field_id`);

--
-- Indexes for table `lms_dynamic_links`
--
ALTER TABLE `lms_dynamic_links`
  ADD PRIMARY KEY (`dynamic_link_id`);

--
-- Indexes for table `lms_enrollment`
--
ALTER TABLE `lms_enrollment`
  ADD PRIMARY KEY (`enrollment_id`);

--
-- Indexes for table `lms_group_master`
--
ALTER TABLE `lms_group_master`
  ADD PRIMARY KEY (`group_id`),
  ADD UNIQUE KEY `group_code_unique_index` (`group_code`),
  ADD KEY `group_master_org_index` (`org_id`),
  ADD KEY `group_master_created_index` (`created_id`),
  ADD KEY `group_master_modified_index` (`modified_id`),
  ADD KEY `group_master_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_group_org`
--
ALTER TABLE `lms_group_org`
  ADD PRIMARY KEY (`group_id`),
  ADD UNIQUE KEY `group_code_unique_index` (`group_code`),
  ADD KEY `group_master_org_index` (`org_id`),
  ADD KEY `group_master_created_index` (`created_id`),
  ADD KEY `group_master_modified_index` (`modified_id`),
  ADD KEY `group_master_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_group_org_settings`
--
ALTER TABLE `lms_group_org_settings`
  ADD PRIMARY KEY (`group_org_setting_id`),
  ADD UNIQUE KEY `group_org_code_unique_index` (`org_code`),
  ADD KEY `group_org_settings_org_index` (`org_id`),
  ADD KEY `group_org_settings_created_index` (`created_id`),
  ADD KEY `group_org_settings_modified_index` (`modified_id`),
  ADD KEY `group_org_settings_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_group_settings`
--
ALTER TABLE `lms_group_settings`
  ADD PRIMARY KEY (`group_setting_id`);

--
-- Indexes for table `lms_icons`
--
ALTER TABLE `lms_icons`
  ADD PRIMARY KEY (`icon_id`);

--
-- Indexes for table `lms_ilt_enrollment`
--
ALTER TABLE `lms_ilt_enrollment`
  ADD PRIMARY KEY (`ilt_enrollment_id`);

--
-- Indexes for table `lms_image`
--
ALTER TABLE `lms_image`
  ADD PRIMARY KEY (`image_id`),
  ADD KEY `image_org_index` (`org_id`),
  ADD KEY `image_created_index` (`created_id`),
  ADD KEY `lms_image_users_1` (`user_id`);

--
-- Indexes for table `lms_job_title`
--
ALTER TABLE `lms_job_title`
  ADD PRIMARY KEY (`job_title_id`);

--
-- Indexes for table `lms_location`
--
ALTER TABLE `lms_location`
  ADD PRIMARY KEY (`location_id`);

--
-- Indexes for table `lms_login_otp`
--
ALTER TABLE `lms_login_otp`
  ADD PRIMARY KEY (`login_otp_id`);

--
-- Indexes for table `lms_media`
--
ALTER TABLE `lms_media`
  ADD PRIMARY KEY (`media_id`),
  ADD KEY `media_org_index` (`org_id`),
  ADD KEY `media_created_index` (`created_id`),
  ADD KEY `media_modified_index` (`modified_id`),
  ADD KEY `media_on_update_date_modified_index` (`on_update_date_modified`);

--
-- Indexes for table `lms_menu`
--
ALTER TABLE `lms_menu`
  ADD PRIMARY KEY (`menu_id`),
  ADD KEY `key_menu_menu_master_index` (`menu_master_id`),
  ADD KEY `key_menu_module_master_index` (`module_id`),
  ADD KEY `key_menu_org_index` (`org_id`),
  ADD KEY `key_menu_role_index` (`role_id`),
  ADD KEY `menu_on_update_date_modified` (`on_update_date_modified`),
  ADD KEY `lms_menu_users_1` (`created_id`),
  ADD KEY `lms_menu_users_2` (`modified_id`);

--
-- Indexes for table `lms_menu_master`
--
ALTER TABLE `lms_menu_master`
  ADD PRIMARY KEY (`menu_master_id`),
  ADD KEY `key_menu_master_menu_master_index` (`parent_menu_master_id`),
  ADD KEY `module_master_on_update_date_modified` (`on_update_date_modified`),
  ADD KEY `lms_menu_master_users_1` (`created_id`),
  ADD KEY `lms_menu_master_users_2` (`modified_id`);

--
-- Indexes for table `lms_module_master`
--
ALTER TABLE `lms_module_master`
  ADD PRIMARY KEY (`module_id`),
  ADD KEY `module_created_index` (`created_id`),
  ADD KEY `module_modified_index` (`modified_id`),
  ADD KEY `module_on_update_date_modified` (`on_update_date_modified`),
  ADD KEY `lms_module_master_menu_master` (`menu_master_id`);

--
-- Indexes for table `lms_notifications`
--
ALTER TABLE `lms_notifications`
  ADD PRIMARY KEY (`notification_id`);

--
-- Indexes for table `lms_notification_category`
--
ALTER TABLE `lms_notification_category`
  ADD PRIMARY KEY (`notification_category_id`);

--
-- Indexes for table `lms_notification_events`
--
ALTER TABLE `lms_notification_events`
  ADD PRIMARY KEY (`notification_event_id`);

--
-- Indexes for table `lms_notification_master`
--
ALTER TABLE `lms_notification_master`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `notification_created_index` (`created_id`),
  ADD KEY `notification_modified_index` (`modified_id`),
  ADD KEY `notification_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_organization_type`
--
ALTER TABLE `lms_organization_type`
  ADD PRIMARY KEY (`organization_type_id`),
  ADD KEY `lms_organization_type_users_1` (`created_id`),
  ADD KEY `lms_organization_type_users_2` (`modified_id`);

--
-- Indexes for table `lms_org_assessment_question`
--
ALTER TABLE `lms_org_assessment_question`
  ADD PRIMARY KEY (`question_id`),
  ADD KEY `org_assessment_question_org_training_index` (`training_id`);

--
-- Indexes for table `lms_org_assessment_settings`
--
ALTER TABLE `lms_org_assessment_settings`
  ADD PRIMARY KEY (`assessment_setting_id`),
  ADD KEY `org_assessment_settings_org_training_index` (`training_id`);

--
-- Indexes for table `lms_org_assign_training_library`
--
ALTER TABLE `lms_org_assign_training_library`
  ADD PRIMARY KEY (`org_assign_training_id`);

--
-- Indexes for table `lms_org_category`
--
ALTER TABLE `lms_org_category`
  ADD PRIMARY KEY (`category_id`),
  ADD UNIQUE KEY `org_category_code_unique_index` (`category_code`),
  ADD KEY `org_category_created_index` (`created_id`),
  ADD KEY `org_category_modified_index` (`modified_id`),
  ADD KEY `org_category_on_update_date_modified` (`on_update_date_modified`),
  ADD KEY `lms_org_category_org_master` (`org_id`);

--
-- Indexes for table `lms_org_category_group_assignment`
--
ALTER TABLE `lms_org_category_group_assignment`
  ADD PRIMARY KEY (`category_group_assignment_id`);

--
-- Indexes for table `lms_org_course_catalog`
--
ALTER TABLE `lms_org_course_catalog`
  ADD PRIMARY KEY (`org_course_catalog_id`),
  ADD KEY `org_course_catalog_created_index` (`created_id`),
  ADD KEY `org_course_catalog_modified_index` (`modified_id`),
  ADD KEY `org_certificate_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_org_credentials`
--
ALTER TABLE `lms_org_credentials`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lms_org_master`
--
ALTER TABLE `lms_org_master`
  ADD PRIMARY KEY (`org_id`),
  ADD KEY `org_domain_index` (`domain_id`),
  ADD KEY `ogr_user_index` (`created_id`),
  ADD KEY `org_user_modified_index` (`modified_id`),
  ADD KEY `org_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_org_notification`
--
ALTER TABLE `lms_org_notification`
  ADD PRIMARY KEY (`org_notification_id`),
  ADD KEY `org_notification_created_index` (`created_id`),
  ADD KEY `org_notification_modified_index` (`modified_id`),
  ADD KEY `org_notification_on_update_date_modified` (`on_update_date_modified`),
  ADD KEY `org_notification_id_index` (`notification_id`),
  ADD KEY `org_notification_org_id_index` (`org_id`);

--
-- Indexes for table `lms_org_question_answer`
--
ALTER TABLE `lms_org_question_answer`
  ADD PRIMARY KEY (`answer_id`);

--
-- Indexes for table `lms_org_skills`
--
ALTER TABLE `lms_org_skills`
  ADD PRIMARY KEY (`org_skill_id`),
  ADD KEY `org_skill_created_index` (`created_id`),
  ADD KEY `org_skill_modified_index` (`modified_id`),
  ADD KEY `org_skill_on_update_date_modified` (`on_update_date_modified`),
  ADD KEY `lms_org_skills_org_master` (`org_id`);

--
-- Indexes for table `lms_org_training_handouts`
--
ALTER TABLE `lms_org_training_handouts`
  ADD PRIMARY KEY (`training_handout_id`),
  ADD KEY `org_training_handouts_org_training_index` (`training_id`),
  ADD KEY `training_resource_index` (`resource_id`);

--
-- Indexes for table `lms_org_training_library`
--
ALTER TABLE `lms_org_training_library`
  ADD PRIMARY KEY (`training_id`),
  ADD KEY `training_training_type_index` (`training_type_id`),
  ADD KEY `training_image_index` (`image_id`),
  ADD KEY `training_certificate_index` (`certificate_id`),
  ADD KEY `training_training_status_index` (`training_status_id`),
  ADD KEY `training_created_index` (`created_id`),
  ADD KEY `training_modified_index` (`modified_id`),
  ADD KEY `training_on_update_date_modified_index` (`on_update_date_modified`),
  ADD KEY `training_enrollment_type_index` (`ilt_enrollment_id`),
  ADD KEY `lms_training_category` (`category_id`),
  ADD KEY `lms_org_training_org` (`org_id`);

--
-- Indexes for table `lms_org_training_media`
--
ALTER TABLE `lms_org_training_media`
  ADD PRIMARY KEY (`training_media_id`),
  ADD KEY `org_training_org_training_index` (`training_id`),
  ADD KEY `org_training_media_index` (`media_id`);

--
-- Indexes for table `lms_org_training_notifications_settings`
--
ALTER TABLE `lms_org_training_notifications_settings`
  ADD PRIMARY KEY (`training_notification_setting_id`),
  ADD KEY `org_training_notifications_settings_training_notification_index` (`training_notification_id`),
  ADD KEY `org_training_notifications_settings_org_training_index` (`training_id`);

--
-- Indexes for table `lms_permission`
--
ALTER TABLE `lms_permission`
  ADD PRIMARY KEY (`permission_id`),
  ADD KEY `key_permission_module_master_index` (`module_id`),
  ADD KEY `key_permission_actions_master_index` (`actions_id`),
  ADD KEY `key_permission_org_index` (`org_id`),
  ADD KEY `key_permission_role_index` (`role_id`),
  ADD KEY `permission_on_update_date_modified` (`on_update_date_modified`),
  ADD KEY `permission_users_1` (`created_id`),
  ADD KEY `permission_users_2` (`modified_id`);

--
-- Indexes for table `lms_question_answer`
--
ALTER TABLE `lms_question_answer`
  ADD PRIMARY KEY (`answer_id`);

--
-- Indexes for table `lms_question_types`
--
ALTER TABLE `lms_question_types`
  ADD PRIMARY KEY (`question_type_id`);

--
-- Indexes for table `lms_resources`
--
ALTER TABLE `lms_resources`
  ADD PRIMARY KEY (`resource_id`),
  ADD KEY `resource_org_index` (`org_id`),
  ADD KEY `resource_created_index` (`created_id`),
  ADD KEY `lms_resource_users_1` (`user_id`);

--
-- Indexes for table `lms_roles`
--
ALTER TABLE `lms_roles`
  ADD PRIMARY KEY (`role_id`);

--
-- Indexes for table `lms_skills_master`
--
ALTER TABLE `lms_skills_master`
  ADD PRIMARY KEY (`skill_id`),
  ADD KEY `skill_created_index` (`created_id`),
  ADD KEY `skill_modified_index` (`modified_id`),
  ADD KEY `skill_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_tag`
--
ALTER TABLE `lms_tag`
  ADD PRIMARY KEY (`tag_id`),
  ADD KEY `lms_tag_users_1` (`created_id`),
  ADD KEY `lms_tags_users_2` (`modified_id`),
  ADD KEY `lms_tag_org` (`org_id`);

--
-- Indexes for table `lms_team_approvals`
--
ALTER TABLE `lms_team_approvals`
  ADD PRIMARY KEY (`team_approval_id`);

--
-- Indexes for table `lms_team_credit`
--
ALTER TABLE `lms_team_credit`
  ADD PRIMARY KEY (`team_credit_id`);

--
-- Indexes for table `lms_theme_master`
--
ALTER TABLE `lms_theme_master`
  ADD PRIMARY KEY (`theme_id`),
  ADD KEY `on_update_date_modified_index` (`on_update_date_modified`);

--
-- Indexes for table `lms_training_handouts`
--
ALTER TABLE `lms_training_handouts`
  ADD PRIMARY KEY (`training_handout_id`),
  ADD KEY `training_training_index` (`training_id`),
  ADD KEY `training_resource_index` (`resource_id`);

--
-- Indexes for table `lms_training_library`
--
ALTER TABLE `lms_training_library`
  ADD PRIMARY KEY (`training_id`),
  ADD KEY `training_training_type_index` (`training_type_id`),
  ADD KEY `training_image_index` (`image_id`),
  ADD KEY `training_certificate_index` (`certificate_id`),
  ADD KEY `training_training_status_index` (`training_status_id`),
  ADD KEY `training_created_index` (`created_id`),
  ADD KEY `training_modified_index` (`modified_id`),
  ADD KEY `training_on_update_date_modified_index` (`on_update_date_modified`),
  ADD KEY `training_enrollment_type_index` (`ilt_enrollment_id`),
  ADD KEY `lms_training_category` (`category_id`);

--
-- Indexes for table `lms_training_media`
--
ALTER TABLE `lms_training_media`
  ADD PRIMARY KEY (`training_media_id`),
  ADD KEY `training_training_index` (`training_id`),
  ADD KEY `training_media_index` (`media_id`);

--
-- Indexes for table `lms_training_notifications`
--
ALTER TABLE `lms_training_notifications`
  ADD PRIMARY KEY (`training_notification_id`);

--
-- Indexes for table `lms_training_notifications_settings`
--
ALTER TABLE `lms_training_notifications_settings`
  ADD PRIMARY KEY (`training_notification_setting_id`),
  ADD KEY `training_notifications_settings_training_notification_index` (`training_notification_id`),
  ADD KEY `training_notifications_settings_training_index` (`training_id`);

--
-- Indexes for table `lms_training_status`
--
ALTER TABLE `lms_training_status`
  ADD PRIMARY KEY (`training_status_id`);

--
-- Indexes for table `lms_training_types`
--
ALTER TABLE `lms_training_types`
  ADD PRIMARY KEY (`training_type_id`);

--
-- Indexes for table `lms_user_category`
--
ALTER TABLE `lms_user_category`
  ADD PRIMARY KEY (`user_category_id`),
  ADD KEY `user_category_user_master_index` (`user_id`),
  ADD KEY `user_category_category_master_index` (`category_id`),
  ADD KEY `user_category_org_master_index` (`org_id`),
  ADD KEY `user_category_created_index` (`created_id`),
  ADD KEY `user_category_modified_index` (`modified_id`),
  ADD KEY `user_category_on_update_date_modified_index` (`on_update_date_modified`);

--
-- Indexes for table `lms_user_group`
--
ALTER TABLE `lms_user_group`
  ADD PRIMARY KEY (`user_group_id`),
  ADD KEY `user_group_user_master_index` (`user_id`),
  ADD KEY `user_group_group_master_index` (`group_id`),
  ADD KEY `user_group_org_master_index` (`org_id`),
  ADD KEY `user_group_created_index` (`created_id`),
  ADD KEY `user_group_modified_index` (`modified_id`),
  ADD KEY `user_group_on_update_date_modified_index` (`on_update_date_modified`);

--
-- Indexes for table `lms_user_login`
--
ALTER TABLE `lms_user_login`
  ADD PRIMARY KEY (`login_id`),
  ADD KEY `user_login_user_index` (`user_id`),
  ADD KEY `user_login_org_index` (`org_id`),
  ADD KEY `user_login_domain_index` (`domain_id`);

--
-- Indexes for table `lms_user_master`
--
ALTER TABLE `lms_user_master`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `user_guid_unique_index` (`user_guid`),
  ADD KEY `user_org_index` (`org_id`),
  ADD KEY `user_role_index` (`role_id`),
  ADD KEY `user_created_index` (`created_id`),
  ADD KEY `user_modified_index` (`modified_id`),
  ADD KEY `user_on_update_date_modified` (`on_update_date_modified`);

--
-- Indexes for table `lms_user_media`
--
ALTER TABLE `lms_user_media`
  ADD PRIMARY KEY (`user_media_id`),
  ADD KEY `user_media_user_master_index` (`user_id`),
  ADD KEY `user_media_org_master_index` (`org_id`),
  ADD KEY `user_media_created_index` (`created_id`),
  ADD KEY `user_media_modified_index` (`modified_id`),
  ADD KEY `user_media_on_update_date_modified_index` (`on_update_date_modified`);

--
-- Indexes for table `lms_user_notification`
--
ALTER TABLE `lms_user_notification`
  ADD PRIMARY KEY (`user_notification_id`),
  ADD KEY `lms_user_notification_user` (`user_id`),
  ADD KEY `lms_user_notification_org` (`org_id`),
  ADD KEY `lms_user_notification_notification` (`notification_id`),
  ADD KEY `lms_user_notification_user_1` (`created_id`),
  ADD KEY `lms_user_notification_user_2` (`modified_id`);

--
-- Indexes for table `lms_user_notification_assignment`
--
ALTER TABLE `lms_user_notification_assignment`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `lms_user_org_group`
--
ALTER TABLE `lms_user_org_group`
  ADD PRIMARY KEY (`user_group_id`),
  ADD KEY `user_group_user_master_index` (`user_id`),
  ADD KEY `user_group_group_master_index` (`group_id`),
  ADD KEY `user_group_org_master_index` (`org_id`),
  ADD KEY `user_group_created_index` (`created_id`),
  ADD KEY `user_group_modified_index` (`modified_id`),
  ADD KEY `user_group_on_update_date_modified_index` (`on_update_date_modified`);

--
-- Indexes for table `lms_user_requirement_courses`
--
ALTER TABLE `lms_user_requirement_courses`
  ADD PRIMARY KEY (`user_requirement_course_id`),
  ADD KEY `user_requirement_courses_org` (`org_id`),
  ADD KEY `user_requirement_courses_org_training_library` (`org_training_id`),
  ADD KEY `user_requirement_courses_org_assign_training_library` (`org_assign_training_id`),
  ADD KEY `user_requirement_courses_role` (`role_id`),
  ADD KEY `user_requirement_courses_user` (`user_id`),
  ADD KEY `user_requirement_courses_user_1` (`created_id`),
  ADD KEY `user_requirement_courses_user_2` (`modified_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `category_group_assignment`
--
ALTER TABLE `category_group_assignment`
  MODIFY `category_group_assignment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `lms_actions_master`
--
ALTER TABLE `lms_actions_master`
  MODIFY `actions_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `lms_area`
--
ALTER TABLE `lms_area`
  MODIFY `area_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_assessment_question`
--
ALTER TABLE `lms_assessment_question`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_assessment_settings`
--
ALTER TABLE `lms_assessment_settings`
  MODIFY `assessment_setting_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_category_master`
--
ALTER TABLE `lms_category_master`
  MODIFY `category_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lms_certificate_master`
--
ALTER TABLE `lms_certificate_master`
  MODIFY `certificate_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_company_announcement`
--
ALTER TABLE `lms_company_announcement`
  MODIFY `announcement_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_content_library`
--
ALTER TABLE `lms_content_library`
  MODIFY `content_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `lms_content_types`
--
ALTER TABLE `lms_content_types`
  MODIFY `content_types_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `lms_country_master`
--
ALTER TABLE `lms_country_master`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=240;

--
-- AUTO_INCREMENT for table `lms_course_catalog`
--
ALTER TABLE `lms_course_catalog`
  MODIFY `course_catalog_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_course_skill`
--
ALTER TABLE `lms_course_skill`
  MODIFY `course_skill_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_division`
--
ALTER TABLE `lms_division`
  MODIFY `division_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_domain`
--
ALTER TABLE `lms_domain`
  MODIFY `domain_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `lms_dynamic_fields`
--
ALTER TABLE `lms_dynamic_fields`
  MODIFY `dynamic_field_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lms_dynamic_fields3`
--
ALTER TABLE `lms_dynamic_fields3`
  MODIFY `dynamic_field_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `lms_dynamic_links`
--
ALTER TABLE `lms_dynamic_links`
  MODIFY `dynamic_link_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lms_enrollment`
--
ALTER TABLE `lms_enrollment`
  MODIFY `enrollment_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_group_master`
--
ALTER TABLE `lms_group_master`
  MODIFY `group_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `lms_group_org`
--
ALTER TABLE `lms_group_org`
  MODIFY `group_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lms_group_org_settings`
--
ALTER TABLE `lms_group_org_settings`
  MODIFY `group_org_setting_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_group_settings`
--
ALTER TABLE `lms_group_settings`
  MODIFY `group_setting_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `lms_icons`
--
ALTER TABLE `lms_icons`
  MODIFY `icon_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=566;

--
-- AUTO_INCREMENT for table `lms_ilt_enrollment`
--
ALTER TABLE `lms_ilt_enrollment`
  MODIFY `ilt_enrollment_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lms_image`
--
ALTER TABLE `lms_image`
  MODIFY `image_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lms_job_title`
--
ALTER TABLE `lms_job_title`
  MODIFY `job_title_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_location`
--
ALTER TABLE `lms_location`
  MODIFY `location_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_login_otp`
--
ALTER TABLE `lms_login_otp`
  MODIFY `login_otp_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_media`
--
ALTER TABLE `lms_media`
  MODIFY `media_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `lms_menu`
--
ALTER TABLE `lms_menu`
  MODIFY `menu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=153;

--
-- AUTO_INCREMENT for table `lms_menu_master`
--
ALTER TABLE `lms_menu_master`
  MODIFY `menu_master_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `lms_module_master`
--
ALTER TABLE `lms_module_master`
  MODIFY `module_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT for table `lms_notifications`
--
ALTER TABLE `lms_notifications`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_notification_category`
--
ALTER TABLE `lms_notification_category`
  MODIFY `notification_category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `lms_notification_events`
--
ALTER TABLE `lms_notification_events`
  MODIFY `notification_event_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `lms_notification_master`
--
ALTER TABLE `lms_notification_master`
  MODIFY `notification_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lms_organization_type`
--
ALTER TABLE `lms_organization_type`
  MODIFY `organization_type_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `lms_org_assessment_question`
--
ALTER TABLE `lms_org_assessment_question`
  MODIFY `question_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_org_assessment_settings`
--
ALTER TABLE `lms_org_assessment_settings`
  MODIFY `assessment_setting_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_org_assign_training_library`
--
ALTER TABLE `lms_org_assign_training_library`
  MODIFY `org_assign_training_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lms_org_category`
--
ALTER TABLE `lms_org_category`
  MODIFY `category_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lms_org_category_group_assignment`
--
ALTER TABLE `lms_org_category_group_assignment`
  MODIFY `category_group_assignment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `lms_org_course_catalog`
--
ALTER TABLE `lms_org_course_catalog`
  MODIFY `org_course_catalog_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_org_credentials`
--
ALTER TABLE `lms_org_credentials`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lms_org_master`
--
ALTER TABLE `lms_org_master`
  MODIFY `org_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `lms_org_notification`
--
ALTER TABLE `lms_org_notification`
  MODIFY `org_notification_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lms_org_question_answer`
--
ALTER TABLE `lms_org_question_answer`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_org_skills`
--
ALTER TABLE `lms_org_skills`
  MODIFY `org_skill_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_org_training_handouts`
--
ALTER TABLE `lms_org_training_handouts`
  MODIFY `training_handout_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_org_training_library`
--
ALTER TABLE `lms_org_training_library`
  MODIFY `training_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_org_training_media`
--
ALTER TABLE `lms_org_training_media`
  MODIFY `training_media_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_org_training_notifications_settings`
--
ALTER TABLE `lms_org_training_notifications_settings`
  MODIFY `training_notification_setting_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_permission`
--
ALTER TABLE `lms_permission`
  MODIFY `permission_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_question_answer`
--
ALTER TABLE `lms_question_answer`
  MODIFY `answer_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_question_types`
--
ALTER TABLE `lms_question_types`
  MODIFY `question_type_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `lms_resources`
--
ALTER TABLE `lms_resources`
  MODIFY `resource_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_roles`
--
ALTER TABLE `lms_roles`
  MODIFY `role_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `lms_skills_master`
--
ALTER TABLE `lms_skills_master`
  MODIFY `skill_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_tag`
--
ALTER TABLE `lms_tag`
  MODIFY `tag_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_team_approvals`
--
ALTER TABLE `lms_team_approvals`
  MODIFY `team_approval_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_team_credit`
--
ALTER TABLE `lms_team_credit`
  MODIFY `team_credit_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lms_theme_master`
--
ALTER TABLE `lms_theme_master`
  MODIFY `theme_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lms_training_handouts`
--
ALTER TABLE `lms_training_handouts`
  MODIFY `training_handout_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_training_library`
--
ALTER TABLE `lms_training_library`
  MODIFY `training_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lms_training_media`
--
ALTER TABLE `lms_training_media`
  MODIFY `training_media_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lms_training_notifications`
--
ALTER TABLE `lms_training_notifications`
  MODIFY `training_notification_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `lms_training_notifications_settings`
--
ALTER TABLE `lms_training_notifications_settings`
  MODIFY `training_notification_setting_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_training_status`
--
ALTER TABLE `lms_training_status`
  MODIFY `training_status_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `lms_training_types`
--
ALTER TABLE `lms_training_types`
  MODIFY `training_type_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `lms_user_category`
--
ALTER TABLE `lms_user_category`
  MODIFY `user_category_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_user_group`
--
ALTER TABLE `lms_user_group`
  MODIFY `user_group_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `lms_user_login`
--
ALTER TABLE `lms_user_login`
  MODIFY `login_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `lms_user_master`
--
ALTER TABLE `lms_user_master`
  MODIFY `user_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=79;

--
-- AUTO_INCREMENT for table `lms_user_media`
--
ALTER TABLE `lms_user_media`
  MODIFY `user_media_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_user_notification`
--
ALTER TABLE `lms_user_notification`
  MODIFY `user_notification_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_user_notification_assignment`
--
ALTER TABLE `lms_user_notification_assignment`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `lms_user_org_group`
--
ALTER TABLE `lms_user_org_group`
  MODIFY `user_group_id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lms_user_requirement_courses`
--
ALTER TABLE `lms_user_requirement_courses`
  MODIFY `user_requirement_course_id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `lms_actions_master`
--
ALTER TABLE `lms_actions_master`
  ADD CONSTRAINT `lms_actions_master_users_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_actions_master_users_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_assessment_question`
--
ALTER TABLE `lms_assessment_question`
  ADD CONSTRAINT `lms_assessment_question_training` FOREIGN KEY (`training_id`) REFERENCES `lms_training_library` (`training_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_assessment_settings`
--
ALTER TABLE `lms_assessment_settings`
  ADD CONSTRAINT `lms_assessment_settings_training` FOREIGN KEY (`training_id`) REFERENCES `lms_training_library` (`training_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_category_master`
--
ALTER TABLE `lms_category_master`
  ADD CONSTRAINT `lms_user_category_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_user_category_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_certificate_master`
--
ALTER TABLE `lms_certificate_master`
  ADD CONSTRAINT `lms_user_certificate_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_user_certificate_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_company_announcement`
--
ALTER TABLE `lms_company_announcement`
  ADD CONSTRAINT `lms_user_announcement_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_user_announcement_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_content_library`
--
ALTER TABLE `lms_content_library`
  ADD CONSTRAINT `lms_content_library_content_types` FOREIGN KEY (`content_types_id`) REFERENCES `lms_content_types` (`content_types_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_content_library_media` FOREIGN KEY (`media_id`) REFERENCES `lms_media` (`media_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_content_library_org` FOREIGN KEY (`org_id`) REFERENCES `lms_org_master` (`org_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_content_library_users_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_content_library_users_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_course_catalog`
--
ALTER TABLE `lms_course_catalog`
  ADD CONSTRAINT `lms_course_catalog_user_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_course_catalog_user_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_course_skill`
--
ALTER TABLE `lms_course_skill`
  ADD CONSTRAINT `lms_course_skill_user_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_course_skill_user_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_group_master`
--
ALTER TABLE `lms_group_master`
  ADD CONSTRAINT `lms_group_master_org` FOREIGN KEY (`org_id`) REFERENCES `lms_org_master` (`org_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_user_group_master_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_user_group_master_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_group_org_settings`
--
ALTER TABLE `lms_group_org_settings`
  ADD CONSTRAINT `lms_group_org_settings_org` FOREIGN KEY (`org_id`) REFERENCES `lms_org_master` (`org_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_user_group_org_settings_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_user_group_org_settings_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_image`
--
ALTER TABLE `lms_image`
  ADD CONSTRAINT `lms_image_org` FOREIGN KEY (`org_id`) REFERENCES `lms_org_master` (`org_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_image_users_1` FOREIGN KEY (`user_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_image_users_2` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_media`
--
ALTER TABLE `lms_media`
  ADD CONSTRAINT `lms_media_org` FOREIGN KEY (`org_id`) REFERENCES `lms_org_master` (`org_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_media_users_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_media_users_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;

--
-- Constraints for table `lms_menu_master`
--
ALTER TABLE `lms_menu_master`
  ADD CONSTRAINT `lms_menu_master_users_1` FOREIGN KEY (`created_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL,
  ADD CONSTRAINT `lms_menu_master_users_2` FOREIGN KEY (`modified_id`) REFERENCES `lms_user_master` (`user_id`) ON DELETE SET NULL ON UPDATE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
