-- Таблица жанров
CREATE TABLE IF NOT EXISTS genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Таблица исполнителей
CREATE TABLE IF NOT EXISTS artists (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Таблица альбомов
CREATE TABLE IF NOT EXISTS albums (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK(release_year > 1900)
);

-- Таблица треков
CREATE TABLE IF NOT EXISTS tracks (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    duration INTEGER NOT NULL CHECK(duration > 0),
    album_id INTEGER NOT NULL REFERENCES albums(id) ON DELETE CASCADE
);

-- Таблица сборников
CREATE TABLE IF NOT EXISTS collections (
    id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INTEGER NOT NULL CHECK(release_year > 1900)
);

-- Связь исполнителей и жанров (многие-ко-многим)
CREATE TABLE IF NOT EXISTS artists_genres (
    artist_id INTEGER REFERENCES artists(id) ON DELETE CASCADE,
    genre_id INTEGER REFERENCES genres(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, genre_id)
);

-- Связь исполнителей и альбомов (многие-ко-многим)
CREATE TABLE IF NOT EXISTS artists_albums (
    artist_id INTEGER REFERENCES artists(id) ON DELETE CASCADE,
    album_id INTEGER REFERENCES albums(id) ON DELETE CASCADE,
    PRIMARY KEY (artist_id, album_id)
);

-- Связь треков и сборников (многие-ко-многим)
CREATE TABLE IF NOT EXISTS tracks_collections (
    track_id INTEGER REFERENCES tracks(id) ON DELETE CASCADE,
    collection_id INTEGER REFERENCES collections(id) ON DELETE CASCADE,
    PRIMARY KEY (track_id, collection_id)
);