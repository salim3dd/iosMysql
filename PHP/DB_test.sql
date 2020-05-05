-- phpMyAdmin SQL Dump
-- version 4.9.5
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: 05 مايو 2020 الساعة 13:43
-- إصدار الخادم: 10.2.31-MariaDB
-- PHP Version: 7.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `u426621598_test`
--

-- --------------------------------------------------------

--
-- بنية الجدول `Users`
--

CREATE TABLE `Users` (
  `id` int(11) NOT NULL,
  `UserName` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Password` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Email` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `RegDate` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `Avatar` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- إرجاع أو استيراد بيانات الجدول `Users`
--

INSERT INTO `Users` (`id`, `UserName`, `Password`, `Email`, `RegDate`, `Avatar`) VALUES
(13, 'salim', '2d02e669731cbade6a64b58d602cf2a4', 'sss', '2020/05/05 - 05:21 am', 'Uzpxvd2020050505211588641693.jpg'),
(16, 'Mohammed', '202cb962ac59075b964b07152d234b70', 'md@gamil.com', '2020/05/05 - 07:07 am', 'Uaunro2020050507071588648052.jpg'),
(17, 'Amur', '202cb962ac59075b964b07152d234b70', 'amm@gamil.com', '2020/05/05 - 07:29 am', 'Uowfjx2020050507291588649374.jpg'),
(19, 'Ali', '202cb962ac59075b964b07152d234b70', 'ali@gmail.com', '2020/05/05 - 09:07 am', 'Utjhqm2020050509071588655258.jpg'),
(20, 'Salim2', '202cb962ac59075b964b07152d234b70', 'Salim@gmail.com', '2020/05/05 - 10:17 am', 'Ubclqr2020050510171588659428.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Users`
--
ALTER TABLE `Users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
