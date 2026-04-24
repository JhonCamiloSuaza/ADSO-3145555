# 🎨 08. LA CARA DEL SISTEMA: EXPLICACIÓN DEL FRONTEND

> 💡 **PARA ALGUIEN QUE NO SABE:** Imagina que el Frontend es la **Vitrina de una Tienda**. Los maniquíes son el HTML, la decoración es el CSS, y el Vendedor que te atiende y anota tu pedido es el JavaScript.

---

## 🏗️ El Concepto: "SPA (Single Page Application)"
Nuestra web es moderna. No se recarga cada vez que das clic. En lugar de eso, JavaScript cambia el contenido de la pantalla al instante. Esto hace que la aplicación sea muy rápida y fluida para el usuario.

### 📂 1. El Archivo `index.html` (El Esqueleto / Los Cimientos)
*   **Responsabilidad:** Definir la estructura visual. Es el mapa que le dice al navegador dónde van los botones y las tablas.
*   **Lenguaje Sencillo:** Es la tienda vacía. Sin esto, no hay nada que ver.
*   **Término Técnico:** **HTML5 DOM**.
*   **Ejemplo de Código (El `<select>` de género):**
    ```html
    <select id="usuario-genero">
        <option value="Masculino">Masculino</option>
        <option value="Femenino">Femenino</option>
        <option value="No Binario">No Binario</option>
    </select>
    ```

### 📂 2. La Carpeta `css` (La Fachada / La Estética)
*   **Responsabilidad:** Embellecer la página. Se encarga de los colores, los bordes redondeados y de que todo esté bien alineado.
*   **Lenguaje Sencillo:** Es la pintura y la decoración de la tienda.
*   **Término Técnico:** **CSS3 (Cascading Style Sheets)**.

### 📂 3. La Carpeta `js` (El Empleado / La Inteligencia)
Aquí es donde ocurre la comunicación con el Backend. Está dividida para que sea organizada:

*   **`api.js` (La Central de Comunicaciones):** Es el que sabe marcar el número del servidor. Usa una herramienta llamada **Axios** para enviar mensajes JSON a través de internet.
*   **`usuarios.js` (El Gerente de Usuarios):** Es el que sabe todo sobre los clientes. Sabe cómo atrapar el género que elegiste y mandárselo al "Mesero" del Backend.
*   **`app.js` (El Coordinador):** Es el que se encarga de que cuando des clic en "Libros", la sección de "Usuarios" se oculte mágicamente.

---

## 🔌 ¿Cómo se conectan el Frontend y el Backend?
Si te preguntan cómo "hablan" las dos carpetas:
*   **Respuesta:** Usamos el protocolo **HTTP** y enviamos datos en formato **JSON**. El Frontend (JavaScript) hace una petición `POST` o `PUT` a la URL `http://localhost:8080/api/v1/usuarios` y el Backend le responde si todo salió bien o mal.

---

## 🔗 Links para Demostración en Vivo
*   **Swagger (Ver el flujo técnico):** [http://localhost:8080/swagger-ui/index.html#/Usuarios/create](http://localhost:8080/swagger-ui/index.html#/Usuarios/create)
*   **URL para usar en Postman:** [http://localhost:8080/api/v1/usuarios](http://localhost:8080/api/v1/usuarios)
*   **Página Web:** Solo abre tu archivo `index.html` local en Chrome o Edge.
