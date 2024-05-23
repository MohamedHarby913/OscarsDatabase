import mysql.connector

# Establish connection
conn = mysql.connector.connect(user='me', password='myUserPassword', database='Oscars_21445116')
cursor1 = conn.cursor()

# Define the first query and data
# Print a newline for spacing between queries
print()
print("First Query")
query1 = ("SELECT actorID, CONCAT(firstName, ' ', lastName) AS Full_Name FROM Actors WHERE firstName LIKE %s")
data1 = ('E%',)
# Execute the first query
cursor1.execute(query1, data1)
# Fetch the results
result1 = cursor1.fetchall()
for row in result1:
    print(row)

# Close the first cursor
cursor1.close()

# Create a new cursor for the second query
cursor2 = conn.cursor()

# Define the second query and data
print()
print("Second Query")
query2 = ("SELECT * FROM Movies WHERE year BETWEEN %s AND %s")
data2 = (2015, 2017)
# Execute the second query
cursor2.execute(query2, data2)
# Fetch the results
result2 = cursor2.fetchall()
for row in result2:
    print(row)

# Close the second cursor and connection
cursor2.close()




cursor3 = conn.cursor()
# Define the third query and data
print()
print("Third Query")
query3 = ("""SELECT CONCAT(firstName, ' ', lastName) AS Full_Name,
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
    )
""")

# Execute the third query
cursor3.execute(query3)
# Fetch the results
result3 = cursor3.fetchall()
for row in result3:
    print(row)

# Close the third cursor and connection
cursor3.close()




cursor4 = conn.cursor()

# Define the fourth query and data
print()
print("Fourth Query")
query4 = ("""SELECT 
    DirectorID, 
    CONCAT(firstName, ' ', lastName) AS Full_Name,
    BirthDate, 
    TRUNCATE(DATEDIFF(CURDATE(), BirthDate) / %s,%s) AS Age
    FROM 
    Directors
    WHERE 
    DATEDIFF(CURDATE(), BirthDate) / %s < %s
    ORDER BY 
    Age""")
    
data4 = (365, 0, 365, 50)
# Execute the fourth query
cursor4.execute(query4, data4)
# Fetch the results
result4 = cursor4.fetchall()
for row in result4:
    print(row)

# Close the fourth cursor and connection
cursor4.close()



cursor5 = conn.cursor()

# Define the fifth query and data
print()
print("Fifth Query")
query5 = ("""SELECT *
FROM Actors
    WHERE actorID NOT IN (
    SELECT DISTINCT actorID
    FROM Actor_Nominated
)""")
# Execute the fifth query
cursor5.execute(query5)
# Fetch the results
result5 = cursor5.fetchall()
for row in result5:
    print(row)

# Close the fifth cursor and connection
cursor5.close()




cursor6 = conn.cursor()
# Define the sixth query and data
print()
print("Sixth Query")
query6 = ("""SELECT %s AS gender, COUNT(*) AS count_actors
    FROM Actors
    WHERE Gender = %s
    UNION
    SELECT %s AS gender, COUNT(*) AS count_actors
    FROM Actors
    WHERE Gender = %s""")

data6 = ('Male Actors','Male', 'Female Actresses','Female')
# Execute the sixth query
cursor6.execute(query6, data6)
# Fetch the results
result6 = cursor6.fetchall()
for row in result6:
    print(row)

# Close the sixth cursor and connection
cursor6.close()





cursor7 = conn.cursor()
# Define the seventh query and data
print()
print("Seventh Query")
query7 = ("""SELECT CONCAT(a.FirstName, ' ', a.LastName) AS Full_Name, an.movieName
    FROM Actor_Nominated AS an
    NATURAL JOIN Actors AS a
    WHERE an.won = %s
    AND (an.categoryID = %s OR an.categoryID = %s)""")

data7 = (1,3, 4)
# Execute the seventh query
cursor7.execute(query7, data7)
# Fetch the results
result7 = cursor7.fetchall()
for row in result7:
    print(row)

# Close the seventh cursor and connection
cursor7.close()






cursor8 = conn.cursor()
# Define the eighth query and data
print()
print("Eighth Query")
query8 = ("""SELECT a.firstName, a.lastName, m.MovieName
    FROM Actors AS a
    INNER JOIN Acts ON a.actorID = Acts.actorID
    INNER JOIN Movie_Nominated AS mn ON Acts.movieID = mn.movieID
    INNER JOIN Movies AS m ON mn.movieID = m.movieID
    WHERE mn.won = %s """)

data8 = (1,)
# Execute the eighth query
cursor8.execute(query8, data8)
# Fetch the results
result8 = cursor8.fetchall()
for row in result8:
    print(row)

# Close the eighth cursor and connection
cursor8.close()



cursor9 = conn.cursor()
# Define the ninth query and data
print()
print("Ninth Query")
query9 = ("""SELECT CONCAT(h.firstName, ' ', h.lastName) AS Full_Name
    FROM Host h
    INNER JOIN Oscars o ON h.hostID = o.hostID
    GROUP BY h.firstName, h.lastName
    HAVING COUNT(*) > %s """)

data9 = (1,)
# Execute the ninth query
cursor9.execute(query9, data9)
# Fetch the results
result9 = cursor9.fetchall()
for row in result9:
    print(row)

# Close the ninth cursor and connection
cursor9.close()




cursor10 = conn.cursor()
# Define the tenth query and data
print()
print("Tenth Query")
query10 = ("""SELECT d.directorID, CONCAT(d.firstName, ' ', d.lastName) AS Full_Name, m.movieID, m.movieName
    FROM Directors d
    LEFT OUTER JOIN Movies m ON m.directorID = d.directorID;""")

# Execute the tenth query
cursor10.execute(query10)
# Fetch the results
result10 = cursor10.fetchall()
for row in result10:
    print(row)

# Close the tenth cursor and connection
cursor10.close()





conn.close()
