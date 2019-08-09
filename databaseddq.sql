DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`(
	`ID` 	 	  int(11) NOT NULL AUTO_INCREMENT,
	`username`    varchar(255) NOT NULL, 
	`joinDate` 	  int(11) NOT NULL, 
	`Male/Female` varchar(255) NOT NULL,
	`Age`		  int(11) NOT NULL,
	`postCount`   int(11) NOT NULL DEFAULT 0, 
	`Premium`	  BOOLEAN NOT NULL DEFAULT 0, 
	`numberOfRep` int(11) NOT NULL DEFAULT 0,
	PRIMARY KEY(`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 


DROP TABLE IF EXISTS `post`; 
CREATE TABLE `post`(
	`postID` 		int(11) NOT NULL AUTO_INCREMENT,
	`userID` 		INT(11) NOT NULL,
	`title` 		varchar(255) NOT NULL, 
	`post_date` 	int(11) NOT NULL, 
	`items`  		int(11) DEFAULT 0, 
	`comments` 		int(11) DEFAULT 0, 
	`views`			int(11) DEFAULT 0, 
	`likes` 		int(11) DEFAULT 0,
	`num_report`	int(11) DEFAULT 0,
	PRIMARY KEY (`postID`),
	FOREIGN KEY (`userID`) REFERENCES user_info(`ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 


DROP TABLE IF EXISTS `picture`; 
CREATE TABLE `picture`(
	`picID` 	int(11) NOT NULL AUTO_INCREMENT, 
	`postID` 	int(11) NOT NULL, 
	`url` 		varchar(255) NOT NULL, 
	`category` 	varchar(255) NOT NULL DEFAULT 'none',	
	`likes` 	int(11) NOT NULL DEFAULT 0,
	`views` 	int(11) NOT NULL DEFAULT 0,
	PRIMARY KEY (`picID`),
	FOREIGN KEY (`postID`) REFERENCES post(`postID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `video`; 
CREATE TABLE `video`(
	`vidID` 	int(11) NOT NULL AUTO_INCREMENT, 
	`postID` 	int(11) NOT NULL, 
	`category` 	varchar(255) NOT NULL DEFAULT 'none',	
	`likes` 	int(11) NOT NULL DEFAULT 0,
	`views` 	int(11) NOT NULL DEFAULT 0,
	PRIMARY KEY (`vidID`),
	FOREIGN KEY (`postID`) REFERENCES post(`postID`) ON DELETE CASCADE ON UPDATE CASCADE
)ENGINE=InnoDB DEFAULT CHARSET=utf8; 

DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`(
	`cID`		int(11) NOT NULL AUTO_INCREMENT, 
	`userID`	int(11) NOT NULL, 
	`postID` 	int(11) NOT NULL, 
	`text`		varchar(255) NOT NULL, 
	`com_date`	varchar(255) NOT NULL, 
	`likes` 	int(11) NOT NULL DEFAULT 0,
	`reports`	int(11) NOT NULL DEFAULT 0,
	PRIMARY KEY(`cID`),
	FOREIGN KEY (`userID`) REFERENCES user_info(`ID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (`postID`) REFERENCES post(`postID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 


DROP TABLE IF EXISTS `likes`;
CREATE TABLE likes(
	`cID`		int(11) NOT NULL, 
	`userID` 	int(11) NOT NULL, 
	FOREIGN KEY(`cID`) REFERENCES comments(`cID`)ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(`userID`) REFERENCES comments(`userID`)ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

CREATE TABLE tag(
	`tagid`		int(11) NOT NULL,
	`name`		varchar(255) NOT NULL, 
	`vidID`		int(11) NOT NULL, 
	`picID`		int(11) NOT NULL,
	PRIMARY KEY(`tagid`),
	FOREIGN KEY(`vidID`) REFERENCES video(`vidID`) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY(`picID`) REFERENCES video(`picID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8; 

LOCK TABLES `user_info` WRITE;
INSERT INTO `user_info`(`userName`, `joinDate`, `Male/Female`, `Age`) VALUES 
('Billyman22', 02142019, 'Male', 17),
('Steven_justice45', 04032018, 'Male', 23),
('Jessica_awesome21', 01012019, 'Female', 20);
UNLOCK TABLES; 

LOCK TABLES `post` WRITE;
INSERT INTO `post` (`title`, `post_date`, `userID`) VALUES
	('here is my dog!', 02262019, 1),
	('cool thing', 10232018, 2),	
	('here we go!', 06022019, 3);
UNLOCK TABLES; 

LOCK TABLES `picture` WRITE;
INSERT INTO `picture` (`postID`, `category`, `url`) VALUES
	(3, 'nature', 'www.now.com'),
	(1, 'city', 'www.osu.com'),
	(2, 'statue', 'www.cool.com'); 
UNLOCK TABLES; 

LOCK TABLES `video` WRITE;
INSERT INTO `video` (`postID`, `category`) VALUES
	(2, 'fun surfing'),
	(1, 'video game gameplay'),
	(2, 'vlog'); 
UNLOCK TABLES; 

LOCK TABLES `comments` WRITE;
INSERT INTO `comments` (`userID`, `text`, `com_date`) VALUES
	(1, 'nice video!', 0422019),
	(3, 'cool!', 05302019),
	(2, 'wow great video!', 03042019); 
UNLOCK TABLES; 

LOCK TABLES `likes` WRITE; 
INSERT INTO `likes` (`cID`, `userID`) VALUES
	(2,3),
	(1,2),
	(2,2);
UNLOCK TABLES; 