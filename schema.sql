CREATE DATABASE hookline;

CREATE TABLE tracks (
  id INTEGER NOT NULL AUTO_INCREMENT,
  filename VARCHAR(255) NOT NULL,
  artist VARCHAR(255),
  title VARCHAR(255),
  album VARCHAR(255),
  year INTEGER,
  track_number INTEGER,
  genre VARCHAR(255),
  PRIMARY KEY(id),
  UNIQUE (filename)
);
