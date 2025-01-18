SELECT ROUND(AVG(Salary))-ROUND(AVG(REPLACE(Salary,0,'')))
FROM EMPLOYEES


# Here, we are replacing the Zeros with Null value to find out the Misalculated amount.