query = """
    SELECT DISTINCT sg.sgname AS sub_genre, r.rname AS region
    FROM Sub_Genre sg
    JOIN Genre g ON sg.gname = g.gname
    JOIN Band_Styles bs ON sg.sgname = bs.sgname
    JOIN Band_Origins bo ON bs.bname = bo.bname
    JOIN Country c ON bo.cname = c.cname
    JOIN Region r ON c.rname = r.rname; 
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