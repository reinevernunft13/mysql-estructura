-- CREATE DATABASE
DROP DATABASE IF EXISTS db_youtube;
CREATE DATABASE db_youtube;
USE db_youtube;

-- CREATE DB TABLES
CREATE TABLE users(
    id_user INT NOT NULL AUTO_INCREMENT,
    email VARCHAR(60),
    pw VARCHAR(45),
    birth_date DATETIME,
    username VARCHAR(20) NOT NULL,
    gender ENUM('male', 'female', 'non-binary'),
    country VARCHAR(45),
    zip INT,
    PRIMARY KEY(id_user)
);

CREATE TABLE channels (
  id_channel INT NOT NULL AUTO_INCREMENT,
  name_channel VARCHAR(45) NULL,
  description_channel VARCHAR(300) NULL,
  creation_date DATETIME,
  id_user INT NOT NULL,
  PRIMARY KEY (id_channel),
  FOREIGN KEY (id_user) REFERENCES users (id_user)
);

CREATE TABLE videos (
  id_video INT NOT NULL AUTO_INCREMENT,
  title VARCHAR(60),
  description_video VARCHAR(300),
  size INT,
  file_name VARCHAR(90),
  length TIME,
  thumbnail_url VARCHAR(90),
  upload_data_time TIMESTAMP,
  views INT,
  likes INT,
  dislikes INT,
  status_video ENUM('public', 'private', 'unlisted'),
  id_user INT NOT NULL,
  id_channel INT NOT NULL,
  PRIMARY KEY (id_video),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_channel) REFERENCES channels (id_channel)
);

CREATE TABLE labels (
  id_label INT NOT NULL AUTO_INCREMENT,
  name_label VARCHAR(45) NULL,
  PRIMARY KEY (id_label)
);

CREATE TABLE video_labels (
  id_videolabel INT NOT NULL AUTO_INCREMENT,
  id_label INT NOT NULL,
  id_video INT NOT NULL,
  PRIMARY KEY (id_videolabel),
  FOREIGN KEY (id_label) REFERENCES labels (id_label),
  FOREIGN KEY (id_video) REFERENCES videos (id_video)
);

CREATE TABLE channel_subscriptions (
  id_subscription INT NOT NULL AUTO_INCREMENT,
  id_channel INT NOT NULL,
  id_user INT NOT NULL,
  PRIMARY KEY (id_subscription),
  FOREIGN KEY (id_channel) REFERENCES channels (id_channel),
  FOREIGN KEY (id_user) REFERENCES users (id_user)
);

CREATE TABLE reactions (
  id_reaction INT NOT NULL AUTO_INCREMENT,
  type_reaction ENUM('like', 'dislike'),
  date_reaction TIMESTAMP,
  id_user INT NOT NULL,
  id_video INT NOT NULL,
  PRIMARY KEY (id_reaction),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_video) REFERENCES videos (id_video)
);

CREATE TABLE playlists (
   id_playlist INT NOT NULL AUTO_INCREMENT,
   name_playlist VARCHAR(45),
   date_creation TIMESTAMP,
   status_playlist ENUM('public', 'private'),
   PRIMARY KEY (id_playlist)
);

CREATE TABLE comments (
  id_comment INT NOT NULL AUTO_INCREMENT,
  text_comment VARCHAR(300),
  date_time TIMESTAMP,
  id_user INT NOT NULL,
  id_video INT NOT NULL,
  PRIMARY KEY (id_comment),
  FOREIGN KEY (id_user) REFERENCES users (id_user),
  FOREIGN KEY (id_video) REFERENCES videos (id_video)
);

CREATE TABLE reactions_comments (
  id_reaction_comment INT NOT NULL AUTO_INCREMENT,
  type_reaction_comment ENUM('like', 'dislike'),
  date_reaction_comment DATETIME,
  id_comment INT NOT NULL,
  id_user INT NOT NULL,
  PRIMARY KEY (id_reaction_comment),
  FOREIGN KEY (id_comment) REFERENCES comments (id_comment),
  FOREIGN KEY (id_user) REFERENCES users (id_user)
);

CREATE TABLE items_playlist (
  id_item_playlist INT NOT NULL AUTO_INCREMENT,
  id_playlist INT NOT NULL,
  id_video INT NOT NULL,
  PRIMARY KEY (id_item_playlist),
  FOREIGN KEY (id_playlist) REFERENCES playlists (id_playlist),
  FOREIGN KEY (id_video) REFERENCES videos (id_video)
);
