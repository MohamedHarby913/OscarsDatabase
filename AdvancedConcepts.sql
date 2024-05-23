
/*  procedure that inserts a new director, 
to call it, type CALL AddActor("firstName", "lastName", "gender", "YYYY-MM-DD"); */

DROP PROCEDURE IF EXISTS AddDirector;
DELIMITER //

CREATE PROCEDURE AddDirector(
    IN p_firstName VARCHAR(50),
    IN p_lastName VARCHAR(50),
    IN p_gender VARCHAR(10),
    IN p_birthDate DATE
)
BEGIN
	DECLARE nextID INT;
	SELECT MAX(directorID) + 1 FROM Directors INTO nextID;
    INSERT INTO Directors (directorID,firstName, lastName, gender, birthDate)
    VALUES (nextID,p_firstName, p_lastName, p_gender, p_birthDate);
END //

DELIMITER ;



/* This procedure retrieves the total number of nominations for an actor or an actress
to call it, type CALL GetActorNominationCount(actorID, @Result); 
SELCET @Result; */

DROP PROCEDURE IF EXISTS GetActorNominationCount;

DELIMITER //

CREATE PROCEDURE GetActorNominationCount(
    IN p_actorID INT,
    OUT p_nominationCount INT
)
BEGIN
    SELECT COUNT(*) INTO p_nominationCount
    FROM Actor_Nominated
    WHERE actorID = p_actorID;
END //

DELIMITER ;






/*procedure that retrieves all the actors nominated for an Oscar in a specific year
to call it, type CALL GetNomineesByYear(year); */

DROP PROCEDURE IF EXISTS GetNomineesByYear;
DELIMITER //
CREATE PROCEDURE GetNomineesByYear(
    IN p_year INT
)
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE actorID INT;
    DECLARE actorName VARCHAR(255);
    
    
    DECLARE actorCursor CURSOR FOR
        SELECT a.actorID, CONCAT(a.firstName, ' ', a.lastName) AS actorName
        FROM Actors a
        INNER JOIN Actor_Nominated an ON a.actorID = an.actorID
        INNER JOIN Oscars o ON an.oscarsID = o.oscarsID
        WHERE o.year = p_year;
        
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    
    OPEN actorCursor;

    
    actor_loop: LOOP
        FETCH actorCursor INTO actorID, actorName;
        IF done THEN
            LEAVE actor_loop;
        END IF;
        
        
        SELECT actorID, actorName;
    END LOOP;

    
    CLOSE actorCursor;
END //

DELIMITER ;

/* view that retrieves all the actors Oscars winners, 
to call it, example: SELECT * FROM ActorWinners; */
DROP VIEW IF EXISTS ActorWinners;
CREATE VIEW ActorWinners AS
SELECT 
    an.oscarsID AS OscarsID,
    an.actorID AS ActorID,
    CONCAT(a.firstName, ' ', a.lastName) AS ActorName,
    an.movieName AS MovieName
FROM 
    Actor_Nominated an
    INNER JOIN Actors a ON an.actorID = a.actorID
WHERE 
    an.won = 1;

/* view to display the hosts who hosted the Oscars, 
to call it, example: SELECT * FROM HostsOfOscars; */
DROP VIEW IF EXISTS HostsOfOscars;
CREATE VIEW HostsOfOscars AS
SELECT 
    o.oscarsID AS OscarsID,
    h.hostID AS HostID,
    CONCAT(h.firstName, ' ', h.lastName) AS HostName,
    o.year AS OscarsYear
FROM 
    Oscars o
    INNER JOIN Host h ON o.hostID = h.hostID;





/* Trigger that makes sure that won for actors is either 0 or 1 */

DELIMITER //
DROP TRIGGER IF EXISTS ActorNominatedCheckWonTrigger;
CREATE TRIGGER ActorNominatedCheckWonTrigger
BEFORE UPDATE ON Actor_Nominated
FOR EACH ROW
BEGIN
    IF NEW.won NOT IN (0, 1) THEN
        SET NEW.won = OLD.won; 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: The "won" column must be either 0 or 1.';
    END IF;
END //

DELIMITER ;


/* Trigger that makes sure that won for directors is either 0 or 1 */

DELIMITER //
DROP TRIGGER IF EXISTS DirectorNominatedCheckWonTrigger;
CREATE TRIGGER DirectorNominatedCheckWonTrigger
BEFORE UPDATE ON Director_Nominated
FOR EACH ROW
BEGIN
    IF NEW.won NOT IN (0, 1) THEN
        SET NEW.won = OLD.won; 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: The "won" column must be either 0 or 1.';
    END IF;
END //

DELIMITER ;


/* Trigger that makes sure that won for movies is either 0 or 1 */

DELIMITER //
DROP TRIGGER IF EXISTS MoviesNominatedCheckWonTrigger;
CREATE TRIGGER MoviesNominatedCheckWonTrigger
BEFORE UPDATE ON Movie_Nominated
FOR EACH ROW
BEGIN
    IF NEW.won NOT IN (0, 1) THEN
        SET NEW.won = OLD.won; 
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Error: The "won" column must be either 0 or 1.';
    END IF;
END //

DELIMITER ;
