/* Open Library SQL */

# DDL

## CREATE DATABASE

CREATE DATABASE open_library

## CREATE TABLES

CREATE TABLE mahasiswa ( 
    nim             CHAR(10) NOT NULL, 
    nama_mahasiswa  VARCHAR(50) NOT NULL, 
    kelas           VARCHAR(8) NOT NULL,
    PRIMARY KEY (nim) 
);

CREATE TABLE dosen ( 
    kode_dosen      CHAR(3) NOT NULL, 
    nama_dosen      VARCHAR(50) NOT NULL, 
    ruangan         CHAR(5) NOT NULL, 
    PRIMARY KEY (kode_dosen) 
);

CREATE TABLE buku ( 
    kode_buku           CHAR(10) NOT NULL, 
    judul_buku          CHAR(80) NOT NULL, 
    nama_penulis        VARCHAR(50) NOT NULL, 
    nama_penerbit       VARCHAR(50) NOT NULL, 
    tahunterbit_buku    DATE NOT NULL, 
    lokasi_rak          VARCHAR(30), 
    status              CHAR(30) NOT NULL, 
    jumlah_eksemplar    INTEGER(3), 
    PRIMARY KEY (kode_buku) 
);

CREATE TABLE ruangan ( 
    kode_ruangan        CHAR(4), 
    PRIMARY KEY (kode_ruangan) 
);

CREATE TABLE member ( 
    kode_member     CHAR(4) NOT NULL, 
    nim             CHAR(10), 
    kode_dosen      CHAR(3), 
    email           CHAR(80), 
    PRIMARY KEY (kode_member) 
);

ALTER TABLE member 
ADD CONSTRAINT fk_nim_member FOREIGN KEY (nim) REFERENCES mahasiswa (nim);

ALTER TABLE member 
ADD CONSTRAINT fk_kode_dosen_member FOREIGN KEY (kode_dosen) REFERENCES dosen (kode_dosen);

CREATE TABLE reservasi_buku ( 
    kode_reservasi_buku     CHAR(5) NOT NULL, 
    kode_buku               CHAR(10), 
    kode_member             CHAR(4), 
    waktu_peminjaman        DATETIME NOT NULL, 
    waktu_pengembalian      DATETIME NOT NULL, 
    PRIMARY KEY (kode_reservasi_buku) 
);

ALTER TABLE reservasi_buku 
ADD CONSTRAINT fk_kode_buku_rb FOREIGN KEY (kode_buku) REFERENCES buku (kode_buku);

ALTER TABLE reservasi_buku 
ADD CONSTRAINT fk_kode_member_rb FOREIGN KEY (kode_member) REFERENCES member (kode_member);

CREATE TABLE reservasi_ruangan ( 
    kode_reservasi_ruangan  CHAR(5) NOT NULL, 
    kode_ruangan            CHAR(4), 
    kode_member             CHAR(4), 
    waktu_mulai             DATETIME NOT NULL, 
    waktu_selesai           DATETIME NOT NULL, 
    PRIMARY KEY (kode_reservasi_ruangan) 
);

ALTER TABLE reservasi_ruangan 
ADD CONSTRAINT fk_kode_ruangan_rr FOREIGN KEY (kode_ruangan) REFERENCES ruangan (kode_ruangan);

ALTER TABLE reservasi_ruangan 
ADD CONSTRAINT fk_kode_member_rr FOREIGN KEY (kode_member) REFERENCES member (kode_member);

CREATE TABLE perpanjangan ( 
    kode_perpanjangan       CHAR(5) NOT NULL, 
    kode_member             CHAR(4), 
    kode_reservasi_buku     CHAR(5), 
    waktu_perpanjangan      DATETIME NOT NULL, 
    PRIMARY KEY (kode_perpanjangan) 
);

ALTER TABLE perpanjangan 
ADD CONSTRAINT fk_kode_member_pp FOREIGN KEY (kode_member) REFERENCES member (kode_member);

ALTER TABLE perpanjangan 
ADD CONSTRAINT fk_kode_rb_pp FOREIGN KEY (kode_reservasi_buku) REFERENCES reservasi_buku (kode_reservasi_buku);

CREATE TABLE denda ( 
    kode_denda      CHAR(4) NOT NULL, 
    kode_member     CHAR(4), 
    jumlah_hari     INTEGER(3), 
    PRIMARY KEY (kode_denda) 
);

ALTER TABLE denda 
ADD CONSTRAINT fk_kode_member_denda FOREIGN KEY (kode_member) REFERENCES member (kode_member);


# DML

## INSERT VALUES TO TABLES

INSERT INTO mahasiswa VALUES
('1301191788','Irfan Arif Muhamad','IF-43-01'),
('1301192527','Krisna Mansur Wira','IF-43-01'),
('1301191549','Kusuma Indah Mansur','IF-43-01'),
('1301192172','Nirmala Harta Cinta','IF-43-01'),
('1301190566','Dwi Susila Surya','IF-43-01'),
('1301193532','Zakaria Intan Irfan','IF-43-02'),
('1301190853','Aditya Yuda Mega','IF-43-02'),
('1301194635','Imran Firdaus Ibrahim','IF-43-02'),
('1301194625','Faisal Sari Muhamad','IF-43-02'),
('1301192062','Asih Ahmad Bima','IF-43-02'),
('1301191047','Wibawa Putri Rahman','IF-43-03'),
('1301192722','Vina Tri Intan','IF-43-03'),
('1301192186','Muhamad Wibawa Susila','IF-43-03'),
('1301194734','Ridwan Muhammad Nur','IF-43-03'),
('1301191920','Citra Yusuf Surya','IF-43-03'),
('1301194388','Haydar Rizaldy Putera Prayudi','IF-43-12'),
('1301190414','Muhammad Iskandar Devanto','IF-43-12'),
('1301194376','Raihan Romzi Rakhman','IF-43-12'),
('1301190351','Fadlan Akmal Ramdahan','IF-43-12'),
('1301190335','Musthafa Zaki Bahar','IF-43-12'),
('1301194076','Nabil Azzumar Labib','IF-43-12');

INSERT INTO dosen VALUES
('WDU','Widi Astuti','F-211'),
('FDA','Firdaniza','F-201'),
('RSA','Rosa Reska Riskiana','F-221'),
('AJG','Aji Gautama Putrada','F-212'),
('TSA','Annisa Aditsania','F-202'),
('API','Agi Prasetiadi','F-203'),
('APA','Agus Priyanto','F-227'),
('ABA','Amalia Beladinna','F-215'),
('AGZ','Anggi Zafia','F-262'),
('AWD','Arif Wirawan Muhammad','F-291'),
('ADO','Aulia Desy Nur Utomo','F-226'),
('ASI','Aulia Sholichah Iman','F-217'),
('AAB','Auliya Burhanuddin','F-208'),
('BPZ','Bita Parga Zen','F-271'),
('DCF','Diandra Chika F','F-229'),
('EII','Emi Iryanti','F-211'),
('FMW','Fahrudin Mukti Wibowo','F-205'),
('IFA','Ipam Fuaddina Adam','F-243'),
('IQA','Iqsyahiro Kresna ','F-257'),
('ISO','Irwan Susanto','F-265');

INSERT INTO buku VALUES
('20.11.0001','Cloud Computing: Manajemen Dan Perencanaan Kapasitas','Riko Herwanto','Andi Offset',date'2016-10-30','Computer & Technology','Available',12),
('20.11.0002','Invader Without A Conscience','Dieter Franz Xaver Saylor','Bookends',date'1962-11-08','Computer & Technology','Available',2),
('20.11.0003','Blacksmith Of The Day','Gundula Beckett Krebs','Better Bound Books',date'1964-01-03','Business & Economy','Unavailable',3),
('20.11.0004','Blacksmiths Of My Imagination','Viola Kourtney Dressler','Page by Page',date'1966-08-22','Fiction','Available',5),
('20.11.0005','Heroes Of Dawn','Peter Allyn Keil','Lost and Bound',date'1972-11-30','Computer & Technology','Unavailable',2),
('20.11.0006','Descendants And Wives','Satchel Danica Baker','Turning Pages',date'1974-02-13','Fiction','Available',1),
('20.11.0007','Aliens And Doctors','Roni Teresa Beckett','Book Barn',date'1977-08-24','Law','Unavailable',3),
('20.11.0008','Intention Of Nightmares','Brady Lili Arbeit','Find Your Bind',date'1978-03-10','Computer & Technology','Unavailable',4),
('20.11.0009','Faction Of The South','Deloris Mikki Monday','The Lookbooks',date'1980-02-08','Fiction','Unavailable',2),
('20.11.0010','Praised By My Dreams','Lisette Minerva Foster','Fresh Pages',date'1986-03-20','Psychology','Available',5),
('21.11.0001','Harlequin With Stunts','Elliot Jodene Ryer','Book Bindings',date'1987-03-10','Business & Economy','Unavailable',6),
('21.11.0002','Unbranding','Scott Stratten','Elex Media Komputindo',date'2018-10-01','Business & Economy','Unavailable',5),
('21.11.0003','Officer Gamble','Martin Mary Beth Seeger','Beautiful Books',date'1988-10-25','Computer & Technology','Available',1),
('21.11.0004','Man Has A Secret Life','Stephany Shell Ford','Beaming Books',date'1988-11-09','History','Unavailable',2),
('21.11.0005','Cat In The Museum','Breann Alita Pope','Brisk Books',date'1989-06-22','Novel','Unavailable',3),
('21.11.0006','Serpent And Stranger','Ferdinand Rosaline Fürst','Beachy Books',date'1990-03-30','Computer & Technology','Available',2),
('21.11.0007','Clown And Buffoon','Truman King Samuel','Beach Bound Books',date'1991-03-20','Psychology','Available',3),
('21.11.0008','Crying Of The Village','Orville Amos Faust','Bound to Books',date'1991-09-06','Law','Available',4),
('21.11.0009','Tricking In The Window','Chanté Eckhard Christopher','Better with Books',date'1992-06-23','History','Available',1),
('21.11.0010','Impressed By My Teacher','Lyanna Koloman Mann','Beyond Books',date'1992-07-06','Computer & Technology','Available',3),
('22.11.0001','Confused By The King','Tyrell Everlee Steiner','Breathtaking Books',date'1996-07-11','History','Available',4),
('22.11.0002','Boy In The Forest','Alysa Pansy Benton','Best Bound Books',date'1997-08-19','History','Available',2),
('22.11.0003','Rupa Dasar Nirmana, Asas Dan Prinsip Dasar Seni Visual','Husen Hendriyana','Andi Offset',date'2020-05-14','Art & Design','Available',9),
('22.11.0004','Wolf Of The Galaxy','Eva Jerri Marsden','Books Without Bounds',date'2004-07-08','Psychology','Available',3),
('22.11.0005','Snakes Of The Flowers','Corrina Garret Kitchen','Bounce Back Books',date'2010-07-20','Novel','Available',1),
('22.11.0006','Bandits In My City','Bernetta Hans-Jürgen Polley','Table of Content',date'2013-09-17','Computer & Technology','Available',8),
('22.11.0007','Humans And Agents','Ilse Maddison Lamar','Library Liftoff',date'2018-08-10','Psychology','Unavailable',2),
('22.11.0008','Criminals And Creators','Fulk Zinnia Gotti','The Book Biz',date'2021-07-14','Novel','Available',3),
('22.11.0009','Runes Of A Cat','Quinton Paxton Weaver','Double Booked',date'1964-01-14','Psychology','Unavailable',2),
('22.11.0010','Dream Of A Person','Harmonie Linford Underhill','The Book Look',date'1964-04-13','Novel','Available',1),
('23.11.0001','Depths Of History','Harta Walker Causer','Andi Offset',date'1964-08-26','biography','Available',5),
('23.11.0002','Depths Of The Light','Cybill Madge Hyland','Elex Media Komputindo',date'1965-01-08','Psychology','Available',2),
('23.11.0003','Pilot In The Past','Porsche Philippa Davidson','Elex Media Komputindo',date'1965-05-12','biography','Available',3),
('23.11.0004','Genom: Kisah Spesies Manusia Dalam 23 Bab','Matt Ridley','Gramedia Pustaka Utama',date'2017-06-19','Science','Available',3),
('23.11.0005','Defender From Outer Space','Amberlynn Kohl','Gramedia Pustaka Utama',date'1965-05-24','biography','Available',4),
('23.11.0006',"Commanders Of Earth's Legacy",'Jayda Ness','Elex Media Komputindo',date'2008-04-18','History','Available',1),
('23.11.0007','Humans From The Portal','Nowell Lawrenz','Andi Offset',date'1968-11-18','Psychology','Available',3),
('23.11.0008','Robots And Aliens','Willie Hoffman','Elex Media Komputindo',date'1969-04-04','Law','Unavailable',2),
('23.11.0009','Commanders And Visitors','Hughie Freund','The Book Biz',date'1975-03-17','Religion','Available',6),
('23.11.0010','Culling Of The New Order','Leontyne Mitchell','Gramedia Pustaka Utama',date'1976-04-05','Religion','Unavailable',1),
('24.11.0001','Result Of Death','Katelin Linton','Gramedia Pustaka Utama',date'1987-09-21','Business & Economy','Unavailable',2),
('24.11.0002','Alive On Solar Flares','Meade Gabrielson','Informatika',date'1992-12-09','Fiction','Unavailable',3),
('24.11.0003','Limits Of A New War','Essie Garver','The Book Biz',date'1993-06-25','Business & Economy','Available',5),
('24.11.0004','Dog Of Magic','Gaynor Wirt','The Book Biz',date'1993-12-17','Fiction','Available',2),
('24.11.0005','Data Mining Dan Machine Learning Menggunakan Matlab Dan Pyth','Rahmadya Trias Handayanto','Informatika',date'2019-11-12','Computer & Technology','Unavailable',4),
('24.11.0006','Chicken Of Miracles','Prosper Horne','Informatika',date'1995-01-05','Law','Unavailable',3),
('24.11.0007','Sheep Of Mystery','Alyse Kolbe','Gramedia Pustaka Utama',date'1997-01-31','Psychology','Unavailable',4),
('24.11.0008','Kings Of Utopia','Chloe Bloxham','Andi Offset',date'2002-06-10','Religion','Available',5),
('24.11.0009','Chickens And Mice','Cherise Brassington','Andi Offset',date'2006-01-04','Psychology','Available',4),
('24.11.0010','Sheep And Birds','Melina Kohl','The Book Biz',date'2006-10-24','Fiction','Unavailable',2);

INSERT INTO ruangan VALUES
('R001'),
('R002'),
('R003'),
('R004'),
('R005'),
('R006'),
('R007'),
('R008'),
('R009'),
('R010'),
('R011'),
('R012'),
('R013'),
('R014'),
('R015');

INSERT INTO member VALUES
('M001','1301194388',null,'haydarrizaldy@student.telkomuniversity.ac.id'),
('M002','1301190351',null,'fadlanakmal@student.telkomuniversity.ac.id'),
('M003','1301194076',null,'nabilazzumar@student.telkomuniversity.ac.id'),
('M004','1301190414',null,'iskandardevan@student.telkomuniversity.ac.id'),
('M005','1301194376',null,'raihanromzi@student.telkomuniversity.ac.id'),
('M006','1301191788',null,'irfanarifmuhamad@student.telkomuniversity.ac.id'),
('M007','1301192527',null,'krisnamansurwira@student.telkomuniversity.ac.id'),
('M008','1301191549',null,'kusumaindahmansur@student.telkomuniversity.ac.id'),
('M009','1301192172',null,'nirmalahartacinta@student.telkomuniversity.ac.id'),
('M010','1301190566',null,'dwisusilasurya@student.telkomuniversity.ac.id'), ('M011','1301193532',null,'zakariaintanirfan@student.telkomuniversity.ac.id'),
('M012','1301190853',null,'adityayudamega@student.telkomuniversity.ac.id'),
('M013','1301194635',null,'imranfirdausibrahim@student.telkomuniversity.ac.id'),
('M014','1301194625',null,'faisalsarimuhamad@student.telkomuniversity.ac.id'),
('M015','1301192062',null,'asihahmadbima@student.telkomuniversity.ac.id'),
('M016','1301191047',null,'wibawaputrirahman@student.telkomuniversity.ac.id'),
('M017','1301192722',null,'vinatriintan@student.telkomuniversity.ac.id'),
('M018','1301192186',null,'muhamadwibawasusila@student.telkomuniversity.ac.id'),
('M019','1301194734',null,'ridwanmuhammadnur@student.telkomuniversity.ac.id'), ('M020','1301191920',null,'citrayusufsurya@student.telkomuniversity.ac.id'),
('M021',null,'WDU','widiastuti@telkomuniversity.ac.id'),
('M022',null,'FDA','firdaniza@telkomuniversity.ac.id'),
('M023',null,'RSA','rosareskariskiana@telkomuniversity.ac.id'),
('M024',null,'AJG','ajigautamaputrada@telkomuniversity.ac.id'),
('M025',null,'TSA','annisaaditsania@telkomuniversity.ac.id'),
('M026',null,'API','agiprasetiadi@telkomuniversity.ac.id'),
('M027',null,'APA','aguspriyanto@telkomuniversity.ac.id'),
('M028',null,'ABA','amaliabeladinna@telkomuniversity.ac.id'),
('M029',null,'AGZ','anggizafia@telkomuniversity.ac.id'),
('M030',null,'AWD','arifWirawanmuhammad@telkomuniversity.ac.id'),
('M031',null,'ADO','auliadesynurutomo@telkomuniversity.ac.id'),
('M032',null,'ASI','auliasholichahiman@telkomuniversity.ac.id'),
('M033',null,'AAB','auliyaburhanuddin@telkomuniversity.ac.id'),
('M034',null,'BPZ','bitapargazen@telkomuniversity.ac.id'),
('M035',null,'DCF','diandrachikaf@telkomuniversity.ac.id'),
('M036',null,'EII','emiiryanti@telkomuniversity.ac.id'),
('M037',null,'FMW','fahrudinmuktiwibowo@telkomuniversity.ac.id'),
('M038',null,'IFA','ipamfuaddinaadam@telkomuniversity.ac.id'),
('M039',null,'IQA','iqsyahirokresna@telkomuniversity.ac.id'),
('M040',null,'ISO','irwansusanto@telkomuniversity.ac.id');

INSERT INTO reservasi_buku VALUES
('RB001','24.11.0005','M003','2020-11-20 18:30:00','2020-11-27 18:30:00'),
('RB002','21.11.0002','M001','2020-11-19 09:30:00','2020-11-26 09:30:00'),
('RB003','23.11.0004','M004','2020-11-22 20:30:00','2020-11-29 20:30:00'),
('RB004','22.11.0003','M002','2020-11-21 10:00:00','2020-11-28 10:00:00'),
('RB005','20.11.0001','M005','2020-11-25 16:15:00','2020-12-02 16:15:00'),
('RB006','21.11.0001','M002','2020-11-1 12:05:00','2020-11-8 12:05:00'),
('RB007','22.11.0001','M001','2020-11-1 20:30:00','2020-11-8 20:30:00'),
('RB008','20.11.0003','M002','2020-11-1 13:35:00','2020-11-8 13:35:00'),
('RB009','21.11.0003','M005','2020-11-2 20:30:00','2020-11-9 20:30:00'),
('RB010','21.11.0004','M007','2020-11-2 13:35:00','2020-11-9 13:35:00'),
('RB011','22.11.0002','M016','2020-11-2 12:05:00','2020-11-9 12:05:00'),
('RB012','23.11.0001','M012','2020-11-2 15:05:00','2020-11-9 15:05:00'),
('RB013','23.11.0002','M002','2020-11-2 13:35:00','2020-11-9 13:35:00'),
('RB014','21.11.0005','M006','2020-11-2 10:45:00','2020-11-9 10:45:00'),
('RB015','24.11.0001','M008','2020-11-4 20:30:00','2020-11-11 20:30:00'),
('RB016','24.11.0002','M009','2020-11-4 12:05:00','2020-11-11 12:05:00'),
('RB017','23.11.0003','M010','2020-11-6 20:30:00','2020-11-13 20:30:00'),
('RB018','20.11.0004','M020','2020-11-7 12:05:00','2020-11-14 12:05:00'),
('RB019','20.11.0005','M019','2020-11-8 20:30:00','2020-11-15 20:30:00'),
('RB020','20.11.0006','M012','2020-11-8 10:45:00','2020-11-15 10:45:00'),
('RB021','23.11.0005','M013','2020-11-9 20:30:00','2020-11-16 20:30:00'),
('RB022','24.11.0003','M015','2020-11-10 20:30:00','2020-11-17 20:30:00'),
('RB023','23.11.0006','M017','2020-11-11 13:35:00','2020-11-18 13:35:00'),
('RB024','22.11.0004','M010','2020-11-11 15:05:00','2020-11-18 15:05:00'),
('RB025','22.11.0005','M001','2020-11-12 12:05:00','2020-11-19 12:05:00'),
('RB026','22.11.0006','M002','2020-11-13 20:30:00','2020-11-20 20:30:00'),
('RB027','24.11.0004','M007','2020-11-14 10:45:00','2020-11-21 10:45:00'),
('RB028','22.11.0007','M006','2020-11-16 13:35:00','2020-11-23 13:35:00'),
('RB029','22.11.0008','M003','2020-11-17 15:05:00','2020-11-24 15:05:00'),
('RB030','24.11.0006','M005','2020-11-18 20:30:00','2020-11-25 20:30:00');
 
INSERT INTO reservasi_ruangan VALUES
('RR001','R001','M001','2020-11-24 13:30:00','2020-11-24 15:30:00'),
('RR002','R002','M002','2020-11-25 09:15:00','2020-11-25 11:15:00'),
('RR003','R003','M003','2020-11-26 10:30:00','2020-11-26 12:30:00'),
('RR004','R004','M004','2020-11-27 16:00:00','2020-11-27 18:00:00'),
('RR005','R005','M005','2020-11-28 18:30:00','2020-11-28 20:30:00');

INSERT INTO perpanjangan VALUES 
('PP001','M001','RB002','2020-12-03 09:30:00'),
('PP002','M004','RB003','2020-12-06 20:30:00'),
('PP003','M002','RB004','2020-12-05 10:00:00'),
('PP004','M003','RB001','2020-12-04 18:30:00'),
('PP005','M005','RB005','2020-12-09 16:15:00');

INSERT INTO denda VALUES 
('D001','M001','1'),
('D002','M003','2'),
('D003','M004','2'),
('D004','M002','4'),
('D005','M005','7'),
('D006','M003','4'),
('D007','M003','8'),
('D008','M006','9'),
('D009','M008','3'),
('D010','M010','5'),
('D011','M010','7'),
('D012','M012','2'),
('D013','M006','1'),
('D014','M014','3'),
('D015','M002','5'),
('D016','M002','9'),
('D017','M002','3'),
('D018','M007','3'),
('D019','M008','2'),
('D020','M009','1');

/* 

- CASE STUDY -

1) Mencari mahasiswa yang melakukan reservasi ruangan pada tanggal tertentu dan nama ruangannya.
2) Mencari mahasiswa yang meminjam ruangan dari yang paling lama hingga sebentar.
3) Menampilkan urutan buku yang memiliki jumlah eksemplar terbanyak hingga paling sedikit.
4) Mendcari mahasiswa dengan denda terbanyak
5) Menampilkan jenis buku (lokasi rak) yang paling banyak dipinjam
6) Menampilkan list tahun terbit buku dari yg terlama hingga terbaru


*/

## QUERY

### 1. Mencari mahasiswa yang melakukan reservasi ruangan pada tanggal tertentu dan nama ruangannya

	SELECT 
		mahasiswa.nim, 
		mahasiswa.nama_mahasiswa, 
		member.kode_member, 
		reservasi_ruangan.kode_reservasi_ruangan, 
		reservasi_ruangan.kode_ruangan, 
		reservasi_ruangan.waktu_mulai, 
		reservasi_ruangan.waktu_selesai 
	FROM mahasiswa 
	JOIN member ON mahasiswa.nim=member.nim 
	JOIN reservasi_ruangan ON member.kode_member=reservasi_ruangan.kode_member 
	WHERE (CONVERT(reservasi_ruangan.waktu_mulai USING utf8) LIKE '%2020-11-26%') AND reservasi_ruangan.kode_ruangan='R003'

### 2. Mencari mahasiswa yang meminjam ruangan dari yang paling lama hingga sebentar

	SELECT 
		mahasiswa.nim, 
		mahasiswa.nama_mahasiswa, 
		member.kode_member, 
		reservasi_ruangan.kode_reservasi_ruangan, 
		reservasi_ruangan.kode_ruangan, 
		reservasi_ruangan.waktu_mulai, 
		reservasi_ruangan.waktu_selesai, 
		TIMESTAMPDIFF(minute, reservasi_ruangan.waktu_selesai, reservasi_ruangan.waktu_mulai) AS jangka_waktu 
	FROM mahasiswa 
	JOIN member ON mahasiswa.nim=member.nim 
	JOIN reservasi_ruangan ON member.kode_member=reservasi_ruangan.kode_member 
	ORDER BY jangka_waktu ASC LIMIT 1

### 3. Menampilkan buku yang tersedia dan diurutkan berdasarkan jumlah eksemplarnya

	SELECT * FROM buku 
	WHERE status='Available' 
	ORDER BY buku.jumlah_eksemplar DESC

### 4. Mencari mahasiswa dengan denda terbanyak

	SELECT 
		mahasiswa.nim, 
		mahasiswa.nama_mahasiswa, 
		denda.kode_member, denda.jumlah_hari, COUNT(denda.kode_member) AS jumlah_denda 
	FROM denda 
	JOIN member ON denda.kode_member=member.kode_member 
	JOIN mahasiswa ON member.nim=mahasiswa.nim 
	GROUP BY kode_member 
	ORDER BY jumlah_denda DESC LIMIT 1

### 5. Menampilkan jenis buku (lokasi rak) yang paling banyak dipinjam

	SELECT 
		buku.lokasi_rak, 
		COUNT(reservasi_buku.kode_buku) AS jumlah_pinjaman 
	FROM buku 
	RIGHT JOIN reservasi_buku ON buku.kode_buku=reservasi_buku.kode_buku 
	GROUP BY buku.lokasi_rak 
	ORDER BY jumlah_pinjaman DESC LIMIT 1

### 6. Menampilkan list buku terbitan Andi Offset berdasarkan urutan tahun terbit buku dimulai dari yang terlama hingga terbaru

	SELECT * FROM buku 
	WHERE nama_penerbit='Andi Offset' 
	ORDER BY buku.tahunterbit_buku ASC