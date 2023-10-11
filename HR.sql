--�irketimizde halen �al��maya devam eden �al��anlar�n listesini getiren sorgu hangisidir?
--Not:��ten ��k�� tarihi bo� olanlar �al��maya devam eden �al��anlard�r.
SELECT * FROM PERSON WHERE OUTDATE IS NULL



--�irketimizde departman bazl� halen �al��maya devam eden �al��an say�s�n� getiren sorguyu yaz�n�z?
SELECT
	D.DEPARTMENT,
	COUNT(*) AS NUMBER_OF_PERSON
FROM PERSON P
JOIN DEPARTMENT D
	ON D.ID = P.DEPARTMENTID
WHERE P.OUTDATE IS NULL
GROUP BY D.DEPARTMENT



--�irketimizde departman bazl� halen �al��maya devam KADIN ve ERKEK say�lar�n� getiren sorguyu yaz�n�z.
SELECT
	D.DEPARTMENT,
	P.GENDER,
	COUNT(*) AS NUMBER_OF_PERSON
FROM PERSON P
JOIN DEPARTMENT D
	ON D.ID = P.DEPARTMENTID
WHERE P.OUTDATE IS NULL
GROUP BY D.DEPARTMENT, P.GENDER



--�irketimizin Planlama departman�na yeni bir �ef atamas� yap�ld� ve maa��n� belirlemek istiyoruz.
--Planlama departman� i�in minimum,maximum ve ortalama �ef maa�� getiren sorgu hangisidir?
--(Not:i�ten ��km�� olan personel maa�lar� da dahildir.)
SELECT
	POS.POSITION,
	MIN(P.SALARY) AS MIN_SALARY,
	MAX(P.SALARY) AS MAX_SALARY,
	ROUND(AVG(P.SALARY),2) AS AVG_SALARY
FROM POSITION POS
JOIN PERSON P
	ON P.POSITIONID=POS.ID
WHERE POS.POSITION = 'PLANLAMA �EF�'
GROUP BY POS.POSITION



--Her bir pozisyonda mevcut halde �al��anlar olarak ka� ki�i ve ortalama maa�lar�n�n ne kadar oldu�unu listeleyin.
SELECT
	POS.POSITION,
	COUNT(*) NUMBER_OF_PERSON,
	AVG(P.SALARY) AVG_SALARY
FROM PERSON P
JOIN POSITION POS
	ON POS.ID = P.POSITIONID
WHERE P.OUTDATE IS NULL
GROUP BY POS.POSITION



--Y�llara g�re i�e al�nan personel say�s�n� kad�n ve erkek baz�nda listelettiren sorguyu yaz�n�z.
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



--Maa� ortalamas� 5.500 TL�den fazla olan departmanlar� listeleyecek sorguyu yaz�n�z.
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



--Her personelin ad�n�, soyad�n�,departman�n� ve pozisyonunu getiren sorguyu yaz�n�z.
SELECT
	P.NAME, P.SURNAME,
	D.DEPARTMENT,
	POS.POSITION
FROM PERSON P
JOIN DEPARTMENT D
	ON D.ID = P.DEPARTMENTID
JOIN POSITION POS
	ON POS.ID = P.POSITIONID



--Departmanlar�n ortalama k�demini ay olarak hesaplayacak sorguyu yaz�n�z.
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




	



