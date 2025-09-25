DROP DATABASE IF EXISTS streaming_musical;
CREATE DATABASE streaming_musical CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE streaming_musical;

CREATE TABLE artists (
  artist_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  country VARCHAR(50),
  primary_genre VARCHAR(50)
);

CREATE TABLE albums (
  album_id INT AUTO_INCREMENT PRIMARY KEY,
  artist_id INT NOT NULL,
  title VARCHAR(150) NOT NULL,
  release_date DATE,
  CONSTRAINT fk_albums_artist FOREIGN KEY (artist_id) REFERENCES artists(artist_id)
);

CREATE TABLE songs (
  song_id INT AUTO_INCREMENT PRIMARY KEY,
  album_id INT NOT NULL,
  title VARCHAR(150) NOT NULL,
  duration_sec INT NOT NULL,
  genre VARCHAR(50),
  popularity INT DEFAULT 0,
  CONSTRAINT fk_songs_album FOREIGN KEY (album_id) REFERENCES albums(album_id)
);

CREATE TABLE users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  country VARCHAR(50),
  plan_name VARCHAR(50),
  plan_price DECIMAL(6,2),
  subscription_end_date DATE
);

CREATE TABLE playlists (
  playlist_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  name VARCHAR(150) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  CONSTRAINT fk_playlists_user FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE playlist_songs (
  playlist_id INT NOT NULL,
  song_id INT NOT NULL,
  added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (playlist_id, song_id),
  CONSTRAINT fk_ps_playlist FOREIGN KEY (playlist_id) REFERENCES playlists(playlist_id),
  CONSTRAINT fk_ps_song FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

CREATE TABLE activity (
  activity_id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  song_id INT NOT NULL,
  activity_type ENUM('PLAY','LIKE') NOT NULL,
  event_time DATETIME NOT NULL,
  seconds_played INT,
  CONSTRAINT fk_activity_user FOREIGN KEY (user_id) REFERENCES users(user_id),
  CONSTRAINT fk_activity_song FOREIGN KEY (song_id) REFERENCES songs(song_id)
);

-- ------------------------
-- Insercion de datos
-- ------------------------
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 1','Reino Unido','Rock');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 2','España','Clásica');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 3','México','Jazz');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 4','México','Rock');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 5','Reino Unido','Country');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 6','España','R&B');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 7','Colombia','Pop');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 8','España','Rock');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 9','México','Jazz');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 10','Estados Unidos','R&B');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 11','España','Country');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 12','México','Country');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 13','Colombia','Jazz');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 14','Colombia','R&B');
INSERT INTO artists (name, country, primary_genre) VALUES ('Artista 15','Argentina','Pop');
INSERT INTO albums (artist_id, title, release_date) VALUES (1,'Album 1','2010-01-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (2,'Album 2','2011-02-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (3,'Album 3','2012-03-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (4,'Album 4','2013-04-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (5,'Album 5','2014-05-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (6,'Album 6','2015-06-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (7,'Album 7','2016-07-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (8,'Album 8','2017-08-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (9,'Album 9','2018-09-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (10,'Album 10','2019-10-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (11,'Album 11','2020-11-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (12,'Album 12','2021-12-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (13,'Album 13','2022-01-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (14,'Album 14','2023-02-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (15,'Album 15','2024-03-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (1,'Album 16','2010-04-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (2,'Album 17','2011-05-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (3,'Album 18','2012-06-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (4,'Album 19','2013-07-15');
INSERT INTO albums (artist_id, title, release_date) VALUES (5,'Album 20','2014-08-15');
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (1,'Cancion 1',150,'Hip-Hop',89);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (2,'Cancion 2',157,'Reguetón',43);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (3,'Cancion 3',164,'Clásica',19);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (4,'Cancion 4',171,'Jazz',97);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (5,'Cancion 5',178,'Electrónica',13);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (6,'Cancion 6',185,'Rock',48);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (7,'Cancion 7',192,'Rock',45);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (8,'Cancion 8',199,'Electrónica',77);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (9,'Cancion 9',206,'Clásica',5);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (10,'Cancion 10',213,'Latina',68);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (11,'Cancion 11',220,'Rock',48);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (12,'Cancion 12',227,'Rock',70);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (13,'Cancion 13',234,'Clásica',80);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (14,'Cancion 14',241,'R&B',46);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (15,'Cancion 15',248,'R&B',24);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (16,'Cancion 16',255,'Rock',5);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (17,'Cancion 17',262,'Jazz',98);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (18,'Cancion 18',269,'Clásica',10);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (19,'Cancion 19',276,'Jazz',12);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (20,'Cancion 20',283,'Reguetón',35);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (1,'Cancion 21',290,'Latina',81);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (2,'Cancion 22',297,'Electrónica',20);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (3,'Cancion 23',304,'Electrónica',45);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (4,'Cancion 24',311,'Jazz',85);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (5,'Cancion 25',318,'Clásica',89);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (6,'Cancion 26',325,'Rock',77);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (7,'Cancion 27',332,'Hip-Hop',68);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (8,'Cancion 28',339,'Jazz',20);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (9,'Cancion 29',346,'Latina',48);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (10,'Cancion 30',353,'Clásica',81);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (11,'Cancion 31',360,'Country',28);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (12,'Cancion 32',367,'Electrónica',98);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (13,'Cancion 33',374,'Pop',29);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (14,'Cancion 34',381,'Pop',40);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (15,'Cancion 35',388,'Reguetón',34);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (16,'Cancion 36',155,'Rock',27);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (17,'Cancion 37',162,'R&B',91);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (18,'Cancion 38',169,'Electrónica',27);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (19,'Cancion 39',176,'Latina',50);
INSERT INTO songs (album_id, title, duration_sec, genre, popularity) VALUES (20,'Cancion 40',183,'Latina',18);
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 1','usuario1@ejemplo.com','México','Individual',9.99,'2025-01-23');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 2','usuario2@ejemplo.com','Estados Unidos','Individual',9.99,'2025-11-30');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 3','usuario3@ejemplo.com','Colombia','Familiar',14.99,'2025-09-07');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 4','usuario4@ejemplo.com','México','Individual',9.99,'2025-03-05');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 5','usuario5@ejemplo.com','España','Familiar',14.99,'2024-12-29');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 6','usuario6@ejemplo.com','Reino Unido','Free',0.0,'2025-01-30');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 7','usuario7@ejemplo.com','Colombia','Estudiante',4.99,'2025-10-27');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 8','usuario8@ejemplo.com','Colombia','Free',0.0,'2025-05-29');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 9','usuario9@ejemplo.com','Argentina','Familiar',14.99,'2025-08-10');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 10','usuario10@ejemplo.com','Reino Unido','Free',0.0,'2025-10-27');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 11','usuario11@ejemplo.com','Estados Unidos','Free',0.0,'2025-10-28');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 12','usuario12@ejemplo.com','Reino Unido','Individual',9.99,'2025-12-11');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 13','usuario13@ejemplo.com','Argentina','Individual',9.99,'2025-01-09');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 14','usuario14@ejemplo.com','Colombia','Familiar',14.99,'2025-02-01');
INSERT INTO users (name, email, country, plan_name, plan_price, subscription_end_date) VALUES ('Usuario 15','usuario15@ejemplo.com','Reino Unido','Free',0.0,'2025-11-17');
INSERT INTO playlists (user_id, name, created_at) VALUES (1,'Playlist 1','2025-01-01 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (2,'Playlist 2','2025-01-02 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (3,'Playlist 3','2025-01-03 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (4,'Playlist 4','2025-01-04 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (5,'Playlist 5','2025-01-05 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (6,'Playlist 6','2025-01-06 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (7,'Playlist 7','2025-01-07 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (8,'Playlist 8','2025-01-08 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (9,'Playlist 9','2025-01-09 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (10,'Playlist 10','2025-01-10 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (11,'Playlist 11','2025-01-11 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (12,'Playlist 12','2025-01-12 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (13,'Playlist 13','2025-01-13 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (14,'Playlist 14','2025-01-14 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (15,'Playlist 15','2025-01-15 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (1,'Playlist 16','2025-01-16 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (2,'Playlist 17','2025-01-17 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (3,'Playlist 18','2025-01-18 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (4,'Playlist 19','2025-01-19 12:00:00');
INSERT INTO playlists (user_id, name, created_at) VALUES (5,'Playlist 20','2025-01-20 12:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (1,33,'2025-01-11 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (1,12,'2025-01-12 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (1,7,'2025-01-13 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (1,20,'2025-01-14 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (2,33,'2025-01-15 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (2,39,'2025-01-16 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (2,13,'2025-01-17 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (2,10,'2025-01-18 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (2,24,'2025-01-19 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (3,35,'2025-01-20 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (3,34,'2025-01-21 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (3,1,'2025-01-22 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (4,21,'2025-01-23 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (4,32,'2025-01-24 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (4,2,'2025-01-25 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (4,8,'2025-01-26 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (4,24,'2025-01-27 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (5,16,'2025-01-28 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (5,4,'2025-01-29 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (5,37,'2025-01-30 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (5,6,'2025-01-31 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (6,32,'2025-02-01 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (6,5,'2025-02-02 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (6,35,'2025-02-03 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (7,9,'2025-02-04 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (7,31,'2025-02-05 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (7,36,'2025-02-06 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (8,17,'2025-02-07 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (8,34,'2025-02-08 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (8,39,'2025-02-09 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (9,14,'2025-02-10 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (9,35,'2025-02-11 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (9,13,'2025-02-12 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (9,20,'2025-02-13 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (10,24,'2025-02-14 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (10,29,'2025-02-15 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (10,34,'2025-02-16 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (10,8,'2025-02-17 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (11,15,'2025-02-18 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (11,5,'2025-02-19 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (11,22,'2025-02-20 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (12,38,'2025-02-21 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (12,36,'2025-02-22 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (12,15,'2025-02-23 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (13,15,'2025-02-24 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (13,1,'2025-02-25 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (13,5,'2025-02-26 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (13,4,'2025-02-27 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (13,3,'2025-02-28 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (14,5,'2025-03-01 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (14,33,'2025-03-02 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (14,16,'2025-03-03 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (14,18,'2025-03-04 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (15,32,'2025-03-05 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (15,14,'2025-03-06 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (15,35,'2025-03-07 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (15,9,'2025-03-08 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (15,37,'2025-03-09 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (16,31,'2025-03-10 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (16,16,'2025-03-11 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (16,27,'2025-03-12 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (16,13,'2025-03-13 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (16,7,'2025-03-14 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (17,28,'2025-03-15 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (17,23,'2025-03-16 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (17,27,'2025-03-17 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (18,4,'2025-03-18 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (18,7,'2025-03-19 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (18,26,'2025-03-20 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (18,22,'2025-03-21 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (19,16,'2025-03-22 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (19,13,'2025-03-23 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (19,35,'2025-03-24 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (20,9,'2025-03-25 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (20,28,'2025-03-26 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (20,12,'2025-03-27 10:00:00');
INSERT INTO playlist_songs (playlist_id, song_id, added_at) VALUES (20,18,'2025-03-28 10:00:00');
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (8,16,'LIKE','2025-03-01 08:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (14,5,'PLAY','2025-03-01 08:15:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (13,36,'PLAY','2025-03-01 08:30:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,35,'PLAY','2025-03-01 08:45:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,16,'LIKE','2025-03-01 09:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (3,27,'PLAY','2025-03-01 09:15:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (8,14,'PLAY','2025-03-01 09:30:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,4,'PLAY','2025-03-01 09:45:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,1,'LIKE','2025-03-01 10:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,17,'PLAY','2025-03-01 10:15:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,28,'PLAY','2025-03-01 10:30:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (12,36,'PLAY','2025-03-01 10:45:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (12,32,'LIKE','2025-03-01 11:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (3,13,'PLAY','2025-03-01 11:15:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,4,'PLAY','2025-03-01 11:30:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (12,35,'PLAY','2025-03-01 11:45:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (12,21,'LIKE','2025-03-01 12:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,4,'PLAY','2025-03-01 12:15:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (8,33,'PLAY','2025-03-01 12:30:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (3,4,'PLAY','2025-03-01 12:45:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,12,'LIKE','2025-03-01 13:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,39,'PLAY','2025-03-01 13:15:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (11,16,'PLAY','2025-03-01 13:30:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,37,'PLAY','2025-03-01 13:45:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (10,39,'LIKE','2025-03-01 14:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,40,'PLAY','2025-03-01 14:15:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,38,'PLAY','2025-03-01 14:30:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (9,21,'PLAY','2025-03-01 14:45:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,21,'LIKE','2025-03-01 15:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,17,'PLAY','2025-03-01 15:15:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (3,20,'PLAY','2025-03-01 15:30:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (6,5,'PLAY','2025-03-01 15:45:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (8,40,'LIKE','2025-03-01 16:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (10,7,'PLAY','2025-03-01 16:15:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (9,14,'PLAY','2025-03-01 16:30:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,9,'PLAY','2025-03-01 16:45:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,5,'LIKE','2025-03-01 17:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,16,'PLAY','2025-03-01 17:15:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,11,'PLAY','2025-03-01 17:30:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (14,35,'PLAY','2025-03-01 17:45:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,40,'LIKE','2025-03-01 18:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (13,34,'PLAY','2025-03-01 18:15:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (11,36,'PLAY','2025-03-01 18:30:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,7,'PLAY','2025-03-01 18:45:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,8,'LIKE','2025-03-01 19:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,7,'PLAY','2025-03-01 19:15:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (9,10,'PLAY','2025-03-01 19:30:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,39,'PLAY','2025-03-01 19:45:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (12,22,'LIKE','2025-03-01 20:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,17,'PLAY','2025-03-01 20:15:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (8,17,'PLAY','2025-03-01 20:30:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,28,'PLAY','2025-03-01 20:45:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,1,'LIKE','2025-03-01 21:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (6,9,'PLAY','2025-03-01 21:15:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,11,'PLAY','2025-03-01 21:30:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (8,36,'PLAY','2025-03-01 21:45:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,36,'LIKE','2025-03-01 22:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,8,'PLAY','2025-03-01 22:15:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,10,'PLAY','2025-03-01 22:30:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,24,'PLAY','2025-03-01 22:45:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (9,10,'LIKE','2025-03-01 23:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,9,'PLAY','2025-03-01 23:15:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,24,'PLAY','2025-03-01 23:30:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,23,'PLAY','2025-03-01 23:45:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (11,16,'LIKE','2025-03-02 00:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (11,7,'PLAY','2025-03-02 00:15:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (13,36,'PLAY','2025-03-02 00:30:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (10,10,'PLAY','2025-03-02 00:45:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (14,11,'LIKE','2025-03-02 01:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (13,12,'PLAY','2025-03-02 01:15:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,12,'PLAY','2025-03-02 01:30:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,22,'PLAY','2025-03-02 01:45:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (13,16,'LIKE','2025-03-02 02:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,11,'PLAY','2025-03-02 02:15:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,25,'PLAY','2025-03-02 02:30:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (14,31,'PLAY','2025-03-02 02:45:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,30,'LIKE','2025-03-02 03:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (6,20,'PLAY','2025-03-02 03:15:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,2,'PLAY','2025-03-02 03:30:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,26,'PLAY','2025-03-02 03:45:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,5,'LIKE','2025-03-02 04:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (13,18,'PLAY','2025-03-02 04:15:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (11,33,'PLAY','2025-03-02 04:30:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (11,35,'PLAY','2025-03-02 04:45:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,8,'LIKE','2025-03-02 05:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,17,'PLAY','2025-03-02 05:15:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (10,17,'PLAY','2025-03-02 05:30:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,39,'PLAY','2025-03-02 05:45:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (6,21,'LIKE','2025-03-02 06:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,39,'PLAY','2025-03-02 06:15:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,25,'PLAY','2025-03-02 06:30:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,17,'PLAY','2025-03-02 06:45:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (12,28,'LIKE','2025-03-02 07:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,34,'PLAY','2025-03-02 07:15:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (11,13,'PLAY','2025-03-02 07:30:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,5,'PLAY','2025-03-02 07:45:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,22,'LIKE','2025-03-02 08:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (10,21,'PLAY','2025-03-02 08:15:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (14,8,'PLAY','2025-03-02 08:30:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (15,20,'PLAY','2025-03-02 08:45:00',240);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,27,'LIKE','2025-03-02 09:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (6,26,'PLAY','2025-03-02 09:15:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,36,'PLAY','2025-03-02 09:30:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,27,'PLAY','2025-03-02 09:45:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,12,'LIKE','2025-03-02 10:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (10,37,'PLAY','2025-03-02 10:15:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,36,'PLAY','2025-03-02 10:30:00',60);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,19,'PLAY','2025-03-02 10:45:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (7,38,'LIKE','2025-03-02 11:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (10,21,'PLAY','2025-03-02 11:15:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (8,29,'PLAY','2025-03-02 11:30:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (4,33,'PLAY','2025-03-02 11:45:00',200);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (13,11,'LIKE','2025-03-02 12:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (11,6,'PLAY','2025-03-02 12:15:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (9,40,'PLAY','2025-03-02 12:30:00',180);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (2,16,'PLAY','2025-03-02 12:45:00',300);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (5,15,'LIKE','2025-03-02 13:00:00',NULL);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (13,13,'PLAY','2025-03-02 13:15:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (1,3,'PLAY','2025-03-02 13:30:00',120);
INSERT INTO activity (user_id, song_id, activity_type, event_time, seconds_played) VALUES (8,40,'PLAY','2025-03-02 13:45:00',60);
