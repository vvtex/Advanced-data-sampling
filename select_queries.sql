-- Задание 2
-- 1. Самый длинный трек
SELECT title, duration 
FROM tracks 
ORDER BY duration DESC 
LIMIT 1;

-- 2. Треки ≥ 3.5 минут (210 секунд)
SELECT title 
FROM tracks 
WHERE duration >= 210;

-- 3. Сборники 2018-2020
SELECT title 
FROM collections 
WHERE release_year BETWEEN 2018 AND 2020;

-- 4. Исполнители из одного слова
SELECT name 
FROM artists 
WHERE name NOT LIKE '% %';

-- 5. Треки с «мой» или «my»
SELECT title 
FROM tracks 
WHERE LOWER(title) LIKE '%мой%' OR LOWER(title) LIKE '%my%';

-- Задание 3
-- 1. Количество исполнителей по жанрам
SELECT g.name, COUNT(ag.artist_id) 
FROM genres g
LEFT JOIN artists_genres ag ON g.id = ag.genre_id
GROUP BY g.name;

-- 2. Треки в альбомах 2019-2020
SELECT COUNT(t.id)
FROM tracks t
JOIN albums a ON t.album_id = a.id
WHERE a.release_year BETWEEN 2019 AND 2020;

-- 3. Средняя продолжительность треков по альбомам
SELECT a.title, AVG(t.duration) 
FROM albums a
JOIN tracks t ON a.id = t.album_id
GROUP BY a.title;

-- 4. Исполнители без альбомов в 2020
SELECT ar.name 
FROM artists ar
WHERE ar.id NOT IN (
    SELECT aa.artist_id 
    FROM artists_albums aa
    JOIN albums al ON aa.album_id = al.id
    WHERE al.release_year = 2020
);

-- 5. Сборники с участием Queen
SELECT c.title 
FROM collections c
JOIN tracks_collections tc ON c.id = tc.collection_id
JOIN tracks t ON tc.track_id = t.id
JOIN albums a ON t.album_id = a.id
JOIN artists_albums aa ON a.id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.id
WHERE ar.name = 'Queen';

-- Задание 4 (необязательное)
-- 1. Альбомы с исполнителями >1 жанра
SELECT al.title 
FROM albums al
JOIN artists_albums aa ON al.id = aa.album_id
JOIN artists ar ON aa.artist_id = ar.id
JOIN artists_genres ag ON ar.id = ag.artist_id
GROUP BY al.title
HAVING COUNT(DISTINCT ag.genre_id) > 1;

-- 2. Треки не в сборниках
SELECT t.title 
FROM tracks t
LEFT JOIN tracks_collections tc ON t.id = tc.track_id
WHERE tc.track_id IS NULL;

-- 3. Исполнители самого короткого трека
SELECT ar.name 
FROM artists ar
JOIN artists_albums aa ON ar.id = aa.artist_id
JOIN albums al ON aa.album_id = al.id
JOIN tracks t ON al.id = t.album_id
WHERE t.duration = (SELECT MIN(duration) FROM tracks);

-- 4. Альбомы с наименьшим числом треков
SELECT al.title 
FROM albums al
JOIN tracks t ON al.id = t.album_id
GROUP BY al.title
HAVING COUNT(t.id) = (
    SELECT COUNT(id) 
    FROM tracks 
    GROUP BY album_id 
    ORDER BY COUNT(id) 
    LIMIT 1
);