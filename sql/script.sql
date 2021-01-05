/* DDL TABEL PERUSAHAAN BEYOUNDUS */

/* TABEL PEGAWAI */
CREATE TABLE pegawai (
    nip VARCHAR2(50) NOT NULL,
    nama VARCHAR2(30),
    tanggal_lahir DATE,
    tanggal_masuk_perusahaan DATE,
    alamat VARCHAR2(250),
    email VARCHAR2(50),
    nomor_ponsel NUMBER
);

ALTER TABLE pegawai ADD CONSTRAINT pegawai_pk PRIMARY KEY (nip);

/* TABEL DIVISI */
CREATE TABLE divisi (
    id_divisi VARCHAR2(10) NOT NULL,
    nama_divisi VARCHAR2(30)
);

ALTER TABLE divisi ADD CONSTRAINT divisi_pk PRIMARY KEY (id_divisi);

/* TABEL JABATAN */
CREATE TABLE jabatan (
    id_jabatan VARCHAR2(10) NOT NULL,
    nip VARCHAR(50) NOT NULL,
    id_divisi VARCHAR2(10) NOT NULL,
    nama_jabatan VARCHAR2(30),
    gaji NUMBER
);

ALTER TABLE jabatan ADD CONSTRAINT jabatan_pk PRIMARY KEY (id_jabatan);
ALTER TABLE jabatan ADD CONSTRAINT jabatan_nip_fk FOREIGN KEY (nip) REFERENCES pegawai(nip);
ALTER TABLE jabatan ADD CONSTRAINT jabatan_divisi_fk FOREIGN KEY (id_divisi) REFERENCES divisi(id_divisi);

/* TABEL HISTORY */
CREATE TABLE history (
    nip VARCHAR2(50) NOT NULL,
    id_jabatan VARCHAR2(10) NOT NULL,
    id_divisi VARCHAR2(10) NOT NULL,
    tanggal_perpindahan DATE,
    jabatan VARCHAR2(30)
);

ALTER TABLE history ADD CONSTRAINT history_pegawai_fk FOREIGN KEY (nip) REFERENCES pegawai(nip);
ALTER TABLE history ADD CONSTRAINT history_jabatan_fk FOREIGN KEY (id_jabatan) REFERENCES jabatan(id_jabatan);
ALTER TABLE history ADD CONSTRAINT history_divisi_fk FOREIGN KEY (id_divisi) REFERENCES divisi(id_divisi);

/* TABEL AKTIVITAS PEGAWAI */
CREATE TABLE aktivitas_pegawai (
    id_aktivitas VARCHAR2(10) NOT NULL,
    nip VARCHAR(50) NOT NULL,
    nama_aktivitas VARCHAR2(100),
    tanggal_pengerjaan DATE,
    durasi NUMBER
);

ALTER TABLE aktivitas_pegawai ADD CONSTRAINT aktivitas_pegawai_pk PRIMARY KEY (id_aktivitas);
ALTER TABLE aktivitas_pegawai ADD CONSTRAINT aktivitas_pegawai_nip_fk FOREIGN KEY (nip) REFERENCES pegawai(nip);

/* TABEL PROYEK KEGIATAN */
CREATE TABLE proyek_kegiatan (
    id_proyek VARCHAR2(10) NOT NULL,
    nip VARCHAR(50) NOT NULL,
    nama VARCHAR2(50),
    deskripsi VARCHAR2(250),
    durasi NUMBER,
    tanggal_mulai DATE
);

ALTER TABLE proyek_kegiatan ADD CONSTRAINT proyek_kegiatan_pk PRIMARY KEY (id_proyek);
ALTER TABLE proyek_kegiatan ADD CONSTRAINT proyek_kegiatan_nip_fk FOREIGN KEY (nip) REFERENCES pegawai(nip);

/* TABEL TASK */
CREATE TABLE task (
    id_task VARCHAR2(10) NOT NULL,
    id_proyek VARCHAR2(10) NOT NULL,
    deskripsi_pekerjaan VARCHAR2(500),
    durasi_waktu NUMBER,
    tanggal_test DATE,
    nilai_progress NUMBER,
    status_task VARCHAR2(20),
    feedback_approval VARCHAR2(250)
);

ALTER TABLE task ADD CONSTRAINT task_pk PRIMARY KEY (id_task);
ALTER TABLE task ADD CONSTRAINT task_proyek_fk FOREIGN KEY (id_proyek) REFERENCES proyek_kegiatan(id_proyek);


/* DML INSERT PERUSAHAAN BEYOUNDUS */

/*PEGAWAI */
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199811232021151002, 'Budi', '23-Nov-1998', '17-Aug-2009', 'Jl HR Rasuna Said Kav C-17 Menara Gracia Dki Jakarta', 'budi@yahoo.co.id', 62897555741);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199306182021152007, 'Defi', '18-Jun-1993', '23-Jan-2015', 'Jl KH Zainul Arifin Kompl Ketapang Indah Bl B-1/6 Dki Jakarta', 'defi@gmail.com', 62878555381);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(198902142021152011, 'Anny', '14-Feb-1989', '6-Dec-2007', 'Jl Majapahit 31/21 Dki Jakarta', 'annyvin@gmail.com', 62898555470);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(198510102021151015, 'Zaki', '10-Oct-1985', '30-Sep-2010', 'Jl Jatiwaringin Raya 9 Dki Jakarta', 'zaki@gmail.com', 62878555663);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(198801132021151012, 'Roni', '13-Jan-1988', '25-Jun-2007', 'Jl Pintu Air Raya 58-64 Ged Istana Pasar Baru Dki Jakarta', 'roni98@gmail.com', 62838555288);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199609212021151004, 'Dedy', '21-Sep-1996', '20-Jan-2014', 'Jl Medan Merdeka Utr 2 Dki Jakarta', 'deddy_abr@gmail.com', 62838555276);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199104162021151009, 'Joko', '16-Apr-1991', '2-May-2011', 'Ged Tifa Arum Dki Jakarta', 'joko@gmail.com', 62856555158);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(198712122021151013, 'Sandi', '12-Dec-1987', '4-Apr-2008', 'Jl Kyai Caringin 2 F-G Dki Jakarta', 'sandi1832@outlook.com', 62838555432);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199710222021151003, 'Carel', '22-Oct-1997', '2-May-2007', 'Jl Pahlawan Revolusi 12 Pondok Bambu Dki Jakarta', 'carel12@yahoo.co.id', 62878555566);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199407192021151006, 'Doni', '19-Jul-1994', '17-Nov-2005', 'Jl Pasar Baru Pasar Baru Bl Dki Jakarta', 'doni@gmail.com', 62817555568);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199508202021151005, 'Tomi', '20-Aug-1995', '16-Jul-2012', 'Jl. M. Saidi Kp. Sawah No. 34 B 03/01 Petukangan Selatan Dki Jakarta', 'tomi@gmail.com', 62878555400);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199912242021151001, 'Robby', '24-Dec-1999', '12-Mar-2011', 'Jl KH Hasyim Ashari ITC Roxy Mas Lt Dasar/148 Jakarta', 'robi_mz@gmail.com', 62838555163);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199205172021152008, 'Rani', '17-May-1992', '19-Oct-2009', 'Kompl Niaga Roxy Mas Bl C-4/17 Dki Jakarta', 'rani15@rocketmail.com', 62854555499);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(198611112021152014, 'Fira', '11-Nov-1986', '13-Mar-2006', 'Jl Danau Sunter Slt Bl C/15 Dki Jakarta', 'fira923@gmail.com', 62838555372);
INSERT INTO pegawai(nip, nama, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, nomor_ponsel)
VALUES(199003152021151010, 'Gani', '15-Mar-1990', '8-May-2008', 'Jl Bungur Besar 34 Dki Jakarta', 'ganimeme@outlook.com', 62899555220);

/* DIVISI */
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D01', 'Kebersihan');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D02', 'Produksi');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D03', 'Marketing');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D04', 'Keamanan');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D05', 'IT Specialist');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D06', 'Penjualan');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D07', 'Keuangan');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D08', 'Logistik');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D09', 'Creative');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D10', 'Konsumsi');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D11', 'Perencanaan');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D12', 'Umum');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D13', 'Personalia');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D14', 'Manajemen Konsumen');
INSERT INTO divisi(id_divisi, nama_divisi)
VALUES('D15', 'Pengembangan Bisnis');

/* JABATAN */
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J01', 199811232021151002, 'D01', 'Kepala Divisi', 24000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J02', 199306182021152007, 'D02', 'Wakil Divisi', 19700000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J03', 198902142021152011, 'D03', 'Pegawai', 7000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J04', 198510102021151015, 'D04', 'Manager', 15000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J05', 198801132021151012, 'D05', 'Pegawai', 7000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J06', 199609212021151004, 'D06', 'Pegawai', 7000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J07', 199104162021151009, 'D07', 'Pegawai', 7000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J08', 198712122021151013, 'D08', 'Manager', 15000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J09', 199710222021151003, 'D09', 'Pegawai', 7000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J10', 199407192021151006, 'D10', 'Pegawai', 7000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J11', 199508202021151005, 'D11', 'Pegawai', 7000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J12', 199912242021151001, 'D12', 'Pegawai', 7000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J13', 199205172021152008, 'D13', 'Manajer', 15000000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J14', 198611112021152014, 'D14', 'Sekertaris', 9500000);
INSERT INTO jabatan(id_jabatan, nip, id_divisi, nama_jabatan, gaji)
VALUES('J15', 199003152021151010, 'D15', 'Manajer', 15000000);

/* HISTORY */
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199811232021151002, 'J01', 'D01', '12-Mar-2019', 'Kepala Divisi');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199306182021152007, 'J02', 'D02', '17-Mar-2019', 'Wakil Divisi');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198902142021152011, 'J03', 'D03', '2-May-2018', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198510102021151015, 'J04', 'D04', '20-Jan-2018', 'Manager');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198801132021151012, 'J05', 'D05', '16-Jul-2017', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199609212021151004, 'J06', 'D06', '17-Nov-2019', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199104162021151009, 'J07', 'D07', '23-Jan-2018', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198712122021151013, 'J08', 'D08', '19-Oct-2017', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199710222021151003, 'J09', 'D09', '2-May-2017', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199407192021151006, 'J10', 'D10', '8-May-2018', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199508202021151005, 'J11', 'D11', '6-Dec-2019', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199912242021151001, 'J12', 'D12', '25-Jun-2019', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199205172021152008, 'J13', 'D13', '4-Apr-2018', 'Manajer');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198611112021152014, 'J14', 'D14', '13-Mar-2017', 'Sekertaris');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199003152021151010, 'J15', 'D15', '30-Sep-2020', 'Manajer');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199205172021152008, 'J13', 'D13', '17-Mar-2015', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199609212021151004, 'J06', 'D06', '20-Jan-2015', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199003152021151010, 'J15', 'D15', '12-Mar-2015', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198510102021151015, 'J04', 'D04', '17-Nov-2015', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199710222021151003, 'J09', 'D09', '6-Dec-2016', 'Manajer');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199104162021151009, 'J07', 'D07', '23-Jan-2017', 'Sekertaris');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199407192021151006, 'J10', 'D10', '16-Jul-2015', 'Manajer');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199811232021151002, 'J01', 'D01', '25-Jun-2016', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198611112021152014, 'J14', 'D14', '13-Mar-2017', 'Kepala Divisi');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199306182021152007, 'J02', 'D02', '2-May-2017', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199912242021151001, 'J12', 'D12', '30-Sep-2016', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198712122021151013, 'J08', 'D08', '8-May-2016', 'Pegawai');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198902142021152011, 'J03', 'D03', '4-Apr-2014', 'Manager');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(198801132021151012, 'J05', 'D05', '2-May-2015', 'Wakil Divisi');
INSERT INTO history(nip, id_jabatan, id_divisi, tanggal_perpindahan, jabatan)
VALUES(199508202021151005, 'J11', 'D11', '19-Oct-2017', 'Pegawai');

/* PROYEK KEGIATAN */
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P01', 199811232021151002, 'Pengiklanan Facebook Ads', 'Melakukan pengiklanan produk berbayar melalui Facebook', 297, '12-Dec-2019');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P02', 199306182021152007, 'Product Design Thinking', 'Melakukan implementasi ide terhadap produk yang akan didesain', 444, '21-Sep-2017');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P03', 198902142021152011, 'Data Modelling', 'Memodelkan suatu data untuk kebutuhan konsumen dalam experience terhadap aplikasi', 151, '17-May-2018');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P04', 198510102021151015, 'Studi Kelayakan', 'Menguji kelayakan berdasarkan kualitas dan kuantitas yang disesuaikan dengan harga', 447, '19-Jul-2020');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P05', 198801132021151012, 'Studi Pasar', 'Penelitian terhadap ceruk atau niche market yang cocok', 346, '16-Apr-2019');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P06', 199609212021151004, 'Data Wrangle', 'Pembersihan data customer yang mempunyai data tidak teratur', 219, '14-Feb-2018');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P07', 199104162021151009, 'Software Mobile Apps', 'Pengembangan software untuk aplikasi smartphone', 236, '11-Nov-2019');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P08', 198712122021151013, 'Material Component', 'Merangkum material dari hasil kerja penelitian desain produk', 486, '23-Nov-2019');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P09', 199710222021151003, 'UI and UX Researcher', 'Melakukan kuseioner terhadap pengujian UX pada tim uji perusahaan', 380, '13-Jan-2019');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P10', 199407192021151006, 'Instalasi', 'Melakukan pengimplementasian API untuk pemasangan aplikasi', 557, '18-Jun-2020');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P11', 199508202021151005, 'Fabrikasi', 'Kegiatan untuk merancang product yang telah lulus uji', 236, '24-Dec-2017');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P12', 199912242021151001, 'Program Pendukung', 'Alat yang digunakan untuk mendukung sebuah pekerjaan', 162, '20-Aug-2020');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P13', 199205172021152008, 'Management', 'Membagi dan menentukan durasi atau waktu untuk kegiatan tertentu', 325, '22-Oct-2020');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P14', 198611112021152014, 'Analisis Biaya', 'Menganalisa kebutuhan biaya yang dikeluarkan oleh perusahaan', 584, '15-Mar-2019');
INSERT INTO proyek_kegiatan(id_proyek, nip, nama, deskripsi, durasi, tanggal_mulai)
VALUES('P15', 199003152021151010, 'Blueprints Pemrosesan Produk', 'Melakukan printing sebagai acuan final design dalam pembuatan produk', 215, '10-Oct-2018');

/* TASK */
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T01', 'P01', 'Melakukan pengiklanan produk berbayar melalui Facebook', 297, '12-Dec-2019', 62, 'Belum Selesai', 'Tenggat waktu pengiklanan belum berakhir');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T02', 'P02', 'Melakukan implementasi ide terhadap produk yang akan didesain', 444, '21-Sep-2017', 44, 'Belum Selesai', 'Belum teimplementasi seutuhnya dari ide yang ada');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T03', 'P03', 'Memodelkan suatu data untuk kebutuhan konsumen dalam experience terhadap aplikasi', 151, '17-May-2018', 100, 'Selesai', 'Telah disetujui');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T04', 'P04', 'Menguji kelayakan berdasarkan kualitas dan kuantitas yang disesuaikan dengan harga', 447, '19-Jul-2020', 77, 'Belum Selesai', 'Menunggu uji kelayakan tahap IV untuk produk tahun 2020');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T05', 'P05', 'Penelitian terhadap ceruk atau niche market yang cocok', 346, '16-Apr-2019', 75, 'Belum Selesai', 'Kurang penelitian pada hasil uji produk tahap IV');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T06', 'P06', 'Pembersihan data customer yang mempunyai data tidak teratur', 219, '14-Feb-2018', 100, 'Selesai', 'Telah disetujui');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T07', 'P07', 'Pengembangan software untuk aplikasi smartphone', 236, '11-Nov-2019', 58, 'Belum Selesai', 'Sedang dalam progress untuk mengembangkan database aplikasi');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T08', 'P08', 'Merangkum material dari hasil kerja penelitian desain produk', 486, '23-Nov-2019', 56, 'Belum Selesai', 'Terlalu banyak desain dan ide yang sudah ada belum diimplementasikan ke elemen');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T09', 'P09', 'Melakukan kuseioner terhadap pengujian UX pada tim uji perusahaan', 380, '13-Jan-2019', 88, 'Belum Selesai', 'Kuesioner kurang dari target minimal');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T10', 'P10', 'Melakukan pengimplementasian API untuk pemasangan aplikasi', 557, '18-Jun-2020', 71, 'Belum Selesai', 'Menunggu progress pengembangan software');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T11', 'P11', 'Kegiatan untuk merancang product yang telah lulus uji', 236, '24-Dec-2017', 100, 'Selesai', 'Belum disetujui');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T12', 'P12', 'Alat yang digunakan untuk mendukung sebuah pekerjaan', 162, '20-Aug-2020', 44, 'Belum Selesai', 'Kurangnya persediaan alat dan masih dalam pengiriman');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T13', 'P13', 'Membagi dan menentukan durasi atau waktu untuk kegiatan tertentu', 325, '22-Oct-2020', 96, 'Belum Selesai', 'Hampir sempurna hanya kurang untuk proyek yang belum update');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T14', 'P14', 'Menganalisa kebutuhan biaya yang dikeluarkan oleh perusahaan', 584, '15-Mar-2019', 100, 'Selesai', 'Telah disetujui');
INSERT INTO task(id_task, id_proyek, deskripsi_pekerjaan, durasi_waktu, tanggal_test, nilai_progress, status_task, feedback_approval)
VALUES('T15', 'P15', 'Melakukan printing sebagai acuan final design dalam pembuatan produk', 215, '10-Oct-2018', 45, 'Belum Selesai', 'Menunggu progress design dan material design');

/* Update task yang berstatus Belum Selesai - tanpa tanggal test */
UPDATE task SET tanggal_test = NULL WHERE status_task = 'Belum Selesai';


/* AKTIVITAS PEGAWAI */
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A01', 199811232021151002, 'Melakukan pengiklanan produk berbayar melalui Facebook', '12-Dec-2019', 297);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A02', 199306182021152007, 'Melakukan implementasi ide terhadap produk yang akan didesain', '21-Sep-2017', 444);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A03', 198902142021152011, 'Memodelkan suatu data untuk kebutuhan konsumen dalam experience terhadap aplikasi', '17-May-2018', 151);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A04', 198510102021151015, 'Menguji kelayakan berdasarkan kualitas dan kuantitas yang disesuaikan dengan harga', '19-Jul-2020', 447);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A05', 198801132021151012, 'Penelitian terhadap ceruk atau niche market yang cocok', '16-Apr-2019', 346);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A06', 199609212021151004, 'Pembersihan data customer yang mempunyai data tidak teratur', '14-Feb-2018', 219);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A07', 199104162021151009, 'Pengembangan software untuk aplikasi smartphone', '11-Nov-2019', 236);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A08', 198712122021151013, 'Merangkum material dari hasil kerja penelitian desain produk', '23-Nov-2019', 486);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A09', 199710222021151003, 'Melakukan kuseioner terhadap pengujian UX pada tim uji perusahaan', '13-Jan-2019', 380);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A10', 199407192021151006, 'Melakukan pengimplementasian API untuk pemasangan aplikasi', '18-Jun-2020', 557);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A11', 199508202021151005, 'Kegiatan untuk merancang product yang telah lulus uji', '24-Dec-2017', 236);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A12', 199912242021151001, 'Alat yang digunakan untuk mendukung sebuah pekerjaan', '20-Aug-2020', 162);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A13', 199205172021152008, 'Membagi dan menentukan durasi atau waktu untuk kegiatan tertentu', '22-Oct-2020', 325);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A14', 198611112021152014, 'Menganalisa kebutuhan biaya yang dikeluarkan oleh perusahaan', '15-Mar-2019', 584);
INSERT INTO aktivitas_pegawai(id_aktivitas, nip, nama_aktivitas, tanggal_pengerjaan, durasi)
VALUES('A15', 199003152021151010, 'Melakukan printing sebagai acuan final design dalam pembuatan produk', '10-Oct-2018', 215);
