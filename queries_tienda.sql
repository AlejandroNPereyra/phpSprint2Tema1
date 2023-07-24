USE tienda;

/* 1. Llista el nom de tots els productes que hi ha en la taula "producto" */
SELECT nombre
FROM producto;

/* 2. Llista els noms i els preus de tots els productes de la taula "producto".*/
SELECT nombre, precio
FROM producto;

/* 3. Llista totes les columnes de la taula "producto". */

SELECT *
FROM producto;

-- Segunda opción utilizando SHOW COLUMS

SHOW COLUMNS
FROM producto;

/* 4. Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans (USD).*/

SELECT nombre, precio AS 'precio(€)', (precio / 0.9) AS 'precio(U$D)'
FROM producto;

/* 5. Llista el nom dels "productos", el preu en euros i el preu en dòlars nord-americans. 
Utilitza els següents àlies per a les columnes: nom de "producto", euros, dòlars nord-americans.*/

SELECT nombre, precio AS 'euros', (precio / 0.9) AS 'dòlars-nord-americans'
FROM producto;

/* 6. Llista els noms i els preus de tots els productes de la taula "producto", convertint els noms a majúscula.*/

SELECT UPPER(nombre) AS 'nombre'
FROM producto; 

/* 7. Llista els noms i els preus de tots els productes de la taula "producto", convertint els noms a minúscula.*/

SELECT LOWER(nombre) AS 'nombre', precio
FROM producto;

/* 8. Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules 
els dos primers caràcters del nom del fabricant.*/

SELECT nombre, (UPPER(SUBSTRING(nombre, 1, 2))) AS 'nombre_corto'
FROM fabricante;

/* 9. Llista els noms i els preus de tots els productes de la taula "producto", arrodonint el valor del preu.*/

SELECT nombre, ROUND(precio, 2) AS 'precio con dos decimales' 
FROM producto;

/* 10. Llista els noms i els preus de tots els productes de la taula "producto", truncant el valor del preu 
per a mostrar-lo sense cap xifra decimal.*/

-- SELECT nombre, ROUND(precio, 0) AS 'precio truncado sin decimales' 
-- FROM producto;

-- Repito la consigna utilizando la función TRUNCATE

SELECT nombre, TRUNCATE(precio, 0) AS 'precio truncado sin decimales'
FROM producto;

/* 11. Llista el codi dels fabricants que tenen productes en la taula "producto".*/

SELECT codigo_fabricante 
FROM producto;

/* 12. Llista el codi dels fabricants que tenen productes en la taula "producto", 
eliminant els codis que apareixen repetits.*/

SELECT DISTINCT codigo_fabricante
FROM producto;

/* 13. Llista els noms dels fabricants ordenats de manera ascendent.*/

SELECT nombre 
FROM fabricante
ORDER BY nombre ASC;

/* 14. Llista els noms dels fabricants ordenats de manera descendent.*/

SELECT nombre 
FROM fabricante
ORDER BY nombre DESC;

/* 15. Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, 
en segon lloc, pel preu de manera descendent.*/

SELECT nombre, precio
FROM producto
ORDER BY nombre ASC, precio DESC;

/* 16. Retorna una llista amb les 5 primeres files de la taula "fabricante".*/

SELECT * 
FROM fabricante
LIMIT 5;

/* 17. Retorna una llista amb 2 files a partir de la quarta fila de la taula 
"fabricante". La quarta fila també s'ha d'incloure en la resposta.*/

SELECT * 
FROM fabricante
LIMIT 3,2;

/* 18. Llista el nom i el preu del producte més barat. 
(Utilitza solament les clàusules ORDER BY i LIMIT). 
NOTA: Aquí no podries usar MIN(preu), necessitaries GROUP BY*/

SELECT nombre, precio
FROM producto
ORDER BY precio ASC
LIMIT 0,1;

/* 19. Llista el nom i el preu del producte més car. 
(Fes servir solament les clàusules ORDER BY i LIMIT). 
NOTA: Aquí no podries usar MAX(preu), necessitaries GROUP BY.*/

SELECT nombre, precio
FROM producto
ORDER BY precio DESC
LIMIT 0,1;

/* 20. Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.*/

SELECT nombre
FROM producto
WHERE codigo_fabricante = 2;

/* 21. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.*/

SELECT pro.nombre, pro.precio, fab.nombre
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo;

/* 22. Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. 
Ordena el resultat pel nom del fabricant, per ordre alfabètic.*/

SELECT pro.nombre, pro.precio, fab.nombre
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
ORDER BY fab.nombre ASC;

/* 23. Retorna una llista amb el codi del producte, nom del producte, codi del fabricant i nom del fabricant, 
de tots els productes de la base de dades.*/

SELECT pro.codigo, pro.nombre, fab.codigo, fab.nombre
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo;

/* 24. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.*/

SELECT pro.nombre, pro.precio, fab.nombre
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
ORDER BY pro.precio ASC
LIMIT 0,1;

/* 25. Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.*/

SELECT pro.nombre, pro.precio, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
ORDER BY pro.precio DESC
LIMIT 0,1;

/* 26. Retorna una llista de tots els productes del fabricant Lenovo.*/

SELECT pro.nombre, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre LIKE 'Lenovo';

/* 27. Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.*/

SELECT pro.nombre, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre LIKE 'Crucial' AND pro.precio > 200;

/* 28. Retorna una llista amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. 
Sense utilitzar l'operador IN.*/

SELECT pro.nombre, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre LIKE 'Asus' OR fab.nombre LIKE 'Hewlett-Packard' OR fab.nombre LIKE 'Seagate';

/* 29. Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard i Seagate. 
Usant l'operador IN.*/

SELECT pro.nombre, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre IN ('Asus','Hewlett-Packard','Seagate');

/* 30. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants 
el nom dels quals acabi per la vocal e.*/

SELECT pro.nombre, pro.precio, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre LIKE '%e';

/* 31. Retorna un llistat amb el nom i el preu de tots els productes dels fabricants 
dels quals contingui el caràcter w en el seu nom.*/

SELECT pro.nombre, pro.precio, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
WHERE fab.nombre LIKE '%w%';

/* 32. Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes 
que tinguin un preu major o igual a 180 €. 
Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).*/

SELECT pro.nombre, pro.precio, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo
WHERE pro.precio > 180
ORDER BY pro.precio DESC, pro.nombre ASC;

/* 33. Retorna un llistat amb el codi i el nom de fabricant, 
solament d'aquells fabricants que tenen productes associats en la base de dades.*/

SELECT DISTINCT fab.codigo, fab.nombre AS nombre_fabricante
FROM producto AS pro
JOIN fabricante AS fab ON pro.codigo_fabricante = fab.codigo;

-- 34. Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. 
-- El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.

SELECT fab.nombre AS nombre_fabricante, pro.nombre AS nombre_producto
FROM fabricante AS fab
LEFT JOIN producto AS pro ON pro.codigo_fabricante = fab.codigo;

-- 35. Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.

SELECT fab.nombre AS nombre_fabricante, pro.nombre AS nombre_producto
FROM fabricante AS fab
LEFT JOIN producto AS pro ON pro.codigo_fabricante = fab.codigo
WHERE pro.nombre IS NULL;

-- 36. Retorna tots els productes del fabricant Lenovo. (Sense utilitzar INNER JOIN).

-- 37. Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. 
-- (Sense fer servir INNER JOIN).

-- 38. Llista el nom del producte més car del fabricant Lenovo.

-- 39. Llista el nom del producte més barat del fabricant Hewlett-Packard.

-- 40. Retorna tots els productes de la base de dades que tenen un preu major o igual 
-- al producte més car del fabricant Lenovo.

-- 41. Llesta tots els productes del fabricant Asus que tenen un preu superior 
-- al preu mitjà de tots els seus productes.