/* QUERY TASK D.1*/ 
SELECT a.*,b.OD2,b.VOD2,b.VOD2 - a.VOD1 as 'Difference of totals (VOD1-VOD2)' FROM((
SELECT date as OD1,locations as 'Country Name',total_vaccinations as VOD1 FROM (Vaccinations_Global t1 LEFT OUTER JOIN Locations t2 ON t1.Iso_code=t2.Iso_code) WHERE t1.date = '2021-11-12') a
LEFT OUTER JOIN (
SELECT date as OD2 ,locations,total_vaccinations as VOD2 FROM (Vaccinations_Global t1 LEFT OUTER JOIN Locations t2 ON t1.Iso_code=t2.Iso_code) WHERE t1.date = '2022-05-08') b ON a.'Country Name' = b.locations)

/* QUERY TASK D.2*/ 
SELECT Locations as "Country","Cumulative Doses" FROM(
SELECT Locations ,MAX(total_vaccinations) as "Cumulative Doses" FROM (Vaccinations_Global t1 LEFT OUTER JOIN Locations t2 ON t1.Iso_code = t2.Iso_code)
WHERE t1.Iso_code NOT LIKE "%OWID_%" 
GROUP BY t2.Iso_code)
WHERE  "Cumulative Doses"  > (
SELECT AVG(max_vax) FROM (
SELECT Iso_code, MAX(total_vaccinations) as max_vax FROM Vaccinations_Global WHERE Iso_code NOT LIKE "%OWID_%" GROUP BY Iso_code )) 

/* QUERY TASK D.3*/ 
SELECT Locations , Vaccines_used FROM Vaccines_used t1 LEFT OUTER JOIN Locations t2 ON t1.Iso_code = t2.Iso_code 
WHERE t1.Iso_code IN(
SELECT Iso_code FROM Vaccines_used GROUP BY Iso_code
ORDER BY count(Vaccines_used.Vaccines_used) DESC LIMIT 10)


/* QUERY TASK D.4*/ 
SELECT source_name as 'Source Name',b as 'Total Administered Vaccines', source_website as 'Source URL'  FROM (
(SELECT source_website ,SUM(a) as b FROM(
SELECT Iso_code, source_website , MAX(total_vaccinations) as a  FROM(
SELECT * FROM (locations t1 LEFT OUTER JOIN Vaccinations_Global t2 ON t1.Iso_code == t2.Iso_code)  ) GROUP BY Iso_code)WHERE source_website IS NOT NULL GROUP BY source_website ) t1 LEFT OUTER JOIN 
datasources t2 ON t1.source_website = t2.source_website)

/* QUERY TASK D.5*/ 
SELECT a.*,b.'United States',c.'England',d.'China' FROM (((
(SELECT DATE(date) as date,people_fully_vaccinated as 'Australia' FROM (Vaccinations_global t1 LEFT OUTER JOIN locations t2 ON t1.Iso_code=t2.Iso_code)  WHERE STRFTIME('%Y',DATE(date)) = '2022' AND locations = 'Australia') a
LEFT OUTER JOIN 
(SELECT DATE(date) as date,people_fully_vaccinated as 'United States' FROM (Vaccinations_global t1 LEFT OUTER JOIN locations t2 ON t1.Iso_code=t2.Iso_code)  WHERE STRFTIME('%Y',DATE(date)) = '2022' AND locations = 'United States') b ON a.date=b.date)
LEFT OUTER JOIN
(SELECT DATE(date) as date,people_fully_vaccinated as 'England' FROM (Vaccinations_global t1 LEFT OUTER JOIN locations t2 ON t1.Iso_code=t2.Iso_code)  WHERE STRFTIME('%Y',DATE(date)) = '2022' AND locations = 'England') c ON c.date=a.date)
LEFT OUTER JOIN
(SELECT DATE(date) as date,people_fully_vaccinated as 'China' FROM (Vaccinations_global t1 LEFT OUTER JOIN locations t2 ON t1.Iso_code=t2.Iso_code)  WHERE STRFTIME('%Y',DATE(date)) = '2022' AND locations = 'China' ) d ON d.date=c.date )