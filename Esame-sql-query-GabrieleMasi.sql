/* 1)	Verificare che i campi definiti come PK siano univoci. In altre parole, scrivi una query per determinare l’univocità dei 
 valori di ciascuna PK (una query per tabella implementata)*/
 
 select
 count(ProductID),
 ProductName
 from product
 group by productID;
 
select
 count(StateID),
 State
 from region
 group by StateID;
 
 select
 count(StateID)
 from region
 group by StateID;
 
 /*2)Esporre l’elenco delle transazioni indicando nel result set il 
 codice documento, la data, il nome del prodotto, la categoria del prodotto,
 il nome dello stato, il nome della regione di vendita e un campo booleano 
 valorizzato in base alla condizione che siano passati più di 180 giorni 
 dalla data vendita o meno (>180 -> True, <= 180 -> False) */

SELECT
  sales.SalesID AS DocumentCode,
  sales.Date,

  (SELECT product.ProductName
   FROM product
   WHERE product.ProductID = sales.ProductID) AS ProductName,

  (SELECT product.Category
   FROM product
   WHERE product.ProductID = sales.ProductID) AS Category,

  (SELECT region.State
   FROM region
   WHERE region.StateID = sales.StateID) AS State,

  (SELECT region.RegionName
   FROM region
   WHERE region.StateID = sales.StateID) AS SalesRegion,

  CASE
    WHEN DATEDIFF(CURDATE(), sales.Date) > 180 THEN 'within'
    ELSE 'older'
  END AS `180days`
FROM sales;

/*3)	Esporre l’elenco dei prodotti che hanno venduto, in totale, 
una quantità maggiore della media delle vendite realizzate nell’ultimo anno 
censito. (ogni valore della condizione deve risultare da una query e 
non deve essere inserito a mano). Nel result set 
devono comparire solo il codice prodotto e il totale venduto */


SELECT
  a.ProductID,
  a.TotalSold
FROM (
SELECT
    sales.ProductID,
    COUNT(*) AS TotalSold
  FROM sales
  GROUP BY sales.ProductID
) AS a
HAVING a.TotalSold >
( SELECT AVG(b.YearlyTotal)
  FROM (
    SELECT
      sales.ProductID,
      COUNT(*) AS YearlyTotal
    FROM sales
    WHERE sales.Date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
    GROUP BY sales.ProductID) 
    AS b );


/* 4) Esporre l’elenco dei soli prodotti venduti 
    e per ognuno di questi il fatturato totale per anno*/
    
select 
s.ProductID,
p.ProductName,
SUM(s.SalesAmount) as TotalAmount
from sales as s
inner join product as p
ON s.ProductID=p.ProductID
group by ProductID;


/*5)	Esporre il fatturato totale per stato per anno. 
Ordina il risultato per data e per fatturato decrescente.*/

select 
stateID,
(select State
from region
WHERE sales.stateID = region.StateID) as State,
SUM(sales.SalesAmount) as TotalAmount
from sales
group by stateID
order by TotalAmount DESC;

/*6)	Rispondere alla seguente domanda: 
qual è la categoria di articoli maggiormente richiesta dal mercato? */

select 
p.Category,
COUNT(SalesID)
from sales as s
inner join product as p
ON s.ProductID = p.ProductID
Group by p.Category
order by COUNT(SalesID) desc;

-- RISPOSTA: le categorie più richieste sono Doll e Peluche;

/*7)	Rispondere alla seguente domanda: quali sono i prodotti invenduti? 
Proponi due approcci risolutivi differenti */

-- PRIMO APPROCCIO
select 
ProductName
from product as p
LEFT JOIN sales as s
ON s.ProductID = p.ProductID
WHERE s.ProductID IS NULL;

-- SECONDO APPROCCIO
SELECT product.ProductName
FROM product
WHERE product.ProductID NOT IN (
  SELECT sales.ProductID
  FROM sales
);

-- C’è solo un prodotto invenduto: Monopoly

/* 8) Creare una vista sui prodotti in modo tale da esporre 
una “versione denormalizzata” delle informazioni utili 
(codice prodotto, nome prodotto, nome categoria, stato dove viene più venduto
store dove viene più venduto, guadagno totale,)*/


SELECT
  product.ProductID,
  product.ProductName,
  product.Category,

  IFNULL(
    (SELECT region.State
     FROM sales
     INNER JOIN region ON sales.StateID = region.StateID
     WHERE sales.ProductID = product.ProductID
     GROUP BY region.State
     ORDER BY COUNT(*) DESC, region.State ASC
     LIMIT 1),
    'NA'
  ) AS TopState,

  IFNULL(
    (SELECT sales.StoreID
     FROM sales
     WHERE sales.ProductID = product.ProductID
     GROUP BY sales.StoreID
     ORDER BY COUNT(*) DESC, sales.StoreID ASC
     LIMIT 1),
    'NA'
  ) AS TopStore,

  IFNULL(
    (SELECT SUM(sales.SalesAmount)
     FROM sales
     WHERE sales.ProductID = product.ProductID),
    0
  ) AS TotalRevenue

FROM product
GROUP BY product.ProductID, product.ProductName, product.Category;


/* 9) Creare una vista per le informazioni geografiche*/

CREATE OR REPLACE VIEW Geography AS
SELECT
  region.RegionID,
  region.RegionName,
  region.StateID,
  region.State,
  sales.StoreID,
  COUNT(*) AS SalesCount
FROM region
INNER JOIN sales
  ON sales.StateID = region.StateID
GROUP BY
  region.RegionID,
  region.RegionName,
  region.StateID,
  region.State,
  sales.StoreID;
