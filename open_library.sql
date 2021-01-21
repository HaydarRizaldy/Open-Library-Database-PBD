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
    kode_denda              CHAR(4) NOT NULL, 
    kode_member             CHAR(4), 
    kode_reservasi_buku     CHAR(5),
    jumlah_hari             INTEGER(3), 
    PRIMARY KEY (kode_denda)
);

ALTER TABLE denda 
ADD CONSTRAINT fk_kode_member_denda FOREIGN KEY (kode_member) REFERENCES member (kode_member);

ALTER TABLE denda 
ADD CONSTRAINT fk_kode_rb_denda FOREIGN KEY (kode_reservasi_buku) REFERENCES reservasi_buku (kode_reservasi_buku);


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
('1301194076','Nabil Azzumar Labib','IF-43-12'),
('1301190208','Bahar Novilda','IF-43-11'),
('1301190212','Fadlan Rachmawati','IF-43-10'),
('1301197327','Roxane Combs','IF-43-09'),
('1301193702','Hilaria Rodrigue','IF-43-08'),
('1301190971','Cathi Dunlap','IF-43-07'),
('1301194887','Ji Fiore','IF-43-06'),
('1301198756','Arletha Mcnamara','IF-43-05'),
('1301196598','Jin Pickens','IF-43-04'),
('1301193674','Gretta Gaylord','IF-43-03'),
('1301193704','Lesa Fountain','IF-43-02'),
('1301199769','Anjanette Coley','IF-43-01'),
('1301199670','Rebekah Post','IF-43-00'),
('1301190372','Carleen Rinehart','IF-43-01'),
('1301192449','Frieda Dotson','IF-43-02'),
('1301196951','Ruthe Stark','IF-43-03'),
('1301199783','Makeda Lindley','IF-43-04'),
('1301194649','Britany Shull','IF-43-05'),
('1301198710','Janita Jewell','IF-43-06'),
('1301191499','Sol Tamayo','IF-43-07'),
('1301196517','Stephanie Mangum','IF-43-08'),
('1301190198','Wilmer Coe','IF-43-09'),
('1301199561','Kisha Mckinnon','IF-43-10'),
('1301197039','Audry Stitt','IF-43-11'),
('1301196012','Maisha Payton','IF-43-12'),
('1301199695','Rosanne Nicholson','IF-43-13'),
('1301195347','Shenika Crews','IF-43-14'),
('1301194786','Louetta Cates','IF-43-15'),
('1301198672','Rosetta Labbe','IF-43-16'),
('1301198469','Delana Kemp','IF-43-17'),
('1301193322','Cheryll Pippin','IF-43-18'),
('1301196825','Antionette Bartlett','IF-43-19'),
('1301191452','Carol Applegate','IF-43-20'),
('1301197174','Dannielle Latimer','IF-43-21'),
('1301199872','Toshiko Reddick','IF-43-22'),
('1301199424','Noel Lemon','IF-43-23'),
('1301199272','Kraig Haggerty','IF-43-24'),
('1301198848','Val Herron','IF-43-25'),
('1301192868','Susanne Leak','IF-43-26'),
('1301197095','Ericka Beebe','IF-43-27'),
('1301194269','Dodie Corona','IF-43-28'),
('1301192040','Zola Staton','IF-43-29'),
('1301199784','Matha Huddleston','IF-43-30'),
('1301198629','Marva Binkley','IF-43-31'),
('1301191526','Raylene Woody','IF-43-32');



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
('ISO','Irwan Susanto','F-265'),
('MPR','Mega Pranata S','F-291'),
('MWB','Merlinda Wibowo','F-261'),
('MAG','Muhamad Azrino Gustalika','F-251'),
('MAM','Muhammad Afrizal Amrustian','F-218'),
('MFS','Muhammad Fajar Sidiq','F-209'),
('MZN','Muhammad Zidny','F-202'),
('NAS','Novanda Alim Setya Nugraha','F-225'),
('NAP','Novian Adi Prasetyo','F-217'),
('PRD','Paradise','F-261'),
('PAR','Pradana Ananda Raharja','F-298'),
('RWP','Ridwan Pandiya','F-222'),
('SDA','Shintia Dwi Alika','F-213'),
('TWM','Tenia Wahyuningrum','F-207'),
('TGL','Tri Ginanjar Laksana','F-221'),
('THY','Trihastuti Yuniati','F-239'),
('WAP','Wahyu Adi Prabowo','F-251'),
('WAA','Wahyu Andi Saputra','F-265'),
('WDW','Widi Widayat','F-263'),
('YAS','Yoso Adi Setyoko','F-217'),
('RRR','Raihan Romzi R','F-295');



INSERT INTO buku VALUES
('22.11.0008', 'Criminals And Creators', 'Fulk Zinnia Gotti', 'The Book Biz', '2021-01-14', 'Novel', 'Available', 3),
('20.11.0006', 'Descendants And Wives', 'Satchel Danica Baker', 'Turning Pages', '2021-01-13', 'Fiction', 'Available', 1),
('21.11.0004', 'Man Has A Secret Life', 'Stephany Shell Ford', 'Beaming Books', '2020-11-09', 'History', 'Unavailable', 2),
('20.11.0004', 'Blacksmiths Of My Imagination', 'Viola Kourtney Dressler', 'Page by Page', '2020-08-22', 'Fiction', 'Available', 5),
('24.11.0003', 'Limits Of A New War', 'Essie Garver', 'The Book Biz', '2020-06-25', 'Business & Economy', 'Available', 5),
('22.11.0003', 'Rupa Dasar Nirmana, Asas Dan Prinsip Dasar Seni Visual', 'Husen Hendriyana', 'Andi Offset', '2020-05-14', 'Art & Design', 'Available', 9),
('22.11.0010', 'Dream Of A Person', 'Harmonie Linford Underhill', 'The Book Look', '2020-04-13', 'Novel', 'Available', 1),
('23.11.0010', 'Culling Of The New Order', 'Leontyne Mitchell', 'Gramedia Pustaka Utama', '2020-04-05', 'Religion', 'Unavailable', 1),
('24.11.0007', 'Sheep Of Mystery', 'Alyse Kolbe', 'Gramedia Pustaka Utama', '2020-01-31', 'Psychology', 'Unavailable', 4),
('20.11.0002', 'Invader Without A Conscience', 'Dieter Franz Xaver Saylor', 'Bookends', '2019-11-08', 'Computer & Technology', 'Available', 2),
('22.11.0002', 'Boy In The Forest', 'Alysa Pansy Benton', 'Best Bound Books', '2019-08-19', 'History', 'Available', 2),
('22.11.0001', 'Confused By The King', 'Tyrell Everlee Steiner', 'Breathtaking Books', '2019-07-11', 'History', 'Available', 4),
('21.11.0002', 'Unbranding', 'Scott Stratten', 'Elex Media Komputindo', '2018-10-01', 'Business & Economy', 'Unavailable', 5),
('22.11.0007', 'Humans And Agents', 'Ilse Maddison Lamar', 'Library Liftoff', '2018-08-10', 'Psychology', 'Unavailable', 2),
('21.11.0005', 'Cat In The Museum', 'Breann Alita Pope', 'Brisk Books', '2018-06-22', 'Novel', 'Unavailable', 3),
('21.11.0008', 'Crying Of The Village', 'Orville Amos Faust', 'Bound to Books', '2017-09-06', 'Law', 'Available', 4),
('21.11.0010', 'Impressed By My Teacher', 'Lyanna Koloman Mann', 'Beyond Books', '2017-07-06', 'Computer & Technology', 'Available', 3),
('23.11.0004', 'Genom: Kisah Spesies Manusia Dalam 23 Bab', 'Matt Ridley', 'Gramedia Pustaka Utama', '2017-06-19', 'Science', 'Available', 3),
('20.11.0003', 'Blacksmith Of The Day', 'Gundula Beckett Krebs', 'Better Bound Books', '2017-01-03', 'Business & Economy', 'Unavailable', 3),
('20.11.0001', 'Cloud Computing: Manajemen Dan Perencanaan Kapasitas', 'Riko Herwanto', 'Andi Offset', '2016-10-30', 'Computer & Technology', 'Available', 12),
('21.11.0003', 'Officer Gamble', 'Martin Mary Beth Seeger', 'Beautiful Books', '2016-10-25', 'Computer & Technology', 'Available', 1),
('20.11.0009', 'Faction Of The South', 'Deloris Mikki Monday', 'The Lookbooks', '2016-02-08', 'Fiction', 'Unavailable', 2),
('24.11.0010', 'Sheep And Birds', 'Melina Kohl', 'The Book Biz', '2015-10-24', 'Fiction', 'Unavailable', 2),
('23.11.0005', 'Defender From Outer Space', 'Amberlynn Kohl', 'Gramedia Pustaka Utama', '2015-05-24', 'Biography', 'Available', 4),
('20.11.0008', 'Intention Of Nightmares', 'Brady Lili Arbeit', 'Find Your Bind', '2015-03-10', 'Computer & Technology', 'Unavailable', 4),
('24.11.0006', 'Chicken Of Miracles', 'Prosper Horne', 'Informatika', '2015-01-05', 'Law', 'Unavailable', 3),
('24.11.0005', 'Data Mining Dan Machine Learning Menggunakan Matlab Dan Pyth', 'Rahmadya Trias Handayanto', 'Informatika', '2014-11-12', 'Computer & Technology', 'Unavailable', 4),
('24.11.0001', 'Result Of Death', 'Katelin Linton', 'Gramedia Pustaka Utama', '2014-09-21', 'Business & Economy', 'Unavailable', 2),
('23.11.0009', 'Commanders And Visitors', 'Hughie Freund', 'The Book Biz', '2014-03-17', 'Religion', 'Available', 6),
('20.11.0005', 'Heroes Of Dawn', 'Peter Allyn Keil', 'Lost and Bound', '2013-11-30', 'Computer & Technology', 'Unavailable', 2),
('22.11.0006', 'Bandits In My City', 'Bernetta Hans-Jürgen Polley', 'Table of Content', '2013-09-17', 'Computer & Technology', 'Available', 8),
('24.11.0004', 'Dog Of Magic', 'Gaynor Wirt', 'The Book Biz', '2012-12-17', 'Fiction', 'Available', 2),
('21.11.0009', 'Tricking In The Window', 'Chanté Eckhard Christopher', 'Better with Books', '2012-06-23', 'History', 'Available', 1),
('23.11.0003', 'Pilot In The Past', 'Porsche Philippa Davidson', 'Elex Media Komputindo', '2012-05-12', 'Biography', 'Available', 3),
('20.11.0007', 'Aliens And Doctors', 'Roni Teresa Beckett', 'Book Barn', '2011-08-24', 'Law', 'Unavailable', 3),
('21.11.0001', 'Harlequin With Stunts', 'Elliot Jodene Ryer', 'Book Bindings', '2011-03-10', 'Business & Economy', 'Unavailable', 6),
('22.11.0005', 'Snakes Of The Flowers', 'Corrina Garret Kitchen', 'Bounce Back Books', '2010-07-20', 'Novel', 'Available', 1),
('23.11.0006', 'Commanders Of Earth\'s Legacy', 'Jayda Ness', 'Elex Media Komputindo', '2008-04-18', 'History', 'Available', 1),
('21.11.0006', 'Serpent And Stranger', 'Ferdinand Rosaline Fürst', 'Beachy Books', '2008-03-30', 'Computer & Technology', 'Available', 2),
('23.11.0008', 'Robots And Aliens', 'Willie Hoffman', 'Elex Media Komputindo', '2007-04-04', 'Law', 'Unavailable', 2),
('23.11.0007', 'Humans From The Portal', 'Nowell Lawrenz', 'Andi Offset', '2006-11-18', 'Psychology', 'Available', 3),
('20.11.0010', 'Praised By My Dreams', 'Lisette Minerva Foster', 'Fresh Pages', '2006-03-20', 'Psychology', 'Available', 5),
('24.11.0009', 'Chickens And Mice', 'Cherise Brassington', 'Andi Offset', '2006-01-04', 'Psychology', 'Available', 4),
('22.11.0009', 'Runes Of A Cat', 'Quinton Paxton Weaver', 'Double Booked', '2005-01-14', 'Psychology', 'Unavailable', 2),
('22.11.0004', 'Wolf Of The Galaxy', 'Eva Jerri Marsden', 'Books Without Bounds', '2004-07-08', 'Psychology', 'Available', 3),
('23.11.0001', 'Depths Of History', 'Harta Walker Causer', 'Andi Offset', '2003-08-26', 'Biography', 'Available', 5),
('24.11.0008', 'Kings Of Utopia', 'Chloe Bloxham', 'Andi Offset', '2002-06-10', 'Religion', 'Available', 5),
('24.11.0002', 'Alive On Solar Flares', 'Meade Gabrielson', 'Informatika', '2001-12-09', 'Fiction', 'Unavailable', 3),
('23.11.0002', 'Depths Of The Light', 'Cybill Madge Hyland', 'Elex Media Komputindo', '2001-01-08', 'Psychology', 'Available', 2),
('21.11.0007', 'Clown And Buffoon', 'Truman King Samuel', 'Beach Bound Books', '2000-03-20', 'Psychology', 'Available', 3);



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
('R015'),
('R016'),
('R017'),
('R018'),
('R019'),
('R020'),
('R021'),
('R022'),
('R023'),
('R024'),
('R025'),
('R026'),
('R027'),
('R028'),
('R029'),
('R030'),
('R031'),
('R032'),
('R033'),
('R034'),
('R035'),
('R036'),
('R037'),
('R038'),
('R039'),
('R040'),
('R041'),
('R042'),
('R043'),
('R044'),
('R045'),
('R046'),
('R047'),
('R048'),
('R049'),
('R050');




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
('RB006','21.11.0002','M002','2020-11-1 12:05:00','2020-11-8 12:05:00'),
('RB007','22.11.0003','M001','2020-11-1 20:30:00','2020-11-8 20:30:00'),
('RB008','20.11.0006','M002','2020-11-1 13:35:00','2020-11-8 13:35:00'),
('RB009','21.11.0008','M005','2020-11-2 20:30:00','2020-11-9 20:30:00'),
('RB010','21.11.0004','M007','2020-11-2 13:35:00','2020-11-9 13:35:00'),
('RB011','22.11.0004','M016','2020-11-2 12:05:00','2020-11-9 12:05:00'),
('RB012','23.11.0009','M012','2020-11-2 15:05:00','2020-11-9 15:05:00'),
('RB013','23.11.0001','M002','2020-11-2 13:35:00','2020-11-9 13:35:00'),
('RB014','21.11.0005','M006','2020-11-2 10:45:00','2020-11-9 10:45:00'),
('RB015','24.11.0001','M008','2020-11-4 20:30:00','2020-11-11 20:30:00'),
('RB016','24.11.0002','M009','2020-11-4 12:05:00','2020-11-11 12:05:00'),
('RB017','23.11.0002','M010','2020-11-6 20:30:00','2020-11-13 20:30:00'),
('RB018','20.11.0003','M020','2020-11-7 12:05:00','2020-11-14 12:05:00'),
('RB019','20.11.0005','M009','2020-11-8 20:30:00','2020-11-15 20:30:00'),
('RB020','20.11.0006','M012','2020-11-8 10:45:00','2020-11-15 10:45:00'),
('RB021','23.11.0004','M013','2020-11-9 20:30:00','2020-11-16 20:30:00'),
('RB022','24.11.0003','M015','2020-11-10 20:30:00','2020-11-17 20:30:00'),
('RB023','23.11.0006','M017','2020-11-11 13:35:00','2020-11-18 13:35:00'),
('RB024','22.11.0004','M010','2020-11-11 15:05:00','2020-11-18 15:05:00'),
('RB025','22.11.0005','M002','2020-11-12 12:05:00','2020-11-19 12:05:00'),
('RB026','22.11.0006','M002','2020-11-13 20:30:00','2020-11-20 20:30:00'),
('RB027','24.11.0004','M001','2020-11-14 10:45:00','2020-11-21 10:45:00'),
('RB028','22.11.0007','M006','2020-11-16 13:35:00','2020-11-23 13:35:00'),
('RB029','23.11.0001','M004','2020-11-17 15:05:00','2020-11-24 15:05:00'),
('RB030','24.11.0002','M005','2020-11-18 20:30:00','2020-11-25 20:30:00'),
('RB031','24.11.0004','M014','2020-11-9 20:30:00','2020-11-16 20:30:00'),
('RB032','24.11.0003','M015','2020-11-10 20:30:00','2020-11-17 20:30:00'),
('RB033','23.11.0006','M017','2020-11-11 13:35:00','2020-11-18 13:35:00'),
('RB034','21.11.0004','M011','2020-11-11 15:05:00','2020-11-18 15:05:00'),
('RB035','21.11.0005','M003','2020-11-12 12:05:00','2020-11-19 12:05:00'),
('RB036','21.11.0006','M002','2020-11-13 20:30:00','2020-11-20 20:30:00'),
('RB037','23.11.0004','M007','2020-11-14 10:45:00','2020-11-21 10:45:00'),
('RB038','24.11.0007','M006','2020-11-16 13:35:00','2020-11-23 13:35:00'),
('RB039','23.11.0008','M003','2020-11-17 15:05:00','2020-11-24 15:05:00'),
('RB040','22.11.0006','M005','2020-11-18 20:30:00','2020-11-25 20:30:00');

 
INSERT INTO reservasi_ruangan VALUES
('RR001', 'R001', 'M002', '2020-11-10 08:10:00', '2020-11-10 11:43:00'),
('RR002', 'R002', 'M001', '2020-11-10 12:37:25', '2020-11-10 14:52:00'),
('RR003', 'R003', 'M002', '2020-11-10 15:00:00', '2020-11-10 18:03:00'),
('RR004', 'R003', 'M004', '2020-11-10 18:10:00', '2020-11-10 19:31:00'),
('RR005', 'R004', 'M007', '2020-11-11 07:11:00', '2020-11-11 08:45:00'),
('RR006', 'R005', 'M008', '2020-11-11 09:01:00', '2020-11-11 11:00:00'),
('RR008', 'R007', 'M009', '2020-11-11 11:32:00', '2020-11-11 12:30:00'),
('RR009', 'R008', 'M001', '2020-11-11 13:03:00', '2020-11-11 14:30:00'),
('RR010', 'R009', 'M002', '2020-11-11 15:11:00', '2020-11-11 17:30:00'),
('RR011', 'R010', 'M011', '2020-11-11 18:11:00', '2020-11-11 20:09:00'),
('RR012', 'R011', 'M012', '2020-11-12 07:44:00', '2020-11-12 08:59:00'),
('RR013', 'R012', 'M015', '2020-11-12 09:30:00', '2020-11-12 10:30:00'),
('RR014', 'R013', 'M017', '2020-11-12 11:00:00', '2020-11-12 12:18:00'),
('RR015', 'R014', 'M020', '2020-11-12 12:30:00', '2020-11-12 14:41:00'),
('RR016', 'R015', 'M013', '2020-11-12 15:30:00', '2020-11-12 17:52:00'),
('RR017', 'R016', 'M012', '2020-11-12 18:03:00', '2020-11-12 22:00:00'),
('RR018', 'R017', 'M015', '2020-11-13 07:00:00', '2020-11-13 08:47:00'),
('RR019', 'R018', 'M002', '2020-11-13 09:00:00', '2020-11-13 11:42:00'),
('RR020', 'R019', 'M004', '2020-11-13 12:34:00', '2020-11-13 14:51:00'),
('RR021', 'R020', 'M006', '2020-11-13 15:14:00', '2020-11-13 18:00:00'),
('RR022', 'R021', 'M006', '2020-11-13 19:00:00', '2020-11-13 21:30:00'),
('RR023', 'R022', 'M001', '2020-11-14 07:49:00', '2020-11-14 08:30:00'),
('RR024', 'R023', 'M001', '2020-11-14 09:00:00', '2020-11-14 09:40:00'),
('RR025', 'R024', 'M001', '2020-11-14 10:12:00', '2020-11-14 11:30:00'),
('RR026', 'R025', 'M002', '2020-11-14 12:00:00', '2020-11-14 14:30:00'),
('RR027', 'R026', 'M003', '2020-11-14 15:09:00', '2020-11-14 16:30:00'),
('RR028', 'R027', 'M005', '2020-11-14 17:17:00', '2020-11-14 20:59:00'),
('RR029', 'R028', 'M020', '2020-11-15 08:12:00', '2020-11-15 09:41:00'),
('RR030', 'R029', 'M019', '2020-11-15 10:30:00', '2020-11-15 12:00:00'),
('RR031', 'R030', 'M003', '2020-11-15 12:15:00', '2020-11-15 13:45:00'),
('RR032', 'R031', 'M011', '2020-11-15 14:05:00', '2020-11-15 15:30:00'),
('RR033', 'R032', 'M012', '2020-11-15 15:46:00', '2020-11-15 18:32:00'),
('RR034', 'R033', 'M013', '2020-11-16 07:40:00', '2020-11-16 11:36:00'),
('RR035', 'R034', 'M004', '2020-11-16 12:30:00', '2020-11-16 14:59:00'),
('RR036', 'R035', 'M005', '2020-11-16 17:20:00', '2020-11-25 21:30:00'),
('RR037', 'R036', 'M006', '2020-11-17 07:08:00', '2020-11-17 08:05:00'),
('RR038', 'R037', 'M017', '2020-11-17 10:07:00', '2020-11-17 11:44:00'),
('RR039', 'R038', 'M018', '2020-11-17 14:08:00', '2020-11-17 15:06:00'),
('RR040', 'R039', 'M009', '2020-11-17 18:30:00', '2020-11-17 20:49:00'),
('RR041', 'R040', 'M040', '2020-11-18 08:48:00', '2020-11-18 10:30:00'),
('RR042', 'R041', 'M039', '2020-11-18 12:30:00', '2020-11-18 13:52:00'),
('RR043', 'R042', 'M002', '2020-11-18 15:10:00', '2020-11-18 17:25:00'),
('RR044', 'R043', 'M001', '2020-11-18 18:19:00', '2020-11-18 21:08:52'),
('RR045', 'R044', 'M003', '2020-11-19 07:30:00', '2020-11-19 09:45:00'),
('RR046', 'R045', 'M005', '2020-11-19 10:11:00', '2020-11-19 11:51:00'),
('RR047', 'R046', 'M007', '2020-11-19 13:00:00', '2020-11-19 14:44:00'),
('RR048', 'R047', 'M008', '2020-11-19 15:14:00', '2020-11-19 18:00:00'),
('RR049', 'R048', 'M010', '2020-11-19 18:30:00', '2020-11-19 20:30:00'),
('RR050', 'R049', 'M001', '2020-11-20 07:42:00', '2020-11-20 10:05:00'),
('RR051', 'R050', 'M002', '2020-11-20 13:12:00', '2020-11-20 15:06:00');


INSERT INTO perpanjangan VALUES 
('PP001','M001','RB002','2020-12-03 09:30:00'),
('PP002','M004','RB003','2020-12-06 20:30:00'),
('PP003','M002','RB004','2020-12-05 10:00:00'),
('PP004','M003','RB001','2020-12-04 18:30:00'),
('PP005','M005','RB005','2020-12-09 16:15:00'),
('PP006','M002','RB004','2020-12-09 17:15:00'),
('PP007','M006','RB003','2020-12-04 19:30:00'),
('PP008','M004','RB005','2020-12-06 05:30:00'),
('PP009','M006','RB007','2020-12-07 15:30:00'),
('PP010','M017','RB009','2020-12-09 01:30:00'),
('PP011','M019','RB011','2020-12-10 11:30:00'),
('PP012','M001','RB013','2020-12-11 21:30:00'),
('PP013','M020','RB015','2020-12-13 07:30:00'),
('PP014','M021','RB017','2020-12-14 17:30:00'),
('PP015','M022','RB019','2020-12-16 03:30:00'),
('PP016','M023','RB021','2020-12-17 13:30:00'),
('PP017','M024','RB023','2020-12-18 23:30:00'),
('PP018','M025','RB025','2020-12-20 09:30:00'),
('PP019','M019','RB027','2020-12-21 19:30:00'),
('PP020','M020','RB029','2020-12-23 05:30:00'),
('PP021','M021','RB031','2020-12-24 15:30:00'),
('PP022','M022','RB033','2020-12-26 01:30:00'),
('PP023','M023','RB035','2020-12-27 11:30:00'),
('PP024','M024','RB037','2020-12-28 21:30:00'),
('PP025','M015','RB039','2020-12-30 07:30:00'),
('PP026','M006','RB001','2020-12-31 17:30:00'),
('PP027','M017','RB005','2021-01-02 03:30:00'),
('PP028','M019','RB009','2021-01-03 13:30:00'),
('PP029','M001','RB013','2021-01-04 23:30:00'),
('PP030','M020','RB017','2021-01-06 09:30:00'),
('PP031','M012','RB021','2021-01-07 19:30:00'),
('PP032','M012','RB025','2021-01-09 05:30:00'),
('PP033','M013','RB029','2021-01-10 15:30:00'),
('PP034','M004','RB033','2021-01-12 01:30:00'),
('PP035','M005','RB037','2021-01-13 11:30:00'),
('PP036','M010','RB017','2021-01-06 09:30:00'),
('PP037','M011','RB021','2021-01-07 19:30:00'),
('PP038','M002','RB025','2021-01-09 05:30:00'),
('PP039','M013','RB029','2021-01-10 15:30:00'),
('PP040','M014','RB033','2021-01-12 01:30:00');



INSERT INTO denda VALUES 
('D001','M001','RB025','1'),
('D002','M003','RB001','2'),
('D003','M004','RB003','2'),
('D004','M002','RB008','4'),
('D005','M005','RB009','7'),
('D006','M003','RB029','4'),
('D007','M001','RB007','8'),
('D008','M006','RB028','9'),
('D009','M008','RB015','3'),
('D010','M010','RB024','5'),
('D011','M010','RB017','7'),
('D012','M012','RB012','2'),
('D013','M006','RB014','1'),
('D014','M013','RB021','3'),
('D015','M002','RB006','5'),
('D016','M002','RB026','9'),
('D017','M002','RB013','3'),
('D018','M007','RB027','3'),
('D019','M005','RB030','2'),
('D020','M009','RB016','1'),
('D021','M022','RB012','2'),
('D022','M006','RB003','9'),
('D023','M004','RB005','10'),
('D024','M006','RB007','1'),
('D025','M017','RB009','4'),
('D026','M019','RB011','1'),
('D027','M001','RB013','1'),
('D028','M020','RB015','2'),
('D029','M021','RB017','12'),
('D030','M022','RB019','20'),
('D031','M023','RB021','14'),
('D032','M024','RB023','18'),
('D033','M025','RB025','17'),
('D034','M019','RB027','4'),
('D035','M020','RB029','2'),
('D036','M021','RB031','19'),
('D037','M022','RB033','23'),
('D038','M023','RB035','20'),
('D039','M024','RB037','11'),
('D040','M015','RB039','3');


/* 

- CASE STUDY -

1) Mencari mahasiswa yang melakukan reservasi ruangan pada tanggal tertentu dan nama ruangannya. (Contoh: tanggal 26 November 2020 dan ruangan R003)
2) Menampilkan urutan peminjaman ruangan oleh mahasiswa dari yang paling lama hingga sebentar.
3) Menampilkan buku apa saja yang dipinjam pada tanggal tertentu. (Contoh: tanggal 2 November 2020)
4) Mencari mahasiswa dengan denda terbanyak serta menampilkan jumlah hari dari denda mahasiswa tesebut.
5) Menampilkan jenis buku (lokasi rak) dengan urutan dari yang paling banyak dipinjam.
6) Mencari mahasiswa yang meminjam ruangan lebih lama dari mahasiswa yang bernama "Citra Yusuf" serta diurutkan dari yang terlama.



*/

## QUERY

### 1. Mencari mahasiswa yang melakukan reservasi ruangan pada tanggal tertentu dan nama ruangannya. (Contoh: tanggal 26 November 2020 dan ruangan R003)

	SELECT mahasiswa.nim, mahasiswa.nama_mahasiswa, member.kode_member, reservasi_ruangan.kode_reservasi_ruangan, reservasi_ruangan.kode_ruangan, reservasi_ruangan.waktu_mulai, reservasi_ruangan.waktu_selesai FROM mahasiswa JOIN member ON mahasiswa.nim=member.nim JOIN reservasi_ruangan ON member.kode_member=reservasi_ruangan.kode_member WHERE (CONVERT(reservasi_ruangan.waktu_mulai USING utf8) LIKE '%2020-11-10%') AND reservasi_ruangan.kode_ruangan='R003'

### 2. Menampilkan urutan peminjaman ruangan oleh mahasiswa dari yang paling lama hingga sebentar.

	SELECT mahasiswa.nim, mahasiswa.nama_mahasiswa, member.kode_member, reservasi_ruangan.kode_reservasi_ruangan, reservasi_ruangan.kode_ruangan, reservasi_ruangan.waktu_mulai, reservasi_ruangan.waktu_selesai, CONCAT(MOD(TIMESTAMPDIFF(hour, reservasi_ruangan.waktu_mulai, reservasi_ruangan.waktu_selesai), 24), ' jam, ', MOD(TIMESTAMPDIFF(minute, reservasi_ruangan.waktu_mulai, reservasi_ruangan.waktu_selesai), 60), ' menit') AS jangka_waktu FROM mahasiswa JOIN member ON mahasiswa.nim=member.nim JOIN reservasi_ruangan ON member.kode_member=reservasi_ruangan.kode_member ORDER BY jangka_waktu DESC

### 3. Menampilkan buku apa saja yang dipinjam pada tanggal tertentu. (Contoh: tanggal 2 November 2020)

	SELECT buku.kode_buku, buku.judul_buku, buku.lokasi_rak, mahasiswa.nama_mahasiswa, member.kode_member, reservasi_buku.waktu_peminjaman FROM reservasi_buku JOIN buku ON reservasi_buku.kode_buku=buku.kode_buku JOIN member ON reservasi_buku.kode_member=member.kode_member JOIN mahasiswa ON member.nim=mahasiswa.nim WHERE (CONVERT(reservasi_buku.waktu_peminjaman USING utf8) LIKE '%2020-11-02%')

### 4. Mencari mahasiswa dengan denda terbanyak serta menampilkan jumlah hari dari denda mahasiswa tesebut

	SELECT mahasiswa.nim, mahasiswa.nama_mahasiswa, denda.kode_member, SUM(denda.jumlah_hari) AS jumlah_hari, COUNT(denda.kode_member) AS jumlah_denda FROM denda JOIN member ON denda.kode_member=member.kode_member JOIN mahasiswa ON member.nim=mahasiswa.nim GROUP BY kode_member ORDER BY jumlah_denda DESC LIMIT 1

### 5. Menampilkan jenis buku (lokasi rak) yang paling banyak dipinjam

	SELECT buku.lokasi_rak, COUNT(reservasi_buku.kode_buku) AS jumlah_pinjaman FROM buku RIGHT JOIN reservasi_buku ON buku.kode_buku=reservasi_buku.kode_buku GROUP BY buku.lokasi_rak ORDER BY jumlah_pinjaman DESC

### 6. Mencari mahasiswa yang meminjam ruangan lebih lama dari mahasiswa yang bernama "Citra Yusuf" serta diurutkan dari yang terlama

	SELECT mahasiswa.nim, mahasiswa.nama_mahasiswa, member.kode_member, CONCAT(SUM(MOD(TIMESTAMPDIFF(minute, reservasi_ruangan.waktu_mulai, reservasi_ruangan.waktu_selesai), 3600)), ' menit') AS jumlah_jangka_waktu FROM mahasiswa JOIN member ON mahasiswa.nim=member.nim JOIN reservasi_ruangan ON member.kode_member=reservasi_ruangan.kode_member GROUP BY mahasiswa.nim HAVING SUM(MOD(TIMESTAMPDIFF(minute, reservasi_ruangan.waktu_mulai, reservasi_ruangan.waktu_selesai), 3600)) > (SELECT SUM(MOD(TIMESTAMPDIFF(minute, reservasi_ruangan.waktu_mulai, reservasi_ruangan.waktu_selesai), 3600)) FROM mahasiswa JOIN member ON mahasiswa.nim=member.nim JOIN reservasi_ruangan ON member.kode_member=reservasi_ruangan.kode_member WHERE CONVERT(mahasiswa.nama_mahasiswa USING utf8) LIKE '%Citra Yusuf%') ORDER BY SUM(MOD(TIMESTAMPDIFF(minute, reservasi_ruangan.waktu_mulai, reservasi_ruangan.waktu_selesai), 3600)) DESC