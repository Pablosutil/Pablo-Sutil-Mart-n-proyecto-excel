USE streaming_musical;

-- Q01. Listar todas las canciones con el nombre de su álbum y artista
SELECT s.title AS cancion, al.title AS album, a.name AS artista
FROM songs s
JOIN albums al ON s.album_id = al.album_id
JOIN artists a ON al.artist_id = a.artist_id;

-- Q02. Mostrar usuarios y el plan al que están suscritos
SELECT u.name, u.plan_name, u.plan_price
FROM users u;

-- Q03. Ver playlists de cada usuario junto con cuántas canciones contiene
SELECT u.name AS usuario, p.name AS playlist, COUNT(ps.song_id) AS total_canciones
FROM playlists p
JOIN users u ON p.user_id = u.user_id
LEFT JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
GROUP BY u.name, p.name;

-- Q04. Listar historial de reproducción con nombre de usuario y canción
SELECT u.name AS usuario, s.title AS cancion, ac.event_time
FROM activity ac
JOIN users u ON ac.user_id = u.user_id
JOIN songs s ON ac.song_id = s.song_id
WHERE ac.activity_type = 'PLAY'
ORDER BY ac.event_time DESC;

-- Q05. Mostrar canciones y si tienen “likes”, junto con el usuario que dio like
SELECT u.name AS usuario, s.title AS cancion
FROM activity ac
JOIN users u ON ac.user_id = u.user_id
JOIN songs s ON ac.song_id = s.song_id
WHERE ac.activity_type = 'LIKE';

-- Q06. Usuarios que tienen más de 1 playlist
SELECT u.name, COUNT(p.playlist_id) AS total_playlists
FROM users u
JOIN playlists p ON u.user_id = p.user_id
GROUP BY u.name
HAVING COUNT(p.playlist_id) > 1;

-- Q07. Canciones con más reproducciones que el promedio global
SELECT s.title, COUNT(*) AS total_repros
FROM songs s
JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'PLAY'
GROUP BY s.title
HAVING COUNT(*) > (
    SELECT AVG(c) FROM (
        SELECT COUNT(*) AS c
        FROM activity
        WHERE activity_type = 'PLAY'
        GROUP BY song_id
    ) AS sub
);

-- Q08. Artistas con al menos un álbum que tenga más de 3 canciones
SELECT a.name AS artista, al.title AS album, COUNT(s.song_id) AS n_canciones
FROM artists a
JOIN albums al ON a.artist_id = al.artist_id
JOIN songs s ON al.album_id = s.album_id
GROUP BY a.name, al.title
HAVING COUNT(s.song_id) > 3;

-- Q09. Usuarios que dieron like a la canción más popular
SELECT DISTINCT u.name AS usuario
FROM users u
JOIN activity ac ON ac.user_id = u.user_id
WHERE ac.activity_type = 'LIKE'
  AND ac.song_id = (
    SELECT song_id
    FROM activity
    WHERE activity_type = 'PLAY'
    GROUP BY song_id
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

-- Q10. Canciones reproducidas por más de 2 usuarios distintos
SELECT s.title, COUNT(DISTINCT ac.user_id) AS usuarios_distintos
FROM songs s
JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'PLAY'
GROUP BY s.title
HAVING COUNT(DISTINCT ac.user_id) > 2;

-- Q11. Top 5 canciones más reproducidas
SELECT s.title, COUNT(*) AS total_repros
FROM songs s
JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'PLAY'
GROUP BY s.title
ORDER BY total_repros DESC
LIMIT 5;

-- Q12. Cantidad total de likes por artista
SELECT a.name AS artista, COUNT(*) AS total_likes
FROM artists a
JOIN albums al ON a.artist_id = al.artist_id
JOIN songs s ON al.album_id = s.album_id
JOIN activity ac ON s.song_id = ac.song_id
WHERE ac.activity_type = 'LIKE'
GROUP BY a.name;

-- Q13. Promedio de duración de canciones por género
SELECT genre, ROUND(AVG(duration_sec),2) AS duracion_media
FROM songs
GROUP BY genre;

-- Q14. Número de usuarios suscritos a cada plan
SELECT plan_name, COUNT(*) AS total_usuarios
FROM users
GROUP BY plan_name;

-- Q15. El usuario con más reproducciones en el historial
SELECT u.name, COUNT(*) AS total_repros
FROM users u
JOIN activity ac ON u.user_id = ac.user_id AND ac.activity_type = 'PLAY'
GROUP BY u.name
ORDER BY total_repros DESC
LIMIT 1;

-- Q16. Las 10 canciones más reproducidas
SELECT s.title, COUNT(*) AS total_repros
FROM songs s
JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'PLAY'
GROUP BY s.title
ORDER BY total_repros DESC
LIMIT 10;

-- Q17. Usuarios que tienen plan activo
SELECT name, plan_name, subscription_end_date
FROM users
WHERE subscription_end_date >= CURDATE();

-- Q18. Listar las playlists con su cantidad respectiva de canciones
SELECT p.name AS playlist, COUNT(ps.song_id) AS total_canciones
FROM playlists p
LEFT JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
GROUP BY p.name;

-- Q19. Listar las canciones reproducidas el último mes
SELECT DISTINCT s.title
FROM songs s
JOIN activity ac ON s.song_id = ac.song_id
WHERE ac.activity_type = 'PLAY'
  AND ac.event_time >= DATE_SUB(CURDATE(), INTERVAL 1 MONTH);

-- Q20. Usuarios que escucharon un mismo artista más de 2 veces
SELECT u.name, a.name AS artista, COUNT(*) AS total
FROM users u
JOIN activity ac ON u.user_id = ac.user_id
JOIN songs s ON ac.song_id = s.song_id
JOIN albums al ON s.album_id = al.album_id
JOIN artists a ON al.artist_id = a.artist_id
WHERE ac.activity_type = 'PLAY'
GROUP BY u.name, a.name
HAVING COUNT(*) > 2;

-- Q21. Canciones con duración mayor al promedio
SELECT title, duration_sec
FROM songs
WHERE duration_sec > (SELECT AVG(duration_sec) FROM songs);

-- Q22. Álbum con más reproducciones totales
SELECT al.title, COUNT(*) AS total_repros
FROM albums al
JOIN songs s ON al.album_id = s.album_id
JOIN activity ac ON s.song_id = ac.song_id
WHERE ac.activity_type = 'PLAY'
GROUP BY al.title
ORDER BY total_repros DESC
LIMIT 1;

-- Q23. Género musical más popular según reproducciones
SELECT s.genre, COUNT(*) AS total_repros
FROM songs s
JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'PLAY'
GROUP BY s.genre
ORDER BY total_repros DESC
LIMIT 1;

-- Q24. Usuario con más likes dados
SELECT u.name, COUNT(*) AS likes
FROM users u
JOIN activity ac ON u.user_id = ac.user_id AND ac.activity_type = 'LIKE'
GROUP BY u.name
ORDER BY likes DESC
LIMIT 1;

-- Q25. Canciones que nunca han sido reproducidas
SELECT s.title
FROM songs s
LEFT JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'PLAY'
WHERE ac.activity_id IS NULL;

-- Q26. Playlists con canciones de más de 2 géneros diferentes
SELECT p.name AS playlist, COUNT(DISTINCT s.genre) AS generos
FROM playlists p
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
JOIN songs s ON ps.song_id = s.song_id
GROUP BY p.name
HAVING COUNT(DISTINCT s.genre) > 2;

-- Q27. Usuarios que escucharon canciones de al menos 3 artistas distintos
SELECT u.name, COUNT(DISTINCT a.artist_id) AS artistas
FROM users u
JOIN activity ac ON u.user_id = ac.user_id AND ac.activity_type = 'PLAY'
JOIN songs s ON ac.song_id = s.song_id
JOIN albums al ON s.album_id = al.album_id
JOIN artists a ON al.artist_id = a.artist_id
GROUP BY u.name
HAVING COUNT(DISTINCT a.artist_id) >= 3;

-- Q28. Ranking de artistas por número de oyentes únicos
SELECT a.name, COUNT(DISTINCT ac.user_id) AS oyentes_unicos
FROM artists a
JOIN albums al ON a.artist_id = al.artist_id
JOIN songs s ON al.album_id = s.album_id
JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'PLAY'
GROUP BY a.name
ORDER BY oyentes_unicos DESC;

-- Q29. Plan con mayor ingreso generado (precio * suscriptores)
SELECT plan_name, SUM(plan_price) AS ingresos
FROM users
WHERE subscription_end_date >= CURDATE()
GROUP BY plan_name
ORDER BY ingresos DESC
LIMIT 1;

-- Q30. Canciones agregadas a playlists en los últimos 7 días
SELECT DISTINCT s.title
FROM songs s
JOIN playlist_songs ps ON s.song_id = ps.song_id
WHERE ps.added_at >= DATE_SUB(CURDATE(), INTERVAL 7 DAY);

-- Q31. Listar los 5 artistas con mayor cantidad de canciones
SELECT a.name, COUNT(s.song_id) AS total_canciones
FROM artists a
JOIN albums al ON a.artist_id = al.artist_id
JOIN songs s ON al.album_id = s.album_id
GROUP BY a.name
ORDER BY total_canciones DESC
LIMIT 5;

-- Q32. Mostrar los álbumes lanzados después de 2020 con su artista
SELECT al.title, al.release_date, a.name AS artista
FROM albums al
JOIN artists a ON al.artist_id = a.artist_id
WHERE YEAR(al.release_date) > 2020;

-- Q33. Obtener los usuarios que nunca han creado una playlist
SELECT u.name
FROM users u
LEFT JOIN playlists p ON u.user_id = p.user_id
WHERE p.playlist_id IS NULL;

-- Q34. Mostrar canciones que aparecen en más de 2 playlists distintas
SELECT s.title, COUNT(DISTINCT ps.playlist_id) AS n_playlists
FROM songs s
JOIN playlist_songs ps ON s.song_id = ps.song_id
GROUP BY s.title
HAVING COUNT(DISTINCT ps.playlist_id) > 2;

-- Q35. Listar artistas con canciones con más de 1000 reproducciones
SELECT DISTINCT a.name
FROM artists a
JOIN albums al ON a.artist_id = al.artist_id
JOIN songs s ON al.album_id = s.album_id
JOIN activity ac ON s.song_id = ac.song_id
WHERE ac.activity_type = 'PLAY'
GROUP BY a.name, s.song_id
HAVING COUNT(ac.activity_id) > 1000;

-- Q36. Top 3 usuarios con más canciones reproducidas en total
SELECT u.name, COUNT(*) AS total_repros
FROM users u
JOIN activity ac ON u.user_id = ac.user_id AND ac.activity_type = 'PLAY'
GROUP BY u.name
ORDER BY total_repros DESC
LIMIT 3;

-- Q37. Playlists que contienen al menos una canción de cada género
SELECT p.name AS playlist
FROM playlists p
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
JOIN songs s ON ps.song_id = s.song_id
GROUP BY p.playlist_id, p.name
HAVING COUNT(DISTINCT s.genre) = (SELECT COUNT(DISTINCT genre) FROM songs);

-- Q38. Usuarios con suscripción vencida
SELECT name, plan_name, subscription_end_date
FROM users
WHERE subscription_end_date < CURDATE();

-- Q39. Canciones que recibieron likes de más de 3 usuarios diferentes
SELECT s.title, COUNT(DISTINCT ac.user_id) AS usuarios_like
FROM songs s
JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'LIKE'
GROUP BY s.title
HAVING COUNT(DISTINCT ac.user_id) > 3;

-- Q40. Álbumes con la duración promedio de sus canciones
SELECT al.title, ROUND(AVG(s.duration_sec),2) AS duracion_promedio
FROM albums al
JOIN songs s ON al.album_id = s.album_id
GROUP BY al.title;

-- Q41. Artistas que no tienen ningún álbum registrado
SELECT a.name
FROM artists a
LEFT JOIN albums al ON a.artist_id = al.artist_id
WHERE al.album_id IS NULL;

-- Q42. Usuarios que nunca han dado like
SELECT u.name
FROM users u
LEFT JOIN activity ac ON u.user_id = ac.user_id AND ac.activity_type = 'LIKE'
WHERE ac.activity_id IS NULL;

-- Q43. Canciones más reproducidas por cada usuario (una por usuario)
SELECT u.name, s.title, COUNT(*) AS plays
FROM users u
JOIN activity ac ON u.user_id = ac.user_id AND ac.activity_type = 'PLAY'
JOIN songs s ON ac.song_id = s.song_id
GROUP BY u.name, s.title
HAVING COUNT(*) = (
    SELECT MAX(c) FROM (
        SELECT COUNT(*) AS c
        FROM activity ac2
        WHERE ac2.user_id = u.user_id AND ac2.activity_type = 'PLAY'
        GROUP BY ac2.song_id
    ) AS sub
);

-- Q44. Top 5 de canciones más agregadas a playlists
SELECT s.title, COUNT(*) AS veces
FROM songs s
JOIN playlist_songs ps ON s.song_id = ps.song_id
GROUP BY s.title
ORDER BY veces DESC
LIMIT 5;

-- Q45. Plan con menor número de usuarios suscritos
SELECT plan_name, COUNT(*) AS total
FROM users
GROUP BY plan_name
ORDER BY total ASC
LIMIT 1;

-- Q46. Canciones reproducidas por usuarios de un país específico (México)
SELECT DISTINCT s.title
FROM songs s
JOIN activity ac ON s.song_id = ac.song_id
JOIN users u ON ac.user_id = u.user_id
WHERE ac.activity_type = 'PLAY' AND u.country = 'México';

-- Q47. Artistas cuyo género principal coincide con el género más popular
WITH genero_top AS (
    SELECT s.genre
    FROM songs s
    JOIN activity ac ON s.song_id = ac.song_id AND ac.activity_type = 'PLAY'
    GROUP BY s.genre
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
SELECT a.name, a.primary_genre
FROM artists a
JOIN genero_top g ON g.genre = a.primary_genre;

-- Q48. Usuarios con al menos una playlist con más de 5 canciones
SELECT DISTINCT u.name
FROM users u
JOIN playlists p ON u.user_id = p.user_id
JOIN playlist_songs ps ON p.playlist_id = ps.playlist_id
GROUP BY u.name, p.playlist_id
HAVING COUNT(ps.song_id) > 5;

-- Q49. Usuarios que comparten canciones en común en sus playlists
SELECT u1.name AS usuario1, u2.name AS usuario2, COUNT(*) AS canciones_comunes
FROM playlists p1
JOIN playlist_songs ps1 ON p1.playlist_id = ps1.playlist_id
JOIN playlists p2 ON p2.user_id <> p1.user_id
JOIN playlist_songs ps2 ON p2.playlist_id = ps2.playlist_id AND ps1.song_id = ps2.song_id
JOIN users u1 ON p1.user_id = u1.user_id
JOIN users u2 ON p2.user_id = u2.user_id
GROUP BY u1.name, u2.name
HAVING COUNT(*) > 0;

-- Q50. Artistas que tienen canciones en playlists de más de 5 usuarios distintos
SELECT a.name, COUNT(DISTINCT p.user_id) AS usuarios
FROM artists a
JOIN albums al ON a.artist_id = al.artist_id
JOIN songs s ON al.album_id = s.album_id
JOIN playlist_songs ps ON s.song_id = ps.song_id
JOIN playlists p ON ps.playlist_id = p.playlist_id
GROUP BY a.name
HAVING COUNT(DISTINCT p.user_id) > 5;
