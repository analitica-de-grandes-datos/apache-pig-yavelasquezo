/*
Pregunta
===========================================================================

Para el archivo `data.tsv` compute Calcule la cantidad de registros en que 
aparece cada letra minúscula en la columna 2.

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        >>> Escriba su respuesta a partir de este punto <<<
*/
-- cargo los datos
lines = LOAD 'data.tsv' AS (letra:CHARARRAY, letrasMinusculas:BAG{t:TUPLE(a:CHARARRAY)}, claves:CHARARRAY);

-- Extraigo la segunda columna
columna = FOREACH lines GENERATE letrasMinusculas;

-- genera una tabla llamada words con una palabra por registro
words = FOREACH columna GENERATE FLATTEN(letrasMinusculas) AS word;

-- agrupa los registros que tienen la misma palabra
grouped = GROUP words BY word;

-- genera una variable que cuenta las ocurrencias por cada grupo
wordcount = FOREACH grouped GENERATE group, COUNT(words);

-- escribe el archivo de salida en el sistema local
STORE wordcount INTO 'output' USING PigStorage(',');
