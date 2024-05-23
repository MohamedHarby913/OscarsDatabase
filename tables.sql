/* Drop tables if they exist */

DROP TABLE IF EXISTS Actor_Nominated;

DROP TABLE IF EXISTS Director_Nominated;

DROP TABLE IF EXISTS Movie_Nominated;

DROP TABLE IF EXISTS Acts;

DROP TABLE IF EXISTS Actors;

DROP TABLE IF EXISTS Directors;

DROP TABLE IF EXISTS Movies;

DROP TABLE IF EXISTS Presents;

DROP TABLE IF EXISTS AwardsCategory;

DROP TABLE IF EXISTS Oscars;

DROP TABLE IF EXISTS Host;

 

/* Create Host table, this will contain all the data regarding hosts*/

CREATE TABLE Host (

    hostID INT PRIMARY KEY,

    firstName VARCHAR(50),

    lastName VARCHAR(50),

    gender VARCHAR(10),

    birthDate DATE

);

 
/* Create Oscars table,  this will contain data about the Oscars */

CREATE TABLE Oscars (

    oscarsID INT PRIMARY KEY,

    year INT,

    hostID INT,

    FOREIGN KEY (hostID) REFERENCES Host(hostID) ON DELETE SET NULL ON UPDATE CASCADE

);

 

/* Create AwardsCategory table, this will contain data about the different awards */

CREATE TABLE AwardsCategory (

    categoryID INT PRIMARY KEY,

    categoryName VARCHAR(100)

);

 

/* Create Presents table, this will contain data regarding the Oscars presenting different awards */

CREATE TABLE Presents (

    oscarID INT,

    categoryID INT,

    PRIMARY KEY (oscarID, categoryID),

    FOREIGN KEY (oscarID) REFERENCES Oscars(oscarsID) ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (categoryID) REFERENCES AwardsCategory(categoryID) ON DELETE RESTRICT ON UPDATE CASCADE

);

 

/* Create Actors table, this will contain data about the actors */

CREATE TABLE Actors (

    actorID INT PRIMARY KEY,

    firstName VARCHAR(50),

    lastName VARCHAR(50),

    gender VARCHAR(10),

    birthdate DATE

);

 

/* Create Directors table, this will contain data about the directors  */

CREATE TABLE Directors (

    directorID INT PRIMARY KEY,

    firstName VARCHAR(50),

    lastName VARCHAR(50),

    gender VARCHAR(10),

    birthdate DATE

);

 

/* Create Movies table, this will contain data about the movies */

CREATE TABLE Movies (

    movieID INT PRIMARY KEY,

    movieName VARCHAR(100),

    year INT,

    genre VARCHAR(50),

    directorID INT,

    FOREIGN KEY (directorID) REFERENCES Directors(directorID) ON DELETE SET NULL ON UPDATE CASCADE

);

 

/* Create Acts table, this will contain data about movies and their actors */

CREATE TABLE Acts (

    movieID INT,

    actorID INT,
    
    role VARCHAR(100),

    PRIMARY KEY (movieID, actorID),

    FOREIGN KEY (movieID) REFERENCES Movies(movieID) ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (actorID) REFERENCES Actors(actorID) ON DELETE RESTRICT ON UPDATE CASCADE

);

 

/* Create Actor_Nominated table, this will contain the nominees for best actor for leading and supporting role, best actress for leading and supporting role */

CREATE TABLE Actor_Nominated (

    oscarsID INT,

    actorID INT,

    categoryID INT,

    movieName VARCHAR(100) NOT NULL,

    won INT NOT NULL,

    PRIMARY KEY (oscarsID, actorID, categoryID),

    FOREIGN KEY (oscarsID) REFERENCES Oscars(oscarsID) ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (actorID) REFERENCES Actors(actorID) ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (categoryID) REFERENCES AwardsCategory(categoryID) ON DELETE RESTRICT ON UPDATE CASCADE

);

 

/* Create Director_Nominated table, this will contain the nominees for best director */

CREATE TABLE Director_Nominated (

    oscarsID INT,

    directorID INT,

    categoryID INT,

    movieName VARCHAR(100) NOT NULL,

    won INT NOT NULL,

    PRIMARY KEY (oscarsID, directorID, categoryID),

    FOREIGN KEY (oscarsID) REFERENCES Oscars(oscarsID) ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (directorID) REFERENCES Directors(directorID) ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (categoryID) REFERENCES AwardsCategory(categoryID) ON DELETE RESTRICT ON UPDATE CASCADE

);

 

/* Create Movie_Nominated table, this will contain the nominees for best movie */

CREATE TABLE Movie_Nominated (

    movieID INT,

    categoryID INT,
    
    movieName VARCHAR(100) NOT NULL,

    won INT NOT NULL,

    PRIMARY KEY (movieID, categoryID),

    FOREIGN KEY (movieID) REFERENCES Movies(movieID) ON DELETE RESTRICT ON UPDATE CASCADE,

    FOREIGN KEY (categoryID) REFERENCES AwardsCategory(categoryID) ON DELETE RESTRICT ON UPDATE CASCADE

);
