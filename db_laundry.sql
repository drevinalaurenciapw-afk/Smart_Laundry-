/*
SQLyog Community v13.0.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - laundry_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`laundry_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `laundry_db`;

/*Table structure for table `detail_transaksi` */

DROP TABLE IF EXISTS `detail_transaksi`;

CREATE TABLE `detail_transaksi` (
  `id_detail` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) NOT NULL,
  `id_layanan` int(11) NOT NULL,
  `berat` decimal(5,2) NOT NULL,
  `harga_satuan` decimal(10,2) NOT NULL,
  `subtotal` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id_detail`),
  KEY `id_transaksi` (`id_transaksi`),
  KEY `id_layanan` (`id_layanan`),
  CONSTRAINT `detail_transaksi_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`),
  CONSTRAINT `detail_transaksi_ibfk_2` FOREIGN KEY (`id_layanan`) REFERENCES `layanan` (`id_layanan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `detail_transaksi` */

/*Table structure for table `layanan` */

DROP TABLE IF EXISTS `layanan`;

CREATE TABLE `layanan` (
  `id_layanan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_layanan` varchar(50) NOT NULL,
  `harga_per_kg` decimal(10,2) NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `satuan` varchar(10) DEFAULT NULL,
  `durasi` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_layanan`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `layanan` */

insert  into `layanan`(`id_layanan`,`nama_layanan`,`harga_per_kg`,`deskripsi`,`satuan`,`durasi`) values 
(1,'Cuci Kering',4000.00,'Layanan cuci dan pengeringan pakaian','kg','2 hari'),
(2,'Cuci Setrika',5000.00,'Layanan cuci, pengeringan, dan setrika pakaian','kg','2 hari'),
(3,'Setrika',5000.00,'Layanan setrika pakaian','kg','1 hari'),
(4,'Express',15000.00,'Layanan laundry dengan proses lebih cepat','kg','4 Jam');

/*Table structure for table `owner` */

DROP TABLE IF EXISTS `owner`;

CREATE TABLE `owner` (
  `id_owner` int(11) NOT NULL AUTO_INCREMENT,
  `nama_owner` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_owner`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `owner` */

insert  into `owner`(`id_owner`,`nama_owner`,`password`) values 
(1,'Jennie','jennie123');

/*Table structure for table `pegawai` */

DROP TABLE IF EXISTS `pegawai`;

CREATE TABLE `pegawai` (
  `id_pegawai` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pegawai` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `no_hp` varchar(15) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id_pegawai`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pegawai` */

insert  into `pegawai`(`id_pegawai`,`nama_pegawai`,`password`,`no_hp`,`status`) values 
(1,'Venty','venty123','081234567890','Aktif'),
(2,'Ana','ana123','082345678901','Aktif'),
(3,'Cia','cia23','082233445566','Cuti'),
(4,'Chelsea','chelsea123','083344556677','Aktif');

/*Table structure for table `pelanggan` */

DROP TABLE IF EXISTS `pelanggan`;

CREATE TABLE `pelanggan` (
  `id_pelanggan` int(11) NOT NULL AUTO_INCREMENT,
  `nama_pelanggan` varchar(100) NOT NULL,
  `no_hp` varchar(20) NOT NULL,
  PRIMARY KEY (`id_pelanggan`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pelanggan` */

insert  into `pelanggan`(`id_pelanggan`,`nama_pelanggan`,`no_hp`) values 
(1,'Alda','08123456789');

/*Table structure for table `pembayaran` */

DROP TABLE IF EXISTS `pembayaran`;

CREATE TABLE `pembayaran` (
  `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_transaksi` int(11) NOT NULL,
  `metode_bayar` varchar(20) NOT NULL,
  `jumlah_bayar` decimal(10,2) NOT NULL,
  `status_pembayaran` varchar(20) NOT NULL,
  `tgl_bayar` datetime NOT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`),
  KEY `id_transaksi` (`id_transaksi`),
  CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_transaksi`) REFERENCES `transaksi` (`id_transaksi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `pembayaran` */

/*Table structure for table `transaksi` */

DROP TABLE IF EXISTS `transaksi`;

CREATE TABLE `transaksi` (
  `id_transaksi` int(11) NOT NULL AUTO_INCREMENT,
  `id_pelanggan` int(11) NOT NULL,
  `id_pegawai` int(11) NOT NULL,
  `id_layanan` int(11) NOT NULL,
  `tgl_masuk` datetime NOT NULL,
  `jumlah_berat` decimal(5,2) NOT NULL,
  `total_harga` decimal(10,2) NOT NULL,
  `tgl_pengambilan` datetime DEFAULT NULL,
  `status_laundry` varchar(30) NOT NULL,
  PRIMARY KEY (`id_transaksi`),
  KEY `id_pelanggan` (`id_pelanggan`),
  KEY `id_pegawai` (`id_pegawai`),
  KEY `id_layanan` (`id_layanan`),
  CONSTRAINT `transaksi_ibfk_1` FOREIGN KEY (`id_pelanggan`) REFERENCES `pelanggan` (`id_pelanggan`),
  CONSTRAINT `transaksi_ibfk_2` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`),
  CONSTRAINT `transaksi_ibfk_3` FOREIGN KEY (`id_layanan`) REFERENCES `layanan` (`id_layanan`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `transaksi` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
