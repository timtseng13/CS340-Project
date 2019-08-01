---create a new user 
LOCK TABLES `user_info` WRITE;
INSERT INTO `user_info`(`userName`, `joinDate`, `Male/Female`, `Age`) VALUES 
(:username, :joindate , :gender, :age),
UNLOCK TABLES; 

--post a picture 
	LOCK TABLES `picture` WRITE;
	
	INSERT INTO `picture` (`postID`, `category`, `url`) VALUES
	(:postID, :category, :url);

	UNLOCK TABLES;
--post a video 	
	LOCK TABLES `video` WRITE; 
	INSERT INTO `video` (`postID`, `category`) VALUES
		(:ID, :category);
	UNLOCK TABLES; 

--search for a post by title 
	SELECT * FROM post 
	WHERE title = :postsearch;
--search for a posts by user
	SELECT * FROM post 
	WHERE userID = :ID;
--search for only video 
	SELECT * FROM post 
	
	
	
--comment on a post 
	LOCK TABLES `comment` WRITE; 
	INSERT INTO `comments` (`userID`, `postID`, `text`, `com_date`) VALUES 
		(:userID, :postID, :text, :com_date);
	UNLOCK TABLES; 
	
--like a comment 
	LOCK TABLES `likes` WRITE; 
	INSERT INTO `likes` (`cID`, `userID`) VALUES 
		(:commentID, userID);
	UPDATE comments
	SET comments.likes = comments.likes +1
	WHERE cID = :commentID; 
	UNLOCK TABLES;
--retrive a post 
	SELECT * FROM post
	WHERE post.postID = :pID 
	INNER JOIN picture ON pictures.postID = post.postID
	INNER JOIN video ON video.postID = post.postID 
	INNER JOIN comments ON comments.postID = post.postID 
--create a post 
	LOCK TABLES `post`, `user_info` WRITE; 
	INSERT INTO `post` (`userID, `title`, `post_date`) VALUES
		(:userID, :title, :post_date); 
	
	UPDATE user_info
	SET postCount = postCount +1,
	WHERE user_info.ID = :ID;
	UNLOCK TABLES; 
	
--report a comment 
	LOCK TABLES `comments` WRITE; 
	UPDATE comments
	SET 	comments.reports = comments.reports +1
	WHERE comments.cID = :cID;
	UNLOCK TABLES;
--report a user 
	LOCK TABLES `user_info` WRITE; 
	UPDATE 	user_info
	SET 	user_info.numberofRep = user_info.numberofRep +1
	WHERE user_info.ID = :ID 
	UNLOCK TABLES; 
--change to premium status
	LOCK TABLES `user_info` WRITE; 
	UPDATE 	user_info
	SET 	user_info.Premium = :isPremium 
	WHERE user_info.ID = :ID 
	UNLOCK TABLES; 
--
	
	