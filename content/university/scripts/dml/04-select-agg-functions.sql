-- Obtener el total de programas por cada facultad
-- ordenado de la facultad con mas programas hacia abajo.
SELECT
    T1.name AS faculty,
    COUNT(*) AS total_programs

FROM university.faculties T1
INNER JOIN university.programs T2
    ON T1.faculty_id = T2.faculty_id
GROUP BY T1.name
ORDER BY total_programs DESC;

-- Obtener el total de estudiantes registrados en el sistema
-- que tengan el rol de estudiante.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT COUNT(*) AS total_students
FROM university.users T1
INNER JOIN university.roles T2 
    ON T1.role_id = T2.role_id
WHERE T2.name = 'Student';

-- Obtener la capacidad máxima entre todas las ofertas de curso
-- que se dictan en un edificio específico.
-- Tipo de JOIN: INNER
-- Agregación: MAX

-- MAX: Capacidad máxima en un edificio específico
SELECT 
    MAX(T3.capacity) AS max_capacity
FROM university.buildings T1
INNER JOIN university.classrooms T2 
    ON T1.building_id = T2.building_id
INNER JOIN university.course_offerings T3 
    ON T2.classroom_id = T3.classroom_id
WHERE T1.name = 'Bloque Nuevo';


-- Obtener la capacidad mínima registrada entre todas las ofertas
-- de curso disponibles, mostrando el nombre del curso asociado.
-- Tipo de JOIN: INNER
-- Agregación: MIN

-- MIN: Capacidad mínima y curso asociado
SELECT 
    T2.name AS course_name,
    MIN(T1.capacity) AS min_capacity
FROM university.course_offerings T1
INNER JOIN university.courses T2 
    ON T1.course_id = T2.course_id
GROUP BY T2.name
ORDER BY min_capacity ASC
LIMIT 1;

-- Obtener la suma total de capacidad disponible en todas las
-- ofertas de curso que pertenecen a una facultad específica.
-- Tipo de JOIN: INNER
-- Agregación: SUM

-- SUM: Capacidad total en una facultad específica
SELECT 
    SUM(T3.capacity) AS total_capacity
FROM university.faculties T1
INNER JOIN university.courses T2 
    ON T1.faculty_id = T2.faculty_id
INNER JOIN university.course_offerings T3 
    ON T2.course_id = T3.course_id
WHERE T1.name = 'Facultad de Artes y Humanidades';

-- Obtener el promedio de capacidad de todas las ofertas de curso
-- que se dictan los días lunes.
-- Tipo de JOIN: INNER
-- Agregación: AVG
-- AVG: Promedio de capacidad en lunes
SELECT 
    AVG(T1.capacity) AS avg_capacity
FROM university.course_offerings T1
INNER JOIN university.schedules T2 
    ON T1.schedule_id = T2.schedule_id
WHERE T2.day = 'Monday';


-- Obtener cuántas ofertas de curso tiene asignadas en total
-- un profesor específico, mostrando su nombre completo.
-- Tipo de JOIN: INNER
-- Agregación: COUNT
SELECT 
    T1.first_name || ' ' || T1.last_name AS professor_name,
    COUNT(T2.course_offering_id) AS total_offerings
FROM university.users T1
INNER JOIN university.course_offerings T2 
    ON T1.user_id = T2.professor_id
WHERE T1.user_id = 32
GROUP BY T1.first_name, T1.last_name;


-- Obtener el número total de cursos que pertenecen al plan
-- de estudios de un programa académico específico,
-- incluyendo los semestres en los que aparecen.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT 
    T2.name AS program_name,
    COUNT(T1.course_id) AS total_courses
FROM university.programs_courses T1
INNER JOIN university.programs T2 
    ON T1.program_id = T2.program_id
WHERE T2.program_id = 1
GROUP BY T2.name;

-- Obtener la cantidad de estudiantes inscritos en una
-- oferta de curso específica, mostrando el nombre del curso
-- y el nombre completo del profesor que la dicta.
-- Tipo de JOIN: INNER
-- Agregación: COUNT

SELECT 
    T3.name AS course_name,
    T1.first_name || ' ' || T1.last_name AS professor_name,
    COUNT(T2.user_id) AS total_students
FROM university.course_offerings T4
INNER JOIN university.enrollments T2 
    ON T4.course_offering_id = T2.course_offering_id
INNER JOIN university.courses T3 
    ON T4.course_id = T3.course_id
INNER JOIN university.users T1 
    ON T4.professor_id = T1.user_id
WHERE T4.course_offering_id = 1
GROUP BY T3.name, T1.first_name, T1.last_name;