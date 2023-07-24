-- 1. Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
-- El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.

SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo LIKE 'alumno'
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- 2. Esbrina el nom i els dos cognoms dels/les alumnes que no han donat d'alta el seu número de telèfon en la base de dades.

SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno' AND telefono IS NULL;

-- 3. Retorna el llistat dels/les alumnes que van néixer en 1999.

SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- 4. Retorna el llistat de professors/es que no han donat d'alta 
-- el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.

SELECT apellido1, apellido2, nombre
FROM persona
WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

-- 5. Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, 
-- en el tercer curs del grau que té l'identificador 7.

SELECT nombre AS nombre_asignatura
FROM asignatura
WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

-- 6. Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats/des. 
-- El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
-- El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.

SELECT per.apellido1, per.apellido2, per.nombre, dep.nombre AS nombre_departamento
FROM persona AS per
JOIN profesor AS prof ON prof.id_profesor = per.id 
JOIN departamento AS dep ON dep.id = prof.id_departamento
WHERE tipo LIKE 'profesor'
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- 7. Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar 
-- de l'alumne/a amb NIF 26902806M.

SELECT per.apellido1, asig.nombre, curs.anyo_inicio, curs.anyo_fin
FROM persona AS per
JOIN alumno_se_matricula_asignatura AS alumno ON alumno.id_alumno = per.id
JOIN asignatura AS asig ON asig.id = alumno.id_asignatura
JOIN curso_escolar AS curs ON curs.id = alumno.id_curso_escolar
WHERE nif = '26902806M';

-- 8. Retorna un llistat amb el nom de tots els departaments que tenen professors/es 
-- que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

SELECT DISTINCT dep.nombre AS nombre_departamento
FROM departamento AS dep
JOIN profesor AS prof ON prof.id_departamento = dep.id
JOIN asignatura AS asig ON asig.id_profesor = prof.id_profesor
JOIN grado AS grad ON grad.id = asig.id_grado
WHERE grad.nombre LIKE 'Grado en Ingeniería Informática (Plan 2015)';

-- 9. Retorna un llistat amb tots els/les alumnes que s'han matriculat en alguna assignatura 
-- durant el curs escolar 2018/2019.

SELECT DISTINCT per.apellido1, per.apellido2, per.nombre
FROM persona AS per
JOIN alumno_se_matricula_asignatura AS alumno ON alumno.id_alumno = per.id
JOIN curso_escolar AS curso ON curso.id = alumno.id_curso_escolar
WHERE anyo_inicio = 2018 AND anyo_fin = 2019;

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

--  1. Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats/des. 
-- El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. 
-- El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. 
-- El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

SELECT dep.nombre AS nombre_departamento, per.apellido1, per.apellido2, per.nombre
FROM persona AS per
LEFT JOIN profesor AS prof ON prof.id_profesor = per.id
LEFT JOIN departamento as dep ON dep.id = prof.id_departamento
WHERE tipo LIKE 'profesor'
ORDER BY nombre_departamento ASC, apellido1 ASC, apellido2 ASC, nombre ASC;

-- 2. Retorna un llistat amb els professors/es que no estan associats a un departament.

SELECT per.apellido1, per.apellido2, per.nombre
FROM persona AS per
LEFT JOIN profesor AS prof ON prof.id_profesor = per.id
LEFT JOIN departamento as dep ON dep.id = prof.id_departamento
WHERE id_departamento IS NULL AND tipo LIKE 'profesor'
ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;

-- 3. Retorna un llistat amb els departaments que no tenen professors/es associats.

SELECT dep.nombre AS nombre_departamento
FROM persona AS per
RIGHT JOIN profesor AS prof ON prof.id_profesor = per.id
RIGHT JOIN departamento as dep ON dep.id = prof.id_departamento
WHERE id_departamento IS NULL AND tipo LIKE 'profesor';

-- 4. Retorna un llistat amb els professors/es que no imparteixen cap assignatura.

SELECT per.apellido1, per.apellido2, per.nombre, per.tipo
FROM persona AS per
LEFT JOIN profesor AS prof ON prof.id_profesor = per.id
LEFT JOIN asignatura AS asig ON asig.id_profesor = prof.id_profesor
WHERE asig.id_profesor IS NULL AND per.tipo LIKE 'profesor';

-- 5. Retorna un llistat amb les assignatures que no tenen un professor/a assignat.

SELECT asig.nombre
FROM persona AS per
RIGHT JOIN profesor AS prof ON prof.id_profesor = per.id
RIGHT JOIN asignatura AS asig ON asig.id_profesor = prof.id_profesor
WHERE asig.id_profesor IS NULL;

-- 6. Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

-- Consultes resum:

-- 1. Retorna el nombre total d'alumnes que hi ha.

SELECT COUNT(id) AS total_alumnos
FROM persona
WHERE tipo LIKE 'alumno';

-- 2. Calcula quants/es alumnes van néixer en 1999.

SELECT COUNT(id) AS numero_total_alumnos_1999
FROM persona
WHERE tipo = 'alumno' AND fecha_nacimiento BETWEEN '1999-01-01' AND '1999-12-31';

-- 3. Calcula quants/es professors/es hi ha en cada departament. 
-- El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb 
-- el nombre de professors/es que hi ha en aquest departament. 
-- El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat 
-- de major a menor pel nombre de professors/es.

SELECT dep.nombre AS nombre_departamento, COUNT(prof.id_departamento) as numero_profesores
FROM departamento AS dep
LEFT JOIN profesor AS prof ON prof.id_departamento = dep.id
GROUP BY dep.nombre
ORDER BY numero_profesores DESC;

-- 4. Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. 
-- Té en compte que poden existir departaments que no tenen professors/es associats/des. 
-- Aquests departaments també han d'aparèixer en el llistat.

/*SELECT per.apellido1, per.apellido2, per.nombre, dep.nombre AS nombre_departamento
FROM persona AS per
RIGHT JOIN profesor AS prof ON prof.id_profesor = per.id 
RIGHT JOIN departamento AS dep ON dep.id = prof.id_departamento
WHERE tipo LIKE 'profesor'OR prof.id_departamento IS NULL;*/

SELECT dep.nombre AS nombre_departamento, COUNT(prof.id_departamento) as numero_profesores
FROM departamento AS dep
LEFT JOIN profesor AS prof ON prof.id_departamento = dep.id
LEFT JOIN persona AS per ON per.id = prof.id_profesor
WHERE per.tipo LIKE 'profesor'OR prof.id_departamento IS NULL
GROUP BY dep.nombre;

-- 5. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. 
-- Té en compte que poden existir graus que no tenen assignatures associades. 
-- Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.

SELECT grad.nombre AS nombre_grado, COUNT(asig.id_grado) as numero_asignaturas
FROM grado AS grad
LEFT JOIN asignatura AS asig ON asig.id_grado = grad.id
GROUP BY grad.nombre
ORDER BY numero_asignaturas DESC;

/* 6. Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, 
dels graus que tinguin més de 40 assignatures associades.*/

SELECT nombre_grado, numero_asignaturas
FROM (
SELECT grad.nombre AS nombre_grado, COUNT(asig.id_grado) AS numero_asignaturas
FROM grado AS grad
LEFT JOIN asignatura AS asig ON asig.id_grado = grad.id
GROUP BY grad.nombre)
AS subquery
WHERE numero_asignaturas > 40 ;

/* 7. Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. 
El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.*/

/* 8. Retorna un llistat que mostri quants/es alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. 
El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar 
i una altra amb el nombre d'alumnes matriculats/des.*/

/* 9. Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. 
El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. 
El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. 
El resultat estarà ordenat de major a menor pel nombre d'assignatures.*/

/* 10. Retorna totes les dades de l'alumne més jove.*/

SELECT *, MAX(fecha_nacimiento)
FROM persona
WHERE tipo LIKE ('alumno');

/* 11. Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.*/

SELECT per.apellido1, per.apellido2, per.nombre
FROM persona AS per
LEFT JOIN profesor AS prof ON prof.id_profesor = per.id
LEFT JOIN departamento AS dep ON dep.id = prof.id_departamento
LEFT JOIN asignatura AS asig ON asig.id_profesor = prof.id_profesor
WHERE asig.id_profesor IS NULL AND prof.id_departamento IS NOT NULL AND per.tipo LIKE 'profesor';
