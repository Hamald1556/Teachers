-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 16, 2024 at 01:02 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `special_education`
--

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `id` int(99) NOT NULL,
  `date` date NOT NULL DEFAULT current_timestamp(),
  `feedback` varchar(500) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`id`, `date`, `feedback`) VALUES
(0, '2024-05-28', 'ni mzuri'),
(0, '2024-05-28', 'ni mzuri'),
(0, '2024-05-28', 'nimeelewa sana'),
(0, '2024-06-08', 'yeah ni elimu mzuri na nimeelewa. asante');

-- --------------------------------------------------------

--
-- Table structure for table `lesson`
--

CREATE TABLE `lesson` (
  `lesson_id` int(99) NOT NULL,
  `lesson_title` varchar(99) NOT NULL,
  `author_name` varchar(99) NOT NULL,
  `lesson_description` varchar(1500) NOT NULL,
  `lesson_materials` varchar(300) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

CREATE TABLE `registration` (
  `user_id` int(99) NOT NULL,
  `first_name` varchar(99) NOT NULL,
  `last_name` varchar(99) NOT NULL,
  `email` varchar(99) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(99) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `registration`
--

INSERT INTO `registration` (`user_id`, `first_name`, `last_name`, `email`, `password`, `role`) VALUES
(1, 'hamadi', 'tindwa', 'tindwahamadi@gmail.com', '$2y$10$ohmGD99IJob/oyNFXPYR8OHdLqxHId.Ee/CjQXRoqRjqYIdNGdnQe', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `resources`
--

CREATE TABLE `resources` (
  `id` int(99) NOT NULL,
  `resource_name` varchar(99) NOT NULL,
  `resource_description` varchar(2000) NOT NULL,
  `image` varchar(99) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `teachers`
--

CREATE TABLE `teachers` (
  `id` int(99) NOT NULL,
  `username` varchar(99) NOT NULL,
  `email` varchar(99) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` varchar(99) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `teachers`
--

INSERT INTO `teachers` (`id`, `username`, `email`, `password`, `role`) VALUES
(3, 'baba', 'baba@gmail.com', '$2y$10$e/agBc6ZkVjZsQTlm9Y3QOleuMP3up3RgPAM8u8XXzO9xfiDPtn6O', 'user'),
(7, 'hamida', 'hamida200@gmail.com', '$2y$10$oBvIXXwi6V3dA9rbMYWA.uyUA4qNYA6iuHMJlGZ5mpa6YoW3djGJ2', 'user'),
(8, 'hamadi', 'tindwahamadi@gmail.com', '$2y$10$g9w3aVk4ND7Rc9Gd7tgZW.pUdXcpJnGkBudbczM4lP14GJzL8bDUu', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `teachers_registration`
--

CREATE TABLE `teachers_registration` (
  `user_id` int(99) NOT NULL,
  `username` varchar(99) NOT NULL,
  `email` varchar(99) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `training`
--

CREATE TABLE `training` (
  `id` int(99) NOT NULL,
  `path` varchar(99) NOT NULL,
  `date` datetime(4) NOT NULL DEFAULT current_timestamp(4)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `training`
--

INSERT INTO `training` (`id`, `path`, `date`) VALUES
(1, 'uploads/How to Install The Ionic Framework CLI to Build Mobile Apps.pdf', '2024-06-15 14:04:50.9642'),
(2, 'uploads/Hardware Back Button for Capacitor & Cordova on Android Devices.pdf', '2024-06-15 14:09:05.9928'),
(3, 'uploads/API NOTES.pdf', '2024-06-15 15:29:36.3888');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `lesson`
--
ALTER TABLE `lesson`
  ADD PRIMARY KEY (`lesson_id`);

--
-- Indexes for table `registration`
--
ALTER TABLE `registration`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `resources`
--
ALTER TABLE `resources`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teachers`
--
ALTER TABLE `teachers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `teachers_registration`
--
ALTER TABLE `teachers_registration`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `training`
--
ALTER TABLE `training`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `lesson`
--
ALTER TABLE `lesson`
  MODIFY `lesson_id` int(99) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `registration`
--
ALTER TABLE `registration`
  MODIFY `user_id` int(99) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `resources`
--
ALTER TABLE `resources`
  MODIFY `id` int(99) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `teachers`
--
ALTER TABLE `teachers`
  MODIFY `id` int(99) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `teachers_registration`
--
ALTER TABLE `teachers_registration`
  MODIFY `user_id` int(99) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `training`
--
ALTER TABLE `training`
  MODIFY `id` int(99) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
