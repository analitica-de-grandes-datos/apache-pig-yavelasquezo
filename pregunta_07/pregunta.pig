/*
Pregunta
===========================================================================

Para el archivo `data.tsv` genere una tabla que contenga la primera columna,
la cantidad de elementos en la columna 2 y la cantidad de elementos en la 
columna 3 separados por coma. La tabla debe estar ordenada por las 
columnas 1, 2 y 3.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- cargo los datos
lines = LOAD 'data.tsv' AS (letra:CHARARRAY, letrasMinusculas:BAG{t:TUPLE(a:CHARARRAY)}, claves:[]);

-- Extraigo la segunda columna
extraigocolumna = FOREACH lines GENERATE claves;
columna = FOREACH extraigocolumna GENERATE COUNT(KEYSET($0));

cuenta = FOREACH lines GENERATE letra, COUNT(letrasMinusculas) as cuenta, COUNT(KEYSET(claves)) as clave;

ordered_data = ORDER cuenta BY letra, cuenta, clave asc;

-- escribe el archivo de salida en el sistema local
STORE ordered_data INTO 'output' USING PigStorage(',');
