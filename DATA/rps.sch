 
;  SYNERGY DATA LANGUAGE OUTPUT
;
;  REPOSITORY     : rpsmain.ism
;                 : rpstext.ism
;                 : Version 10.3.3a
;
;  GENERATED      : 05-MAY-2017, 14:04:25
;                 : Version 10.3.3c
;  EXPORT OPTIONS : [ALL] 
 
 
Format PHONE   Type NUMERIC   "(XXX) XXX-XXXX"   Justify LEFT
 
Template DEPARTMENT_ID   Type ALPHA   Size 15
   Description "Department ID"
   Prompt "Department ID"
   Uppercase
   Required
   Drill Method "department_drill"   Change Method "department_change"
 
Template DEPARTMENT_NAME   Type ALPHA   Size 50
   Description "Department name"
   Required
 
Template EMPLOYEE_ID   Type DECIMAL   Size 6
   Description "Employee ID"
   Prompt "Employee ID"
   Required
 
Template PERSON_FIRST_NAME   Type ALPHA   Size 20
   Description "First name"
   Prompt "First name"
   Required
 
Template PERSON_LAST_NAME   Type ALPHA   Size 20
   Description "Last name"
   Prompt "Last name"
   Required
 
Template PHONE_NUMBER   Type DECIMAL   Size 10
   Description "Phone Number"
   Prompt "Phone"   Info Line "Enter a telephone number"   Format PHONE
   Report Just LEFT   Input Just LEFT   Blankifzero
 
Structure DEPARTMENT   DBL ISAM
   Description "Department master"
 
Field ID   Template DEPARTMENT_ID
 
Field NAME   Template DEPARTMENT_NAME   Dimension 1
   User Text "@CODEGEN_DISPLAY_FIELD"
 
Field MANAGER   Template EMPLOYEE_ID
   Description "Department manager"
   Prompt "Manager"
 
Key DEPARTMENT_ID   ACCESS   Order ASCENDING   Dups NO
   Description "Department ID"
   Segment FIELD   ID
 
Key MANAGER   ACCESS   Order ASCENDING   Dups YES   Insert END   Modifiable YES
   Krf 001
   Description "Department manager"
   Segment FIELD   MANAGER  SegType ALPHA
 
Structure EMPLOYEE   DBL ISAM
   Description "Employee master"
 
Field ID   Template EMPLOYEE_ID
   Info Line "Enter an employee ID"   ODBC Name EMPLOYEE_ID
 
Field FIRST_NAME   Template PERSON_FIRST_NAME
   Prompt "First name"   Info Line "Enter the employees first name"
   Required
 
Field LAST_NAME   Template PERSON_LAST_NAME
   Info Line "Enter the employees last name"
   User Text "@CODEGEN_DISPLAY_FIELD"   ODBC Name LAST_NAME
 
Field DEPARTMENT   Template DEPARTMENT_ID
   Description "Employee's department ID"
   Info Line "Enter a department ID"   ODBC Name DEPARTMENT_ID   Nodisabled
 
Field HIRE_DATE   Type DATE   Size 8   Stored YYYYMMDD
   Coerced Type NULLABLE_DATETIME
   Description "Date hired"
   Prompt "Hire Date"   Info Line "Enter the employees date of hire"
   ODBC Name HIRE_DATE
   Date Today
 
Field PHONE_WORK   Type ALPHA   Size 14
   Description "Work phone number"
   Prompt "Work phone"
 
Field PHONE_HOME   Type ALPHA   Size 14
   Description "Home phone number"
   Prompt "Home phone"
 
Field PHONE_CELL   Type ALPHA   Size 14
   Description "Cell phone number"
   Prompt "Cell phone"
 
Field PAID   Type DECIMAL   Size 1
   Description "Employee pay method"
   Prompt "Paid"   Info Line "Is the employee paid hourly or salaried"
   Default "1"   Automatic
   Selection List 0 0 0  Entries "Hourly", "Salaried"
   Enumerated 8 1 1
 
Field PHONE_HOME_OK   Type DECIMAL   Size 1
   Description "OK to call at home"
   Prompt "Call home OK"   Info Line "Is it OK to call this employee at home"
   Checkbox
   Default "1"   Automatic
 
Field DATE_OF_BIRTH   Type DATE   Size 8   Stored YYYYMMDD
   Coerced Type NULLABLE_DATETIME
   Description "Date of birth"
   Prompt "Date of birth"   Info Line "Enter the employees date of birth"
 
Field HIRE_TIME   Type TIME   Size 4   Stored HHMM
   Description "Hire time"
   Prompt "Hire time"   Info Line "Enter the time the employee was hired"
   Time Now
 
Field EMAIL   Type ALPHA   Size 40
   Description "Email address"
   Prompt "Email"
 
Field STREET   Type ALPHA   Size 30
   Description "Street address"
   Prompt "Address"   Info Line "What is the employees street address?"
 
Field CITY   Type ALPHA   Size 20
   Description "City"
   Prompt "City"   Info Line "What city does the employee live in?"
 
Field STATE   Type ALPHA   Size 2
   Description "State"
   Prompt "State"   User Text "Which state does the employee live in?"
   Uppercase
 
Field ZIP   Type DECIMAL   Size 5
   Description "Zip code"
   Prompt "Zip code"   Info Line "What is the employees home ZIP code?"
 
Field NONAME_001   Type ALPHA   Size 78   Language Noview   Script Noview
   Report Noview   Nonamelink
   Description "Spare space"
 
Key EMPLOYEE_ID   ACCESS   Order ASCENDING   Dups NO
   Segment FIELD   ID  SegType ALPHA
 
Key DEPARTMENT   ACCESS   Order ASCENDING   Dups YES   Insert END
   Modifiable YES   Krf 001
   Description "Department ID"
   Segment FIELD   DEPARTMENT
 
Key LAST_NAME   ACCESS   Order ASCENDING   Dups YES   Insert END
   Modifiable YES   Krf 002
   Description "Last name"
   Segment FIELD   LAST_NAME  SegType NOCASE  SegOrder ASCENDING
 
Key STATE   ACCESS   Order ASCENDING   Dups YES   Insert END   Modifiable YES
   Krf 003
   Description "State"
   Segment FIELD   STATE  SegType ALPHA  SegOrder ASCENDING
 
Key ZIP   ACCESS   Order ASCENDING   Dups YES   Insert END   Modifiable YES
   Krf 004
   Description "Zip code"
   Segment FIELD   ZIP  SegType ALPHA  SegOrder ASCENDING
 
File DEPARTMENT   DBL ISAM   "DAT:department.ism"
   Description "Department master file"
   Compress
   Assign DEPARTMENT
 
File EMPLOYEE   DBL ISAM   "DAT:employee.ism"
   Description "Employee master file"
   Compress
   Assign EMPLOYEE
 
