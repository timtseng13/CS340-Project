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

--using the select search on movie, will be able to used on any of the catagories 
SELECT * FROM Movie 
WHERE Movie.movieTitle = :userinput; 

--delete a music 
LOCK TABLES `Music` WRITE; 
DELETE FROM `Music` WHERE Music.musicID = :buttnouserid

--update an entry, there will be an update button next to each enteity on the website when pressed, will allow you to change them. 
UPDATE movie 
SET movieTitle = :user_input, Genre = :user_input 
WHERE Movie.movieID = :movieID
