/*
    ##### INFORMATION SCRIPT [LICENSE: GPL] #####
    
    Released Date   : January 07, 2020
    Build (Author)  : Sultan Kautsar
                      Arga Bimantara
                      Bagas Alfito Prismawan
                      Wisnu Wardana
    Completion Task : Pemodelan dan Implementasi Basis Data
    Study           : Telkom University
    Script Name     : script.sql
    Description     : Untuk memenuhi tugas besar PIBD dengan membuat DDL dan DML
                      dari skema relasi perusahaan BeyoundUs.
*/

/* DROP TABLE AND CONSTRAINS */
BEGIN
   FOR cur_rec IN (SELECT object_name, object_type
                   FROM user_objects
                   WHERE object_type IN
                             ('TABLE',
                              'VIEW',
                              'MATERIALIZED VIEW',
                              'PACKAGE',
                              'PROCEDURE',
                              'FUNCTION',
                              'SEQUENCE',
                              'SYNONYM',
                              'PACKAGE BODY'
                             ))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE'
         THEN
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE 'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line ('FAILED: DROP '
                                  || cur_rec.object_type
                                  || ' "'
                                  || cur_rec.object_name
                                  || '"'
                                 );
      END;
   END LOOP;
   FOR cur_rec IN (SELECT * 
                   FROM all_synonyms 
                   WHERE table_owner IN (SELECT USER FROM dual))
   LOOP
      BEGIN
         EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM ' || cur_rec.synonym_name;
      END;
   END LOOP;
END;

/* DDL */
/* TABEL HISTORY */
CREATE TABLE history (
    id_history VARCHAR2(10) NOT NULL,
    tanggal_perpindahan DATE,
    history_nama_pegawai VARCHAR2(30),
    history_nama_jabatan VARCHAR2(30)
);

ALTER TABLE history ADD CONSTRAINT history_pk PRIMARY KEY (id_history);

/* TABEL DIVISI */
CREATE TABLE divisi (
    id_divisi VARCHAR2(10) NOT NULL,
    kepala_divisi VARCHAR2(30),
    nama_divisi VARCHAR2(30)
);

ALTER TABLE divisi ADD CONSTRAINT divisi_pk PRIMARY KEY (id_divisi);

/* TABEL JABATAN */
CREATE TABLE jabatan (
    id_jabatan VARCHAR2(10) NOT NULL,
    nama_jabatan VARCHAR2(30)
);

ALTER TABLE jabatan ADD CONSTRAINT jabatan_pk PRIMARY KEY (id_jabatan);

/* TABEL TASK */
CREATE TABLE task (
    id_task VARCHAR2(10) NOT NULL,
    deskripsi_pekerjaan VARCHAR2(500),
    durasi_task NUMBER,
    nilai_progress NUMBER
);

ALTER TABLE task ADD CONSTRAINT task_pk PRIMARY KEY (id_task);

/* TABEL PROYEK KEGIATAN */
CREATE TABLE proyek_kegiatan (
    id_proyek VARCHAR2(10) NOT NULL,
    id_task VARCHAR2(10) NOT NULL,
    nama_proyek VARCHAR2(50),
    deskripsi_proyek VARCHAR2(250),
    durasi_proyek NUMBER,
    tanggal_mulai DATE
);

ALTER TABLE proyek_kegiatan ADD CONSTRAINT proyek_kegiatan_pk PRIMARY KEY (id_proyek);
ALTER TABLE proyek_kegiatan ADD CONSTRAINT proyek_kegiatan_task_fk FOREIGN KEY (id_task) REFERENCES task(id_task);

/* TABEL TASK PROSES */
CREATE TABLE status_task (
    id_task VARCHAR2(10) NOT NULL
);

ALTER TABLE status_task ADD CONSTRAINT status_task_task_fk FOREIGN KEY (id_task) REFERENCES task(id_task);

/* TABEL TASK SELESAI */
CREATE TABLE task_selesai (
    id_task VARCHAR2(10) NOT NULL,
    tanggal_test DATE,
    approval VARCHAR2(50)
);

ALTER TABLE task_selesai ADD CONSTRAINT task_selesai_task_fk FOREIGN KEY (id_task) REFERENCES task(id_task);

/* TABEL TASK BELUM SELESAI */
CREATE TABLE task_belum_selesai (
    id_task VARCHAR2(10) NOT NULL,
    feedback VARCHAR2(250)
);

ALTER TABLE task_belum_selesai ADD CONSTRAINT task_belum_selesai_task_fk FOREIGN KEY (id_task) REFERENCES task(id_task);

/* TABEL PEGAWAI */
CREATE TABLE pegawai (
    nip VARCHAR2(50) NOT NULL,
    id_history VARCHAR2(10) NOT NULL,
    id_divisi VARCHAR2(10) NOT NULL,
    id_jabatan VARCHAR2(10) NOT NULL,
    id_task VARCHAR2(10) NOT NULL,
    nama_pegawai VARCHAR2(30),
    tanggal_lahir DATE,
    tanggal_masuk_perusahaan DATE,
    alamat VARCHAR2(250),
    email VARCHAR2(50),
    gaji NUMBER
);

ALTER TABLE pegawai ADD CONSTRAINT pegawai_pk PRIMARY KEY (nip);
ALTER TABLE pegawai ADD CONSTRAINT pegawai_history_fk FOREIGN KEY (id_history) REFERENCES history(id_history);
ALTER TABLE pegawai ADD CONSTRAINT pegawai_divisi_fk FOREIGN KEY (id_divisi) REFERENCES divisi(id_divisi);
ALTER TABLE pegawai ADD CONSTRAINT pegawai_jabatan_fk FOREIGN KEY (id_jabatan) REFERENCES jabatan(id_jabatan);
ALTER TABLE pegawai ADD CONSTRAINT pegawai_task_fk FOREIGN KEY (id_task) REFERENCES task(id_task);

/* NOMOR PONSEL */
CREATE TABLE nomor_ponsel (
    nip VARCHAR2(50) NOT NULL,
    no_hp NUMBER
);

ALTER TABLE nomor_ponsel ADD CONSTRAINT nomor_ponsel_nip_fk FOREIGN KEY (nip) REFERENCES pegawai(nip);

/* DML */
/* INSERT HISTORY */
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H01', to_date('25-Jun-2019', 'DD-MON-RR'), 'Robby', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H02', to_date('16-Jul-2017', 'DD-MON-RR'), 'Roni', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H03', to_date('12-Mar-2019', 'DD-MON-RR'), 'Budi', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H04', to_date('30-Sep-2020', 'DD-MON-RR'), 'Gani', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H05', to_date('17-Nov-2019', 'DD-MON-RR'), 'Dedy', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H06', to_date('20-Jan-2018', 'DD-MON-RR'), 'Zaki', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H07', to_date('19-Oct-2017', 'DD-MON-RR'), 'Sandi', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H08', to_date('17-Mar-2019', 'DD-MON-RR'), 'Defi', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H09', to_date('6-Dec-2019', 'DD-MON-RR'), 'Tomi', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H10', to_date('13-Mar-2017', 'DD-MON-RR'), 'Fira', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H11', to_date('2-May-2018', 'DD-MON-RR'), 'Anny', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H12', to_date('8-May-2018', 'DD-MON-RR'), 'Doni', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H13', to_date('4-Apr-2018', 'DD-MON-RR'), 'Rani', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H14', to_date('2-May-2017', 'DD-MON-RR'), 'Carel', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H15', to_date('23-Jan-2018', 'DD-MON-RR'), 'Joko', 'Kepala Divisi');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H16', to_date('30-Sep-2016', 'DD-MON-RR'), 'Tomi', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H17', to_date('25-Jun-2016', 'DD-MON-RR'), 'Sandi', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H18', to_date('4-Apr-2014', 'DD-MON-RR'), 'Rani', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H19', to_date('13-Mar-2017', 'DD-MON-RR'), 'Carel', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H20', to_date('16-Jul-2015', 'DD-MON-RR'), 'Joko', 'Manager');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H21', to_date('2-May-2017', 'DD-MON-RR'), 'Doni', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H22', to_date('8-May-2016', 'DD-MON-RR'), 'Robby', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H23', to_date('6-Dec-2016', 'DD-MON-RR'), 'Roni', 'Manager');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H24', to_date('2-May-2015', 'DD-MON-RR'), 'Fira', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H25', to_date('23-Jan-2017', 'DD-MON-RR'), 'Dedy', 'Manager');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H26', to_date('20-Jan-2015', 'DD-MON-RR'), 'Defi', 'Manager');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H27', to_date('19-Oct-2017', 'DD-MON-RR'), 'Gani', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H28', to_date('12-Mar-2015', 'DD-MON-RR'), 'Anny', 'Manager');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H29', to_date('17-Mar-2015', 'DD-MON-RR'), 'Budi', 'Manager');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H30', to_date('17-Nov-2015', 'DD-MON-RR'), 'Zaki', 'Manager');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H31', to_date('4-Nov-2011', 'DD-MON-RR'), 'Defi', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H32', to_date('16-Dec-2012', 'DD-MON-RR'), 'Roni', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H33', to_date('20-Mar-2012', 'DD-MON-RR'), 'Zaki', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H34', to_date('23-Aug-2013', 'DD-MON-RR'), 'Dedy', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H35', to_date('18-Jun-2013', 'DD-MON-RR'), 'Joko', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H36', to_date('7-Apr-2011', 'DD-MON-RR'), 'Budi', 'Pegawai');
INSERT INTO history(id_history, tanggal_perpindahan, history_nama_pegawai, history_nama_jabatan) VALUES('H37', to_date('12-May-2011', 'DD-MON-RR'), 'Anny', 'Pegawai');

/* INSERT DIVISI */
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D01', 'Budi', 'Produksi');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D02', 'Defi', 'Keuangan');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D03', 'Anny', 'Logistik');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D04', 'Zaki', 'Konsumsi');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D05', 'Roni', 'Manajemen Konsumen');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D06', 'Dedy', 'Creative');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D07', 'Joko', 'Pengembangan Bisnis');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D08', 'Sandi', 'Kebersihan');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D09', 'Carel', 'Penjualan');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D10', 'Doni', 'Perencanaan');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D11', 'Tomi', 'Marketing');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D12', 'Robby', 'Umum');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D13', 'Rani', 'IT Specialist');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D14', 'Fira', 'Keamanan');
INSERT INTO divisi(id_divisi, kepala_divisi, nama_divisi) VALUES('D15', 'Gani', 'Personalia');

/* INSERT JABATAN */
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J01', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J02', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J03', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J04', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J05', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J06', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J07', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J08', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J09', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J10', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J11', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J12', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J13', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J14', 'Kepala Divisi');
INSERT INTO jabatan(id_jabatan, nama_jabatan) VALUES('J15', 'Kepala Divisi');

/* INSERT TASK */
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T01', 'Melakukan pengiklanan produk berbayar melalui Facebook', 297, 62);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T02', 'Melakukan implementasi ide terhadap produk yang akan didesain', 444, 44);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T03', 'Memodelkan suatu data untuk kebutuhan konsumen dalam experience terhadap aplikasi', 151, 100);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T04', 'Menguji kelayakan berdasarkan kualitas dan kuantitas yang disesuaikan dengan harga', 447, 77);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T05', 'Penelitian terhadap ceruk atau niche market yang cocok', 346, 75);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T06', 'Pembersihan data customer yang mempunyai data tidak teratur', 219, 100);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T07', 'Pengembangan software untuk aplikasi smartphone', 236, 58);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T08', 'Merangkum material dari hasil kerja penelitian desain produk', 486, 56);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T09', 'Melakukan kuseioner terhadap pengujian UX pada tim uji perusahaan', 380, 88);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T10', 'Melakukan pengimplementasian API untuk pemasangan aplikasi', 557, 71);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T11', 'Kegiatan untuk merancang product yang telah lulus uji', 236, 100);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T12', 'Alat yang digunakan untuk mendukung sebuah pekerjaan', 162, 44);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T13', 'Membagi dan menentukan durasi atau waktu untuk kegiatan tertentu', 325, 96);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T14', 'Menganalisa kebutuhan biaya yang dikeluarkan oleh perusahaan', 584, 100);
INSERT INTO task(id_task, deskripsi_pekerjaan, durasi_task, nilai_progress) VALUES('T15', 'Melakukan printing sebagai acuan final design dalam pembuatan produk', 215, 45);

/* STATUS TASK */
INSERT INTO status_task(id_task) VALUES('T01');
INSERT INTO status_task(id_task) VALUES('T02');
INSERT INTO status_task(id_task) VALUES('T03');
INSERT INTO status_task(id_task) VALUES('T04');
INSERT INTO status_task(id_task) VALUES('T05');
INSERT INTO status_task(id_task) VALUES('T06');
INSERT INTO status_task(id_task) VALUES('T07');
INSERT INTO status_task(id_task) VALUES('T08');
INSERT INTO status_task(id_task) VALUES('T09');
INSERT INTO status_task(id_task) VALUES('T10');
INSERT INTO status_task(id_task) VALUES('T11');
INSERT INTO status_task(id_task) VALUES('T12');
INSERT INTO status_task(id_task) VALUES('T13');
INSERT INTO status_task(id_task) VALUES('T14');
INSERT INTO status_task(id_task) VALUES('T15');

/* TASK SELESAI */
INSERT INTO task_selesai(id_task, tanggal_test, approval) VALUES('T03', '17-May-2018', 'Disetujui');
INSERT INTO task_selesai(id_task, tanggal_test, approval) VALUES('T06', '14-Feb-2018', 'Disetujui');
INSERT INTO task_selesai(id_task, tanggal_test, approval) VALUES('T11', '24-Dec-2017', 'Belum Disetujui');
INSERT INTO task_selesai(id_task, tanggal_test, approval) VALUES('T14', '15-Mar-2019', 'Disetujui');

/* TASK BELUM SELESAI */
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T01', 'Tenggat waktu pengiklanan belum berakhir');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T02', 'Belum teimplementasi seutuhnya dari ide yang ada');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T04', 'Menunggu uji kelayakan tahap IV untuk produk tahun 2020');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T05', 'Kurang penelitian pada hasil uji produk tahap IV');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T07', 'Sedang dalam progress untuk mengembangkan database aplikasi');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T08', 'Terlalu banyak desain dan ide yang sudah ada belum diimplementasikan ke elemen');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T09', 'Kuesioner kurang dari target minimal');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T10', 'Menunggu progress pengembangan software');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T12', 'Kurangnya persediaan alat dan masih dalam pengiriman');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T13', 'Hampir sempurna hanya kurang untuk proyek yang belum update');
INSERT INTO task_belum_selesai(id_task, feedback) VALUES('T15', 'Menunggu progress design dan material design');

/* INSERT PROYEK KEGIATAN */
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P01', 'T01', 'Pengiklanan Facebook Ads', 'Melakukan pengiklanan produk berbayar melalui Facebook', 297, '12-Dec-2019');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P02', 'T02', 'Product Design Thinking', 'Melakukan implementasi ide terhadap produk yang akan didesain', 444, '21-Sep-2017');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P03', 'T03', 'Data Modelling', 'Memodelkan suatu data untuk kebutuhan konsumen dalam experience terhadap aplikasi', 151, '17-May-2018');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P04', 'T04', 'Studi Kelayakan', 'Menguji kelayakan berdasarkan kualitas dan kuantitas yang disesuaikan dengan harga', 447, '19-Jul-2020');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P05', 'T05', 'Studi Pasar', 'Penelitian terhadap ceruk atau niche market yang cocok', 346, '16-Apr-2019');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P06', 'T06', 'Data Wrangle', 'Pembersihan data customer yang mempunyai data tidak teratur', 219, '14-Feb-2018');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P07', 'T07', 'Software Mobile Apps', 'Pengembangan software untuk aplikasi smartphone', 236,'11-Nov-2019');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P08', 'T08', 'Material Component', 'Merangkum material dari hasil kerja penelitian desain produk', 486, '23-Nov-2019');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P09', 'T09', 'UI and UX Researcher', 'Melakukan kuseioner terhadap pengujian UX pada tim uji perusahaan', 380, '13-Jan-2019');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P10', 'T10', 'Instalasi', 'Melakukan pengimplementasian API untuk pemasangan aplikasi', 557, '18-Jun-2020');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P11', 'T11', 'Fabrikasi', 'Kegiatan untuk merancang product yang telah lulus uji', 236, '24-Dec-2017');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P12', 'T12', 'Program Pendukung', 'Alat yang digunakan untuk mendukung sebuah pekerjaan', 162, '20-Aug-2020');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P13', 'T13', 'Management', 'Membagi dan menentukan durasi atau waktu untuk kegiatan tertentu', 325, '22-Oct-2020');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P14', 'T14', 'Analisis Biaya', 'Menganalisa kebutuhan biaya yang dikeluarkan oleh perusahaan', 584, '15-Mar-2019');
INSERT INTO proyek_kegiatan(id_proyek, id_task, nama_proyek, deskripsi_proyek, durasi_proyek, tanggal_mulai) VALUES('P15', 'T15', 'Blueprints Pemrosesan Produk', 'Melakukan printing sebagai acuan final design dalam pembuatan produk', 215, '10-Oct-2018');

/* INSERT PEGAWAI */
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199811232021151002, 'H01', 'D01', 'J01', 'T01', 'Budi', '23-Nov-1998', '17-Aug-2009', 'Jl HR Rasuna Said Kav C-17 Menara Gracia Dki Jakart a','budi@yahoo.co.id', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199306182021152007, 'H02', 'D02', 'J02', 'T02', 'Defi', '18-Jun-1993', '23-Jan-2015', 'Jl KH Zainul Arifin Kompl Ketapang Indah Bl B-1/6 Dki Jakarta', 'defi@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(198902142021152011, 'H03', 'D03', 'J03', 'T03', 'Anny', '14-Feb-1989', '6-Dec-2007', 'Jl Majapahit 31/21 Dki Jakarta', 'annyvin@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(198510102021151015, 'H04', 'D04', 'J04', 'T04', 'Zaki', '10-Oct-1985', '30-Sep-2010', 'Jl Jatiwaringin Raya 9 Dki Jakarta', 'zaki@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(198801132021151012, 'H05', 'D05', 'J05', 'T05', 'Roni', '13-Jan-1988', '25-Jun-2007', 'Jl Pintu Air Raya 58-64 Ged Istana Pasar Baru Dki Jakarta', 'roni98@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199609212021151004, 'H06', 'D06', 'J06', 'T06', 'Dedy', '21-Sep-1996', '20-Jan-2014', 'Jl Medan Merdeka Utr 2 Dki Jakarta', 'deddy_abr@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199104162021151009, 'H07', 'D07', 'J07', 'T07', 'Joko', '16-Apr-1991', '2-May-2011', 'Ged Tifa Arum Dki Jakarta','joko@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(198712122021151013, 'H08', 'D08', 'J08', 'T08', 'Sandi', '12-Dec-1987', '4-Apr-2008', 'Jl Kyai Caringin 2 F-G Dki Jakarta', 'sandi1832@outlook.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199710222021151003, 'H09', 'D09', 'J09', 'T09', 'Carel', '22-Oct-1997', '2-May-2007', 'Jl Pahlawan Revolusi 12 Pondok Bambu Dki Jakarta', 'carel12@yahoo.co.id', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199407192021151006, 'H10', 'D10', 'J10', 'T10', 'Doni', '19-Jul-1994', '17-Nov-2005', 'Jl Pasar Baru Pasar Baru Bl Dki Jakarta','doni@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199508202021151005, 'H11', 'D11', 'J11', 'T11', 'Tomi', '20-Aug-1995', '16-Jul-2012', 'Jl. M. Saidi Kp. Sawah No. 34 B 03/01 Petukangan Selatan Dki Jakarta', 'tomi@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199912242021151001, 'H12', 'D12', 'J12', 'T12', 'Robby', '24-Dec-1999', '12-Mar-2011', 'Jl KH Hasyim Ashari ITC Roxy Mas Lt Dasar/148 Jakarta', 'robi_mz@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199205172021152008, 'H13', 'D13', 'J13', 'T13', 'Rani', '17-May-1992', '19-Oct-2009', 'Kompl Niaga Roxy Mas Bl C-4/17 Dki Jakarta', 'rani15@rocketmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(198611112021152014, 'H14', 'D14', 'J14', 'T14', 'Fira', '11-Nov-1986', '13-Mar-2006', 'Jl Danau Sunter Slt Bl C/15 Dki Jakarta', 'fira923@gmail.com', 25000000);
INSERT INTO pegawai(nip, id_history, id_divisi, id_jabatan, id_task, nama_pegawai, tanggal_lahir, tanggal_masuk_perusahaan, alamat, email, gaji) VALUES(199003152021151010, 'H15', 'D15', 'J15', 'T15', 'Gani', '15-Mar-1990', '8-May-2008', 'Jl Bungur Besar 34 Dki Jakarta', 'ganimeme@outlook.com', 25000000);

/* NOMOR PONSEL */
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199811232021151002, 089755574146);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199306182021152007, 087855538136);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(198902142021152011, 089855547034);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(198510102021151015, 087855566387);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(198801132021151012, 083855528812);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199609212021151004, 083855527639);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199104162021151009, 085655515867);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(198712122021151013, 083855543212);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199710222021151003, 087855556645);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199407192021151006, 081755556865);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199508202021151005, 087855540091);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199912242021151001, 083855516338);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199205172021152008, 085455549957);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(198611112021152014, 083855537192);
INSERT INTO nomor_ponsel(nip, no_hp) VALUES(199003152021151010, 089955528234);
