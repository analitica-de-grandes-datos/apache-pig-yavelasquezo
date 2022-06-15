/*
Pregunta
===========================================================================

Para responder la pregunta use el archivo `data.csv`.

Escriba el código equivalente a la siguiente consulta SQL.

   SELECT
       firstname,
       color
   FROM 
       u 
   WHERE 
       color REGEXP '^b';

Escriba el resultado a la carpeta `output` del directorio actual. Para la 
evaluación, pig sera eejcutado ejecutado en modo local:

$ pig -x local -f pregunta.pig

        /* >>> Escriba su respuesta a partir de este punto <<< */



-- cargo los datos
lines = LOAD 'data.csv' USING PigStorage(',') AS (numero:int, nombre:CHARARRAY, apellido:CHARARRAY, fecha:CHARARRAY, color:CHARARRAY, num:int);

--selectcolor = FOREACH lines GENERATE CONCAT(nombre, ',', color) as colUnidas;
--bcolor = FOREACH  selectcolor GENERATE FLATTEN(REGEX_EXTRACT_ALL(colUnidas, '([a-zA-Z]+,.*b.*)')) as result;
--filtro = FILTER bcolor BY (result is NOT NULL);

selectcolor = FOREACH lines GENERATE nombre, FLATTEN(REGEX_EXTRACT_ALL(color, '(.*b.*)')) as colorFiltrado;
filtro = FILTER selectcolor BY (colorFiltrado is NOT NULL);

-- escribe el archivo de salida en el sistema local
STORE filtro INTO 'output' USING PigStorage(',');
