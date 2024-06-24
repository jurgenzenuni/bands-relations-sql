
CREATE DATABASE IF NOT EXISTS CSC315Final2023;
USE CSC315Final2023;


CREATE TABLE IF NOT EXISTS Genre (
	gid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	gname CHAR(20) NOT NULL
);

INSERT INTO Genre (gname) VALUES ('Rock'), ('Jazz'), ('Country'), ('Classical'), ('Throat Singing');

CREATE TABLE IF NOT EXISTS Sub_Genre (
	sgid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	gname CHAR(20) NOT NULL,
	sgname CHAR(20) NOT NULL
);

INSERT INTO Sub_Genre (gname, sgname) VALUES ('Rock', 'Blues'), ('Rock', 'Classic Rock'), ('Rock', 'Power Metal'), ('Rock', 'Thrash Metal'), ('Rock', 'Death Metal'), ('Rock', 'Folk Metal');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Jazz', 'Swing'), ('Jazz', 'Smooth Jazz'), ('Jazz', 'Bossa Nova'), ('Jazz', 'Ragtime');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Country', 'Bluegrass'), ('Country', 'Country and Western'), ('Country', 'Jug Band');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Classical', 'Chamber Music'), ('Classical', 'Opera'), ('Classical', 'Orchestral');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Throat Singing', 'Khoomii'), ('Throat Singing', 'Kargyraa'), ('Throat Singing', 'Khamryn');

CREATE TABLE IF NOT EXISTS Region (
	rid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	rname CHAR(20) NOT NULL
);

INSERT INTO Region (rname) VALUES ('Central Asia'), ('Europe'), ('North Americ'), ('South America');

CREATE TABLE IF NOT EXISTS Country (
	rid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	rname CHAR(20) NOT NULL,
	cname CHAR(20) NOT NULL
);

INSERT INTO Country (rname, cname) VALUES ('Central Asia', 'Mongolia'), ('Central Asia', 'Tibet'), ('Central Asia', 'Tuva');
INSERT INTO Country (rname, cname) VALUES ('North Americ', 'Canada'), ('North Americ', 'United States'), ('North Americ', 'Mexico');
INSERT INTO Country (rname, cname) VALUES ('South Americ', 'Brazil');
INSERT INTO Country (rname, cname) VALUES ('Europe', 'Norway'), ('Europe', 'Austria'), ('Europe', 'England'), ('Europe', 'Russia');

CREATE TABLE IF NOT EXISTS Bands (
	bid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL
);

INSERT INTO Bands (bname) VALUES ('Seputura'), ('Death'), ('Muddy Waters'), ('Led Zeppelin'), ('The Guess Who');
INSERT INTO Bands (bname) VALUES ('The Hu'), ('Huun-Huur-Tu'), ('Paul Pena'), ('Battuvshin'), ('Sade');
INSERT INTO Bands (bname) VALUES ('Mozart'), ('Tchaikovsky'), ('Twisted Sister'), ('Testament'), ('Tengger Cavalry');


CREATE TABLE IF NOT EXISTS Band_Origins (
	boid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL,
	cname CHAR(20) NOT NULL
);

INSERT INTO Band_Origins (bname, cname) VALUES ('Seputura', 'Brazil');
INSERT INTO Band_Origins (bname, cname) VALUES ('Death', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Muddy Waters', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Led Zeppelin', 'England');
INSERT INTO Band_Origins (bname, cname) VALUES ('The Guess Who', 'Canada');
INSERT INTO Band_Origins (bname, cname) VALUES ('The Hu', 'Mongolia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Huun-Huur-Tu', 'Tuva');
INSERT INTO Band_Origins (bname, cname) VALUES ('Paul Pena', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Battuvshin', 'Mongolia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Sade', 'England');
INSERT INTO Band_Origins (bname, cname) VALUES ('Mozart', 'Austria');
INSERT INTO Band_Origins (bname, cname) VALUES ('Tchaikovsky', 'Russia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Twisted Sister', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Testament', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Tengger Cavalry', 'United States');


CREATE TABLE IF NOT EXISTS Band_Styles (
	boid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL,
	sgname CHAR(20) NOT NULL
);

INSERT INTO Band_Styles (bname, sgname) VALUES ('Seputura', 'Death Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Seputura', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Death', 'Death Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Muddy Waters', 'Blues');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Led Zeppelin', 'Classic Rock');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Guess Who', 'Classic Rock');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Hu', 'Folk Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Hu', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Huun-Huur-Tu', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Huun-Huur-Tu', 'Kargyraa');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Paul Pena', 'Blues');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Paul Pena', 'Kargyraa');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Battuvshin', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Battuvshin', 'Smooth Jazz');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Sade', 'Smooth Jazz');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Mozart', 'Opera');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tchaikovsky', 'Opera');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tchaikovsky', 'Orchestral');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Twisted Sister', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Testament', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tengger Cavalry', 'Folk Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tengger Cavalry', 'Khoomii');



-- cleanup
DROP TABLE IF EXISTS Band_Styles;
DROP TABLE IF EXISTS Band_Origins;
DROP TABLE IF EXISTS Bands;
DROP TABLE IF EXISTS Country;
DROP TABLE IF EXISTS Region;
DROP TABLE IF EXISTS Sub_Genre;
DROP TABLE IF EXISTS Genre;
DROP DATABASE IF EXISTS CSC315Final2023;
