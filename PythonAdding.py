import mysql.connector

# Establish connection
conn = mysql.connector.connect(user='me', password='myUserPassword', database='Oscars_21445116')

cursorTemp = conn.cursor()
tempQuery = "SELECT MAX(actorID) + 1 FROM Actors"
cursorTemp.execute(tempQuery)
result = cursorTemp.fetchone()[0]  # Fetch the result
cursorTemp.close()

cursor = conn.cursor()

# Prompt user for actor details
print("Adding Query")
print("Enter the first name of the actor:")
firstName = input()
print("Enter the last name of the actor:")
lastName = input()
print("Enter the gender of the actor:")
gender = input()
print("Enter the birth date of the actor (YYYY-MM-DD):")
birthDate = input()

# Define the query to insert actor
query = "INSERT INTO Actors (actorID, firstName, lastName, gender, birthDate) VALUES (%s, %s, %s, %s, %s)"
data = (result, firstName, lastName, gender, birthDate)

# Execute the insert query
cursor.execute(query, data)
conn.commit()

# Fetch the newly inserted actor's information
query_result = "SELECT * FROM Actors WHERE actorID = %s"
data_result = (result,)
cursor.execute(query_result, data_result)
actor_info = cursor.fetchone()
print("Newly added actor details:")
print(actor_info)

# Close the cursor and connection
cursor.close()
conn.close()

