CREATE TABLE `Music`(
	`musicID` int(11) NOT NULL AUTO_INCREMENT, 
	`musicName` varchar(255) NOT NULL, 
	`artist` varchar(255) NOT NULL, 
	`musicLength` int(11) NOT NULL, 
	PRIMARY KEY(`musicID`)
)ENGINE =InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `Movie`(
	`movieID` int(11) NOT NULL AUTO_INCREMENT, 
	`movieTitle` varchar(255) NOT NULL, 
	`Genre` 	varchar(255) NOT NULL, 
	`director` varchar(255) NOT NULL, 
	`run_Time` int(11) NOT NULL, 
	`musicID` int(11), 
	`tvID` 	int(11),
	PRIMARY KEY(`movieID`),
	FOREIGN KEY(`musicID`) REFERENCES Music(`musicID`)
)ENGINE =InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `TV_show`(
	`showID` int(11) NOT NULL AUTO_INCREMENT, 
	`showTitle` varchar(255) NOT NULL, 
	`Genre` 	varchar(255) NOT NULL, 
	`producer` varchar(255) NOT NULL, 
	`episode_Count` int(11) NOT NULL, 
	`musicID` int(11),
	`movieID` int(11),
	PRIMARY KEY(`showID`),
	FOREIGN KEY (`musicID`) REFERENCES Music(`musicID`),
	FOREIGN KEY (`movieID`) REFERENCES Movie(`movieID`) 
)ENGINE =InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `video_Game`(
	`gameID` int(11) NOT NULL AUTO_INCREMENT, 
	`gameTitle` varchar(255) NOT NULL, 
	`Genre` 	varchar(255) NOT NULL, 
	`gameStudio` varchar(255) NOT NULL, 
	`musicID` int(11),
	`movieID` int(11),
	`tvID` 	  int(11),
	PRIMARY KEY(`gameID`),
	FOREIGN KEY (`musicID`) REFERENCES Music(`musicID`), 
	FOREIGN KEY (`movieID`) REFERENCES Movie(`movieID`),
	FOREIGN KEY (`tvID`) REFERENCES TV_show(`showID`)
)ENGINE =InnoDB DEFAULT CHARSET=utf8;





LOCK TABLES `Music` WRITE;
INSERT INTO `Music`(`musicName`, `artist`, `musicLength`) VALUES 
('Hey Jude', 'The Beatles','3'),
('Stronger','Kanye West', '4'),
('Mr.Sandman','Metallica', '6');
UNLOCK TABLES; 

LOCK TABLES `Movie` WRITE;
INSERT INTO `Movie`(`movieTitle`, `Genre`, `director`,`run_Time`) VALUES 
('Alien', 'Horror','Ridley Scott', '2'),
('The Matrix','Thriller', 'The Wachowskis', '2'),
('2001 A space Odyssey','Science Fiction', 'Stanley Kubrick', '2');
UNLOCK TABLES; 

LOCK TABLES `TV_show` WRITE;
INSERT INTO `TV_show`(`showTitle`, `Genre`, `producer`,`episode_Count`) VALUES 
('cool kids', 'comedy','billy joe', '250'),
('The Matrix the show','Thriller', 'The Wachowskis', '24'),
('Evangelion','Science Fiction', 'Hedeki Anno', '24');
UNLOCK TABLES; 


LOCK TABLES `video_Game` WRITE;
INSERT INTO `video_Game`(`gameTitle`, `Genre`, `gameStudio`) VALUES 
('Super Mario Bros', 'platformer','Nintendo'),
('Sonic the Hedgehog','platformer', 'Sega'),
('Metal Gear Solid','Action', 'Konami');
UNLOCK TABLES; 
