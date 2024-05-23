import mysql.connector

# Establish connection
conn = mysql.connector.connect(user='me', password='myUserPassword', database='Oscars_21445116')

cursor = conn.cursor()

print("Enter the Director ID you want to update their birth Date:")
DirectorID = input()
print("Enter the updated birth date (YYYY-MM-DD):")
BirthDate = input()

# Define the UPDATE query
query = "UPDATE Directors SET BirthDate = %s WHERE DirectorID = %s"
data = (BirthDate, DirectorID)

# Execute the UPDATE query
cursor.execute(query, data)
conn.commit()

# Fetch and print the newly updated director information
query_result = "SELECT * FROM Directors WHERE DirectorID = %s"
data_result = (DirectorID,)
cursor.execute(query_result, data_result)
director_info = cursor.fetchone()
print("Newly updated director birth date:")
print(director_info)

# Close cursor and connection
cursor.close()
conn.close()


