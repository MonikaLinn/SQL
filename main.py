import sqlalchemy
engine = sqlalchemy.create_engine('sqlite:///mydb.db')
con = engine.raw_connection()
cursor = con.cursor()

st = "DROP TABLE IF EXISTS students;"
cursor.execute(st)
con.commit()

st = "DROP TABLE IF EXISTS enrolled;"
cursor.execute(st)
con.commit()

cursor.execute("""CREATE TABLE students (
    ID INTEGER,
    Name TEXT,
    Last_Name TEXT,
    PRIMARY KEY (ID)
);""")

cursor.execute("""INSERT INTO students VALUES(
    1012,
    'John',
    'Smith'
);""")

cursor.execute("""INSERT INTO students VALUES(
    1117,
    'Abe',
    'Claire'
);""")

cursor.execute("""INSERT INTO students VALUES(
    1098,
    'Joe',
    'Dee'
);""")

con.commit()


cursor.execute("""CREATE TABLE enrolled (
    ID INTEGER,
    Enrolled INTEGER,
    PRIMARY KEY (ID)
);""")

cursor.execute("""INSERT INTO enrolled VALUES(
    1012,
    1
);""")

cursor.execute("""INSERT INTO enrolled VALUES(
    1117,
    0
);""")

cursor.execute("""INSERT INTO enrolled VALUES(
    1099,
    1
);""")

con.commit()

for row in cursor.execute("""SELECT * FROM students;"""):print(row)
print("---------------------")
for row in cursor.execute("""SELECT * FROM enrolled;"""):print(row)
print("---------------------")

q = """SELECT students.Name, students.Last_Name, enrolled.enrolled
FROM students 
LEFT JOIN enrolled ON students.ID = enrolled.ID;"""

for row in cursor.execute(q):print(row)
print("---------------------")
con.commit()

f = """SELECT students.Name, students.Last_Name, enrolled.enrolled
FROM students 
INNER JOIN enrolled ON students.ID = enrolled.ID;"""

for row in cursor.execute(f):print(row)

con.commit()

# The results differ by taking out Joe Dee, and the rest is the same. By keeping only the ID's that match we were able
# to weed out the one that didn't have the same ID as the students since enrolled had an extra one which
# didn't have a name assigned.
