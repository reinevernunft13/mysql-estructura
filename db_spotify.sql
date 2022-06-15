-- CREATE DATABASE
DROP DATABASE IF EXISTS alt_spotify;
CREATE DATABASE alt_spotify; 
USE alt_spotify; 

-- CREATE DB TABLES 
CREATE TABLE users (
  id_user INT NOT NULL AUTO_INCREMENT,
  type_user ENUM('free', 'premium'),
  email VARCHAR(60),
  pw VARCHAR(45),
  username VARCHAR(45),
  birth_date DATETIME,
  gender ENUM('male', 'female', 'non-binary'),
  country VARCHAR(45),
  zip VARCHAR(20),
  PRIMARY KEY (id_user)
  );

CREATE TABLE premium_subscriptions (
   id_premium_subscription INT NOT NULL AUTO_INCREMENT,
   payment_date DATETIME,
   renewal_date DATETIME,
   payment_method ENUM('credit card', 'paypal'),
   id_user INT,
   PRIMARY KEY (id_premium_subscription),
   FOREIGN KEY (id_user) REFERENCES users (id_user)
);

CREATE TABLE credit_card_payments (
  id_credit_card_payment INT NOT NULL AUTO_INCREMENT,
  id_premium_subscription INT NOT NULL,
  card_number INT NULL,
  expiration_date_month SMALLINT,
  expiration_date_year YEAR,
  cvv_code SMALLINT,
  id_user INT NOT NULL,
  PRIMARY KEY (id_credit_card_payment),
  FOREIGN KEY (id_premium_subscription) REFERENCES premium_subscriptions (id_premium_subscription),
   FOREIGN KEY (id_user) REFERENCES users (id_user)
);

CREATE TABLE paypal_payments (
    id_paypal_payment INT NOT NULL AUTO_INCREMENT,
    id_premium_subscription INT NOT NULL,
    username_paypal VARCHAR(30) NOT NULL,
    PRIMARY KEY(id_paypal_payment),
    FOREIGN KEY(id_premium_subscription) REFERENCES premium_subscriptions (id_premium_subscription)
);

CREATE TABLE playlists_active (
    id_playlist_active INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    title VARCHAR(20) NOT NULL,
    number_songs INT NOT NULL,
    creation_date TIMESTAMP,
    PRIMARY KEY(id_playlist_active),
    FOREIGN KEY(id_user) REFERENCES users (id_user)
);

CREATE TABLE playlists_deleted (
    id_playlist_deleted INT NOT NULL AUTO_INCREMENT,
    id_playlist INT NOT NULL,
    delete_date TIMESTAMP,
    PRIMARY KEY(id_playlist_deleted),
    FOREIGN KEY(id_playlist) REFERENCES playlists_active (id_playlist_active)
);

CREATE TABLE artists (
    id_artist INT NOT NULL AUTO_INCREMENT,
    name_artist VARCHAR(20) NOT NULL,
    image_url VARCHAR(120),
    PRIMARY KEY(id_artist)
);

CREATE TABLE albums(
    id_album INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(25) NOT NULL,
    release_date YEAR NOT NULL,
    cover_url VARCHAR(120),
    id_artist INT NOT NULL,
    PRIMARY KEY(id_album),
    FOREIGN KEY(id_artist) REFERENCES artists (id_artist)
);
CREATE TABLE songs (
    id_song INT NOT NULL AUTO_INCREMENT,
    title VARCHAR(25) NOT NULL,
    length VARCHAR(10) NOT NULL,
    play_count INT NOT NULL,
    id_album INT NOT NULL,
    PRIMARY KEY(id_song),
    FOREIGN KEY(id_album) REFERENCES albums (id_album)
);

CREATE TABLE added_songs (
    id_added_song INT NOT NULL AUTO_INCREMENT,
    id_playlist INT NOT NULL,
    id_user INT NOT NULL,
    date_added TIMESTAMP NOT NULL,
    id_song INT NOT NULL,
    PRIMARY KEY(id_added_song),
    FOREIGN KEY(id_playlist) REFERENCES playlists_active (id_playlist_active),
    FOREIGN KEY(id_user) REFERENCES users (id_user),
    FOREIGN KEY(id_song) REFERENCES songs (id_song)
);
CREATE TABLE related_artists (
    id_related_artists INT NOT NULL AUTO_INCREMENT,
    id_artist_1 INT NOT NULL,
    id_artist_2 INT NOT NULL,
    PRIMARY KEY(id_related_artists),
    FOREIGN KEY(id_artist_1) REFERENCES artists (id_artist),
    FOREIGN KEY(id_artist_2) REFERENCES artists (id_artist)
);
CREATE TABLE favorite_albums (
    id_favorite_albums INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_album INT NOT NULL,
    PRIMARY KEY(id_favorite_albums),
    FOREIGN KEY(id_user) REFERENCES users (id_user),
    FOREIGN KEY(id_album) REFERENCES albums (id_album)
);
CREATE TABLE favorite_songs (
    id_favorite_song INT NOT NULL AUTO_INCREMENT,
    id_user INT NOT NULL,
    id_song INT NOT NULL,
    PRIMARY KEY(id_favorite_song),
    FOREIGN KEY(id_user) REFERENCES users (id_user),
    FOREIGN KEY(id_song) REFERENCES songs (id_song)
);
