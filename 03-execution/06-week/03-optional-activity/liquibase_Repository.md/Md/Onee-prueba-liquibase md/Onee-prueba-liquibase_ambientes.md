# Flujo Git — Estrategia por Ambientes

Repositorio: `Onee-prueba-liquibase`  
Estrategia de trabajo por ambientes `main`, `develop` y `qa` usando ramas hijas por HU.

---

## Regla principal

Las ramas padre (`main`, `develop`, `qa`) **nunca se tocan directamente**.  
Todo cambio entra por una rama hija HU y se sube manualmente.

---

## Estructura de ramas

Cada rama padre es **independiente entre sí**, todas nacen desde `main`:

```
main ──── develop   (independiente)
     ──── qa        (independiente)
```

Cada padre tiene su propia rama hija por HU:

```
main    ──── HU-01-main
develop ──── HU-01-develop
qa      ──── HU-01-qa
```

---

## Paso a paso completo

### PASO 1 — Clonar el repositorio

```bash
cd ~/Desktop
git clone https://github.com/TuUsuario/Onee-prueba-liquibase.git
cd Onee-prueba-liquibase
```

---

### PASO 2 — Primer commit en main

Crea `README.md` en VSCode y guárdalo. Luego:

```bash
echo "# Onee-prueba-liquibase" > README.md
git add .
git commit -m "Initial commit"
git push origin main
```

---

### PASO 3 — Crear develop desde main

```bash
git switch main
git switch -c develop
echo "# rama develop" > develop.md
git add .
git commit -m "inicio develop"
git push origin develop
```

---

### PASO 4 — Crear qa desde main

```bash
git switch main
git switch -c qa
echo "# rama qa" > qa.md
git add .
git commit -m "inicio qa"
git push origin qa
```

---

### PASO 5 — Agregar commit inicial a main

```bash
git switch main
echo "# rama main" > main.md
git add .
git commit -m "inicio main"
git push origin main
```

---

### PASO 6 — Crear las 3 ramas hijas

Cada rama hija se crea desde su padre correspondiente:

```bash
# Hija de develop
git switch develop
git switch -c HU-01-develop
git push origin HU-01-develop

# Hija de qa
git switch qa
git switch -c HU-01-qa
git push origin HU-01-qa

# Hija de main
git switch main
git switch -c HU-01-main
git push origin HU-01-main
```

---

### PASO 7 — Trabajar en HU-01-develop

Posicionarse en la rama hija, crear los archivos y subirlos:

```bash
git switch HU-01-develop
# Crear carpeta develop/ con HU-01.md en VSCode
git add .
git commit -m "HU-01: agregar archivo HU-01.md en ambiente develop"
git push origin HU-01-develop
```

---

### PASO 8 — Pasar cambios manualmente a develop

```bash
git switch develop
# Crear carpeta develop/ con HU-01.md en VSCode (mismo contenido)
git add .
git commit -m "HU-01: cambio llega a develop"
git push origin develop
```

---

### PASO 9 — Trabajar en HU-01-qa

```bash
git switch HU-01-qa
# Crear carpeta qa/ con HU-01.md en VSCode
git add .
git commit -m "HU-01: agregar archivo HU-01.md en ambiente qa"
git push origin HU-01-qa
```

---

### PASO 10 — Pasar cambios manualmente a qa

```bash
git switch qa
# Crear carpeta qa/ con HU-01.md en VSCode (mismo contenido)
git add .
git commit -m "HU-01: cambio llega a qa"
git push origin qa
```

---

### PASO 11 — Trabajar en HU-01-main

```bash
git switch HU-01-main
# Crear carpeta main/ con HU-01.md en VSCode
git add .
git commit -m "HU-01: agregar archivo HU-01.md en ambiente main"
git push origin HU-01-main
```

---

### PASO 12 — Pasar cambios manualmente a main

```bash
git switch main
# Crear carpeta main/ con HU-01.md en VSCode (mismo contenido)
git add .
git commit -m "HU-01: cambio llega a main"
git push origin main
```

---

## Resultado final en Git Graph

```
main     ←── HU-01-main    ✅
qa       ←── HU-01-qa      ✅
develop  ←── HU-01-develop ✅
```

Cada rama hija sale de su padre de forma independiente, sin cruces entre ambientes.

---

## Comandos clave

| Acción | Comando |
|---|---|
| Crear rama | `git switch -c nombre-rama` |
| Cambiar de rama | `git switch nombre-rama` |
| Ver todas las ramas | `git branch -a` |
| Ver en qué rama estoy | `git branch` |
| Subir rama nueva | `git push origin nombre-rama` |
| Guardar cambios | `git add .` + `git commit -m "mensaje"` |
| Subir cambios | `git push origin nombre-rama` |
| Ver árbol completo | `git --no-pager log --oneline --all --graph` |

