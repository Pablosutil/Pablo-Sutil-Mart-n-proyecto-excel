-- Q01: Listado de artistas con su país y género principal
SELECT artist_id, name, country, primary_genre
FROM artists
ORDER BY name;

-- Q02: Álbumes por artista (JOIN)
SELECT a.name AS artista, al.title AS album, al.release_date
FROM artists a
JOIN albums al ON al.artist_id = a.artist_id
ORDER BY a.name, al.release_date;

-- Q03: Canciones por álbum (JOIN)
SELECT al.title AS album, s.title AS cancion, s.duration_sec
FROM albums al
JOIN songs s ON s.album_id = al.album_id
ORDER BY al.title, s.title;

-- Q04: Usuarios por país (agregación)
SELECT country, COUNT(*) AS total_usuarios
FROM users
GROUP BY country
ORDER BY total_usuarios DESC;

-- Q05: Top 5 canciones por popularidad
SELECT s.song_id, s.title, s.popularity
FROM songs s
ORDER BY s.popularity DESC
LIMIT 5;

-- Q06: Playlists de cada usuario (LEFT JOIN)
SELECT u.user_id, u.name AS usuario, p.playlist_id, p.name AS playlist
FROM users u
LEFT JOIN playlists p ON p.user_id = u.user_id
ORDER BY u.user_id, p.playlist_id;

-- Q07: Número de canciones por playlist
SELECT p.playlist_id, p.name AS playlist, COUNT(ps.song_id) AS total_canciones
FROM playlists p
LEFT JOIN playlist_songs ps ON ps.playlist_id = p.playlist_id
GROUP BY p.playlist_id, p.name
ORDER BY total_canciones DESC;

-- Q08: Historial de reproducciones (últimas 10)
SELECT ac.activity_id, u.name AS usuario, s.title AS cancion, ac.event_time, ac.seconds_played
FROM activity ac
JOIN users u ON u.user_id = ac.user_id
JOIN songs s ON s.song_id = ac.song_id
WHERE ac.activity_type = 'PLAY'
ORDER BY ac.event_time DESC
LIMIT 10;

-- Q09: Canciones con más likes (TOP 5)
SELECT s.song_id, s.title, COUNT(*) AS likes
FROM activity ac
JOIN songs s ON s.song_id = ac.song_id
WHERE ac.activity_type = 'LIKE'
GROUP BY s.song_id, s.title
ORDER BY likes DESC, s.title
LIMIT 5;

-- Q10: Usuarios con suscripción vencida (a fecha actual)
SELECT user_id, name, plan_name, subscription_end_date
FROM users
WHERE subscription_end_date < CURDATE();

-- Q11: Duración promedio de canciones por álbum
SELECT al.album_id, al.title AS album, ROUND(AVG(s.duration_sec),2) AS duracion_media
FROM albums al
JOIN songs s ON s.album_id = al.album_id
GROUP BY al.album_id, al.title
ORDER BY duracion_media DESC;

-- Q12: Artistas sin álbumes registrados (LEFT JOIN + IS NULL)
SELECT a.artist_id, a.name
FROM artists a
LEFT JOIN albums al ON al.artist_id = a.artist_id
WHERE al.album_id IS NULL;

-- Q13: Usuarios que nunca han dado like (subconsulta)
SELECT u.user_id, u.name
FROM users u
WHERE u.user_id NOT IN (
  SELECT DISTINCT ac.user_id
  FROM activity ac
  WHERE ac.activity_type = 'LIKE'
);

-- Q14: Canción más reproducida por cada usuario (window + subconsulta)
SELECT t.user_id, u.name AS usuario, t.song_id, s.title, t.total_plays
FROM (
  SELECT ac.user_id, ac.song_id, COUNT(*) AS total_plays,
         ROW_NUMBER() OVER (PARTITION BY ac.user_id ORDER BY COUNT(*) DESC, ac.song_id) AS rn
  FROM activity ac
  WHERE ac.activity_type = 'PLAY'
  GROUP BY ac.user_id, ac.song_id
) t
JOIN users u ON u.user_id = t.user_id
JOIN songs s ON s.song_id = t.song_id
WHERE t.rn = 1
ORDER BY u.user_id;

-- Q15: Top 5 canciones más agregadas a playlists
SELECT s.song_id, s.title, COUNT(*) AS veces_en_playlists
FROM playlist_songs ps
JOIN songs s ON s.song_id = ps.song_id
GROUP BY s.song_id, s.title
ORDER BY veces_en_playlists DESC, s.title
LIMIT 5;

-- Q16: Plan con menor número de usuarios
SELECT plan_name, COUNT(*) AS usuarios
FROM users
GROUP BY plan_name
ORDER BY usuarios ASC, plan_name
LIMIT 1;

-- Q17: Canciones reproducidas por usuarios de México
SELECT DISTINCT s.song_id, s.title
FROM activity ac
JOIN users u ON u.user_id = ac.user_id
JOIN songs s ON s.song_id = ac.song_id
WHERE ac.activity_type = 'PLAY' AND u.country = 'México'
ORDER BY s.title;

-- Q18: Artistas cuyo género principal coincide con el género más popular en reproducciones
WITH popular AS (
    SELECT s.genre, COUNT(*) AS plays
    FROM activity ac
    JOIN songs s ON s.song_id = ac.song_id
    WHERE ac.activity_type = 'PLAY'
    GROUP BY s.genre
    ORDER BY plays DESC
    LIMIT 1
)
SELECT DISTINCT a.artist_id, a.name, a.primary_genre
FROM artists a
JOIN albums al ON al.artist_id = a.artist_id
JOIN songs s ON s.album_id = al.album_id
JOIN popular p ON p.genre = a.primary_genre
WHERE s.genre = p.genre;

-- Q19: Usuarios con al menos una playlist con más de 5 canciones
SELECT DISTINCT u.user_id, u.name
FROM users u
JOIN playlists p ON p.user_id = u.user_id
JOIN playlist_songs ps ON ps.playlist_id = p.playlist_id
GROUP BY u.user_id, u.name, p.playlist_id
HAVING COUNT(ps.song_id) > 5;

-- Q20: Usuarios que comparten canciones en común en sus playlists (pares)
SELECT u1.user_id AS usuario_a, u2.user_id AS usuario_b, COUNT(*) AS canciones_en_comun
FROM playlists p1
JOIN playlist_songs ps1 ON ps1.playlist_id = p1.playlist_id
JOIN playlists p2 ON p2.user_id <> p1.user_id
JOIN playlist_songs ps2 ON ps2.playlist_id = p2.playlist_id AND ps2.song_id = ps1.song_id
JOIN users u1 ON u1.user_id = p1.user_id
JOIN users u2 ON u2.user_id = p2.user_id
GROUP BY u1.user_id, u2.user_id
HAVING COUNT(*) >= 3
ORDER BY canciones_en_comun DESC;

-- Q21: Artistas con canciones en playlists de más de 5 usuarios distintos
SELECT a.artist_id, a.name, COUNT(DISTINCT p.user_id) AS usuarios_distintos
FROM artists a
JOIN albums al ON al.artist_id = a.artist_id
JOIN songs s ON s.album_id = al.album_id
JOIN playlist_songs ps ON ps.song_id = s.song_id
JOIN playlists p ON p.playlist_id = ps.playlist_id
GROUP BY a.artist_id, a.name
HAVING COUNT(DISTINCT p.user_id) > 5
ORDER BY usuarios_distintos DESC;

-- Q22: Total de reproducciones por canción
SELECT s.song_id, s.title, COUNT(*) AS total_plays
FROM songs s
JOIN activity ac ON ac.song_id = s.song_id AND ac.activity_type = 'PLAY'
GROUP BY s.song_id, s.title
ORDER BY total_plays DESC, s.title;

-- Q23: Total de likes por usuario y género
SELECT u.user_id, u.name, s.genre, COUNT(*) AS likes
FROM activity ac
JOIN users u ON u.user_id = ac.user_id
JOIN songs s ON s.song_id = ac.song_id
WHERE ac.activity_type = 'LIKE'
GROUP BY u.user_id, u.name, s.genre
ORDER BY u.user_id, likes DESC;

-- Q24: Canciones nunca reproducidas
SELECT s.song_id, s.title
FROM songs s
LEFT JOIN activity ac ON ac.song_id = s.song_id AND ac.activity_type = 'PLAY'
WHERE ac.activity_id IS NULL;

-- Q25: Canciones nunca agregadas a playlists
SELECT s.song_id, s.title
FROM songs s
LEFT JOIN playlist_songs ps ON ps.song_id = s.song_id
WHERE ps.playlist_id IS NULL;

-- Q26: Usuarios sin playlists
SELECT u.user_id, u.name
FROM users u
LEFT JOIN playlists p ON p.user_id = u.user_id
WHERE p.playlist_id IS NULL;

-- Q27: Promedio de duración por género
SELECT genre, ROUND(AVG(duration_sec),2) AS duracion_media
FROM songs
GROUP BY genre
ORDER BY duracion_media DESC;

-- Q28: Ranking de países por reproducciones totales
SELECT u.country, COUNT(*) AS total_reproducciones
FROM activity ac
JOIN users u ON u.user_id = ac.user_id
WHERE ac.activity_type = 'PLAY'
GROUP BY u.country
ORDER BY total_reproducciones DESC;

-- Q29: Usuarios más activos (top 3)
SELECT u.user_id, u.name, COUNT(*) AS eventos
FROM activity ac
JOIN users u ON u.user_id = ac.user_id
GROUP BY u.user_id, u.name
ORDER BY eventos DESC
LIMIT 3;

-- Q30: Playtime total por usuario
SELECT u.user_id, u.name, COALESCE(SUM(ac.seconds_played),0) AS segundos_reproducidos
FROM users u
LEFT JOIN activity ac ON ac.user_id = u.user_id AND ac.activity_type = 'PLAY'
GROUP BY u.user_id, u.name
ORDER BY segundos_reproducidos DESC;

-- Q31: Álbumes con más canciones
SELECT al.album_id, al.title, COUNT(s.song_id) AS n_canciones
FROM albums al
JOIN songs s ON s.album_id = al.album_id
GROUP BY al.album_id, al.title
ORDER BY n_canciones DESC, al.title;

-- Q32: Canciones más recientes (por fecha de álbum)
SELECT s.title, al.title AS album, al.release_date
FROM songs s
JOIN albums al ON al.album_id = s.album_id
ORDER BY al.release_date DESC, s.title
LIMIT 10;

-- Q33: Usuarios por plan
SELECT plan_name, COUNT(*) AS total
FROM users
GROUP BY plan_name
ORDER BY total DESC;

-- Q34: Ingresos potenciales por plan
SELECT plan_name, ROUND(SUM(plan_price),2) AS ingresos_mensuales
FROM users
GROUP BY plan_name
ORDER BY ingresos_mensuales DESC;

-- Q35: Canciones favoritas por likes (>= 3 usuarios distintos)
SELECT s.song_id, s.title, COUNT(DISTINCT ac.user_id) AS usuarios_que_likearon
FROM songs s
JOIN activity ac ON ac.song_id = s.song_id AND ac.activity_type = 'LIKE'
GROUP BY s.song_id, s.title
HAVING COUNT(DISTINCT ac.user_id) >= 3
ORDER BY usuarios_que_likearon DESC, s.title;

-- Q36: Usuarios con 0 reproducciones
SELECT u.user_id, u.name
FROM users u
WHERE NOT EXISTS (
  SELECT 1 FROM activity ac
  WHERE ac.user_id = u.user_id AND ac.activity_type = 'PLAY'
);

-- Q37: Género más escuchado por país
WITH g AS (
  SELECT u.country, s.genre, COUNT(*) AS plays
  FROM activity ac
  JOIN users u ON u.user_id = ac.user_id
  JOIN songs s ON s.song_id = ac.song_id
  WHERE ac.activity_type = 'PLAY'
  GROUP BY u.country, s.genre
),
r AS (
  SELECT g.*,
         ROW_NUMBER() OVER (PARTITION BY country ORDER BY plays DESC) AS rn
  FROM g
)
SELECT country, genre, plays
FROM r
WHERE rn = 1
ORDER BY plays DESC;

-- Q38: Playlists creadas en los últimos 30 días
SELECT playlist_id, name, created_at
FROM playlists
WHERE created_at >= (CURRENT_DATE - INTERVAL 30 DAY)
ORDER BY created_at DESC;

-- Q39: Canciones con duración superior a la media de su género
SELECT s.song_id, s.title, s.genre, s.duration_sec
FROM songs s
WHERE s.duration_sec > (
  SELECT AVG(s2.duration_sec) FROM songs s2 WHERE s2.genre = s.genre
)
ORDER BY s.duration_sec DESC;

-- Q40: Usuarios que comparten país con su artista más escuchado
WITH plays AS (
  SELECT ac.user_id, al.artist_id, COUNT(*) AS n
  FROM activity ac
  JOIN songs s ON s.song_id = ac.song_id
  JOIN albums al ON al.album_id = s.album_id
  WHERE ac.activity_type = 'PLAY'
  GROUP BY ac.user_id, al.artist_id
),
topa AS (
  SELECT user_id, artist_id, n,
         ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY n DESC) AS rn
  FROM plays
)
SELECT u.user_id, u.name, a.name AS artista_top, u.country, a.country AS pais_artista
FROM topa t
JOIN users u ON u.user_id = t.user_id
JOIN artists a ON a.artist_id = t.artist_id
WHERE t.rn = 1 AND u.country = a.country;

-- Q41: Usuarios y número de canciones únicas reproducidas
SELECT u.user_id, u.name, COUNT(DISTINCT ac.song_id) AS canciones_unicas
FROM users u
LEFT JOIN activity ac ON ac.user_id = u.user_id AND ac.activity_type = 'PLAY'
GROUP BY u.user_id, u.name
ORDER BY canciones_unicas DESC;

-- Q42: Artistas con promedio de popularidad de sus canciones
SELECT a.artist_id, a.name, ROUND(AVG(s.popularity),2) AS pop_media
FROM artists a
JOIN albums al ON al.artist_id = a.artist_id
JOIN songs s ON s.album_id = al.album_id
GROUP BY a.artist_id, a.name
ORDER BY pop_media DESC;

-- Q43: Canciones reproducidas en un rango horario (18-22h)
SELECT s.title, ac.event_time
FROM activity ac
JOIN songs s ON s.song_id = ac.song_id
WHERE ac.activity_type = 'PLAY'
  AND TIME(ac.event_time) BETWEEN '18:00:00' AND '22:00:00'
ORDER BY ac.event_time DESC;

-- Q44: Usuarios con playlist que cubre todos los géneros
WITH all_genres AS (
  SELECT DISTINCT genre FROM songs
),
user_playlist_genres AS (
  SELECT p.user_id, p.playlist_id, COUNT(DISTINCT s.genre) AS generos_en_playlist
  FROM playlists p
  JOIN playlist_songs ps ON ps.playlist_id = p.playlist_id
  JOIN songs s ON s.song_id = ps.song_id
  GROUP BY p.user_id, p.playlist_id
)
SELECT u.user_id, u.name, upg.playlist_id
FROM user_playlist_genres upg
JOIN users u ON u.user_id = upg.user_id
WHERE upg.generos_en_playlist = (SELECT COUNT(*) FROM all_genres);

-- Q45: Canciones más reproducidas por género (top 3 por género)
WITH c AS (
  SELECT s.genre, s.song_id, s.title, COUNT(*) AS plays,
         ROW_NUMBER() OVER (PARTITION BY s.genre ORDER BY COUNT(*) DESC, s.song_id) AS rn
  FROM activity ac
  JOIN songs s ON s.song_id = ac.song_id
  WHERE ac.activity_type = 'PLAY'
  GROUP BY s.genre, s.song_id, s.title
)
SELECT genre, song_id, title, plays
FROM c
WHERE rn <= 3
ORDER BY genre, plays DESC;

-- Q46: Usuarios que escucharon al menos 10 canciones en total
SELECT u.user_id, u.name, COUNT(*) AS total_plays
FROM users u
JOIN activity ac ON ac.user_id = u.user_id AND ac.activity_type = 'PLAY'
GROUP BY u.user_id, u.name
HAVING COUNT(*) >= 10
ORDER BY total_plays DESC;

-- Q47: Porcentaje de likes sobre reproducciones por canción
SELECT s.song_id, s.title,
       SUM(CASE WHEN ac.activity_type='LIKE' THEN 1 ELSE 0 END) AS likes,
       SUM(CASE WHEN ac.activity_type='PLAY' THEN 1 ELSE 0 END) AS plays,
       ROUND(100.0 * SUM(CASE WHEN ac.activity_type='LIKE' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN ac.activity_type='PLAY' THEN 1 ELSE 0 END),0),2) AS pct_like_sobre_play
FROM songs s
LEFT JOIN activity ac ON ac.song_id = s.song_id
GROUP BY s.song_id, s.title
ORDER BY pct_like_sobre_play DESC;

-- Q48: Usuarios cuyo plan no es Free y con suscripción vigente
SELECT user_id, name, plan_name, subscription_end_date
FROM users
WHERE plan_name <> 'Free' AND subscription_end_date >= CURDATE();

-- Q49: Artistas ordenados por número de oyentes únicos
SELECT a.artist_id, a.name, COUNT(DISTINCT ac.user_id) AS oyentes_unicos
FROM artists a
JOIN albums al ON al.artist_id = a.artist_id
JOIN songs s ON s.album_id = al.album_id
JOIN activity ac ON ac.song_id = s.song_id AND ac.activity_type = 'PLAY'
GROUP BY a.artist_id, a.name
ORDER BY oyentes_unicos DESC;

-- Q50: Usuarios que han dado like a todas las canciones de un álbum
SELECT DISTINCT u.user_id, u.name, al.album_id, al.title AS album
FROM users u
JOIN activity ac ON ac.user_id = u.user_id AND ac.activity_type = 'LIKE'
JOIN songs s ON s.song_id = ac.song_id
JOIN albums al ON al.album_id = s.album_id
WHERE NOT EXISTS (
  SELECT 1
  FROM songs s2
  WHERE s2.album_id = al.album_id
    AND s2.song_id NOT IN (
        SELECT ac2.song_id FROM activity ac2
        WHERE ac2.user_id = u.user_id AND ac2.activity_type = 'LIKE'
    )
);

-- Q51: Usuarios con más canciones en sus playlists (top 3)
SELECT u.user_id, u.name, COUNT(*) AS canciones_en_playlists
FROM users u
JOIN playlists p ON p.user_id = u.user_id
JOIN playlist_songs ps ON ps.playlist_id = p.playlist_id
GROUP BY u.user_id, u.name
ORDER BY canciones_en_playlists DESC
LIMIT 3;

-- Q52: Canciones más 'saltadas' (plays < 120 segundos)
SELECT s.song_id, s.title, COUNT(*) AS saltos
FROM activity ac
JOIN songs s ON s.song_id = ac.song_id
WHERE ac.activity_type = 'PLAY' AND ac.seconds_played < 120
GROUP BY s.song_id, s.title
ORDER BY saltos DESC;

-- Q53: Usuarios que escucharon canciones del mismo artista en sesiones consecutivas
WITH ordered AS (
  SELECT ac.*, al.artist_id,
         LAG(al.artist_id) OVER (PARTITION BY ac.user_id ORDER BY ac.event_time) AS prev_artist
  FROM activity ac
  JOIN songs s ON s.song_id = ac.song_id
  JOIN albums al ON al.album_id = s.album_id
  WHERE ac.activity_type = 'PLAY'
)
SELECT DISTINCT o.user_id
FROM ordered o
WHERE o.artist_id = o.prev_artist;

-- Q54: Tiempo medio de reproducción por canción
SELECT s.song_id, s.title, ROUND(AVG(ac.seconds_played),2) AS segundos_medios
FROM songs s
JOIN activity ac ON ac.song_id = s.song_id
WHERE ac.activity_type = 'PLAY'
GROUP BY s.song_id, s.title
ORDER BY segundos_medios DESC;

-- Q55: Usuarios sin likes pero con reproducciones
SELECT DISTINCT u.user_id, u.name
FROM users u
JOIN activity acp ON acp.user_id = u.user_id AND acp.activity_type = 'PLAY'
LEFT JOIN activity acl ON acl.user_id = u.user_id AND acl.activity_type = 'LIKE'
WHERE acl.activity_id IS NULL;

-- Q56: Artistas más añadidos a playlists (por canciones)
SELECT a.artist_id, a.name, COUNT(*) AS veces_en_playlists
FROM artists a
JOIN albums al ON al.artist_id = a.artist_id
JOIN songs s ON s.album_id = al.album_id
JOIN playlist_songs ps ON ps.song_id = s.song_id
GROUP BY a.artist_id, a.name
ORDER BY veces_en_playlists DESC;

-- Q57: Usuarios y su primera reproducción
SELECT u.user_id, u.name, MIN(ac.event_time) AS primera_reproduccion
FROM users u
JOIN activity ac ON ac.user_id = u.user_id AND ac.activity_type = 'PLAY'
GROUP BY u.user_id, u.name
ORDER BY primera_reproduccion;

-- Q58: Usuarios que escucharon canciones de al menos 5 géneros distintos
SELECT u.user_id, u.name, COUNT(DISTINCT s.genre) AS generos_distintos
FROM users u
JOIN activity ac ON ac.user_id = u.user_id AND ac.activity_type = 'PLAY'
JOIN songs s ON s.song_id = ac.song_id
GROUP BY u.user_id, u.name
HAVING COUNT(DISTINCT s.genre) >= 5
ORDER BY generos_distintos DESC;

-- Q59: Álbumes nunca reproducidos
SELECT al.album_id, al.title
FROM albums al
LEFT JOIN songs s ON s.album_id = al.album_id
LEFT JOIN activity ac ON ac.song_id = s.song_id AND ac.activity_type = 'PLAY'
GROUP BY al.album_id, al.title
HAVING COUNT(ac.activity_id) = 0;

-- Q60: Usuarios con más likes dentro de un mismo género
WITH likes_by_genre AS (
  SELECT u.user_id, s.genre, COUNT(*) AS likes
  FROM activity ac
  JOIN users u ON u.user_id = ac.user_id
  JOIN songs s ON s.song_id = ac.song_id
  WHERE ac.activity_type = 'LIKE'
  GROUP BY u.user_id, s.genre
),
r AS (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY likes DESC) AS rn
  FROM likes_by_genre
)
SELECT user_id, genre, likes
FROM r
WHERE rn = 1
ORDER BY likes DESC;

-- Q61: Países con porcentaje de usuarios en plan Free
SELECT country,
       ROUND(100.0 * SUM(CASE WHEN plan_name='Free' THEN 1 ELSE 0 END) / COUNT(*),2) AS pct_free
FROM users
GROUP BY country
ORDER BY pct_free DESC;

-- Q62: Usuarios que escucharon la canción más popular
WITH top_song AS (
  SELECT song_id, title
  FROM songs
  ORDER BY popularity DESC
  LIMIT 1
)
SELECT DISTINCT u.user_id, u.name
FROM activity ac
JOIN users u ON u.user_id = ac.user_id
JOIN top_song t ON t.song_id = ac.song_id
WHERE ac.activity_type = 'PLAY';

-- Q63: Artistas con canciones de múltiples géneros (>=3)
SELECT a.artist_id, a.name, COUNT(DISTINCT s.genre) AS generos
FROM artists a
JOIN albums al ON al.artist_id = a.artist_id
JOIN songs s ON s.album_id = al.album_id
GROUP BY a.artist_id, a.name
HAVING COUNT(DISTINCT s.genre) >= 3
ORDER BY generos DESC;

-- Q64: Usuarios que tienen al menos 2 playlists
SELECT u.user_id, u.name, COUNT(*) AS n_playlists
FROM users u
JOIN playlists p ON p.user_id = u.user_id
GROUP BY u.user_id, u.name
HAVING COUNT(*) >= 2
ORDER BY n_playlists DESC;

-- Q65: Canciones que aparecen en más de 3 playlists distintas
SELECT s.song_id, s.title, COUNT(DISTINCT ps.playlist_id) AS n_playlists
FROM songs s
JOIN playlist_songs ps ON ps.song_id = s.song_id
GROUP BY s.song_id, s.title
HAVING COUNT(DISTINCT ps.playlist_id) > 3
ORDER BY n_playlists DESC;
