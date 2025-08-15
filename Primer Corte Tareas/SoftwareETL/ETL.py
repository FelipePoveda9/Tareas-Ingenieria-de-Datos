import pandas as pd

# Cargar el archivo CSV original
df = pd.read_csv(
    r"C:\Users\prestamour\Desktop\Tareas-Ingenieria-de-Datos\Primer Corte Tareas\SoftwareETL\predios_propiedad.csv",
    sep=';', encoding='cp1252'
)

# Eliminar columnas 'Folio' y 'Chip'
df.drop(columns=['Folio', 'Chip'], inplace=True)

# Crear nueva columna 'Localidad' extrayendo el final del texto en 'Proyecto'
df['Localidad'] = df['Proyecto'].str.extract(r'-\s*([A-Z0-9]+)$')

df.loc[df['Proyecto'].str.contains('UMA', na=False), 'Localidad'] = 'UMANA'
df.loc[df['Proyecto'].str.contains('COLMENA', na=False), 'Localidad'] = 'LA COLMENA'
df.loc[df['Proyecto'].str.contains('CRUCES', na=False), 'Localidad'] = 'LAS CRUCES'
df.loc[df['Proyecto'].str.contains('ESTACI', na=False), 'Localidad'] = 'ESTACION CENTRAL'
df.loc[df['Proyecto'].str.contains('HOJA', na=False), 'Localidad'] = 'LA HOJA'
df.loc[df['Proyecto'].str.contains('PUSLPO', na=False), 'Localidad'] = 'EL PULPO'
df.loc[df['Proyecto'].str.contains('PORVENIR', na=False), 'Localidad'] = 'PORVENIR'
df.loc[df['Proyecto'].str.contains('CIUDADELA EL RECREO', na=False), 'Localidad'] = 'EL RECREO'
df.loc[df['Proyecto'].str.contains('SAN BERNARDO', na=False), 'Localidad'] = 'SAN BERNARDO'
df.loc[df['Proyecto'].str.contains('SAN BLAS', na=False), 'Localidad'] = 'SAN BLAS'
df.loc[df['Proyecto'].str.contains('SAN VICTORINO', na=False), 'Localidad'] = 'SAN VICTORINO'
df.loc[df['Proyecto'].str.contains('USME 3', na=False), 'Localidad'] = 'USME'
df.loc[df['Proyecto'].str.contains('TRES QUEBRADAS', na=False), 'Localidad'] = 'TRES QUEBRADAS'
df.loc[df['Proyecto'].str.contains('VOTO NACIONAL', na=False), 'Localidad'] = 'VOTO NACIONAL'
df.loc[df['Proyecto'].str.contains('AREA DE OPORTUNIDAC', na=False), 'Localidad'] = 'BUENOS AIRES'

# Guardar archivo transformado
df.to_csv(
    r"C:\Users\prestamour\Desktop\Tareas-Ingenieria-de-Datos\Primer Corte Tareas\SoftwareETL\predios_transformado.csv",
    sep=';', index=False, encoding='cp1252'
)

print("Transformación completada. Nuevo archivo guardado como 'predios_transformado'")

# Agrupar por 'Localidad' y contar cuántos predios hay en cada una
conteo = df['Localidad'].value_counts().reset_index()
conteo.columns = ['Localidad', 'Cantidad_de_Predios']

# Mostrar la tabla ordenada
print("\nCantidad de predios vendidos por localidad:\n")
print(conteo)

# Localidad con más predios
localidad_top = conteo.iloc[0]
print(f"\nLocalidad con más predios vendidos fue: *{localidad_top['Localidad']}* con {localidad_top['Cantidad_de_Predios']} predios.")