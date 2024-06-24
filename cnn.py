import mysql.connector
from prettytable import PrettyTable

cnx = mysql.connector.connect(user='api', password='root', database='csc315final2023')
cursor = cnx.cursor()

#TASK 11
#inserting data into users
query = "INSERT INTO user (ID, name, home_country) VALUES (%s ,%s, %s)"
data = (1556, 'James', 'Canada')
cursor.execute(query, data)
cnx.commit()

query = "INSERT INTO user (ID, name, home_country) VALUES (%s, %s, %s)"
data = (2310, 'Jurgen', 'United States')
cursor.execute(query, data)
cnx.commit()

query = "INSERT INTO user (ID, name, home_country) VALUES (%s, %s, %s)"
data = (3007, 'Mikel', 'Norway')
cursor.execute(query, data)
cnx.commit()

#insert into favorites ( added extra favorite for user 1556 so i can delete it after)
fav_data = [
    (1, 1556, 4),
    (2, 1556, 5),
    (3, 1556, 6),
    (4, 1556, 7),
    (5, 2310, 11),
    (6, 2310, 12),
    (7, 2310, 1),
    (8, 2310, 3),
    (9, 3007, 2),
    (10, 3007, 9),
    (11, 3007, 10),
    (12, 3007, 5),
    (13, 1556, 10)

] 
fav_query = "INSERT INTO favorites (ID, user_id, band_id) VALUES (%s, %s, %s)"
for row in fav_data:
    cursor.execute(fav_query, row)
cnx.commit()


#deleting from favorites
del_query = "DELETE FROM favorites WHERE user_id = %s AND band_id = %s"
del_data = (1556, 10)
cursor.execute(del_query, del_data)
cnx.commit()

#Task 10 - All queries running and working from this backend file.
#TASK 4 - Create a query to determine which sub_genres come from which regions.
query = """
    SELECT DISTINCT sg.sgname AS sub_genre, r.rname AS region
    FROM Sub_Genre sg
    JOIN Genre g ON sg.gname = g.gname
    JOIN Band_Styles bs ON sg.sgname = bs.sgname
    JOIN Band_Origins bo ON bs.bname = bo.bname
    JOIN Country c ON bo.cname = c.cname
    JOIN Region r ON c.rname = r.rname
    ORDER BY sub_genre ASC; 
"""
cursor.execute(query)
results = cursor.fetchall()
column_names = [desc[0] for desc in cursor.description]
for column in column_names:
    print(f"{column:<15}", end="")
print()
for row in results:
    for value in row:
        print(f"{value:<15}", end="")
    print()

#TASK 5 - Create a query to determine what other bands, not currently in their favorites, are of the same sub_genres as those which are(for a specific user)
#results can be shown without the use of prettytable, but i used it because it looks much cleaner. in the example above you see i didnt use it to show i know how to do both.
query = """
    SELECT DISTINCT b.bname
    FROM Bands b
    JOIN Band_Styles bs ON b.bname = bs.bname
    JOIN Sub_Genre sg ON bs.sgname = sg.sgname
    WHERE sg.sgname IN (
        SELECT sg.sgname
        FROM Bands bf
        JOIN Band_Styles bfs ON bf.bname = bfs.bname
        JOIN Sub_Genre sg ON bfs.sgname = sg.sgname
        JOIN Favorites f ON bf.bid = f.band_id
        WHERE f.user_id = %s
    )
    AND b.bid NOT IN (
        SELECT band_id
        FROM Favorites
        WHERE user_id = %s
    );
"""
data = (2310, 2310)
cursor.execute(query, data)
results = cursor.fetchall()
table = PrettyTable(["Band Names, w/ related sub genres"])
table.align["Band Name"] = "l"  
for row in results:
    table.add_row(row)
print(table)

#TASK 6 - Create a query to determine what other bands, not currently in their favorites, are of the same genres as those which are(for A specific user)
query = """
    SELECT DISTINCT b.bname
    FROM Bands b
    JOIN Band_Styles bs ON b.bname = bs.bname
    JOIN Sub_Genre sg ON bs.sgname = sg.sgname
    WHERE sg.gname IN (
        SELECT sg.gname
        FROM Bands bf
        JOIN Band_Styles bfs ON bf.bname = bfs.bname
        JOIN Sub_Genre sg ON bfs.sgname = sg.sgname
        JOIN Favorites f ON bf.bid = f.band_id
        WHERE f.user_id = %s
    )
    AND b.bid NOT IN (
        SELECT band_id
        FROM Favorites
        WHERE user_id = %s
    );
"""
data = (2310, 2310)
cursor.execute(query, data)
results = cursor.fetchall()
table = PrettyTable(["Band Names, w/ related Genres"])
table.align["Band Name"] = "l"  
for row in results:
    table.add_row(row)
print(table)

#TASK 7 - Create a query which finds other users who have the same band in their favorites, and list their other favorite bands. user 2310 doesnt have any matching bands so dont use him, result will be empty
query = """
    SELECT DISTINCT u2.ID AS user_id, u2.name AS user_name, GROUP_CONCAT(DISTINCT b.bname ORDER BY b.bname ASC SEPARATOR ', ') AS similar_favorite_bands, GROUP_CONCAT(DISTINCT b2.bname ORDER BY b2.bname ASC SEPARATOR ', ') AS other_user_favorite_bands
    FROM Favorites f1
    JOIN Favorites f2 ON f1.band_id = f2.band_id AND f1.user_id != f2.user_id
    JOIN User u2 ON f2.user_id = u2.ID
    JOIN Bands b ON f2.band_id = b.bid
    JOIN Favorites f3 ON u2.ID = f3.user_id AND f3.band_id NOT IN (SELECT band_id FROM Favorites WHERE user_id = %s) 
    JOIN Bands b2 ON f3.band_id = b2.bid
    WHERE f1.user_id = %s
    GROUP BY u2.ID, u2.name;
"""
data = (1556, 1556)
cursor.execute(query, data)
results = cursor.fetchall()

table = PrettyTable()
column_names = [desc[0] for desc in cursor.description]
table.field_names = column_names
for row in results:
    table.add_row(row)
print(table)

#TASK 8 - List other countries, excluding the user’s home country, where they could travel to where they could hear the same genres as the bands in their favorites.
query = """
    SELECT DISTINCT c.cname AS country
    FROM User u
    JOIN Favorites f ON u.ID = f.user_id
    JOIN Bands b ON f.band_id = b.bid
    JOIN Band_Origins bo ON b.bname = bo.bname
    JOIN Country c ON bo.cname = c.cname
    JOIN Band_Styles bs ON b.bname = bs.bname
    JOIN Sub_Genre sg ON bs.sgname = sg.sgname
    JOIN Genre g ON sg.gname = g.gname
    WHERE u.ID = %s
    AND u.home_country <> c.cname
    AND sg.sgname IN (
        SELECT DISTINCT sg2.sgname
        FROM Favorites f2
        JOIN Bands b2 ON f2.band_id = b2.bid
        JOIN Band_Styles bs2 ON b2.bname = bs2.bname
        JOIN Sub_Genre sg2 ON bs2.sgname = sg2.sgname
        WHERE f2.user_id = %s
    );
"""
data = (3007, 3007)
cursor.execute(query, data)
results = cursor.fetchall()
table = PrettyTable()
column_names = [desc[0] for desc in cursor.description]
table.field_names = column_names
for row in results:
    table.add_row(row)
print(table)


cursor.close()
cnx.close()