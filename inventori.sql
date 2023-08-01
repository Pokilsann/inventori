-- phpMyAdmin SQL Dump
-- version 4.1.12
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 24 Jun 2023 pada 02.56
-- Versi Server: 5.6.16
-- PHP Version: 5.5.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `inventori`
--

DELIMITER $$
--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `generate_barang_no`() RETURNS varchar(6) CHARSET utf8
BEGIN
	DECLARE generate Varchar(6);
	Select LPAD(count(1)+1, 6,'0') into generate from tbl_barang WHERE `pk_barang_id`!='0000000';
RETURN (generate);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `keluar`
--
CREATE TABLE IF NOT EXISTS `keluar` (
`id_barang` int(11)
,`stok` decimal(32,0)
);
-- --------------------------------------------------------

--
-- Stand-in structure for view `stok`
--
CREATE TABLE IF NOT EXISTS `stok` (
`id_barang` int(11)
,`stok` decimal(32,0)
);
-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_barang`
--

CREATE TABLE IF NOT EXISTS `tbl_barang` (
  `pk_barang_id` int(11) NOT NULL AUTO_INCREMENT,
  `id_barang` varchar(20) DEFAULT NULL,
  `nama_barang` varchar(20) DEFAULT NULL,
  `fk_jenisbarang_id` int(11) DEFAULT NULL,
  `stok` int(11) DEFAULT NULL,
  `fk_satuan_id` int(11) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`pk_barang_id`),
  KEY `FK_tbl_barang_tbl_jenisbarang` (`fk_jenisbarang_id`),
  KEY `FK_tbl_barang_tbl_satuan` (`fk_satuan_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=21 ;

--
-- Dumping data untuk tabel `tbl_barang`
--

INSERT INTO `tbl_barang` (`pk_barang_id`, `id_barang`, `nama_barang`, `fk_jenisbarang_id`, `stok`, `fk_satuan_id`, `created_by`, `created_date`) VALUES
(13, 'B000002', 'Ayam Kecil', 1, NULL, 5, NULL, NULL),
(14, 'B000003', 'Ati Ampela', 3, NULL, 11, NULL, NULL),
(15, 'B000004', 'Usus', 2, NULL, 5, NULL, NULL),
(17, 'B000006', 'Ceker', 6, NULL, 5, NULL, NULL),
(18, 'B000007', 'Kepala', 5, NULL, 5, NULL, NULL),
(19, 'B000006', 'Ayam Tanggung', 8, NULL, 5, NULL, NULL),
(20, 'B000007', 'Ayam Besar', 10, NULL, 5, NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_jenisbarang`
--

CREATE TABLE IF NOT EXISTS `tbl_jenisbarang` (
  `pk_jenisbarang_id` int(11) NOT NULL AUTO_INCREMENT,
  `jenis_barang` varchar(50) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`pk_jenisbarang_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=11 ;

--
-- Dumping data untuk tabel `tbl_jenisbarang`
--

INSERT INTO `tbl_jenisbarang` (`pk_jenisbarang_id`, `jenis_barang`, `created_by`, `created_date`) VALUES
(1, 'Ayam Kecil', NULL, NULL),
(2, 'Usus', NULL, NULL),
(3, 'Ati Ampela', NULL, NULL),
(5, 'Kepala', NULL, NULL),
(6, 'Ceker', NULL, NULL),
(8, 'Ayam Tanggung', NULL, NULL),
(10, 'Ayam Besar', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_satuan`
--

CREATE TABLE IF NOT EXISTS `tbl_satuan` (
  `pk_satuan_id` int(11) NOT NULL AUTO_INCREMENT,
  `satuan_barang` varchar(50) DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `created_date` datetime DEFAULT NULL,
  PRIMARY KEY (`pk_satuan_id`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=12 ;

--
-- Dumping data untuk tabel `tbl_satuan`
--

INSERT INTO `tbl_satuan` (`pk_satuan_id`, `satuan_barang`, `created_by`, `created_date`) VALUES
(5, 'Kilogram', NULL, NULL),
(10, 'Ekor', NULL, NULL),
(11, 'Biji', NULL, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_transaksi_keluar`
--

CREATE TABLE IF NOT EXISTS `tbl_transaksi_keluar` (
  `pk_transaksi_keluar_id` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` date DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `jumlah_keluar` int(11) DEFAULT NULL,
  `status` int(11) DEFAULT NULL,
  PRIMARY KEY (`pk_transaksi_keluar_id`) USING BTREE,
  KEY `FK_tbl_transaksi_masuk_tbl_barang` (`id_barang`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=22 ;

--
-- Dumping data untuk tabel `tbl_transaksi_keluar`
--

INSERT INTO `tbl_transaksi_keluar` (`pk_transaksi_keluar_id`, `tanggal`, `id_barang`, `jumlah_keluar`, `status`) VALUES
(11, '2023-04-14', 14, 30, 1),
(15, '2023-04-14', 15, 6, 1),
(17, '0000-00-00', 14, 0, 2),
(18, '2023-06-06', 13, 1200, 1),
(19, '2023-06-07', 14, 150, 1),
(20, '2023-06-07', 14, 4, 2),
(21, '2023-06-12', 13, 560, NULL);

-- --------------------------------------------------------

--
-- Struktur dari tabel `tbl_transaksi_masuk`
--

CREATE TABLE IF NOT EXISTS `tbl_transaksi_masuk` (
  `pk_transaksi_masuk_id` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal` date DEFAULT NULL,
  `id_barang` int(11) DEFAULT NULL,
  `jumlah_masuk` int(11) DEFAULT NULL,
  PRIMARY KEY (`pk_transaksi_masuk_id`),
  KEY `FK_tbl_transaksi_masuk_tbl_barang` (`id_barang`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8mb4 AUTO_INCREMENT=34 ;

--
-- Dumping data untuk tabel `tbl_transaksi_masuk`
--

INSERT INTO `tbl_transaksi_masuk` (`pk_transaksi_masuk_id`, `tanggal`, `id_barang`, `jumlah_masuk`) VALUES
(21, '2023-06-02', 13, 4420),
(24, '2023-06-06', 13, 1500),
(25, '2023-06-06', 14, 30),
(27, '2023-06-06', 14, 40),
(28, '2023-06-12', 14, 250),
(29, '2023-06-12', 15, 55),
(30, '2023-06-12', 17, 30),
(31, '2023-06-12', 18, 20),
(32, '2023-06-16', 20, 2690),
(33, '2023-06-10', 19, 1567);

-- --------------------------------------------------------

--
-- Struktur dari tabel `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `user_id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `level` enum('admin','user') NOT NULL,
  `blokir` enum('N','Y') NOT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=28 ;

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `email`, `level`, `blokir`) VALUES
(10, 'admin', '21232f297a57a5a743894a0e4a801fc3', 'admin@gmail.com', 'admin', 'N'),
(26, 'user', 'ee11cbb19052e40b07aac0ca060c23ee', 'user@gmail.com', 'user', ''),
(27, 'Rizky', '96a3be3cf272e017046d1b2674a52bd3', 'rizkypokil@gmail.com', 'user', '');

-- --------------------------------------------------------

--
-- Stand-in structure for view `vbarang`
--
CREATE TABLE IF NOT EXISTS `vbarang` (
`pk_barang_id` int(11)
,`id_barang` varchar(20)
,`nama_barang` varchar(20)
,`fk_jenisbarang_id` int(11)
,`stok` int(11)
,`fk_satuan_id` int(11)
,`created_by` int(11)
,`created_date` datetime
,`jenis_barang` varchar(50)
,`satuan_barang` varchar(50)
,`kocak` varchar(73)
,`stokbarang` decimal(32,0)
,`keluar` decimal(32,0)
);
-- --------------------------------------------------------

--
-- Struktur untuk view `keluar`
--
DROP TABLE IF EXISTS `keluar`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `keluar` AS select `kl`.`id_barang` AS `id_barang`,sum(`kl`.`jumlah_keluar`) AS `stok` from `tbl_transaksi_keluar` `kl` where (`kl`.`status` = 1) group by `kl`.`id_barang`;

-- --------------------------------------------------------

--
-- Struktur untuk view `stok`
--
DROP TABLE IF EXISTS `stok`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `stok` AS select `tm`.`id_barang` AS `id_barang`,sum(`tm`.`jumlah_masuk`) AS `stok` from `tbl_transaksi_masuk` `tm` group by `tm`.`id_barang`;

-- --------------------------------------------------------

--
-- Struktur untuk view `vbarang`
--
DROP TABLE IF EXISTS `vbarang`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `vbarang` AS select `tb`.`pk_barang_id` AS `pk_barang_id`,`tb`.`id_barang` AS `id_barang`,`tb`.`nama_barang` AS `nama_barang`,`tb`.`fk_jenisbarang_id` AS `fk_jenisbarang_id`,`tb`.`stok` AS `stok`,`tb`.`fk_satuan_id` AS `fk_satuan_id`,`tb`.`created_by` AS `created_by`,`tb`.`created_date` AS `created_date`,`tj`.`jenis_barang` AS `jenis_barang`,`ts`.`satuan_barang` AS `satuan_barang`,concat(`tb`.`nama_barang`,' (',`ts`.`satuan_barang`,')') AS `kocak`,`st`.`stok` AS `stokbarang`,`kl`.`stok` AS `keluar` from ((((`tbl_barang` `tb` left join `tbl_jenisbarang` `tj` on((`tb`.`fk_jenisbarang_id` = `tj`.`pk_jenisbarang_id`))) left join `tbl_satuan` `ts` on((`tb`.`fk_satuan_id` = `ts`.`pk_satuan_id`))) left join `stok` `st` on((`tb`.`pk_barang_id` = `st`.`id_barang`))) left join `keluar` `kl` on((`kl`.`id_barang` = `tb`.`pk_barang_id`)));

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `tbl_barang`
--
ALTER TABLE `tbl_barang`
  ADD CONSTRAINT `FK_tbl_barang_tbl_jenisbarang` FOREIGN KEY (`fk_jenisbarang_id`) REFERENCES `tbl_jenisbarang` (`pk_jenisbarang_id`),
  ADD CONSTRAINT `FK_tbl_barang_tbl_satuan` FOREIGN KEY (`fk_satuan_id`) REFERENCES `tbl_satuan` (`pk_satuan_id`);

--
-- Ketidakleluasaan untuk tabel `tbl_transaksi_keluar`
--
ALTER TABLE `tbl_transaksi_keluar`
  ADD CONSTRAINT `tbl_transaksi_keluar_ibfk_1` FOREIGN KEY (`id_barang`) REFERENCES `tbl_barang` (`pk_barang_id`);

--
-- Ketidakleluasaan untuk tabel `tbl_transaksi_masuk`
--
ALTER TABLE `tbl_transaksi_masuk`
  ADD CONSTRAINT `FK_tbl_transaksi_masuk_tbl_barang` FOREIGN KEY (`id_barang`) REFERENCES `tbl_barang` (`pk_barang_id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
