USE streaming_musical;

-- ====================================================
-- LIMPIAR TABLAS (opcional si ya tienes el esquema)
-- ====================================================
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE activity;
TRUNCATE TABLE playlist_songs;
TRUNCATE TABLE playlists;
TRUNCATE TABLE users;
TRUNCATE TABLE songs;
TRUNCATE TABLE albums;
TRUNCATE TABLE artists;
SET FOREIGN_KEY_CHECKS = 1;

-- ====================================================
-- 1) ARTISTS (15)
-- ====================================================
INSERT INTO artists (name, country, primary_genre) VALUES
('Taylor Swift','Estados Unidos','Pop'),
('Bad Bunny','Puerto Rico','Reguetón'),
('Adele','Reino Unido','Pop'),
('Ed Sheeran','Reino Unido','Pop'),
('Shakira','Colombia','Pop Latino'),
('Drake','Canadá','Hip-Hop'),
('Beyoncé','Estados Unidos','R&B'),
('Coldplay','Reino Unido','Rock'),
('Billie Eilish','Estados Unidos','Pop'),
('The Weeknd','Canadá','R&B'),
('Dua Lipa','Reino Unido','Pop'),
('Karol G','Colombia','Reguetón'),
('J Balvin','Colombia','Reguetón'),
('Imagine Dragons','Estados Unidos','Rock'),
('Rosalía','España','Pop');

-- ====================================================
-- 2) ALBUMS (20)
-- ====================================================
INSERT INTO albums (artist_id, title, release_date) VALUES
(1,'Midnights','2022-10-21'),
(1,'1989 (Taylor''s Version)','2023-10-27'),
(2,'Un Verano Sin Ti','2022-05-06'),
(3,'30','2021-11-19'),
(4,'=','2021-10-29'),
(5,'El Dorado','2017-05-26'),
(6,'Scorpion','2018-06-29'),
(7,'Renaissance','2022-07-29'),
(8,'A Head Full of Dreams','2015-12-04'),
(9,'Happier Than Ever','2021-07-30'),
(10,'After Hours','2020-03-20'),
(11,'Future Nostalgia','2020-03-27'),
(12,'Mañana Será Bonito','2023-02-24'),
(13,'Colores','2020-03-19'),
(14,'Evolve','2017-06-23'),
(15,'Motomami','2022-03-18');

-- ====================================================
-- 3) SONGS (25)
-- ====================================================
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES
(1,'Anti-Hero',200,'Pop',95),
(1,'Bejeweled',210,'Pop',85),
(2,'Style',231,'Pop',90),
(3,'Tití Me Preguntó',235,'Reguetón',98),
(3,'Me Porto Bonito',240,'Reguetón',96),
(4,'Easy On Me',224,'Pop',97),
(5,'Shivers',207,'Pop',90),
(6,'Chantaje',196,'Pop Latino',92),
(7,'God''s Plan',220,'Hip-Hop',94),
(7,'In My Feelings',210,'Hip-Hop',91),
(8,'CUFF IT',217,'R&B',89),
(9,'Adventure of a Lifetime',250,'Rock',87),
(10,'Happier Than Ever',298,'Pop',95),
(11,'Blinding Lights',200,'R&B',99),
(12,'Levitating',203,'Pop',96),
(13,'Provenza',210,'Reguetón',94),
(14,'Rojo',220,'Reguetón',90),
(15,'Believer',204,'Rock',93),
(15,'Thunder',187,'Rock',88),
(16,'Despechá',180,'Pop',91),
(16,'La Fama',215,'Pop',89),
(16,'Candy',190,'Pop',88),
(5,'Try Everything',210,'Pop Latino',85),
(8,'Yellow',270,'Rock',97),
(8,'Fix You',260,'Rock',96);

-- ====================================================
-- 4) USERS (15)
-- ====================================================
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES
('Laura García','laura.garcia@email.com','España','Individual',9.99,'2025-12-31'),
('Carlos Pérez','carlos.perez@email.com','México','Familiar',14.99,'2024-11-15'),
('Ana Torres','ana.torres@email.com','Colombia','Estudiante',4.99,'2025-07-01'),
('John Smith','john.smith@email.com','Estados Unidos','Free',0.00,'2025-03-01'),
('Emily Johnson','emily.johnson@email.com','Reino Unido','Individual',9.99,'2026-01-15'),
('Pedro Sánchez','pedro.sanchez@email.com','España','Familiar',14.99,'2026-05-01'),
('María López','maria.lopez@email.com','México','Estudiante',4.99,'2025-09-15'),
('James Brown','james.brown@email.com','Estados Unidos','Individual',9.99,'2024-12-31'),
('Lucía Fernández','lucia.fernandez@email.com','España','Free',0.00,'2025-02-10'),
('Sofía Martínez','sofia.martinez@email.com','Colombia','Individual',9.99,'2025-11-20'),
('Miguel Ángel','miguel.angel@email.com','España','Familiar',14.99,'2024-08-01'),
('Emma Watson','emma.watson@email.com','Reino Unido','Individual',9.99,'2026-03-15'),
('Oliver Queen','oliver.queen@email.com','Estados Unidos','Individual',9.99,'2025-06-30'),
('Camila Cabello','camila.cabello@email.com','Estados Unidos','Free',0.00,'2025-09-01'),
('Jorge Ramos','jorge.ramos@email.com','México','Estudiante',4.99,'2024-10-01');

-- ====================================================
-- 5) PLAYLISTS (20)
-- ====================================================
INSERT INTO playlists (user_id, name, created_at) VALUES
(1,'Pop Hits','2025-01-10 12:00:00'),
(2,'Reggaeton Party','2025-02-05 15:30:00'),
(3,'Study Focus','2025-02-20 09:00:00'),
(4,'Morning Drive','2025-03-01 07:30:00'),
(5,'Workout Beats','2025-03-02 18:00:00'),
(6,'Family Vibes','2025-03-03 20:15:00'),
(7,'Relax Latino','2025-03-04 22:00:00'),
(8,'Rock Legends','2025-03-05 21:00:00'),
(9,'Chill Pop','2025-03-06 19:00:00'),
(10,'Hits Colombia','2025-03-07 16:00:00'),
(11,'Top España','2025-03-08 10:00:00'),
(12,'Morning Energy','2025-03-09 08:00:00'),
(13,'Driving Rock','2025-03-09 19:00:00'),
(14,'Fiesta Latina','2025-03-10 22:00:00'),
(15,'New Discoveries','2025-03-11 14:00:00'),
(1,'Chill Acoustic','2025-03-12 09:00:00'),
(3,'Love Songs','2025-03-12 21:00:00'),
(5,'Gym Motivation','2025-03-13 07:30:00'),
(8,'Epic Rock','2025-03-13 20:00:00'),
(12,'Morning Coffee','2025-03-14 08:15:00');

-- ====================================================
-- 6) PLAYLIST_SONGS (40)
-- ====================================================
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES
(1,1,'2025-01-11 10:00:00'),
(1,2,'2025-01-12 11:30:00'),
(1,3,'2025-01-12 11:35:00'),
(2,4,'2025-02-06 16:00:00'),
(2,5,'2025-02-06 16:05:00'),
(2,13,'2025-02-06 16:10:00'),
(3,6,'2025-02-21 10:00:00'),
(3,7,'2025-02-21 10:05:00'),
(4,8,'2025-03-01 08:00:00'),
(4,9,'2025-03-01 08:10:00'),
(5,10,'2025-03-02 18:10:00'),
(5,11,'2025-03-02 18:15:00'),
(6,12,'2025-03-03 20:20:00'),
(6,13,'2025-03-03 20:25:00'),
(7,14,'2025-03-04 22:05:00'),
(7,15,'2025-03-04 22:10:00'),
(8,16,'2025-03-05 21:05:00'),
(8,17,'2025-03-05 21:10:00'),
(9,18,'2025-03-06 19:05:00'),
(9,19,'2025-03-06 19:10:00'),
(10,20,'2025-03-07 16:05:00'),
(10,21,'2025-03-07 16:10:00'),
(11,22,'2025-03-08 10:05:00'),
(11,23,'2025-03-08 10:10:00'),
(12,24,'2025-03-09 08:05:00'),
(12,25,'2025-03-09 08:10:00'),
(13,1,'2025-03-09 19:05:00'),
(13,4,'2025-03-09 19:10:00'),
(14,5,'2025-03-10 22:05:00'),
(14,13,'2025-03-10 22:10:00'),
(15,6,'2025-03-11 14:05:00'),
(15,7,'2025-03-11 14:10:00'),
(16,8,'2025-03-12 09:05:00'),
(16,9,'2025-03-12 09:10:00'),
(17,10,'2025-03-12 21:05:00'),
(17,11,'2025-03-12 21:10:00'),
(18,12,'2025-03-13 07:35:00'),
(18,13,'2025-03-13 07:40:00'),
(19,14,'2025-03-13 20:05:00'),
(19,15,'2025-03-13 20:10:00');

-- ====================================================
-- 7) ACTIVITY (50 eventos: plays y likes)
-- ====================================================
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES
(1,1,'PLAY','2025-03-01 09:00:00',200),
(1,1,'LIKE','2025-03-01 09:05:00',NULL),
(1,2,'PLAY','2025-03-02 12:00:00',210),
(2,4,'PLAY','2025-03-03 18:30:00',235),
(2,4,'LIKE','2025-03-03 18:35:00',NULL),
(2,5,'PLAY','2025-03-04 19:00:00',240),
(3,6,'PLAY','2025-03-05 20:15:00',224),
(3,6,'LIKE','2025-03-05 20:20:00',NULL),
(3,7,'PLAY','2025-03-05 21:15:00',207),
(4,8,'PLAY','2025-03-06 08:45:00',207),
(4,9,'PLAY','2025-03-06 08:50:00',210),
(5,10,'PLAY','2025-03-07 22:00:00',196),
(5,10,'LIKE','2025-03-07 22:05:00',NULL),
(6,11,'PLAY','2025-03-08 09:00:00',200),
(6,12,'PLAY','2025-03-08 09:10:00',203),
(7,13,'PLAY','2025-03-09 20:00:00',210),
(7,13,'LIKE','2025-03-09 20:05:00',NULL),
(8,14,'PLAY','2025-03-10 07:30:00',220),
(8,14,'LIKE','2025-03-10 07:35:00',NULL),
(9,15,'PLAY','2025-03-11 13:00:00',204),
(9,15,'PLAY','2025-03-11 13:05:00',204),
(10,16,'PLAY','2025-03-12 15:00:00',180),
(11,17,'PLAY','2025-03-13 19:00:00',215),
(11,17,'LIKE','2025-03-13 19:05:00',NULL),
(12,18,'PLAY','2025-03-14 11:00:00',190),
(12,18,'LIKE','2025-03-14 11:05:00',NULL),
(13,19,'PLAY','2025-03-15 14:30:00',210),
(13,19,'LIKE','2025-03-15 14:35:00',NULL),
(14,20,'PLAY','2025-03-16 16:00:00',215),
(14,20,'PLAY','2025-03-16 16:05:00',215),
(15,21,'PLAY','2025-03-17 20:00:00',190),
(1,22,'PLAY','2025-03-18 08:00:00',210),
(2,23,'PLAY','2025-03-19 09:00:00',260),
(3,24,'PLAY','2025-03-20 12:00:00',250),
(4,25,'PLAY','2025-03-21 13:00:00',250),
(5,1,'PLAY','2025-03-22 14:00:00',200),
(6,2,'PLAY','2025-03-23 15:00:00',210),
(7,3,'PLAY','2025-03-24 16:00:00',231),
(8,4,'PLAY','2025-03-25 17:00:00',235),
(9,5,'PLAY','2025-03-26 18:00:00',240),
(10,6,'PLAY','2025-03-27 19:00:00',224),
(11,7,'PLAY','2025-03-28 20:00:00',207),
(12,8,'PLAY','2025-03-29 21:00:00',196),
(13,9,'PLAY','2025-03-30 22:00:00',207),
(14,10,'PLAY','2025-03-31 23:00:00',196),
(15,11,'PLAY','2025-04-01 09:00:00',200),
(1,12,'PLAY','2025-04-02 10:00:00',203),
(2,13,'PLAY','2025-04-03 11:00:00',210),
(3,14,'PLAY','2025-04-04 12:00:00',220);

