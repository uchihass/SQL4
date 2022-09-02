CREATE TABLE IF NOT EXISTS musical_genres (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS performers (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS performers_genres (
	PRIMARY KEY (musical_genre_id, performer_id),
	musical_genre_id INTEGER NOT NULL REFERENCES musical_genres(id),
	performer_id 	 INTEGER NOT NULL REFERENCES performers(id)
);

CREATE TABLE IF NOT EXISTS albums (
	id SERIAL PRIMARY KEY,
	name 		 VARCHAR(50) NOT NULL,
	date_release DATE 	 	 NOT NULL,
		 		 CHECK (date_release > '1900-01-01')
);

CREATE TABLE IF NOT EXISTS performers_albums (
	PRIMARY KEY (album_id, performer_id),
	album_id 	 INTEGER NOT NULL REFERENCES albums(id),
	performer_id INTEGER NOT NULL REFERENCES performers(id)
);

CREATE TABLE IF NOT EXISTS tracks (
	id SERIAL PRIMARY KEY,
	name 	 VARCHAR(50) 	NOT NULL,
	duration NUMERIC(18, 2) NOT NULL 
			 CHECK (duration > 0),
	album_id INTEGER 		NOT NULL REFERENCES albums(id)
);

CREATE TABLE IF NOT EXISTS music_collections (
	id SERIAL PRIMARY KEY,
	name 		 VARCHAR(50) NOT NULL,
	date_release DATE 		 NOT NULL,
				 CHECK (date_release > '1900-01-01')
);

CREATE TABLE IF NOT EXISTS music_collection_tracks (
	PRIMARY KEY (music_collection_id, track_id),
	music_collection_id INTEGER NOT NULL REFERENCES music_collections(id),
	track_id 			INTEGER NOT NULL REFERENCES tracks(id)
);