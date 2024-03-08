-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.30 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for ujikom
CREATE DATABASE IF NOT EXISTS `ujikom` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `ujikom`;

-- Dumping structure for table ujikom.deleted
CREATE TABLE IF NOT EXISTS `deleted` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `data` json DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=204 DEFAULT CHARSET=ascii ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.deleted: ~1 rows (approximately)
REPLACE INTO `deleted` (`id`, `table_name`, `data`, `created_at`) VALUES
	(202, 'master_barang', '{"id": 11807, "kode": "BRG_005", "nama": "Barang Usulan 1", "harga": 200000.0, "satuan": "70", "pdam_id": 4, "created_at": "2023-08-03 16:49:39.000000", "created_by": "Super Admin", "updated_at": null, "kategori_id": 33}', '2023-08-09 11:29:28.502201');

-- Dumping structure for table ujikom.log
CREATE TABLE IF NOT EXISTS `log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `table_name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `data` json DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unique` (`id`) USING BTREE,
  KEY `priority` (`table_name`,`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=ascii ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.log: ~0 rows (approximately)

-- Dumping structure for table ujikom.log_akses
CREATE TABLE IF NOT EXISTS `log_akses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pdam_id` int DEFAULT NULL,
  `times` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `id_user` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `username` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `name` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `ip` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `message` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `data` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `response` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `controller` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `action` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=64 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.log_akses: ~63 rows (approximately)
REPLACE INTO `log_akses` (`id`, `pdam_id`, `times`, `id_user`, `username`, `name`, `ip`, `url`, `message`, `data`, `response`, `controller`, `action`) VALUES
	(1, 1, '2023-11-14 01:50:21', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/update', 'Update Data Master-Referensi Barang-Satuan', '{"nama":"ELIS SUKA MAJU","kode":"k002","password":"superkasir","password_hash":"$2y$10$Ze1zOqLzYheKpNo.tjykGuYZ9aFCOf6lW63BHFyqvM4kV8FzV\\/B4e","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'UPDATE'),
	(2, 1, '2023-11-14 02:23:14', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/store', 'Insert Data Master-Referensi Barang-Satuan', '{"nama":"Ikbal","kode":"k006","password":"masterplan","password_hash":"$2y$10$uqD7VF\\/dpbyac18NLrXjwO9SqkQslJqHYqbLdcA1HwhQtXyIg6\\/aO","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'INSERT'),
	(3, 1, '2023-11-14 02:25:19', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/update', 'Update Data Master-Referensi Barang-Satuan', '{"nama":"Ikbal","kode":"k006","password":"superkasir","password_hash":"$2y$10$g34qDopGoRgVuxq7ta7xDeKEQGk.Hpcu6i0vBAtPsH4O45lEpDc7a","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'UPDATE'),
	(4, 1, '2023-11-14 02:25:47', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/update', 'Update Data Master-Referensi Barang-Satuan', '{"nama":"YANTI SUKA HAJI","kode":"k001","password":"superkasir","password_hash":"$2y$10$nSIeuoLO6.OGV27U4p8umeGufS543ZN17xw62WVcYHLJ6O23I3eQO","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'UPDATE'),
	(5, 1, '2023-11-14 02:25:55', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/update', 'Update Data Master-Referensi Barang-Satuan', '{"nama":"Kopi Hitman","kode":"k003","password":"superkasir","password_hash":"$2y$10$BAXj2j\\/9ITGTjOByXyGEA.IBymMNhtWoXq2zmwkI4mBlHlnUlDgga","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'UPDATE'),
	(6, 1, '2023-11-14 02:30:48', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/delete?id=8', 'Delete Data Master-Referensi Barang-Satuan', '{"id":"8"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'DELETE'),
	(7, 1, '2023-11-14 02:31:41', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/delete?id=5', 'Delete Data Master-Referensi Barang-Satuan', '{"id":"5"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'DELETE'),
	(8, 1, '2023-11-14 02:40:37', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/store', 'Insert Data Master-Referensi Barang-Kategori', '{"nama":"kentang","jumlah":"1000","satuan_id":"1","harga":"10000","created_at":"2023-11-14 09:40:37","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'INSERT'),
	(9, 1, '2023-11-14 02:40:46', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/update', 'Update Data Master-Referensi Barang-Kategori', '{"nama":"kentang","jumlah":"1000","satuan_id":"1","harga":"15000","updated_at":"2023-11-14 09:40:46","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'UPDATE'),
	(10, 1, '2023-11-17 01:26:36', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/update', 'Update Data Master-Referensi Barang-Satuan', '{"nama":"Ahmad","kode":"k002","password":"superkasir","password_hash":"$2y$10$YPGah4qfEjMZWgT584f16.XMKWGU.yWhJITcwh6QSJj7x1tQIEJIi","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'UPDATE'),
	(11, 1, '2023-11-17 01:27:47', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/store', 'Insert Data Master-Referensi Barang-Satuan', '{"nama":"superadmin","kode":"SP","password":"adminsuper","password_hash":"$2y$10$jXo2KqbDtZVXj63ItWQ9su.SQ8CAnyOLbxiT5P5HOuFJhUmzR2oSS","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'INSERT'),
	(12, 1, '2023-11-17 01:31:45', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/update', 'Update Data Master-Referensi Barang-Satuan', '{"nama":"Derral","kode":"k003","password":"superkasir","password_hash":"$2y$10$k5wFbZ2Vp6YLxeafxe6nYePiL.hq5U7DC33R8xH.O0UuSh3FWomzu","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'UPDATE'),
	(13, 1, '2023-11-17 01:31:50', '225', 'owner', 'OWNER', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/update', 'Update Data Master-Referensi Barang-Satuan', '{"nama":"Ahmad","kode":"k002","password":"superkasir","password_hash":"$2y$10$\\/m\\/7ZsMaAiNmQvYxGx6c5OqeH8pF9uy11PDzmuWl3X1Tg\\/KaMCTkq","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'UPDATE'),
	(14, 1, '2023-11-20 08:55:13', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/store', 'Insert Data Master-Referensi Barang-Kategori', '{"nama":"Air","jumlah":"1000","satuan_id":"2","harga":"5000","created_at":"2023-11-20 15:55:13","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'INSERT'),
	(15, 1, '2023-11-20 08:55:34', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/update', 'Update Data Master-Referensi Barang-Kategori', '{"nama":"Kentang","jumlah":"1000","satuan_id":"1","harga":"15000","updated_at":"2023-11-20 15:55:34","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'UPDATE'),
	(16, 1, '2023-11-20 08:55:51', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/update', 'Update Data Master-Referensi Barang-Kategori', '{"nama":"Gula","jumlah":"1000","satuan_id":"1","harga":"50000","updated_at":"2023-11-20 15:55:51","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'UPDATE'),
	(17, 1, '2023-11-20 08:56:00', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/update', 'Update Data Master-Referensi Barang-Kategori', '{"nama":"Coklat","jumlah":"1000","satuan_id":"1","harga":"150000","updated_at":"2023-11-20 15:56:00","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'UPDATE'),
	(18, 1, '2023-11-20 08:56:23', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/update', 'Update Data Master-Referensi Barang-Kategori', '{"nama":"Cup","jumlah":"1","satuan_id":"3","harga":"500","updated_at":"2023-11-20 15:56:23","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'UPDATE'),
	(19, 1, '2023-11-20 08:56:31', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/update', 'Update Data Master-Referensi Barang-Kategori', '{"nama":"Boba","jumlah":"1000","satuan_id":"1","harga":"50000","updated_at":"2023-11-20 15:56:31","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'UPDATE'),
	(20, 1, '2023-11-20 08:56:42', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/update', 'Update Data Master-Referensi Barang-Kategori', '{"nama":"Kopi","jumlah":"1000","satuan_id":"1","harga":"100000","updated_at":"2023-11-20 15:56:42","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'UPDATE'),
	(21, 1, '2023-11-20 09:10:47', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/bahan/store', 'Insert Data Master-Referensi Barang-Kategori', '{"nama":"Tepung Terigu","jumlah":"1000","satuan_id":"1","harga":"15000","created_at":"2023-11-20 16:10:47","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Kategori\\Controller', 'INSERT'),
	(22, 1, '2023-11-24 03:49:12', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=55', 'Delete Data Master-Referensi Barang-Barang', '{"id":"55"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(23, 1, '2023-11-24 03:49:15', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=51', 'Delete Data Master-Referensi Barang-Barang', '{"id":"51"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(24, 1, '2023-11-24 09:24:09', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=25', 'Delete Data Master-Referensi Barang-Barang', '{"id":"25"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(25, 1, '2023-11-24 09:24:17', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=49', 'Delete Data Master-Referensi Barang-Barang', '{"id":"49"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(26, 1, '2023-11-24 09:24:53', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=43', 'Delete Data Master-Referensi Barang-Barang', '{"id":"43"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(27, 1, '2023-11-24 09:24:59', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=42', 'Delete Data Master-Referensi Barang-Barang', '{"id":"42"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(28, 1, '2023-11-24 09:25:11', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=41', 'Delete Data Master-Referensi Barang-Barang', '{"id":"41"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(29, 1, '2023-11-24 09:27:10', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=45', 'Delete Data Master-Referensi Barang-Barang', '{"id":"45"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(30, 1, '2023-11-24 09:27:21', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=33', 'Delete Data Master-Referensi Barang-Barang', '{"id":"33"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(31, 1, '2023-11-25 08:14:38', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/store', 'Insert Data Master-Referensi Barang-Satuan', '{"nama":"Hadi","kode":"k009","password":"superkasir","password_hash":"$2y$10$0kfpoyvQV49hziDPfyDkbetTAgmD8VJX5Caj0HKbUOdCGboeAYJua","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'INSERT'),
	(32, 1, '2023-11-27 03:09:56', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=56', 'Delete Data Master-Referensi Barang-Barang', '{"id":"56"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(33, 1, '2023-11-27 03:10:01', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=57', 'Delete Data Master-Referensi Barang-Barang', '{"id":"57"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(34, 1, '2023-11-27 06:54:59', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/voucher/store', 'Insert Data Master-Referensi Barang-Barang', '{"kode":"p007","diskon":"0.09","qty":"7","active_at":"2023-11-14","expired_at":"2023-11-30","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'INSERT'),
	(35, 1, '2023-11-27 06:55:52', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/kasir/update', 'Update Data Master-Referensi Barang-Satuan', '{"nama":"Jhon","kode":"k005","password":"superkasir","password_hash":"$2y$10$wffDNviC571FqbkHsRPkcON4JcbD8HOPHpeeo7anprh2TFWRbBN86","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'UPDATE'),
	(36, 1, '2023-11-29 02:18:41', '234', 'superadmin', 'Super Admin', '::1', 'localhost/cafe-tahura/panel//master/voucher/update', 'Update Data Master-Referensi Barang-Barang', '{"kode":"p007","diskon":"0.09","qty":"10","active_at":"2023-11-14","expired_at":"2023-11-30","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'UPDATE'),
	(37, 1, '2023-11-29 04:24:04', '234', 'superadmin', 'Super Admin', '::1', 'localhost/cafe-tahura/panel//master/voucher/update', 'Update Data Master-Referensi Barang-Barang', '{"kode":"p007","diskon":"0.09","qty":"100","active_at":"2023-11-14","expired_at":"2023-11-30","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'UPDATE'),
	(38, 1, '2023-12-04 09:20:48', '234', 'superadmin', 'Super Admin', '::1', 'localhost/cafe-tahura/panel//master/voucher/update', 'Update Data Master-Referensi Barang-Barang', '{"kode":"p007","diskon":"0.09","qty":"88","active_at":"2023-11-14","expired_at":"2023-12-09","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'UPDATE'),
	(39, 1, '2023-12-06 09:13:15', '234', 'superadmin', 'Super Admin', '127.0.0.1', 'localhost/cafe-tahura/panel//master/produk/delete?id=58', 'Delete Data Master-Referensi Barang-Barang', '{"id":"58"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(40, 1, '2023-12-30 17:14:15', '234', 'superadmin', 'Super Admin', '::1', 'localhost/cafe-tahura/panel//master/voucher/store', 'Insert Data Master-Referensi Barang-Barang', '{"kode":"narda","diskon":"0.10","qty":"3","active_at":"2023-12-31","expired_at":"2024-01-10","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'INSERT'),
	(41, 1, '2024-01-22 12:34:50', '234', 'superadmin', 'Super Admin', '::1', 'localhost/phalcon-tahura-pos-master/panel//master/voucher/update', 'Update Data Master-Referensi Barang-Barang', '{"kode":"p007","diskon":"0.09","qty":"80","active_at":"2023-11-14","expired_at":"2024-01-23","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'UPDATE'),
	(42, 1, '2024-01-22 12:37:27', '234', 'superadmin', 'Super Admin', '::1', 'localhost/phalcon-tahura-pos-master/panel//master/voucher/store', 'Insert Data Master-Referensi Barang-Barang', '{"kode":"diskonramadhan","diskon":"0.09","qty":"100","active_at":"2024-01-21","expired_at":"2024-01-30","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'INSERT'),
	(43, 1, '2024-01-25 01:54:09', '234', 'superadmin', 'Super Admin', '::1', 'localhost/phalcon-tahura-pos-master/panel//master/voucher/store', 'Insert Data Master-Referensi Barang-Barang', '{"kode":"KanooGanteng","diskon":"0.90","qty":"100","active_at":"2024-01-25","expired_at":"2024-01-31","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'INSERT'),
	(44, 1, '2024-02-13 02:30:15', '234', 'superadmin', 'Super Admin', '::1', 'localhost/phalcon-tahura-pos-master/panel//master/kasir/store', 'Insert Data Master-Referensi Barang-Satuan', '{"nama":"abuy","kode":"k010","password":"superkasir","password_hash":"$2y$10$1j7D2viWrQoNh87XWmL8DeTXGMacfWQyvoLngM4wtQQO7xzGpvvN6","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'INSERT'),
	(45, 1, '2024-02-24 10:47:01', '234', 'superadmin', 'Super Admin', '::1', 'localhost/phalcon-tahura-pos-master/panel//master/voucher/store', 'Insert Data Master-Referensi Barang-Barang', '{"kode":"009","diskon":"0.09","qty":"0","active_at":"2024-02-23","expired_at":"2024-02-25","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'INSERT'),
	(46, 1, '2024-02-24 10:47:13', '234', 'superadmin', 'Super Admin', '::1', 'localhost/phalcon-tahura-pos-master/panel//master/voucher/update', 'Update Data Master-Referensi Barang-Barang', '{"kode":"009","diskon":"0.09","qty":"1","active_at":"2024-02-23","expired_at":"2024-02-25","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'UPDATE'),
	(47, 1, '2024-02-29 08:56:41', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/produk/delete?id=59', 'Delete Data Master-Referensi Barang-Barang', '{"id":"59"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(48, 1, '2024-02-29 08:56:47', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/produk/delete?id=60', 'Delete Data Master-Referensi Barang-Barang', '{"id":"60"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(49, 1, '2024-02-29 08:56:53', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/produk/delete?id=61', 'Delete Data Master-Referensi Barang-Barang', '{"id":"61"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(50, 1, '2024-02-29 08:57:03', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/produk/delete?id=62', 'Delete Data Master-Referensi Barang-Barang', '{"id":"62"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(51, 1, '2024-02-29 10:43:13', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/store', 'Insert Data Master-Referensi Barang-Barang', '{"kode":"dapa","diskon":"0.09","qty":"100","active_at":"2024-02-28","expired_at":"2024-12-30","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'INSERT'),
	(52, 1, '2024-03-04 01:11:03', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/kasir/store', 'Insert Data Master-Referensi Barang-Satuan', '{"nama":"jaki","kode":"k0010","password":"jaki","password_hash":"$2y$10$NNptykRVNlQhvdXXib6Q5..GDYOCPMlguuT2KXYQE7jBPb5p7zIve","pdam_id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'INSERT'),
	(53, 1, '2024-03-06 01:59:54', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/delete?id=1', 'Delete Data Master-Referensi Barang-Barang', '{"id":"1"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(54, 1, '2024-03-06 01:59:58', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/delete?id=3', 'Delete Data Master-Referensi Barang-Barang', '{"id":"3"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(55, 1, '2024-03-06 02:00:00', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/delete?id=4', 'Delete Data Master-Referensi Barang-Barang', '{"id":"4"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(56, 1, '2024-03-06 02:00:03', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/delete?id=5', 'Delete Data Master-Referensi Barang-Barang', '{"id":"5"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(57, 1, '2024-03-06 02:00:05', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/delete?id=6', 'Delete Data Master-Referensi Barang-Barang', '{"id":"6"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(58, 1, '2024-03-06 02:00:08', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/delete?id=7', 'Delete Data Master-Referensi Barang-Barang', '{"id":"7"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(59, 1, '2024-03-06 02:00:10', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/delete?id=8', 'Delete Data Master-Referensi Barang-Barang', '{"id":"8"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(60, 1, '2024-03-06 02:00:13', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/voucher/delete?id=9', 'Delete Data Master-Referensi Barang-Barang', '{"id":"9"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(61, 1, '2024-03-06 03:36:46', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/produk/delete?id=63', 'Delete Data Master-Referensi Barang-Barang', '{"id":"63"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Barang\\Controller', 'DELETE'),
	(62, 1, '2024-03-07 01:27:13', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/kasir/delete?id=10', 'Delete Data Master-Referensi Barang-Satuan', '{"id":"10"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'DELETE'),
	(63, 1, '2024-03-07 01:27:17', '234', 'superadmin', 'Super Admin', '::1', 'localhost/ujikom/panel//master/kasir/delete?id=11', 'Delete Data Master-Referensi Barang-Satuan', '{"id":"11"}', 'true', 'App\\Modules\\Defaults\\Master\\ReferensiBarang\\Satuan\\Controller', 'DELETE');

-- Dumping structure for table ujikom.master_bahan
CREATE TABLE IF NOT EXISTS `master_bahan` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) DEFAULT NULL,
  `jumlah` int DEFAULT NULL,
  `satuan_id` int DEFAULT NULL,
  `harga` int DEFAULT NULL,
  `pdam_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nama` (`nama`),
  KEY `FK_master_bahan_master_satuan` (`satuan_id`),
  CONSTRAINT `FK_master_bahan_master_satuan` FOREIGN KEY (`satuan_id`) REFERENCES `master_satuan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ujikom.master_bahan: ~9 rows (approximately)
REPLACE INTO `master_bahan` (`id`, `nama`, `jumlah`, `satuan_id`, `harga`, `pdam_id`) VALUES
	(1, 'Kopi', 1000, 1, 100000, 1),
	(6, 'Boba', 1000, 1, 50000, 1),
	(8, 'Cup', 1, 3, 500, 1),
	(9, 'susu full cream', 1000, 2, 30000, 1),
	(10, 'Coklat', 1000, 1, 150000, 1),
	(11, 'Gula', 1000, 1, 50000, 1),
	(13, 'Kentang', 1000, 1, 15000, 1),
	(14, 'Air', 1000, 2, 5000, 1),
	(15, 'Tepung Terigu', 1000, 1, 15000, 1);

-- Dumping structure for table ujikom.master_kasir
CREATE TABLE IF NOT EXISTS `master_kasir` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0',
  `kode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0',
  `password` varchar(50) DEFAULT '0',
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '0',
  `pdam_id` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ujikom.master_kasir: ~6 rows (approximately)
REPLACE INTO `master_kasir` (`id`, `nama`, `kode`, `password`, `password_hash`, `pdam_id`) VALUES
	(1, 'Andhika', 'k001', 'superkasir', '$2y$10$nSIeuoLO6.OGV27U4p8umeGufS543ZN17xw62WVcYHLJ6O23I3eQO', 1),
	(2, 'Ahmad', 'k002', 'superkasir', '$2y$10$/m/7ZsMaAiNmQvYxGx6c5OqeH8pF9uy11PDzmuWl3X1Tg/KaMCTkq', 1),
	(3, 'Derral', 'k003', 'superkasir', '$2y$10$k5wFbZ2Vp6YLxeafxe6nYePiL.hq5U7DC33R8xH.O0UuSh3FWomzu', 1),
	(12, 'Hadi', 'k009', 'superkasir', '$2y$10$0kfpoyvQV49hziDPfyDkbetTAgmD8VJX5Caj0HKbUOdCGboeAYJua', 1),
	(13, 'abuy', 'k010', 'superkasir', '$2y$10$1j7D2viWrQoNh87XWmL8DeTXGMacfWQyvoLngM4wtQQO7xzGpvvN6', 1),
	(14, 'jaki', 'k0010', 'jaki', '$2y$10$NNptykRVNlQhvdXXib6Q5..GDYOCPMlguuT2KXYQE7jBPb5p7zIve', 1);

-- Dumping structure for table ujikom.master_kategori
CREATE TABLE IF NOT EXISTS `master_kategori` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nama` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `icon` varchar(50) DEFAULT NULL,
  `pdam_id` int DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `nama` (`nama`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.master_kategori: ~3 rows (approximately)
REPLACE INTO `master_kategori` (`id`, `nama`, `icon`, `pdam_id`) VALUES
	(1, 'Minuman', 'fas fa-coffee', 1),
	(2, 'Makanan', 'fa fa-hamburger', 1),
	(3, 'Desert', 'fa fa-ice-cream', 1);

-- Dumping structure for table ujikom.master_produk
CREATE TABLE IF NOT EXISTS `master_produk` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kategori_id` int DEFAULT '0',
  `nama` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `gambar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `hpp` int DEFAULT '0',
  `harga_jual` int DEFAULT '0',
  `stok` int DEFAULT '0',
  `pdam_id` int DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `FK_master_produk_master_kategori` (`kategori_id`),
  CONSTRAINT `FK_master_produk_master_kategori` FOREIGN KEY (`kategori_id`) REFERENCES `master_kategori` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ujikom.master_produk: ~26 rows (approximately)
REPLACE INTO `master_produk` (`id`, `kategori_id`, `nama`, `gambar`, `hpp`, `harga_jual`, `stok`, `pdam_id`) VALUES
	(1, 1, 'Coffe With Boba', '6d52bedcd811f586e37b5210b224fee8.png', 10000, 15000, 0, 1),
	(14, 2, 'Kentang Goreng', '9391a0477657efc94b1ef69d31d82daf.png', 9000, 15000, 2, 1),
	(15, 1, 'Coffee Milk', 'f96bc921c1ba6a312d00f5412f442e0c.png', 15000, 17000, 0, 1),
	(17, 1, 'Teh Manis Lemon', '4c1330ebdaa9512cc4ef75e99e5aa0a3.png', 7000, 10000, 0, 1),
	(18, 1, 'Americano', 'b52e7e5655abc1f32a7fffe870370185.png', 13000, 16000, 5, 1),
	(19, 1, 'Latte', 'f72f2ad7f1ac1b33eb0ffe5856899b43.png', 15000, 17000, 3, 1),
	(20, 1, 'Cappucino', '1d369743a5a087624a4f4d1b3e6a4968.png', 15000, 18000, 8, 1),
	(22, 1, 'Mocha', '921a654acdc455bde442926b6e6da4e7.png', 14000, 17000, 4, 1),
	(23, 1, 'Cold Brew', '0c4bf232b6d3410f4f9a4f13f45c21d0.png', 13000, 17000, 4, 1),
	(24, 1, 'Affogato', 'bb99c8d6dec06909325e6374453c50ca.png', 15000, 19000, 0, 1),
	(26, 2, 'Cake', 'd018d43ada8fabaf26a9b46a63b1989b.png', 15000, 20000, 0, 1),
	(27, 2, 'Pastry', '4a3f0a117b79843c4b7a92a216728d77.png', 16000, 21000, 0, 1),
	(28, 2, 'Sandwich', '1b054bda31c55db14f58466497972a15.png', 12000, 15000, 0, 1),
	(29, 2, 'Pasta', 'cf520fe1c1e60c4396dcaddba37fce41.png', 17000, 25000, 0, 1),
	(30, 2, 'Muffin', '4689df9053d8ffd6b5295c41d79b5419.png', 12000, 15000, 0, 1),
	(31, 2, 'Pancake', 'bf4e9e606f2ab4765643937f77d18366.png', 12000, 15000, 0, 1),
	(32, 2, 'Burger', 'ede506681a629a6d4565698743ed1801.png', 17000, 25000, 0, 1),
	(34, 2, 'Pie', '23adca821aa1f66d576986ce5b6a6b08.png', 25000, 37500, 0, 1),
	(35, 3, 'Es Campur', '174d407fa92d6585ef347a8af25fe842.png', 10000, 15000, 0, 1),
	(36, 3, 'Cendol', '47af29e6d3fa7376fd30294af679936f.png', 10000, 15000, 0, 1),
	(37, 3, 'Es Pisang Ijo', '8433634f9bf4605dfbeba07444f710eb.png', 10000, 15000, 0, 1),
	(39, 3, 'Ice Cream', '2946e1c461a97a36f8346dec33924972.png', 5000, 10000, 0, 1),
	(40, 3, 'Klepon', 'e4adba96bf9cb142d1017272fe7dfab4.png', 2000, 3000, 0, 1),
	(44, 3, 'Tiramisu', 'e0d5d0a913fdca680c3e7a7d8bc564b3.png', 15000, 20000, 0, 1),
	(54, 1, 'Jus Alpukat', 'c769c7188caf420464e2f2fbeed206a0.png', 12000, 15000, 0, 1),
	(64, 1, 'teh manis', 'fe29f40abe844b0e5cffd1ce152c917e.png', 10000, 15000, 5, 1);

-- Dumping structure for table ujikom.master_produk_detail
CREATE TABLE IF NOT EXISTS `master_produk_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `produk_id` int NOT NULL,
  `bahan_id` int NOT NULL,
  `jumlah` int DEFAULT NULL,
  `harga` int DEFAULT NULL,
  `pdam_id` int DEFAULT '1',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `id` (`id`),
  KEY `FK_master_produk_detail_master_bahan` (`bahan_id`),
  CONSTRAINT `FK_master_produk_detail_master_bahan` FOREIGN KEY (`bahan_id`) REFERENCES `master_bahan` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=130 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ujikom.master_produk_detail: ~110 rows (approximately)
REPLACE INTO `master_produk_detail` (`id`, `produk_id`, `bahan_id`, `jumlah`, `harga`, `pdam_id`) VALUES
	(1, 1, 8, 7, 3500, 1),
	(2, 1, 1, 8, 800, 1),
	(5, 54, 8, 13, 6500, 1),
	(7, 14, 1, 6, 600, 1),
	(8, 14, 8, 6, 3000, 1),
	(9, 1, 11, 55, 2750, 1),
	(11, 20, 8, 16, 8000, 1),
	(12, 27, 1, 7, 700, 1),
	(13, 27, 8, 2, 1000, 1),
	(14, 27, 11, 51, 2550, 1),
	(15, 32, 1, 7, 700, 1),
	(16, 32, 8, 50, 25000, 1),
	(17, 32, 11, 51, 2550, 1),
	(18, 17, 1, 3, 300, 1),
	(19, 17, 8, 2, 1000, 1),
	(20, 17, 11, 51, 2550, 1),
	(21, 26, 1, 7, 700, 1),
	(22, 26, 8, 2, 1000, 1),
	(23, 26, 11, 51, 2550, 1),
	(24, 30, 1, 1, 100, 1),
	(25, 30, 8, 2, 1000, 1),
	(26, 30, 11, 51, 2550, 1),
	(27, 15, 1, 3, 300, 1),
	(28, 15, 8, 2, 1000, 1),
	(29, 15, 11, 51, 2550, 1),
	(30, 19, 1, 6, 600, 1),
	(31, 19, 8, 5, 2500, 1),
	(32, 19, 11, 54, 2700, 1),
	(33, 18, 1, 3, 300, 1),
	(34, 18, 8, 2, 1000, 1),
	(35, 18, 11, 51, 2550, 1),
	(36, 22, 1, 3, 300, 1),
	(37, 22, 8, 2, 1000, 1),
	(38, 22, 11, 53, 2650, 1),
	(39, 28, 1, 7, 700, 1),
	(40, 28, 8, 2, 1000, 1),
	(41, 28, 11, 51, 2550, 1),
	(42, 29, 1, 1, 100, 1),
	(43, 29, 8, 2, 1000, 1),
	(45, 23, 1, 5, 500, 1),
	(46, 23, 8, 5, 2500, 1),
	(47, 23, 11, 54, 2700, 1),
	(48, 24, 1, 7, 700, 1),
	(49, 24, 8, 50, 25000, 1),
	(50, 24, 11, 51, 2550, 1),
	(54, 40, 1, 2, 200, 1),
	(55, 40, 8, 1, 500, 1),
	(56, 40, 11, 50, 2500, 1),
	(57, 39, 1, 4, 400, 1),
	(58, 39, 8, 1, 500, 1),
	(59, 39, 11, 54, 2700, 1),
	(60, 37, 1, 7, 700, 1),
	(61, 37, 8, 3, 1500, 1),
	(62, 37, 11, 53, 2650, 1),
	(63, 36, 1, 7, 700, 1),
	(64, 36, 8, 7, 3500, 1),
	(65, 36, 11, 60, 3000, 1),
	(66, 35, 1, 7, 700, 1),
	(67, 35, 8, 7, 3500, 1),
	(68, 35, 11, 80, 4000, 1),
	(69, 34, 1, 7, 700, 1),
	(70, 34, 8, 50, 25000, 1),
	(71, 34, 11, 80, 4000, 1),
	(72, 31, 1, 1, 100, 1),
	(73, 31, 8, 2, 1000, 1),
	(74, 31, 11, 51, 2550, 1),
	(75, 1, 14, 2, 10, 1),
	(78, 20, 1, 3, 300, 1),
	(79, 20, 11, 51, 2550, 1),
	(80, 44, 8, 6, 3000, 1),
	(81, 44, 11, 1, 50, 1),
	(82, 54, 11, 1, 50, 1),
	(83, 24, 9, 2, 60, 1),
	(84, 24, 10, 1, 150, 1),
	(85, 32, 9, 2, 60, 1),
	(86, 32, 10, 1, 150, 1),
	(87, 32, 13, 2, 30, 1),
	(88, 32, 15, 15, 7500, 1),
	(89, 26, 9, 2, 60, 1),
	(90, 26, 10, 1, 150, 1),
	(91, 26, 13, 2, 30, 1),
	(92, 26, 15, 50, 750, 1),
	(93, 27, 9, 50, 1500, 1),
	(94, 27, 10, 1, 150, 1),
	(95, 27, 13, 2, 30, 1),
	(96, 27, 15, 50, 750, 1),
	(97, 28, 9, 50, 1500, 1),
	(98, 28, 10, 1, 150, 1),
	(99, 28, 13, 2, 30, 1),
	(100, 28, 15, 50, 750, 1),
	(101, 28, 14, 2, 10, 1),
	(102, 31, 9, 50, 1500, 1),
	(103, 31, 10, 1, 150, 1),
	(104, 31, 13, 50, 750, 1),
	(105, 31, 15, 50, 750, 1),
	(106, 31, 14, 2, 10, 1),
	(107, 31, 6, 2, 100, 1),
	(108, 30, 9, 50, 1500, 1),
	(109, 30, 10, 1, 150, 1),
	(110, 30, 13, 1, 15, 1),
	(111, 30, 15, 2, 30, 1),
	(112, 30, 14, 2, 10, 1),
	(113, 30, 6, 2, 100, 1),
	(114, 29, 11, 51, 2550, 1),
	(115, 29, 9, 50, 1500, 1),
	(116, 29, 10, 1, 150, 1),
	(117, 29, 13, 11, 5500, 1),
	(118, 29, 15, 11, 1100, 1),
	(119, 29, 14, 12, 60, 1),
	(120, 29, 6, 2, 100, 1);

-- Dumping structure for table ujikom.master_voucher
CREATE TABLE IF NOT EXISTS `master_voucher` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kode` varchar(255) NOT NULL DEFAULT 'p001',
  `diskon` decimal(20,2) DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `active_at` date DEFAULT NULL,
  `expired_at` date DEFAULT NULL,
  `pdam_id` int DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `kode` (`kode`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ujikom.master_voucher: ~4 rows (approximately)
REPLACE INTO `master_voucher` (`id`, `kode`, `diskon`, `qty`, `active_at`, `expired_at`, `pdam_id`) VALUES
	(10, 'diskonramadhan', 0.09, 100, '2024-01-21', '2024-01-30', 1),
	(11, 'KanooGanteng', 0.90, 97, '2024-01-25', '2024-01-31', 1),
	(12, '009', 0.09, 0, '2024-02-23', '2024-02-25', 1),
	(13, 'dapa', 0.09, 96, '2024-02-28', '2024-12-30', 1);

-- Dumping structure for table ujikom.menu
CREATE TABLE IF NOT EXISTS `menu` (
  `id_menu` int NOT NULL AUTO_INCREMENT,
  `nama_menu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `jenis` smallint DEFAULT NULL,
  `parent_menu` smallint DEFAULT NULL,
  `link_menu` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `urutan` smallint DEFAULT NULL,
  `is_aktif` tinyint DEFAULT '1',
  `is_tampil` tinyint DEFAULT '1',
  `keterangan` text CHARACTER SET latin1 COLLATE latin1_swedish_ci,
  PRIMARY KEY (`id_menu`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.menu: ~12 rows (approximately)
REPLACE INTO `menu` (`id_menu`, `nama_menu`, `jenis`, `parent_menu`, `link_menu`, `icon`, `urutan`, `is_aktif`, `is_tampil`, `keterangan`) VALUES
	(1, 'Dashboard', 0, 0, 'dashboard', 'fa fa-tachometer-alt', 1, 1, 1, NULL),
	(2, 'Master', 0, 0, NULL, 'fa-database', 2, 1, 1, NULL),
	(10, 'Pengaturan', 0, 0, NULL, 'fa-cog', 99, 1, 1, NULL),
	(13, 'IPA', 1, 2, NULL, NULL, 3, 1, 0, NULL),
	(14, 'Intake', 1, 2, NULL, NULL, 4, 1, 0, NULL),
	(20, 'Voucher', 1, 2, 'master/voucher', NULL, 2, 1, 1, NULL),
	(21, 'Data Kasir', 1, 2, 'master/kasir', NULL, 3, 1, 1, NULL),
	(22, 'Produk', 1, 2, 'master/produk', NULL, 1, 1, 1, NULL),
	(42, 'User', 1, 10, 'pengaturan/user', NULL, 1, 1, 1, NULL),
	(43, 'Ganti Password', 1, 10, 'pengaturan/ubah-password', NULL, 2, 1, 1, NULL),
	(45, 'Kasir', 0, 0, 'kasir', 'fa-cash-register', 3, 1, 1, NULL),
	(46, 'Laporan', 0, 0, 'laporan', 'fa-file-alt', 4, 1, 1, NULL);

-- Dumping structure for table ujikom.menu_otorisasi
CREATE TABLE IF NOT EXISTS `menu_otorisasi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pdam_id` int DEFAULT '1',
  `id_menu` int DEFAULT NULL,
  `id_role` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2390 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.menu_otorisasi: ~24 rows (approximately)
REPLACE INTO `menu_otorisasi` (`id`, `pdam_id`, `id_menu`, `id_role`) VALUES
	(1, 1, 1, 1),
	(2, 1, 2, 1),
	(12, 1, 12, 1),
	(13, 1, 13, 1),
	(14, 1, 14, 1),
	(20, 1, 20, 1),
	(22, 1, 22, 1),
	(43, 1, 43, 1),
	(2368, 1, 44, 1),
	(2371, 1, 46, 1),
	(2372, 1, 47, 1),
	(2373, 1, 1, 3),
	(2374, 1, 2, 3),
	(2376, 1, 12, 3),
	(2377, 1, 13, 3),
	(2378, 1, 14, 3),
	(2379, 1, 20, 3),
	(2380, 1, 22, 3),
	(2382, 1, 42, 3),
	(2383, 1, 43, 3),
	(2384, 1, 44, 3),
	(2386, 1, 46, 3),
	(2387, 1, 47, 3),
	(2388, 1, 21, 3);

-- Dumping structure for table ujikom.pdam
CREATE TABLE IF NOT EXISTS `pdam` (
  `pdam_id` int NOT NULL AUTO_INCREMENT,
  `kode` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `nama_pdam` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `alamat` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci,
  `direktori` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `pemerintah_kota_kab` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `kota_kab_pdam` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `alamat_pdam` varchar(200) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `no_telp_pdam` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `daerah_pdam` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `latitude` double DEFAULT NULL,
  `longitude` double DEFAULT NULL,
  `file_logo_pdam` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `file_logo_pemerintah_kota_kab` varchar(150) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci DEFAULT NULL,
  `usia_pensiun` int DEFAULT NULL,
  `sinkron_akuntansi` tinyint DEFAULT '0',
  PRIMARY KEY (`pdam_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3 ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.pdam: ~2 rows (approximately)
REPLACE INTO `pdam` (`pdam_id`, `kode`, `nama_pdam`, `alamat`, `direktori`, `pemerintah_kota_kab`, `kota_kab_pdam`, `alamat_pdam`, `no_telp_pdam`, `daerah_pdam`, `latitude`, `longitude`, `file_logo_pdam`, `file_logo_pemerintah_kota_kab`, `usia_pensiun`, `sinkron_akuntansi`) VALUES
	(1, 'panel', 'PDAM TIRTA DEMO', NULL, 'defaults', NULL, 'Kabupaten Nusantara', 'JL. Raya Sumedang-Cirebon, Km. 4, 5, Cimalaka, Kabupaten Sumedang', 'Telp. (022) 7794127', NULL, NULL, NULL, 'logo4270287403_2023-07-27.png', '56', 56, 0),
	(10, 'chpn', 'CHARISMA PERSADA NUSANTARA', NULL, 'chpn', NULL, 'Kabupaten Nusantara', 'JL. Raya Sumedang-Cirebon, Km. 4, 5, Cimalaka, Kabupaten Sumedang', NULL, NULL, NULL, NULL, 'chpn.png', '56', 56, 0);

-- Dumping structure for table ujikom.role
CREATE TABLE IF NOT EXISTS `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pdam_id` int DEFAULT NULL,
  `satuan_kerja_id` int DEFAULT '0',
  `role` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status` int DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.role: ~20 rows (approximately)
REPLACE INTO `role` (`id`, `pdam_id`, `satuan_kerja_id`, `role`, `status`) VALUES
	(1, 1, 0, 'superadmin', 1),
	(2, 0, 0, 'superadmin', 1),
	(3, 1, 0, 'superadmin', 1),
	(9, 1, 0, 'SATKER', 1),
	(10, 8, 0, 'superadmin', 1),
	(11, 8, 0, 'SATKER', 1),
	(12, 2, 0, 'superadmin', 1),
	(13, 4, 0, 'superadmin', 1),
	(14, 4, 0, 'bagian', 1),
	(15, 2, 0, 'superadmin', 1),
	(16, 4, 0, 'anggaran', 1),
	(17, 4, 61, 'spi', 1),
	(18, 4, 62, 'umum', 1),
	(19, 4, 63, 'kepegawaian', 1),
	(20, 4, 64, 'keuangan', 1),
	(21, 4, 65, 'humas', 1),
	(22, 4, 66, 'produksi', 1),
	(23, 4, 67, 'perawatan', 1),
	(24, 4, 68, 'perencanaan', 1),
	(25, 4, 0, 'admin', 1);

-- Dumping structure for table ujikom.transaksi
CREATE TABLE IF NOT EXISTS `transaksi` (
  `id` int NOT NULL AUTO_INCREMENT,
  `kode_kasir` varchar(50) DEFAULT NULL,
  `voucher_kode` varchar(50) DEFAULT NULL,
  `total` int DEFAULT NULL,
  `grand_total` int DEFAULT NULL,
  `bayar` int DEFAULT NULL,
  `kembalian` int DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `pdam_id` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=207 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ujikom.transaksi: ~11 rows (approximately)
REPLACE INTO `transaksi` (`id`, `kode_kasir`, `voucher_kode`, `total`, `grand_total`, `bayar`, `kembalian`, `created_at`, `pdam_id`) VALUES
	(196, 'Super Admin', 'dapa', 27540, 25061, 30000, 4939, '2024-02-29 17:56:40', 1),
	(197, 'Super Admin', '', 47700, 47700, 50000, 2300, '2024-02-29 17:56:50', 1),
	(198, 'Super Admin', '', 120000, 120000, 130000, 10000, '2024-03-04 08:10:20', 1),
	(199, 'k0010', '', 37170, 37170, 40000, 2830, '2024-03-04 08:14:24', 1),
	(200, 'Super Admin', '', 8700, 8700, 9000, 300, '2024-03-05 07:48:10', 1),
	(201, 'Super Admin', '', 17325, 17325, 30000, 12675, '2024-03-05 09:38:42', 1),
	(202, 'Super Admin', 'dapa', 8550, 7780, 10000, 2220, '2024-03-06 10:03:17', 1),
	(203, 'Super Admin', '', 11550, 11550, 12000, 450, '2024-03-06 10:03:49', 1),
	(204, 'Super Admin', '', 176550, 176550, 200000, 23450, '2024-03-06 12:38:19', 1),
	(205, 'Super Admin', '', 49000, 49000, 50000, 1000, '2024-03-07 09:21:20', 1),
	(206, 'Super Admin', 'dapa', 77000, 70070, 80000, 9930, '2024-03-07 10:00:04', 1);

-- Dumping structure for table ujikom.transaksi_detail
CREATE TABLE IF NOT EXISTS `transaksi_detail` (
  `id` int NOT NULL AUTO_INCREMENT,
  `transaksi_id` int DEFAULT NULL,
  `produk_id` int DEFAULT NULL,
  `qty` int DEFAULT NULL,
  `sub_total` int DEFAULT NULL,
  `pdam_id` int DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=442 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table ujikom.transaksi_detail: ~23 rows (approximately)
REPLACE INTO `transaksi_detail` (`id`, `transaksi_id`, `produk_id`, `qty`, `sub_total`, `pdam_id`) VALUES
	(6, 8, 17, 1, 5250, 1),
	(127, 79, 15, 1, 9750, 1),
	(421, 196, 1, 1, 10590, 1),
	(422, 196, 14, 1, 5400, 1),
	(423, 196, 15, 1, 5775, 1),
	(424, 196, 17, 1, 5775, 1),
	(425, 197, 22, 1, 5925, 1),
	(426, 197, 17, 1, 5775, 1),
	(427, 197, 20, 3, 36000, 1),
	(428, 198, 20, 10, 120000, 1),
	(429, 199, 1, 3, 31770, 1),
	(430, 199, 14, 1, 5400, 1),
	(431, 200, 19, 1, 8700, 1),
	(432, 201, 15, 3, 17325, 1),
	(433, 202, 23, 1, 8550, 1),
	(434, 203, 17, 2, 11550, 1),
	(435, 204, 1, 11, 165000, 1),
	(436, 204, 15, 1, 5775, 1),
	(437, 204, 17, 1, 5775, 1),
	(438, 205, 14, 1, 15000, 1),
	(439, 205, 15, 2, 34000, 1),
	(440, 206, 14, 4, 60000, 1),
	(441, 206, 19, 1, 17000, 1);

-- Dumping structure for table ujikom.updated
CREATE TABLE IF NOT EXISTS `updated` (
  `id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(255) CHARACTER SET ascii COLLATE ascii_general_ci NOT NULL,
  `data` json DEFAULT NULL,
  `created_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=ascii ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.updated: ~1 rows (approximately)
REPLACE INTO `updated` (`id`, `table_name`, `data`, `created_at`) VALUES
	(202, 'master_barang', '{"id": 11805, "kode": "BRG_0021", "nama": "Peralatan Kantor", "harga": 200000.0, "satuan": "73", "pdam_id": 4, "created_at": "2023-08-03 16:25:35.000000", "created_by": "Super Admin", "updated_at": "2023-08-09 11:29:47.000000", "kategori_id": 53}', '2023-08-09 11:30:53.900201');

-- Dumping structure for table ujikom.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pdam_id` int DEFAULT '1',
  `satuan_kerja_id` int DEFAULT NULL,
  `username` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `nama` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `password` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `id_role` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT '2' COMMENT '1. admin\r\n2. operator general\r\n3. by cabang',
  `state` int DEFAULT '1' COMMENT '0 Non Aktif, 1 Aktif',
  `kasir_kode` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `unq_user` (`username`,`pdam_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;

-- Dumping data for table ujikom.user: ~8 rows (approximately)
REPLACE INTO `user` (`id`, `pdam_id`, `satuan_kerja_id`, `username`, `nama`, `password`, `id_role`, `state`, `kasir_kode`) VALUES
	(225, 1, NULL, 'owner', 'Owner', '$2y$10$S1o3HU1rQVLoAZ4fFYjo2evixNAk7gF4qNWKEvtG6M6R49If10Z.e', '1', 1, 'Owner'),
	(226, 1, NULL, 'k001', 'Andhika', '$2y$10$nSIeuoLO6.OGV27U4p8umeGufS543ZN17xw62WVcYHLJ6O23I3eQO', '2', 1, 'k001'),
	(232, 1, NULL, 'k002', 'Ahmad', '$2y$10$/m/7ZsMaAiNmQvYxGx6c5OqeH8pF9uy11PDzmuWl3X1Tg/KaMCTkq', '3', 1, 'k002'),
	(233, 1, NULL, 'k003', 'Derral', '$2y$10$k5wFbZ2Vp6YLxeafxe6nYePiL.hq5U7DC33R8xH.O0UuSh3FWomzu', '2', 1, 'k003'),
	(234, 1, NULL, 'superadmin', 'Super Admin', '$2y$10$jXo2KqbDtZVXj63ItWQ9su.SQ8CAnyOLbxiT5P5HOuFJhUmzR2oSS', '3', 1, 'Super Admin'),
	(237, 1, NULL, 'k009', 'Hadi', '$2y$10$0kfpoyvQV49hziDPfyDkbetTAgmD8VJX5Caj0HKbUOdCGboeAYJua', '2', 1, 'k009'),
	(238, 1, NULL, 'k010', 'abuy', '$2y$10$1j7D2viWrQoNh87XWmL8DeTXGMacfWQyvoLngM4wtQQO7xzGpvvN6', '2', 1, 'k010'),
	(245, 1, NULL, 'k0010', 'jaki', '$2y$10$NNptykRVNlQhvdXXib6Q5..GDYOCPMlguuT2KXYQE7jBPb5p7zIve', '2', 1, 'k0010');

-- Dumping structure for view ujikom.vw_detail_produk
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_detail_produk` (
	`id` INT(10) NULL,
	`id_produk` BIGINT(19) NOT NULL,
	`nama` VARCHAR(255) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`gambar` VARCHAR(255) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`hpp` INT(10) NULL,
	`harga` INT(10) NULL,
	`kategori_id` INT(10) NULL,
	`kategori` VARCHAR(255) NULL COLLATE 'utf8mb3_general_ci',
	`pdam_id` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view ujikom.vw_master_produk
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_master_produk` (
	`id` INT(10) NOT NULL,
	`nama` VARCHAR(255) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`gambar` VARCHAR(255) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`hpp` INT(10) NULL,
	`harga` INT(10) NULL,
	`stok` INT(10) NULL,
	`kategori_id` INT(10) NULL,
	`kategori` VARCHAR(255) NULL COLLATE 'utf8mb3_general_ci',
	`pdam_id` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view ujikom.vw_master_produk_detail
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_master_produk_detail` (
	`id` INT(10) NOT NULL,
	`produk_id` INT(10) NOT NULL,
	`bahan_id` INT(10) NOT NULL,
	`jumlah` INT(10) NULL,
	`harga` INT(10) NULL,
	`pdam_id` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view ujikom.vw_produk
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_produk` (
	`id` INT(10) NOT NULL,
	`nama` VARCHAR(255) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`gambar` VARCHAR(255) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`hpp` INT(10) NULL,
	`stok` INT(10) NULL,
	`harga` INT(10) NULL,
	`kategori_id` INT(10) NULL,
	`kategori` VARCHAR(255) NULL COLLATE 'utf8mb3_general_ci',
	`pdam_id` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view ujikom.vw_t
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_t` (
	`id` INT(10) NOT NULL,
	`kode_kasir` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`kasir` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`voucher` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`total` INT(10) NULL,
	`bayar` INT(10) NULL,
	`kembalian` INT(10) NULL,
	`created_at` DATETIME NULL,
	`pdam_id` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view ujikom.vw_trans
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_trans` (
	`tahun` INT(10) NULL,
	`bulan` INT(10) NULL,
	`total` DECIMAL(32,0) NULL
) ENGINE=MyISAM;

-- Dumping structure for view ujikom.vw_transaksi
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_transaksi` (
	`id` INT(10) NOT NULL,
	`kode_kasir` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nama_kasir` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`voucher_kode` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`diskon` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`total` BIGINT(19) NOT NULL,
	`grand_total` BIGINT(19) NOT NULL,
	`bayar` BIGINT(19) NOT NULL,
	`kembalian` BIGINT(19) NOT NULL,
	`created_at` DATETIME NULL,
	`pdam_id` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view ujikom.vw_transaksi_detail
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_transaksi_detail` (
	`id` INT(10) NOT NULL,
	`trans_id` INT(10) NULL,
	`kode_kasir` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`nama_kasir` VARCHAR(50) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`prod_id` INT(10) NULL,
	`nama_produk` VARCHAR(255) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`harga` INT(10) NULL,
	`qty` INT(10) NULL,
	`sub_total` INT(10) NULL,
	`kode_voucher` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`diskon` VARCHAR(50) NULL COLLATE 'utf8mb4_0900_ai_ci',
	`total` BIGINT(19) NULL,
	`tanggal` DATETIME NULL,
	`pdam_id` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for view ujikom.vw_voucher
-- Creating temporary table to overcome VIEW dependency errors
CREATE TABLE `vw_voucher` (
	`id` INT(10) NOT NULL,
	`kode` VARCHAR(255) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`diskon` DECIMAL(20,2) NULL,
	`qty` BIGINT(19) NOT NULL,
	`active_at` DATE NULL,
	`expired_at` DATE NULL,
	`status` VARCHAR(11) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`pdam_id` INT(10) NULL
) ENGINE=MyISAM;

-- Dumping structure for trigger ujikom.after_delete_master_kasir
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_delete_master_kasir` AFTER DELETE ON `master_kasir` FOR EACH ROW BEGIN
    DELETE FROM `user` WHERE `username` = OLD.kode; 
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger ujikom.after_edit_master_kasir
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_edit_master_kasir` AFTER UPDATE ON `master_kasir` FOR EACH ROW BEGIN
    UPDATE `user` SET 
        `username` = NEW.kode, 
        `nama` = NEW.nama, 
        `password` = NEW.password_hash, 
        `kasir_kode` = NEW.kode 
    WHERE `username` = OLD.kode;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger ujikom.after_insert_master_kasir
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_insert_master_kasir` AFTER INSERT ON `master_kasir` FOR EACH ROW BEGIN
    INSERT INTO user (pdam_id, username, nama, password, id_role, state, kasir_kode)
    VALUES (NEW.pdam_id, NEW.kode, NEW.nama, NEW.password_hash, '2', 1, NEW.kode);
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger ujikom.after_insert_produk
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `after_insert_produk` AFTER INSERT ON `transaksi_detail` FOR EACH ROW BEGIN
    DECLARE produk_id INT;
    DECLARE qty INT;
    
    -- Mengambil nilai id_produk dan quantity dari baris yang dimasukkan
    SELECT NEW.produk_id, NEW.qty INTO produk_id, qty;
    
    -- Mengurangi nilai stok pada tabel produk
    UPDATE master_produk SET stok = stok - qty WHERE id = produk_id;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger ujikom.after_insert_transaksi
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='';
DELIMITER //
CREATE TRIGGER `after_insert_transaksi` AFTER INSERT ON `transaksi` FOR EACH ROW BEGIN
 IF NEW.voucher_kode IS NOT NULL THEN
        UPDATE master_voucher
        SET qty = qty - 1
        WHERE kode = NEW.voucher_kode;
    END IF;
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger ujikom.master_produk_after_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `master_produk_after_delete` AFTER DELETE ON `master_produk` FOR EACH ROW BEGIN
	    DELETE FROM `master_produk_detail` WHERE `produk_id` = OLD.id; 
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger ujikom.transaksi_after_delete
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
DELIMITER //
CREATE TRIGGER `transaksi_after_delete` AFTER DELETE ON `transaksi` FOR EACH ROW BEGIN
	 DELETE FROM `transaksi_detail` WHERE `transaksi_id` = OLD.id; 
END//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for view ujikom.vw_detail_produk
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_detail_produk`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_detail_produk` AS select `produk`.`id` AS `id`,coalesce(`item`.`produk_id`,`produk`.`id`) AS `id_produk`,`produk`.`nama` AS `nama`,`produk`.`gambar` AS `gambar`,`produk`.`hpp` AS `hpp`,`produk`.`harga_jual` AS `harga`,`produk`.`kategori_id` AS `kategori_id`,`kategori`.`nama` AS `kategori`,`produk`.`pdam_id` AS `pdam_id` from ((`master_produk_detail` `item` left join `master_produk` `produk` on((`item`.`produk_id` = `produk`.`id`))) left join `master_kategori` `kategori` on((`produk`.`kategori_id` = `kategori`.`id`)));

-- Dumping structure for view ujikom.vw_master_produk
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_master_produk`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_master_produk` AS select `produk`.`id` AS `id`,`produk`.`nama` AS `nama`,`produk`.`gambar` AS `gambar`,`produk`.`hpp` AS `hpp`,`produk`.`harga_jual` AS `harga`,`produk`.`stok` AS `stok`,`produk`.`kategori_id` AS `kategori_id`,`kategori`.`nama` AS `kategori`,`produk`.`pdam_id` AS `pdam_id` from (`master_produk` `produk` left join `master_kategori` `kategori` on((`kategori`.`id` = `produk`.`kategori_id`)));

-- Dumping structure for view ujikom.vw_master_produk_detail
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_master_produk_detail`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_master_produk_detail` AS select `item`.`id` AS `id`,`item`.`produk_id` AS `produk_id`,`item`.`bahan_id` AS `bahan_id`,`item`.`jumlah` AS `jumlah`,`item`.`harga` AS `harga`,`item`.`pdam_id` AS `pdam_id` from `master_produk_detail` `item`;

-- Dumping structure for view ujikom.vw_produk
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_produk`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_produk` AS select `produk`.`id` AS `id`,`produk`.`nama` AS `nama`,`produk`.`gambar` AS `gambar`,`produk`.`hpp` AS `hpp`,`produk`.`stok` AS `stok`,`produk`.`harga_jual` AS `harga`,`produk`.`kategori_id` AS `kategori_id`,`kategori`.`nama` AS `kategori`,`produk`.`pdam_id` AS `pdam_id` from (`master_produk` `produk` left join `master_kategori` `kategori` on((`kategori`.`id` = `produk`.`kategori_id`)));

-- Dumping structure for view ujikom.vw_t
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_t`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_t` AS select `trans`.`id` AS `id`,`trans`.`kode_kasir` AS `kode_kasir`,`kasir`.`nama` AS `kasir`,`trans`.`voucher_kode` AS `voucher`,`trans`.`total` AS `total`,`trans`.`bayar` AS `bayar`,`trans`.`kembalian` AS `kembalian`,`trans`.`created_at` AS `created_at`,`trans`.`pdam_id` AS `pdam_id` from ((`transaksi` `trans` left join `transaksi_detail` `detail` on((`trans`.`id` = `detail`.`transaksi_id`))) left join `master_kasir` `kasir` on((`trans`.`kode_kasir` = `kasir`.`kode`)));

-- Dumping structure for view ujikom.vw_trans
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_trans`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_trans` AS select year(`t`.`created_at`) AS `tahun`,month(`t`.`created_at`) AS `bulan`,sum(`t`.`total`) AS `total` from `transaksi` `t` group by year(`t`.`created_at`),month(`t`.`created_at`);

-- Dumping structure for view ujikom.vw_transaksi
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_transaksi`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_transaksi` AS select `trans`.`id` AS `id`,`trans`.`kode_kasir` AS `kode_kasir`,coalesce(`kasir`.`nama`,`trans`.`kode_kasir`) AS `nama_kasir`,`trans`.`voucher_kode` AS `voucher_kode`,coalesce(`voucher`.`diskon`,`trans`.`voucher_kode`,'-') AS `diskon`,coalesce(`trans`.`total`,0) AS `total`,coalesce(`trans`.`grand_total`,0) AS `grand_total`,coalesce(`trans`.`bayar`,0) AS `bayar`,coalesce(`trans`.`kembalian`,0) AS `kembalian`,`trans`.`created_at` AS `created_at`,`trans`.`pdam_id` AS `pdam_id` from ((`transaksi` `trans` left join `master_kasir` `kasir` on((`trans`.`kode_kasir` = `kasir`.`kode`))) left join `master_voucher` `voucher` on((`trans`.`voucher_kode` = `voucher`.`kode`)));

-- Dumping structure for view ujikom.vw_transaksi_detail
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_transaksi_detail`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_transaksi_detail` AS select `detail`.`id` AS `id`,`detail`.`transaksi_id` AS `trans_id`,`kasir`.`kode` AS `kode_kasir`,coalesce(`kasir`.`nama`,`trans`.`kode_kasir`,0) AS `nama_kasir`,`detail`.`produk_id` AS `prod_id`,`item`.`nama` AS `nama_produk`,`item`.`harga_jual` AS `harga`,`detail`.`qty` AS `qty`,`detail`.`sub_total` AS `sub_total`,`trans`.`voucher_kode` AS `kode_voucher`,coalesce(`voucher`.`diskon`,`trans`.`voucher_kode`) AS `diskon`,cast((`detail`.`sub_total` - (coalesce(`voucher`.`diskon`,0) * `detail`.`sub_total`)) as signed) AS `total`,`trans`.`created_at` AS `tanggal`,`detail`.`pdam_id` AS `pdam_id` from ((((`transaksi_detail` `detail` left join `master_produk` `item` on((`detail`.`produk_id` = `item`.`id`))) left join `transaksi` `trans` on((`detail`.`transaksi_id` = `trans`.`id`))) left join `master_kasir` `kasir` on((`trans`.`kode_kasir` = `kasir`.`kode`))) left join `master_voucher` `voucher` on((`trans`.`voucher_kode` = `voucher`.`kode`)));

-- Dumping structure for view ujikom.vw_voucher
-- Removing temporary table and create final VIEW structure
DROP TABLE IF EXISTS `vw_voucher`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `vw_voucher` AS select `voucher`.`id` AS `id`,`voucher`.`kode` AS `kode`,cast(`voucher`.`diskon` as decimal(20,2)) AS `diskon`,coalesce(`voucher`.`qty`,0) AS `qty`,`voucher`.`active_at` AS `active_at`,`voucher`.`expired_at` AS `expired_at`,(case when ((`voucher`.`qty` > 0) and (curdate() between `voucher`.`active_at` and `voucher`.`expired_at`)) then 'Aktif' else 'Tidak Aktif' end) AS `status`,`voucher`.`pdam_id` AS `pdam_id` from `master_voucher` `voucher`;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
