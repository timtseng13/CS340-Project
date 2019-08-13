--insert into song 
LOCK TABLES `Music` WRITE;
INSERT INTO `Music`(`musicName`, `artist`, `musicLength`) VALUES 
(:musicname, :artist,:songlength),
UNLOCK TABLES; 
--insert into Movie 
LOCK TABLES `Movie` WRITE;
INSERT INTO `Movie`(`movieTitle`, `Genre`, `director`,`run_Time`, `musicID`) VALUES 
(:title, :Genre,:director, :runtime, :musicID)
UNLOCK TABLES; 
--insert into tvshow 
LOCK TABLES `TV_show` WRITE;
INSERT INTO `TV_show`(`showTitle`, `Genre`, `producer`,`episode_Count`, `musicID`, `movieID`) VALUES 
(:showtitle, :genre, :producer, :episode_count, :musicID, movieID),
UNLOCK TABLES; 
--insert into videogame 
LOCK TABLES `TV_show` WRITE;
INSERT INTO `TV_show`(`showTitle`, `Genre`, `producer`,`episode_Count`, `musicID`, `movieID`) VALUES 
(:showtitle, :genre, :producer, :episode_count, :musicID, movieID),
UNLOCK TABLES; 