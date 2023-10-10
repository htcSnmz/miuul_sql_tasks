--Customers tablosundan adý ‘A’ harfi ile baþlayan kiþileri çeken sorguyu yazýnýz.
SELECT * FROM CUSTOMERS WHERE CUSTOMERNAME LIKE 'A%'


--1990 ve 1995 yýllarý arasýnda doðan müþterileri çekiniz. 1990 ve 1995 yýllarý dahildir.
SELECT * FROM CUSTOMERS WHERE YEAR(BIRTHDATE) BETWEEN 1990 AND 1995


--Ýstanbul’da yaþayan kiþileri Join kullanarak getiren sorguyu yazýnýz.
SELECT C.*, CT.CITY FROM CUSTOMERS C JOIN CITIES CT ON C.CITYID = CT.ID WHERE CT.CITY = 'ÝSTANBUL'


--Ýstanbul’da yaþayan kiþileri subquery kullanarak getiren sorguyu yazýnýz.
SELECT * FROM CUSTOMERS WHERE CITYID IN (SELECT ID FROM CITIES WHERE CITY = 'ÝSTANBUL')


--Hangi þehirde kaç müþterimizin olduðu bilgisini getiren sorguyu yazýnýz.
SELECT CT.CITY, COUNT(*) NUMBER_OF_CUSTOMERS FROM CUSTOMERS C JOIN CITIES CT ON C.CITYID = CT.ID GROUP BY CT.CITY


--10’dan fazla müþterimiz olan þehirleri müþteri sayýsý ile birlikte müþteri sayýsýna göre fazladan aza doðru sýralý þekilde getiriniz.
SELECT 
	CT.CITY,
	COUNT(*) NUMBER_OF_CUSTOMERS
FROM CUSTOMERS C 
JOIN CITIES CT ON C.CITYID = CT.ID 
GROUP BY CT.CITY
HAVING COUNT(*) > 10
ORDER BY 2 DESC


--Hangi þehirde kaç erkek, kaç kadýn müþterimizin olduðu bilgisini getiren sorguyu yazýnýz
SELECT
	CT.CITY,
	C.GENDER,
	COUNT(*) NUMBER_OF_CUSTOMERS
FROM CUSTOMERS C 
JOIN CITIES CT ON C.CITYID = CT.ID
GROUP BY CT.CITY, C.GENDER
ORDER BY 1


--Customers tablosuna yaþ grubu için yeni bir alan ekleyiniz. Bu iþlemi hem management studio ile hem de sql kodu ile yapýnýz.
--Alaný adý AGEGROUP veritipi Varchar(50)
ALTER TABLE CUSTOMERS ADD AGEGROUP VARCHAR(50)


--Customers tablosuna eklediðiniz AGEGROUP alanýný 20-35 yaþ arasý,36-45 yaþ arasý,46-55 yaþ arasý,55-65 yaþ arasý ve 65 yaþ üstü olarak güncelleyiniz.
UPDATE CUSTOMERS 
SET AGEGROUP = 
    CASE 
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 20 AND 35 THEN '20-35 yaþ arasý'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 36 AND 45 THEN '20-35 yaþ arasý'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 46 AND 55 THEN '20-35 yaþ arasý'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) BETWEEN 55 AND 65 THEN '20-35 yaþ arasý'
        WHEN DATEDIFF(YEAR, BIRTHDATE, GETDATE()) > 65 THEN '65 yaþ üstü'
        ELSE 'Bilinmiyor'
    END


--Ýstanbul’da yaþayýp ilçesi ‘Kadýköy’ dýþýnda olanlarý listeleyiniz.
SELECT *, CT.CITY, D.DISTRICT 
FROM CUSTOMERS C
JOIN CITIES CT ON C.CITYID = CT.ID
JOIN DISTRICT D ON D.CITYID = CT.ID
WHERE CT.CITY = 'ÝSTANBUL'
AND D.DISTRICT <> 'KADIKÖY'


--Müþterilerimizin telefon numalarýnýn operatör bilgisini getirmek istiyoruz.
--TELNR1 ve TELNR2 alanlarýnýn yanýna operatör numarasýný (532),(505) gibi getirmek istiyoruz. Bu sorgu için gereken SQL cümlesini yazýnýz.
SELECT
	CUSTOMERNAME,
	TELNR1, LEFT(TELNR1, 5) OPR1,
	TELNR2, LEFT(TELNR2, 5) OPR2
FROM CUSTOMERS


--Her ilde en çok müþteriye sahip olduðumuz ilçeleri müþteri sayýsýna göre çoktan aza doðru sýralý þekilde getirmek için gereken sorguyu yazýnýz.	
SELECT CT.CITY,D.DISTRICT,COUNT(C.ID) AS NUMBER_OF_CUSTOMERS 
FROM CUSTOMERS C
INNER JOIN CITIES CT ON CT.ID=C.CITYID
INNER JOIN DISTRICT D ON D.ID=C.DISTRICTID
GROUP BY CT.CITY,D.DISTRICT
ORDER BY 1,3 DESC


--Müþterilerin doðum günlerini haftanýn günü(Pazartesi, Salý, Çarþamba..) olarak getiren sorguyu yazýnýz.
SET LANGUAGE Turkish
SELECT 
	CUSTOMERNAME,
	DATENAME(WEEKDAY, BIRTHDATE) DAY_NAME
FROM CUSTOMERS

