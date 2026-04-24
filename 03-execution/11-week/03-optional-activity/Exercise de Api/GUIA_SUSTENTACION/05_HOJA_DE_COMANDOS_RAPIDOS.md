# ⚡ 05. HOJA DE COMANDOS RÁPIDOS (GUÍA REAL DE PRODUCCIÓN)

> 💡 **INSTRUCCIÓN:** Estos comandos ya tienen tus links de GitHub reales. Copia el bloque completo según la carpeta en la que estés trabajando.

---

## 🏗️ BLOQUE A: CONTROL DE DOCKER (DESDE LA RAÍZ)
*Ejecuta esto si estás en la carpeta principal:* `Exercise de Api`

| Acción | Comando |
| :--- | :--- |
| **Limpiar, Recompilar y Prender todo** | `docker-compose up --build` |
| **Apagar el sistema** | `docker-compose down` |
| **Ver estado de contenedores** | `docker ps` |

---

## 🐙 BLOQUE B: SUBIR CAMBIOS A GITHUB (CON LINKS REALES)

### 1. SUBIR EL FRONTEND (Si te da error de Git)
```powershell
cd "Frontend_exercise_prueba"
git init
git remote add origin https://github.com/JhonCamiloSuaza/Frontend_exercise_prueba.git
git add .
git commit -m "Actualizando Frontend con Genero"
git push -f origin main
cd ..
```

### 2. SUBIR EL BACKEND
```powershell
cd "Backend_exercise_prueba"
git add .
git commit -m "Actualizando Backend con Genero y validaciones"
git push -f origin main
cd ..
```

### 3. SUBIR LA BASE DE DATOS
```powershell
cd "BD_exercise_prueba"
git add .
git commit -m "Actualizando BD con nueva columna de Liquibase"
git push -f origin main
cd ..
```

---

## 🤖 BLOQUE C: COMANDOS PARA EL SABOTAJE (PRUEBA EN VIVO)

### Sabotaje de Backend (Probar Semáforo Rojo ❌)
```powershell
cd "Backend_exercise_prueba"
# (Borra un punto y coma en el controlador antes de ejecutar lo siguiente)
git add .
git commit -m "Sabotaje de prueba para CI"
git push origin main
cd ..
```

### Sabotaje de Base de Datos (Probar Semáforo Rojo ❌)
```powershell
cd "BD_exercise_prueba"
# (Daña el archivo db.changelog-master.yaml antes de ejecutar lo siguiente)
git add .
git commit -m "Sabotaje de Liquibase para CI"
git push origin main
cd ..
```

---

## 📂 BLOQUE D: NAVEGACIÓN Y LIMPIEZA
*   **Ir al Backend:** `cd "Backend_exercise_prueba"`
*   **Ir a la BD:** `cd "BD_exercise_prueba"`
*   **Ir al Frontend:** `cd "Frontend_exercise_prueba"`
*   **Salir de una carpeta:** `cd ..`
*   **Limpiar consola:** `cls`

---

## 🧪 BLOQUE E: JSON PARA PRUEBAS (SWAGGER / POSTMAN)

**JSON ÉXITO (Copia y pega):**
```json
{
  "nombre": "Jhon",
  "apellido": "Suaza",
  "email": "jhon@gmail.com",
  "telefono": "123456",
  "activo": true,
  "genero": "Masculino"
}
```

**JSON ERROR 400 (Copia y pega):**
```json
{
  "nombre": "Error",
  "genero": "Robot"
}
```
