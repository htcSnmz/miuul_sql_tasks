--Customers tablosundan ad� �A� harfi ile ba�layan ki�ileri �eken sorguyu yaz�n�z.
SELECT * FROM CUSTOMERS WHERE CUSTOMERNAME LIKE 'A%'


--1990 ve 1995 y�llar� aras�nda do�an m��terileri �ekiniz. 1990 ve 1995 y�llar� dahildir.
SELECT * FROM CUSTOMERS WHERE YEAR(BIRTHDATE) BETWEEN 1990 AND 1995


--�stanbul�da ya�ayan ki�ileri Join kullanarak getiren sorguyu yaz�n�z.
SELECT C.*, CT.CITY FROM CUSTOMERS C JOIN CITIES CT ON C.CITYID = CT.ID WHERE CT.CITY = '�STANBUL'


--�stanbul�da ya�ayan ki�ileri subquery kullanarak getiren sorguyu yaz�n�z.
SELECT * FROM CUSTOMERS WHERE CITYID IN (SELECT ID FROM CITIES WHERE CITY = '�STANBUL')


--Hangi �ehirde ka� m��terimizin oldu�u bilgisini getiren sorguyu yaz�n�z.
SELECT CT.CITY, COUNT(*) NUMBER_OF_CUSTOMERS FROM CUSTOMERS C JOIN CITIES CT ON C.CITYID = CT.ID GROUP BY CT.CITY


--10�dan fazla m��terimiz olan �ehirleri m��teri say�s� ile birlikte m��teri say�s�na g�re fazladan aza do�ru s�ral� �ekilde getiriniz.
SELECT 
	CT.CITY,
	COUNT(*) NUMBER_OF_CUSTOMERS
FROM CUSTOMERS C 
JOIN CITIES CT ON C.CITYID = CT.ID 
GROUP BY CT.CITY
HAVING COUNT(*) > 10
ORDER BY 2 DESC


--Hangi �ehirde ka� erkek, ka� kad�n m��terimizin oldu�u bilgisini getiren sorguyu yaz�n�z
SELECT
	CT.CITY,
	C.GENDER,
	COUNT(*) NUMBER_OF_CUSTOMERS
FROM CUSTOMERS C 
JOIN CITIES CT ON C.CITYID = CT.ID
GROUP BY CT.CITY, C.GENDER
ORDER BY 1


--Customers tablosuna ya� grubu i�in yeni bir alan ekleyiniz. Bu i�lemi hem management studio ile hem de sql kodu ile yap�n�z.
--Alan� ad� AGEGROUP veritipi Varchar(50)
ALTER TABLE CUSTOMERS ADD AGEGROUP VARCHAR(50)


--Customers tablosuna ekledi�iniz AGEGROUP alan�n� 20-35 ya� aras�,36-45 ya� aras�,46-55 ya� aras�,55-65 ya� aras� ve 65 ya� �st� olarak g�ncelleyiniz.
UPDATE CUSTOMERS 
SET AGEGROUP = 
    CASE 
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35 ya� aras�'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '20-35 ya� aras�'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '20-35 ya� aras�'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 55 AND 65 THEN '20-35 ya� aras�'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65 ya� �st�'
        ELSE 'Bilinmiyor'
    END


--�stanbul�da ya�ay�p il�esi �Kad�k�y� d���nda olanlar� listeleyiniz.
SELECT *, CT.CITY, D.DISTRICT 
FROM CUSTOMERS C
JOIN CITIES CT ON C.CITYID = CT.ID
JOIN DISTRICT D ON D.CITYID = CT.ID
WHERE CT.CITY = '�STANBUL'
AND D.DISTRICT <> 'KADIK�Y'


--M��terilerimizin telefon numalar�n�n operat�r bilgisini getirmek istiyoruz.
--TELNR1 ve TELNR2 alanlar�n�n yan�na operat�r numaras�n� (532),(505) gibi getirmek istiyoruz. Bu sorgu i�in gereken SQL c�mlesini yaz�n�z.
SELECT
	CUSTOMERNAME,
	TELNR1, LEFT(TELNR1, 5) OPR1,
	TELNR2, LEFT(TELNR2, 5) OPR2
FROM CUSTOMERS


--Her ilde en �ok m��teriye sahip oldu�umuz il�eleri m��teri say�s�na g�re �oktan aza do�ru s�ral� �ekilde getirmek i�in gereken sorguyu yaz�n�z.	
SELECT CT.CITY,D.DISTRICT,COUNT(C.ID) AS NUMBER_OF_CUSTOMERS 
FROM CUSTOMERS C
INNER JOIN CITIES CT ON CT.ID=C.CITYID
INNER JOIN DISTRICT D ON D.ID=C.DISTRICTID
GROUP BY CT.CITY,D.DISTRICT
ORDER BY 1,3 DESC


--M��terilerin do�um g�nlerini haftan�n g�n�(Pazartesi, Sal�, �ar�amba..) olarak getiren sorguyu yaz�n�z.
SET LANGUAGE Turkish
SELECT 
	CUSTOMERNAME,
	DATENAME(WEEKDAY, BIRTHDATE) DAY_NAME
FROM CUSTOMERS

