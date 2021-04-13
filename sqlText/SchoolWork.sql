#1.
SELECT student.StudentId,student.StudentName,DeptrmentType
FROM student,deptmentindex
WHERE StudentDeptmentId = deptmentindex.DeptmentId
GROUP BY student.StudentId;
#2.
SELECT count(StudentId)
FROM student
WHERE StudentSex = 0;
#3.
SELECT count(StudentId)
FROM student
WHERE StudentSex = 0 AND StudentId>=2 AND StudentId<=10;
#4.
SELECT StudentSex,count(StudentId)
FROM student
GROUP BY StudentSex;
#5.
SELECT StudentSex,count(StudentId)
FROM student
WHERE StudentDeptmentId = (
    SELECT deptmentindex.DeptmentId
    FROM deptmentindex
    WHERE DeptrmentType = 'CS'
    )
GROUP BY StudentSex;
#6.
SELECT StudentId,StudentName,DeptrmentType
FROM student,deptmentindex
WHERE StudentDeptmentId=StudentDeptmentId AND StudentSex = 1 AND StudentAge >= 18 AND StudentAge <= 20;
#7.
SELECT student.StudentId,student.StudentName,COUNT(classofferindex.StudentId)
FROM student,classofferindex
WHERE classofferindex.StudentId = student.StudentId
GROUP BY classofferindex.StudentId;
#8.
SELECT StudentId,StudentName
FROM student
WHERE StudentId IN (
    SELECT StudentId
    FROM classofferindex
    WHERE Grade > 80 AND ClassId IN (
        SELECT ClassId
        FROM class
        WHERE ClassName = 'English'
        )
    );
#9.
SELECT StudentId,StudentDeptmentId
FROM student
WHERE StudentId IN (
    SELECT StudentId
    FROM classofferindex
    WHERE ClassId IN (
        SELECT ClassId
        FROM class
        WHERE ClassName != 'Physics'
        )
    );
#10.
SELECT COUNT(classofferindex.StudentId)
FROM classofferindex
WHERE classofferindex.StudentId IN (
    SELECT StudentId
    FROM student
    WHERE StudentName = 'Wang_Ming'
    )
GROUP BY classofferindex.StudentId;
#11.
SELECT AVG(Grade)
FROM classofferindex
WHERE StudentId IN (
    SELECT StudentId
    FROM student
    WHERE StudentName = 'Wang_Ming'
    );
#12.
SELECT COUNT(StudentId)
FROM classofferindex
WHERE Grade > EXISTS(
    SELECT AVG(Grade)
    FROM classofferindex
    WHERE ClassId IN (
        SELECT ClassId
        FROM class
        WHERE ClassName = 'English'
        )
    );
#13.Review
SELECT StudentId,StudentName
FROM student
WHERE StudentId IN (
    SELECT StudentId
    FROM classofferindex
    WHERE ClassId = EXISTS (
        SELECT ClassId
        FROM class
        WHERE ClassMangeTeacher = 'Wang_One' AND ClassMangeTeacher = 'Wang_Two'
        ));
#14.
SELECT StudentName,StudentDeptmentId
FROM student
WHERE StudentAge < (SELECT MIN(StudentAge IN (
    SELECT StudentAge
    FROM student
    WHERE StudentDeptmentId = (
    SELECT DeptmentId
        FROM deptmentindex
        WHERE DeptrmentType = 'MA'
    )))) AND StudentDeptmentId = (
    SELECT DeptmentId
        FROM deptmentindex
        WHERE DeptrmentType = 'CS'
    )
GROUP BY StudentName;
#15.
SELECT StudentId,sum(Grade)
FROM classofferindex
GROUP BY StudentId
ORDER BY sum(Grade) DESC ;
#16.
SELECT StudentId,StudentName,StudentAge
FROM student
WHERE StudentId > (
    SELECT StudentId
    FROM student
    WHERE StudentName = 'Wang_One'
    ) AND StudentAge < (
        SELECT StudentAge
        FROM student
        WHERE StudentName = 'Wang_One'
    );
#17.
SELECT StudentName,StudentAge
FROM student
WHERE StudentSex = 1 AND StudentAge < (
    SELECT AVG(StudentAge)
    FROM student
    WHERE StudentSex = 0
    );
#18.
SELECT student.StudentId,student.StudentName
FROM student , classofferindex
WHERE student.StudentId = classofferindex.StudentId
GROUP BY student.StudentId, student.StudentName
HAVING count(ClassId) = 1;
#19.
SELECT StudentId,StudentName,DeptrmentType
FROM student,deptmentindex
WHERE StudentDeptmentId = DeptmentId
  AND StudentId IN (
      SELECT StudentId
      FROM classofferindex
      WHERE ClassId IN (
          SELECT ClassId
          FROM class
          WHERE ClassMangeTeacher != 'Wang_One'
          ));

#20.
SELECT student.StudentId,student.StudentName
FROM student , classofferindex
WHERE student.StudentId = classofferindex.StudentId
GROUP BY student.StudentId, student.StudentName
HAVING count(ClassId) >= 3;
#21.
SELECT ClassId,MAX(Grade),MIN(Grade)
FROM classofferindex
GROUP BY ClassId;
#22.
CREATE VIEW gdf（cno，max，min）
AS
    SELECT ClassId,MAX(Grade),MIN(Grade)
    FROM classofferindex
    GROUP BY ClassId;
#2.1
UPDATE student
SET StudentAge = StudentAge+1;
#2.2
UPDATE classofferindex
SET Grade = 0
WHERE ClassId IN (
    SELECT ClassId
    FROM class
    WHERE ClassName = 'Physics'
    ) AND Grade < 60;
#2.3
DELETE
FROM classofferindex
WHERE ClassId IN (
    SELECT ClassId
    FROM class
    WHERE ClassMangeTeacher = 'Wang_WU'
    );
DELETE
FROM class
WHERE ClassMangeTeacher = 'Wang_WU';
#2.4
CREATE TABLE stu
(
	sno int NOT NULL ,
	sname longtext NOT NULL ,
	dept int NULL ,
	CONSTRAINT stu_pk
		PRIMARY KEY (sno),
	CONSTRAINT stu___sno
		FOREIGN KEY (sno, sname, dept) REFERENCES student (StudentId, StudentName, StudentDeptmentId)
);
INSERT INTO stu(sno, sname, dept)
SELECT StudentId,StudentName,StudentDeptmentId
FROM student
WHERE StudentId IN (
    SELECT StudentId
    FROM classofferindex
    WHERE Grade > 80
    );

