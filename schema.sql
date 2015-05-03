DROP DATABASE hookline;

CREATE DATABASE hookline;

USE hookline;

CREATE TABLE artists (
  id INTEGER NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY(id)
);

CREATE TABLE tracks (
  id INTEGER NOT NULL AUTO_INCREMENT,
  artist_id INTEGER NOT NULL,
  filename VARCHAR(255) NOT NULL,
  title VARCHAR(255),
  album VARCHAR(255),
  year INTEGER,
  track_number INTEGER,
  genre VARCHAR(255),
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL,
  PRIMARY KEY(id),
  UNIQUE (filename)
);
