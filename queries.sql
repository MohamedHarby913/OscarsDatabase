
/* 1 Select the actor ID and names of the actors that their name starts with an E*/
SELECT actorID, CONCAT(firstName, ' ', lastName) AS Full_Name
FROM Actors
WHERE firstName LIKE 'E%';

/*  2 select all the movie that got released between 2016 and 2018*/

SELECT *
FROM Movies
WHERE year BETWEEN 2015 AND 2017;


/*  3 select the actor with the most nominees  */

SELECT CONCAT(firstName, ' ', lastName) AS Full_Name,
    (SELECT COUNT(*) 
     FROM Actor_Nominated b 
     WHERE b.actorID = a.actorID
    ) AS num_nominations
FROM 
    Actors a
WHERE 
    (SELECT COUNT(*) 
     FROM Actor_Nominated c 
     WHERE c.actorID = a.actorID
    ) >= ALL (
        SELECT COUNT(*) 
        FROM Actor_Nominated 
        GROUP BY actorID
    );


/* 4 select all the directors below the age of 50*/

SELECT 
    DirectorID, 
    CONCAT(firstName, ' ', lastName) AS Full_Name,
    BirthDate, 
    TRUNCATE(DATEDIFF(CURDATE(), BirthDate) / 365, 0) AS Age
FROM 
    Directors
WHERE 
    DATEDIFF(CURDATE(), BirthDate) / 365 < 50
ORDER BY 
    Age;

    
/* 5 select all the actors that have never been nominated for an Oscar*/

SELECT *
FROM Actors
WHERE actorID NOT IN (
    SELECT DISTINCT actorID
    FROM Actor_Nominated
);



/* 6 select the number of male actors and the number of female actresses*/

SELECT 'Male Actors' AS gender, COUNT(*) AS count_actors
FROM Actors
WHERE Gender = 'Male'
UNION
SELECT 'Female Actresses' AS gender, COUNT(*) AS count_actors
FROM Actors
WHERE Gender = 'Female';

/*  7 select all the Oscars winners for leading role and for which movie */
SELECT CONCAT(a.FirstName, ' ', a.LastName) AS Full_Name, an.movieName
FROM Actor_Nominated AS an
NATURAL JOIN Actors AS a
WHERE an.won = 1
AND (an.categoryID = 3 OR an.categoryID = 4);

/*  8 select all the actors that have worked on best picture movies */

SELECT a.firstName, a.lastName, m.MovieName
FROM Actors AS a
INNER JOIN Acts ON a.actorID = Acts.actorID
INNER JOIN Movie_Nominated AS mn ON Acts.movieID = mn.movieID
INNER JOIN Movies AS m ON mn.movieID = m.movieID
WHERE mn.won = 1;

/* 9 select the hosts that have hosted the Oscars more than once */

SELECT CONCAT(h.firstName, ' ', h.lastName) AS Full_Name
FROM Host h
INNER JOIN Oscars o ON h.hostID = o.hostID
GROUP BY h.firstName, h.lastName
HAVING COUNT(*) > 1;


/*  10 select all the directors, the movies they have directed, and put NULL if they have not directed any movies */

SELECT d.directorID, CONCAT(d.firstName, ' ', d.lastName) AS Full_Name, m.movieID, m.movieName
FROM Directors d
LEFT OUTER JOIN Movies m ON m.directorID = d.directorID;

