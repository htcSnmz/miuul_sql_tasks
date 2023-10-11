--Þirketimizde halen çalýþmaya devam eden çalýþanlarýn listesini getiren sorgu hangisidir?
--Not:Ýþten çýkýþ tarihi boþ olanlar çalýþmaya devam eden çalýþanlardýr.
SELECT * FROM PERSON WHERE OUTDATE IS NULL



--Þirketimizde departman bazlý halen çalýþmaya devam eden çalýþan sayýsýný getiren sorguyu yazýnýz?
SELECT
	D.DEPARTMENT,
	COUNT(*) AS NUMBER_OF_PERSON
FROM PERSON P
JOIN DEPARTMENT D
	ON D.ID = P.DEPARTMENTID
WHERE P.OUTDATE IS NULL
GROUP BY D.DEPARTMENT



--Þirketimizde departman bazlý halen çalýþmaya devam KADIN ve ERKEK sayýlarýný getiren sorguyu yazýnýz.
SELECT
	D.DEPARTMENT,
	P.GENDER,
	COUNT(*) AS NUMBER_OF_PERSON
FROM PERSON P
JOIN DEPARTMENT D
	ON D.ID = P.DEPARTMENTID
WHERE P.OUTDATE IS NULL
GROUP BY D.DEPARTMENT, P.GENDER



--Þirketimizin Planlama departmanýna yeni bir þef atamasý yapýldý ve maaþýný belirlemek istiyoruz.
--Planlama departmaný için minimum,maximum ve ortalama þef maaþý getiren sorgu hangisidir?
--(Not:iþten çýkmýþ olan personel maaþlarý da dahildir.)
SELECT
	POS.POSITION,
	MIN(P.SALARY) AS MIN_SALARY,
	MAX(P.SALARY) AS MAX_SALARY,
	ROUND(AVG(P.SALARY),2) AS AVG_SALARY
FROM POSITION POS
JOIN PERSON P
	ON P.POSITIONID=POS.ID
WHERE POS.POSITION = 'PLANLAMA ÞEFÝ'
GROUP BY POS.POSITION



--Her bir pozisyonda mevcut halde çalýþanlar olarak kaç kiþi ve ortalama maaþlarýnýn ne kadar olduðunu listeleyin.
SELECT
	POS.POSITION,
	COUNT(*) NUMBER_OF_PERSON,
	AVG(P.SALARY) AVG_SALARY
FROM PERSON P
JOIN POSITION POS
	ON POS.ID = P.POSITIONID
WHERE P.OUTDATE IS NULL
GROUP BY POS.POSITION



--Yýllara göre iþe alýnan personel sayýsýný kadýn ve erkek bazýnda listelettiren sorguyu yazýnýz.
SELECT
	YEAR(INDATE) YEAR_,
	GENDER,
	COUNT(*) NUMBER_OF_PERSON_HIRING
FROM PERSON
GROUP BY YEAR(INDATE), GENDER


SELECT DISTINCT YEAR(P.INDATE) YEAR_,
(SELECT COUNT(*) FROM PERSON WHERE GENDER = 'E' AND YEAR(INDATE)=YEAR(P.INDATE)) AS MALE_PERSONCOUNT,
(SELECT COUNT(*) FROM PERSON WHERE GENDER = 'K' AND YEAR(INDATE)=YEAR(P.INDATE)) AS FEMALE_PERSONCOUNT
FROM PERSON P
ORDER BY 1



--Maaþ ortalamasý 5.500 TL’den fazla olan departmanlarý listeleyecek sorguyu yazýnýz.
SELECT
	D.DEPARTMENT,
	AVG(P.SALARY) SALARY
FROM PERSON P
JOIN DEPARTMENT D
	ON D.ID = P.DEPARTMENTID
GROUP BY D.DEPARTMENT
HAVING AVG(P.SALARY) > 5500
ORDER BY 2 DESC


SELECT *,
ROUND((SELECT AVG(SALARY) FROM PERSON WHERE DEPARTMENTID = D.ID),0) AS AVGSALARY FROM DEPARTMENT D
WHERE (SELECT AVG(SALARY) FROM PERSON WHERE DEPARTMENTID = D.ID) > 5500



--Her personelin adýný, soyadýný,departmanýný ve pozisyonunu getiren sorguyu yazýnýz.
SELECT
	P.NAME, P.SURNAME,
	D.DEPARTMENT,
	POS.POSITION
FROM PERSON P
JOIN DEPARTMENT D
	ON D.ID = P.DEPARTMENTID
JOIN POSITION POS
	ON POS.ID = P.POSITIONID



--Departmanlarýn ortalama kýdemini ay olarak hesaplayacak sorguyu yazýnýz.
SELECT DEPARTMENT,AVG(WORKINGTIME)
FROM
(
SELECT D.DEPARTMENT,
CASE
	WHEN OUTDATE IS NOT NULL THEN DATEDIFF(MONTH,INDATE,OUTDATE)
	ELSE DATEDIFF(MONTH,INDATE,GETDATE()) END AS WORKINGTIME
FROM PERSON P
INNER JOIN DEPARTMENT D ON D.ID=P.DEPARTMENTID
) T 
GROUP BY DEPARTMENT
ORDER BY 1




	



