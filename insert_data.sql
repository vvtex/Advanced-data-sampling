-- Жанры
INSERT INTO genres (name) VALUES 
('Rock'), ('Pop'), ('Jazz'), ('Classical'), ('Hip-Hop')
ON CONFLICT (name) DO NOTHING;

-- Исполнители
INSERT INTO artists (name) VALUES 
('The Beatles'), ('Adele'), ('Miles Davis'), ('Queen'), ('Drake')
ON CONFLICT (name) DO NOTHING;

-- Альбомы
INSERT INTO albums (title, release_year) VALUES 
('Abbey Road', 2019), ('25', 2020), ('Kind of Blue', 2018), ('A Night at the Opera', 2021)
ON CONFLICT (title) DO NOTHING;

-- Треки
INSERT INTO tracks (title, duration, album_id) VALUES 
('Come Together', 259, 1),
('Hello', 295, 2),
('So What', 328, 3),
('Bohemian Rhapsody', 354, 4),
('Something', 183, 1),
('Skyfall', 276, 2),
('All Blues', 421, 3),
('Love of My Life', 223, 4),
('My Universe', 245, 1),
('Rolling in the Deep', 228, 2)
ON CONFLICT (title) DO NOTHING;

-- Сборники
INSERT INTO collections (title, release_year) VALUES 
('Greatest Hits 2018', 2018),
('Top Tracks 2019', 2019),
('Best of 2020', 2020),
('Ultimate Collection', 2021)
ON CONFLICT (title) DO NOTHING;

-- Связи: Исполнители-Жанры
INSERT INTO artists_genres (artist_id, genre_id) VALUES 
(1, 1), (1, 2), 
(2, 2), 
(3, 3), 
(4, 1), 
(5, 5)
ON CONFLICT DO NOTHING;

-- Связи: Исполнители-Альбомы
INSERT INTO artists_albums (artist_id, album_id) VALUES 
(1, 1), (2, 2), (3, 3), (4, 4), (5, 1), (1, 4)
ON CONFLICT DO NOTHING;

-- Связи: Треки-Сборники
INSERT INTO tracks_collections (track_id, collection_id) VALUES 
(1, 1), (2, 1), (3, 2), (4, 2), (5, 3), (6, 3), (7, 4), (8, 4), (9, 1), (10, 4)
ON CONFLICT DO NOTHING;