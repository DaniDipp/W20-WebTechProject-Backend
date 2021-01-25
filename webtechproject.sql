-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: mariadb
-- Generation Time: Jan 25, 2021 at 03:18 PM
-- Server version: 10.5.8-MariaDB-1:10.5.8+maria~focal
-- PHP Version: 7.4.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `webtechproject`
--

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `name` varchar(32) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`name`, `last_update`) VALUES
('Apparels', '2021-01-13 21:27:09'),
('Books', '2021-01-13 21:27:09'),
('Computer Hardware & Accessories', '2021-01-13 21:27:09'),
('Consumer Electronics', '2021-01-13 21:27:09'),
('Fashion Accessories', '2021-01-13 21:27:09'),
('Food & Provisions', '2021-01-13 21:27:09'),
('Footwear', '2021-01-13 21:27:09'),
('Health & Beauty Supplements', '2021-01-13 21:27:09'),
('Home Décor Items', '2021-01-13 21:27:09'),
('Household Appliances', '2021-01-13 21:27:09'),
('Kitchen Ware', '2021-01-13 21:27:09'),
('Mobile Phones', '2021-01-13 21:27:09'),
('Sports & Fitness Equipment', '2021-01-13 21:27:09'),
('Toys and Games', '2021-01-13 21:27:09');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` varchar(24) NOT NULL,
  `user_email` varchar(32) NOT NULL,
  `product_id` smallint(5) UNSIGNED NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `time`, `status`, `user_email`, `product_id`, `last_update`) VALUES
(6, '2021-01-14 02:39:00', 'Waiting', 'team@trustmart.com', 51, '2021-01-14 03:00:08'),
(8, '2021-01-14 02:41:00', 'Waiting for Payment', 'test@example.com', 62, '2021-01-14 17:00:06'),
(9, '2021-01-17 15:44:42', 'New Order', 'markkofler@edu.aau.at', 52, '2021-01-17 15:44:43'),
(10, '2021-01-17 15:44:42', 'New Order', 'markkofler@edu.aau.at', 51, '2021-01-17 15:44:43'),
(11, '2021-01-17 15:45:21', 'New Order', 'markkofler@edu.aau.at', 50, '2021-01-17 15:45:22'),
(12, '2021-01-17 15:45:21', 'New Order', 'markkofler@edu.aau.at', 51, '2021-01-17 15:45:22'),
(13, '2021-01-14 02:41:00', 'Waiting for Payment', 'test@example.com', 50, '2021-01-17 15:53:00'),
(14, '2021-01-17 16:55:04', 'New Order', 'markkofler@edu.aau.at', 65, '2021-01-17 16:55:05'),
(15, '2021-01-17 16:55:04', 'New Order', 'markkofler@edu.aau.at', 50, '2021-01-17 16:55:05'),
(16, '2021-01-17 17:45:43', 'New Order', 'markkofler@edu.aau.at', 51, '2021-01-17 17:45:44'),
(17, '2021-01-17 17:45:43', 'New Order', 'markkofler@edu.aau.at', 52, '2021-01-17 17:45:44'),
(18, '2021-01-18 14:13:32', 'New Order', 'markkofler@edu.aau.at', 50, '2021-01-18 14:13:32'),
(19, '2021-01-18 15:47:11', 'New Order', 'markkofler@edu.aau.at', 52, '2021-01-18 15:47:12'),
(20, '2021-01-18 15:47:11', 'New Order', 'markkofler@edu.aau.at', 50, '2021-01-18 15:47:12'),
(21, '2021-01-24 15:21:46', 'New Order', 'markkofler@edu.aau.at', 53, '2021-01-24 15:21:54'),
(22, '2021-01-24 15:21:57', 'New Order', 'markkofler@edu.aau.at', 56, '2021-01-24 15:22:04'),
(23, '2021-01-24 15:21:57', 'New Order', 'markkofler@edu.aau.at', 51, '2021-01-24 15:22:04'),
(24, '2021-01-24 15:54:13', 'New Order', 'markkofler@edu.aau.at', 51, '2021-01-24 15:54:21'),
(25, '2021-01-24 15:54:13', 'New Order', 'markkofler@edu.aau.at', 53, '2021-01-24 15:54:21'),
(26, '2021-01-24 16:10:03', 'New Order', 'john@doe.com', 51, '2021-01-24 16:10:11'),
(27, '2021-01-24 16:10:03', 'New Order', 'john@doe.com', 50, '2021-01-24 16:10:11'),
(28, '2021-01-24 16:10:03', 'New Order', 'john@doe.com', 55, '2021-01-24 16:10:11'),
(29, '2021-01-24 16:17:39', 'New Order', 'markkofler@edu.aau.at', 53, '2021-01-24 16:17:47'),
(30, '2021-01-24 16:17:39', 'New Order', 'markkofler@edu.aau.at', 55, '2021-01-24 16:17:47');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` smallint(5) UNSIGNED NOT NULL,
  `name` varchar(64) NOT NULL,
  `price` smallint(5) UNSIGNED NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `image` varchar(64) DEFAULT NULL,
  `category_name` varchar(32) NOT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `description`, `image`, `category_name`, `last_update`) VALUES
(50, 'Nice Dress', 2999, 'Just a nice Dress.', 'https://i.imgur.com/DouWP9o.png', 'Apparels', '2021-01-14 00:40:40'),
(51, 'Jeans', 899, 'It\'s jeans. They\'re blue.', 'https://i.imgur.com/STdxvtX.jpg', 'Apparels', '2021-01-14 00:40:40'),
(52, 'Puffy Jacket', 1199, 'It\'s very warm and puffy.', 'https://i.imgur.com/sgagukW.png', 'Apparels', '2021-01-14 00:40:40'),
(53, 'Leather Jacket', 3499, 'Black leather jacket. Probably not real leather.', 'https://i.imgur.com/ZaUHlp0.png', 'Apparels', '2021-01-14 00:40:40'),
(54, 'Men\'s Underwear Briefs', 499, 'Set of 4. I couldn\'t take a picture of the red one because I was wearing it.', 'https://i.imgur.com/1DmesMC.png', 'Apparels', '2021-01-14 00:40:40'),
(55, 'Lord of the Rings Set', 3499, 'A set of books in the Lord of the Rings series', 'https://i.imgur.com/uiylaDW.png', 'Books', '2021-01-14 00:40:40'),
(56, 'Lord of the Rings Set', 3999, 'Paperback, includes The Hobbit for some reason', 'https://i.imgur.com/HJzWcuM.png', 'Books', '2021-01-14 00:40:40'),
(57, 'Lord of the Rings Set', 2799, 'Lord of the Rings books, used', 'https://i.imgur.com/ru5I2Nn.png', 'Books', '2021-01-14 00:40:40'),
(58, 'Lord of the Rings Set', 4299, 'Comes with a cool little book case', 'https://i.imgur.com/UKRk5jd.png', 'Books', '2021-01-14 00:40:40'),
(59, 'The Silmarillion', 1699, 'For nerds.', 'https://i.imgur.com/GPt8Vgo.jpg', 'Books', '2021-01-14 00:40:40'),
(60, 'Hard Disk', 2399, 'Just 1 TB, really bad deal tbh.', 'https://i.imgur.com/NzLtKqA.png', 'Computer Hardware & Accessories', '2021-01-14 00:41:05'),
(61, 'Graphics Card - Limited Stock!', 7999, 'This is actually just a bad clip-art of a graphics card. This might be a scam.', 'https://i.imgur.com/Mm6bCg8.png', 'Computer Hardware & Accessories', '2021-01-14 00:40:40'),
(62, 'USB-Stick', 1599, 'No idea how much storage this has. Think of it as a mystery box.', 'https://i.imgur.com/LQ9HhFk.jpg', 'Computer Hardware & Accessories', '2021-01-14 00:40:40'),
(63, 'Wireless Headphones', 2499, 'They also come in white but I lost the picture', 'https://i.imgur.com/qGTJ9sI.png', 'Computer Hardware & Accessories', '2021-01-14 00:40:40'),
(64, 'TV', 2499, NULL, 'https://i.imgur.com/C5ymM4I.png', 'Consumer Electronics', '2021-01-18 14:05:12'),
(65, 'Digital CAmera', 6499, NULL, 'https://i.imgur.com/TqVBCi7.png', 'Consumer Electronics', '2021-01-18 14:04:20'),
(79, 'Fancy Earrings', 6899, NULL, 'https://i.imgur.com/1N5o5Ho.png', 'Fashion Accessories', '2021-01-18 13:54:26'),
(80, 'Sunglasses', 4699, NULL, 'https://i.imgur.com/NHonhly.png', 'Fashion Accessories', '2021-01-18 13:54:26'),
(81, 'Watch', 8899, NULL, 'https://i.imgur.com/abRPHlE.png', 'Fashion Accessories', '2021-01-18 13:54:26'),
(82, 'Apple', 89, '3 of them', 'https://i.imgur.com/7rcBKgm.jpg', 'Food & Provisions', '2021-01-18 13:54:26'),
(83, 'Bananas', 139, NULL, 'https://i.imgur.com/N9DhMaE.png', 'Food & Provisions', '2021-01-18 13:54:26'),
(84, 'Ravioli', 699, NULL, 'https://i.imgur.com/dwUyTkX.png', 'Food & Provisions', '2021-01-18 13:54:26'),
(85, 'Sweet Shoes', 2699, NULL, 'https://i.imgur.com/BzHqfDo.png', 'Footwear', '2021-01-18 13:54:26'),
(86, 'Sick Shoes', 16899, NULL, 'https://i.imgur.com/OyUjeSP.png', 'Footwear', '2021-01-18 13:54:26'),
(87, 'Nice Shoes', 9599, NULL, 'https://i.imgur.com/eEaj6FT.png', 'Footwear', '2021-01-18 13:54:26'),
(88, 'Cute Shoes', 2699, NULL, 'https://i.imgur.com/mBLyPab.png', 'Footwear', '2021-01-18 13:54:26'),
(89, 'Shampoo', 1199, NULL, 'https://i.imgur.com/tDk9wzA.png', 'Heath & Beauty Supplies', '2021-01-18 13:54:26'),
(90, 'Lipstick', 1899, NULL, 'https://i.imgur.com/zrQri1X.png', 'Heath & Beauty Supplies', '2021-01-18 13:54:26'),
(91, 'Essential oils', 6999, NULL, 'https://i.imgur.com/7BEGNTe.png', 'Heath & Beauty Supplies', '2021-01-18 13:54:26'),
(92, 'Bonsai Tree', 3299, NULL, 'https://i.imgur.com/mUaTU6k.jpg', 'Home Décor Items', '2021-01-18 14:02:33'),
(93, 'Lamp', 1699, NULL, 'https://i.imgur.com/Is2jkg2.png', 'Home Décor Items', '2021-01-18 14:02:33'),
(94, 'Picture Frame', 599, NULL, 'https://i.imgur.com/6L8C2wc.png', 'Home Décor Items', '2021-01-18 14:02:33'),
(95, 'Colorful Pillow Cases', 4799, '7 colors!', 'https://i.imgur.com/grnteLT.png', 'Home Décor Items', '2021-01-18 14:02:33'),
(96, 'Toaster', 2999, NULL, 'https://i.imgur.com/J8V9hPM.png', 'Household Appliances', '2021-01-18 14:22:31'),
(97, 'Washing Machine', 34999, 'Colorful towels sold separately', 'https://i.imgur.com/gdU94lL.png', 'Household Appliances', '2021-01-18 14:22:31'),
(98, 'Hair Dryer', 1799, 'It\'s cute and pink', 'https://i.imgur.com/TiQKMwv.png', 'Household Appliances', '2021-01-18 14:22:31'),
(99, 'Pot', 4299, 'with lid', 'https://i.imgur.com/zHH4oAr.png', 'Kitchen Ware', '2021-01-18 14:22:31'),
(100, 'Knife', 399, NULL, 'https://i.imgur.com/3x2DfSo.png', 'Kitchen Ware', '2021-01-18 14:22:31'),
(101, 'Golden Spatula', 41999, NULL, 'https://i.imgur.com/Oz4qM2v.png', 'Kitchen Ware', '2021-01-18 14:22:31'),
(102, 'Old Phone', 399, NULL, 'https://i.imgur.com/dCzELNq.png', 'Mobile Phones', '2021-01-18 14:22:31'),
(103, 'Flip Phone', 1699, NULL, 'https://i.imgur.com/y1eo8eT.png', 'Mobile Phones', '2021-01-18 14:22:31'),
(104, 'Phone', 14899, NULL, 'https://i.imgur.com/4cvsmov.png', 'Mobile Phones', '2021-01-18 14:22:31'),
(105, 'Sports Water Bottle', 1399, NULL, 'https://i.imgur.com/xm6rJCc.png', 'Sports & Fitness Equipment', '2021-01-18 14:35:46'),
(106, 'Sports Bike', 5299, NULL, 'https://i.imgur.com/lHc9STL.png', 'Sports & Fitness Equipment', '2021-01-18 14:35:46'),
(107, 'Sports Car', 65535, NULL, 'https://i.imgur.com/lQlyyBB.png', 'Sports & Fitness Equipment', '2021-01-18 14:35:46'),
(108, 'Teddy Bear', 1399, NULL, 'https://i.imgur.com/zFUN1Mq.jpeg', 'Toys and Games', '2021-01-18 14:35:46'),
(109, 'Rubik\'s Cube', 999, NULL, 'https://i.imgur.com/MVcpVlZ.png', 'Toys and Games', '2021-01-18 14:35:46'),
(110, 'Radical Pogo Stick', 3299, NULL, 'https://i.imgur.com/DksVyju.png', 'Toys and Games', '2021-01-18 14:35:46'),
(111, 'Building Blocks Set', 2899, NULL, 'https://i.imgur.com/6iwi8kj.png', 'Toys and Games', '2021-01-18 14:35:46'),
(112, 'Monopoly Board Game', 1999, NULL, 'https://i.imgur.com/nlglpgx.png', 'Toys and Games', '2021-01-18 14:35:46'),
(113, 'Dice Set', 2699, '7 parts', 'https://i.imgur.com/yq5m1s6.png', 'Toys and Games', '2021-01-18 14:35:46');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `product_id` smallint(5) UNSIGNED NOT NULL,
  `user_email` varchar(32) NOT NULL,
  `value` tinyint(3) UNSIGNED NOT NULL,
  `text` varchar(128) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`product_id`, `user_email`, `value`, `text`, `last_update`) VALUES
(50, 'markkofler@edu.aau.at', 3, NULL, '2021-01-17 14:30:48'),
(50, 'test@example.com', 2, NULL, '2021-01-17 15:45:10'),
(51, 'john@doe.com', 1, NULL, '2021-01-24 16:09:15'),
(51, 'team@trustmart.com', 5, 'It\'s pants', '2021-01-14 03:28:56'),
(52, 'markkofler@edu.aau.at', 4, NULL, '2021-01-17 20:16:17'),
(53, 'markkofler@edu.aau.at', 5, NULL, '2021-01-17 20:15:59'),
(54, 'markkofler@edu.aau.at', 2, NULL, '2021-01-24 15:13:03'),
(55, 'markkofler@edu.aau.at', 3, NULL, '2021-01-17 20:15:50'),
(56, 'markkofler@edu.aau.at', 5, NULL, '2021-01-18 15:47:28'),
(58, 'markkofler@edu.aau.at', 1, NULL, '2021-01-24 15:57:25'),
(64, 'markkofler@edu.aau.at', 3, NULL, '2021-01-18 14:33:37'),
(65, 'markkofler@edu.aau.at', 3, NULL, '2021-01-17 14:37:14');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `email` varchar(32) NOT NULL,
  `password` char(60) NOT NULL,
  `name` varchar(32) NOT NULL,
  `address` varchar(64) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `creditcard` varchar(60) DEFAULT NULL,
  `last_update` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`email`, `password`, `name`, `address`, `phone`, `creditcard`, `last_update`) VALUES
('john@doe.com', '$2b$10$YOxnKlMP91YiMQOqEubF3e3QXSX8SKEsr6Ls3xSOOs6qwPEYPodJ.', 'John Doe', NULL, NULL, NULL, '2021-01-24 16:08:38'),
('markkofler@edu.aau.at', '$2b$10$6ND0waZ6DW51/AyONcy40evHLuc3nLS05Jk5hdlQKiX4nV1w3Fomu', 'Markus Kofler', NULL, NULL, NULL, '2021-01-17 13:57:05'),
('team@trustmart.com', '$2b$10$kzR8.RaM7u5fr4W2N6yHx.9VkeKoIyjg.DlfmjGeBkUeEnEMLfrNu', 'Trustmart Team', NULL, NULL, NULL, '2021-01-13 23:10:06'),
('test@example.com', '$2b$10$ziraJ4UTV8FyhVVNC7KJ1.6etkquufdG4eD3CusteEvkzYr60LNPa', 'Test User', NULL, NULL, NULL, '2021-01-14 16:54:21');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`name`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_email` (`user_email`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category` (`category_name`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`product_id`,`user_email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` smallint(5) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=114;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `users` (`email`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
