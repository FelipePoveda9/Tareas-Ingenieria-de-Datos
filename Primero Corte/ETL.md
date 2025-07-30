# ¿Qué es ETL? - Ciencias de Datos

ETL es un proceso fundamental en la ingeniería y ciencia de datos que permite mover y preparar datos desde distintas fuentes hasta un sistema donde puedan ser analizados eficientemente. Este proceso se divide en tres etapas principales:

---

## EXTRACT

La extracción consiste en **obtener los datos desde diferentes fuentes donde se encuentran almacenados**.  
Estas fuentes pueden ser:

- Internas (por ejemplo, bases de datos de la empresa)
- Externas (como sitios web o APIs)
- Estructuradas (archivos CSV, bases de datos relacionales)
- No estructuradas (textos, imágenes, archivos JSON, etc.)

El objetivo principal es **recuperar toda la información relevante** que será utilizada para análisis posteriores.  
Esta etapa debe realizarse de forma eficiente, garantizando **la calidad y completitud** de los datos, evitando errores o pérdidas.

---

## TRANSFORM

En esta etapa se **convierten, limpian y preparan los datos** extraídos para que sean coherentes, comprensibles y útiles.  
Algunas tareas comunes en esta fase son:

- Eliminar duplicados
- Corregir errores
- Normalizar datos
- Cambiar formatos
- Unir o dividir tablas
- Aplicar reglas de negocio

El objetivo es **asegurar la calidad y consistencia** de los datos, adaptándolos al formato y estructura requeridos por los sistemas de análisis.

---

## LOAD

Consiste en **cargar los datos ya transformados en un sistema de almacenamiento**, como una base de datos, un data warehouse o un lago de datos (data lake).

Esta carga puede ser:

- **Total**: reemplaza los datos existentes completamente.
- **Incremental**: solo añade o actualiza los datos que han cambiado.

El objetivo es **dejar los datos listos para ser usados** por herramientas de análisis, reportes, visualizaciones o modelos de inteligencia artificial.

---

