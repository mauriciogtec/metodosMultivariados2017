
### ¡¡¡ANUNCIOS!!! ### 

* Todos los equipos deben mandarme por correo la evaluación de los viñetas de los demás equipos.
  + Comienzo de evaluación: Sábado 8 de abril 11:59pm. Antes de fecha pueden hacer modifiaciones.
  + Deben mandármelo por correo antes de la clase del 19 de abril.
  + Un envío por equipo, incluir en el correo las claves de los integrantes. Enviar a mauricio.garcia@itam.mx
  + También se deben evaluar a su propio equipo. Indicar en el correo quién en su equipo.

* Las clases 8, 15 y 22 de marzo serán de 6:00pm a 9:30pm para reponer horas de clase perdidas.
* La fecha tentativa para un examen parcial será el 29 de marzo

# Métodos Multivariados en Ciencias de Datos y Estadística
## Instituto Tecnológico Autónomo de México
### Primavera 2017

Página del curso de Métodos Multivariados y Datos Categóricos 2017.

Este repositorio contiene una idea experimental de hacer un paquete de R y un repositorio de Github para transmitir los materiales del curso. El objetivo es que contenga tutoriales usando 'vignettes' y las bases de datos y funciones que desarrollemos durante clase.

## Usando el paquete

Para instalar el paquete:

```r
install_github("mauriciogtec/metodosMultivariados2017", build_vignettes= TRUE)
```

Para ver los vignettes:

```r
browseVignettes("metodosMultivariados2017")

```

## Temario del curso

Detalles en el temario pueden ir cambiando conforme avancemos, pero el propósito general puede en consultarse [este link](https://github.com/mauriciogtec/metodosMultivariados2017/blob/master/materiales_clase/temario.pdf). Habrá cambios importantes en las primeras dos semanas de clase.

## Definición de equipos

El trabajo en equipo será muy importante en este curso. Es importante que definan al comienzo del curso el equipo con el que van a trabajar. En caso de no contar con un equipo acérquense conmigo para que les asigne uno. Los grupos deben ser variados en el interior, traten de que un equipo tenga integrantes de disintos perfiles.


Para elegir su grupo, dense de alta en el siguiente [link](https://docs.google.com/spreadsheets/d/1KzvMqAbdNL7UYAn8ZFPj1BReXLmg773BDPVRAG0ivrA/edit?usp=sharing)

!!! **Autoevaluación tareas grupales**


[link](https://docs.google.com/spreadsheets/d/1AMJilzkoFArcN8PbWPfvvNSQy1owxNfIMOBhsfAyNxw/edit?usp=sharing)

## Forma de evaluación 

La evaluación tentativa será de la siguiente forma:

| Criterio | Porcentaje |
| --- | --- |
|Contribución por equipo al git del grupo	| 10% |
|Tareas individuales semanales	|	20% |
|Tareas grupales semanales	|	20% |
|Examen Parcial		|	20% |
|Video grupal		|		30% |
| **Total** | 100% |

## Materiales del curso

Las presentaciones de la clase pueden consultarse en [este link dentro del repositorio](https://github.com/mauriciogtec/metodosMultivariados2017/tree/master/materiales_clase/presentaciones)


## Tareas individuales

Habrá tareas individuales todas las clases, los detalles de la forma de entrega se discutirán en clase. Usualmente no pasará de un reporte en una página o participación en la clase. Incluyo aquí una lista no detallada para que revisen si están al corriente

*Lista de tareas individuales*

1. Investigar y ejemplificar cómo se representan cada tipo de dato estadístico en R
2. Investigar sobre el Teorema Espectral para matrices simétricas ý cómo visualizar los eingenvalores de la matriz de covarianzas de una nube de datos. Para más detalles ver la presentación 2 del curso.

## Tareas grupales

Son el corazón del curso. Cada clase uno o dos grupos tendrá una tarea que involucrará programación y explicación de su material en la clase. Los detalles los dicutiré cada semana con cada grupo.

*Lista de tareas grupales*

1. Investigar escalas de medición para cada tipo de dato estadístico y cómo se miden distancias entre ellos. Crear un rmarkdown html y exponerlo en clase
2. Mostrar una aplicación práctica de Análisis de Componentes Principales. Mostrar todos los elementos de un análisis.
3. Aplicacion Financiera a componentes principales
4. Correlacion policóricas, poliseriales y aplicación a componentes principales
5. Aplicación de MDS (ver detalles abajo)


*Detalles tarea 5*

1. Hacer un análisis de MDS siguiendo los pasos de la clase del 1 de marzo 
2. Mostrar todos los detalles del algoritmo con claridad (matriz de disimilitudes, doble centrar, descomposición espectral, aproximación de coordenadas principales, calidad de la aproximación, visualización, etc.)
3. Escoger datos de los cuales puedan concluir algo interesante. Yo propongo los datos del senado de la paquetería y combinar con el partido de cada senador *(usar `data(senado_votacion)` y `data(senado_partidos)` para cargar los datos. Si tienen dudas del significado de las claves de notaciones ver `help(senadores_votaciones)` despues de cargar los datos)*. Si tienen datos alternativos de los cuales quieran hacer MDS por razones especiales, pueden hacerlo siempre y cuando concluyan algo sobre los datos también.
4. Su tarea tienen que tener un párrafo de conclusiones, tanto del método como de sus datos.

