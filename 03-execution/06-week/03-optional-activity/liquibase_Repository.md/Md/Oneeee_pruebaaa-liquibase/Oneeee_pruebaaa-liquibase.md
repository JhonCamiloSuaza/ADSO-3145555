# Flujo Git — Estrategia por Ambientes (Estilo Nicolas)

Repositorio: `Oneeee_pruebaaa-liquibase`  
Estrategia de trabajo por ambientes usando ramas hijas por HU.

---

## Estructura de ramas

```
main
 └── develop
      └── qa
```

- `develop` nace desde `main`
- `qa` nace desde `develop`
- Cada padre tiene su propia rama hija

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
git clone https://github.com/JhonCamiloSuaza/Oneeee_pruebaaa-liquibase.git
cd Oneeee_pruebaaa-liquibase
```

---

### PASO 2 — Primer commit en main

```bash
echo "# Oneeee_pruebaaa-liquibase" > README.md
git add .
git commit -m "Initial commit"
git push -u origin main
```

---

### PASO 3 — Crear develop desde main

```bash
git switch -c develop
echo "# rama develop" > develop.md
git add .
git commit -m "inicio develop"
git push -u origin develop
```

---

### PASO 4 — Crear qa desde develop

⚠️ NO hacer `git switch main` antes. `qa` debe nacer desde `develop`.

```bash
git switch -c qa
echo "# rama qa" > qa.md
git add .
git commit -m "inicio qa"
git push -u origin qa
```

---

### PASO 5 — Crear las 3 ramas hijas

```bash
# Hija de develop
git switch develop
git switch -c HU-01-develop
git push -u origin HU-01-develop

# Hija de qa
git switch qa
git switch -c HU-01-qa
git push -u origin HU-01-qa

# Hija de main
git switch main
git switch -c HU-01-main
git push -u origin HU-01-main
```

---

### PASO 6 — Trabajar en HU-01-develop

Crear carpeta `develop/` con archivo `HU-01.md` en VSCode:

```bash
git switch HU-01-develop
git add .
git commit -m "HU-01: add HU-01.md file in develop environment"
git push origin HU-01-develop
```

---

### PASO 7 — Pasar cambios a develop

Copiar carpeta `develop/HU-01.md` manualmente en VSCode:

```bash
git switch develop
git add .
git commit -m "HU-01: change reaches develop"
git push origin develop
```

---

### PASO 8 — Trabajar en HU-01-qa

Crear carpeta `qa/` con archivo `HU-01.md` en VSCode:

```bash
git switch HU-01-qa
git add .
git commit -m "HU-01: add HU-01.md file in qa environment"
git push origin HU-01-qa
```

---

### PASO 9 — Pasar cambios a qa

Copiar carpeta `qa/HU-01.md` manualmente en VSCode:

```bash
git switch qa
git add .
git commit -m "HU-01: change reaches qa"
git push origin qa
```

---

### PASO 10 — Trabajar en HU-01-main

Crear carpeta `main/` con archivo `HU-01.md` en VSCode:

```bash
git switch HU-01-main
git add .
git commit -m "HU-01: add HU-01.md file in main environment"
git push origin HU-01-main
```

---

### PASO 11 — Pasar cambios a main

Copiar carpeta `main/HU-01.md` manualmente en VSCode:

```bash
git switch main
git add .
git commit -m "HU-01: change reaches main"
git push origin main
```

---

## Resultado final en Git Graph

```
main     ←── HU-01-main    ✅
qa       ←── HU-01-qa      ✅
develop  ←── HU-01-develop ✅
inicio qa      (qa nació desde develop)
inicio develop (develop nació desde main)
Initial commit (base en main)
```

---

## Reglas importantes

| ✅ Se debe hacer | ❌ No se debe hacer |
|---|---|
| `develop` nace desde `main` | Commits directos en ramas padre |
| `qa` nace desde `develop` | Hacer `git switch main` antes de crear `qa` |
| Trabajar siempre en la rama hija | Mezclar cambios entre ambientes |
| Comentarios en inglés | Mezclar idiomas en los commits |

---

## Comandos clave

| Acción | Comando |
|---|---|
| Crear rama | `git switch -c nombre-rama` |
| Cambiar de rama | `git switch nombre-rama` |
| Ver todas las ramas | `git branch -a` |
| Ver rama actual | `git branch` |
| Subir rama nueva | `git push -u origin nombre-rama` |
| Guardar cambios | `git add .` + `git commit -m "mensaje"` |
| Subir cambios | `git push origin nombre-rama` |
| Ver árbol completo | `git --no-pager log --oneline --all --graph` |

