
import psycopg2, sys, datetime

# usage()
# Print error messages to stderr
def usage():
    print("Usage:  python3 runElectionsApplication.py userid pwd", file=sys.stderr)
    sys.exit(-1)
# end usage

def countNumberOfPatients (myConn, theDentistID):
    if theDentistID is None:
        return -1 
    try:
        myCursor = myConn.cursor()
        dentist_Check = "SELECT COUNT(*) FROM Dentists WHERE dentistID = %s"
        myCursor.execute(dentist_Check, (theDentistID,))
        dentist_Exist = myCursor.fetchone()[0]

        if dentist_Exist == 0:
            return -1

        psg = "SELECT COUNT(DISTINCT patientID) FROM Visits WHERE dentistID = %s"
        myCursor.execute(psg, (theDentistID,))
        patientCount = myCursor.fetchone()[0]
        return patientCount

    except:
        print("Error in countNumberOfPatients with parameter", theDentistID, file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)

    myCursor.close()
    return 0

def emphasizeToothSide (myConn, toothSide):
    if toothSide is None or toothSide not in ["L", "R"]: 
        return -1
    try:
        myCursor = myConn.cursor()
        if toothSide == 'L':
            update_query = "UPDATE Teeth SET toothName = 'Left ' || toothName WHERE quadrant IN ('TL', 'BL') "
        elif toothSide == 'R':
            update_query = "UPDATE Teeth SET toothName = 'Right ' || toothName WHERE quadrant IN ('TR', 'BR') "
        myCursor.execute(update_query)
        rows_updated = myCursor.rowcount
        
    except Exception as e:
        print("Error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    myCursor.close()
    return rows_updated

def cancelSomeVisits (myConn, maxVisitCancellations):
        
    try:
        myCursor = myConn.cursor()
        sql = "SELECT cancelSomeVisitsFunction(%s)"
        myCursor.execute(sql, (maxVisitCancellations, ))
    except:
        print("Call of cancelSomeVisitsFunction with argument", maxVisitCancellations, "had error", file=sys.stderr)
        myCursor.close()
        myConn.close()
        sys.exit(-1)
    
    row = myCursor.fetchone()
    myCursor.close()
    return(row[0])

#end cancelSomeVisits


def main():

    if len(sys.argv)!=3:
       usage()

    hostname = "cse182-db.lt.ucsc.edu"
    userID = sys.argv[1]
    pwd = sys.argv[2]

    # Try to make a connection to the database
    try:
        myConn = psycopg2.connect(host=hostname, user=userID, password=pwd)
    except:
        print("Connection to database failed", file=sys.stderr)
        sys.exit(-1)
        
    myConn.autocommit = True
    
    test1 = countNumberOfPatients(myConn, 11)
    if test1 >= 0:
        print("Number of patients for dentist 11 is", test1, "patients")
        print()
    elif test1 < 0: # when return negative, print out the values of its parameters, with a message explaining the error that occurred
        print("Dentist with ID" , 11, "does not exist.")
        print()
        
    test2 = countNumberOfPatients(myConn, 17)
    if test2 >= 0:
        print("Number of patients for dentist 17 is", test2, "patients")
        print()
    elif test2 < 0: # when return negative, print out the values of its parameters, with a message explaining the error that occurred
        print("Dentist with ID" , 17, "does not exist.")
        print()

    test3 = countNumberOfPatients(myConn, 44)
    if test3 >= 0:
        print("Number of patients for dentist 44 is", test3, "patients")
        print()
    elif test3 < 0: # when return negative, print out the values of its parameters, with a message explaining the error that occurred
        print("Dentist with ID" , 44, "does not exist.")
        print()

    test4 = countNumberOfPatients(myConn, 66)
    if test4 >= 0:
        print("Number of patients for dentist 66 is", test4, "patients")
        print()
    elif test4 < 0: # when return negative, print out the values of its parameters, with a message explaining the error that occurred
        print("Dentist with ID" , 66, "does not exist.")
        print()
    
    update1 = emphasizeToothSide(myConn, 'R')
    if update1 < 0: # when return negative, print out the values of its parameters, with a message explaining the error that occurred
        print("Error from emphasizeToothSide with the parameter value of R due to a negative output.")
        print()
    else:
        print("Number of teeth whoose toothName values for R were updated by emphasizeToothSide is ", update1)
        print()

    update2 = emphasizeToothSide(myConn, 'L')
    if update2 < 0: # when return negative, print out the values of its parameters, with a message explaining the error that occurred
        print("Error from emphasizeToothSide with the parameter value of L due to a negative output.")
        print()
    else:
        print("Number of teeth whose toothName values for L were updated by emphasizeToothSide is ", update2)
        print()

    update3 = emphasizeToothSide(myConn, 'C')
    if update3 < 0: # when return negative, print out the values of its parameters, with a message explaining the error that occurred
        print("Tooth side can only be L or R")
        print()
    else:
        print("Number of teeth whose toothName values for C were updated by emphasizeToothSide is ", update3)
        print()

    test_one = cancelSomeVisits(myConn, 2)
    if test_one >= 0:
        print("Number of visits which were cancelled for maxVisitCancellations value 2 is ", test_one)
        print()
    else: 
        print("Error from cancelSomeVisits with the parameter value of 2 due to a negative output.")
        print()

    test_two = cancelSomeVisits(myConn, 4)
    if test_two >= 0:
        print("Number of visits which were cancelled for maxVisitCancellations value 4 is ", test_two)
        print()
    else: 
        print("Error from cancelSomeVisits with the parameter value of 4 due to a negative output.")
        print()

    test_three = cancelSomeVisits(myConn, 3)
    if test_three >= 0:
        print("Number of visits which were cancelled for maxVisitCancellations value 3 is ", test_three)
        print()
    else: 
        print("Error from cancelSomeVisits with the parameter value of 3 due to a negative output.")
        print()

    test_four = cancelSomeVisits(myConn, 1)
    if test_four >= 0:
        print("Number of visits which were cancelled for maxVisitCancellations value 1 is ", test_four)
        print()
    else: 
        print("Error from cancelSomeVisits with the parameter value of 1 due to a negative output.")
        print()

    myConn.close()
    sys.exit(0)
#end

#------------------------------------------------------------------------------
if __name__=='__main__':

    main()

# end
