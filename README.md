# Acre Facturación

Sistema administrativo desarrollado en **ASP.NET Core MVC, Entity Framework Core y MySQL** para gestionar clientes, productos, inventario, facturación, reportes y bitácora de eventos.

El proyecto fue desarrollado como prueba técnica, aplicando buenas prácticas de organización, validaciones, manejo de errores, autenticación, persistencia en base de datos relacional, documentación y control de versiones con Git.

---

## Versión final

La versión final del proyecto se encuentra en la rama principal:

```bash
master
```

Para revisar o ejecutar el sistema, se debe clonar el repositorio y trabajar directamente sobre `master`.

---

## Requisitos previos

Para ejecutar el proyecto en un equipo local se necesita:

* .NET SDK 10
* MySQL Server
* Git
* Visual Studio 2022 o Visual Studio Code
* MySQL Workbench o consola MySQL

Verificación rápida:

```bash
dotnet --version
mysql --version
git --version
```

Si el comando `dotnet ef` no está disponible, instalar la herramienta de Entity Framework Core:

```bash
dotnet tool install --global dotnet-ef
```

Si ya está instalada:

```bash
dotnet tool update --global dotnet-ef
```

---

## Tecnologías utilizadas

* C#
* ASP.NET Core MVC
* .NET 10
* Entity Framework Core
* MySQL
* Pomelo EntityFrameworkCore MySQL
* Razor Views
* Bootstrap
* Cookie Authentication
* JWT Bearer Authentication
* Swagger / OpenAPI
* IMemoryCache
* Stored Procedures
* Git / GitHub

---

## Funcionalidades principales

### Clientes

El sistema permite:

* Crear clientes
* Editar clientes
* Listar clientes
* Buscar clientes por nombre, identidad/RTN o correo
* Activar y desactivar clientes
* Validar campos obligatorios
* Paginar el listado

Campos principales:

* Nombre
* Identidad / RTN
* Teléfono
* Correo
* Fecha de registro
* Estado

---

### Productos

El sistema permite:

* Crear productos
* Editar productos
* Listar productos
* Buscar productos por nombre o código
* Activar y desactivar productos
* Controlar stock disponible
* Validar datos de entrada
* Paginar el listado

Campos principales:

* Nombre
* Código
* Precio
* Stock
* Estado

---

### Facturación

El módulo de facturación permite:

* Crear facturas
* Seleccionar cliente
* Agregar productos
* Validar stock disponible
* Calcular subtotal
* Calcular ISV del 15%
* Calcular total
* Descontar inventario automáticamente
* Generar número de factura
* Consultar detalle de factura
* Imprimir factura en formato limpio

La factura incluye:

* Número de factura
* Cliente
* Fecha
* Productos
* Cantidad
* Precio unitario
* Subtotal
* ISV
* Total

---

### Reportes

El sistema incluye reportes administrativos:

* Top productos más vendidos
* Clientes con mayor facturación
* Inventario bajo

Los reportes están disponibles desde la interfaz web y también mediante procedimientos almacenados SQL.

---

### Logs / Bitácora

El sistema registra eventos relevantes como:

* Errores del sistema
* Excepciones importantes
* Intentos fallidos de login
* Stock insuficiente
* Inicio de sesión
* Cierre de sesión

Los logs se almacenan en:

* Tabla `ErrorLogs`
* Archivos `.txt` dentro de la carpeta `Logs`

---

## Seguridad y autenticación

El sistema incluye autenticación para proteger las vistas principales.

Credenciales iniciales del sistema web:

```text
Usuario: admin
Contraseña: Admin123*
```

Características implementadas:

* Login MVC con cookies
* Logout
* Contraseña almacenada con hash usando BCrypt
* Rutas protegidas con `[Authorize]`
* Registro de intentos fallidos de acceso
* Visualización del usuario autenticado en la interfaz

---

## API REST y JWT

Además de las vistas MVC, el sistema expone una API REST protegida con JWT Bearer.

Endpoints disponibles:

```http
POST /api/auth/login
GET  /api/clientes
GET  /api/productos
GET  /api/reportes/inventario-bajo
```

El endpoint `/api/auth/login` genera un token JWT.
Los demás endpoints requieren autorización mediante Bearer Token.

Ejemplo de body para login API:

```json
{
  "nombreUsuario": "admin",
  "password": "Admin123*"
}
```

---

## Swagger

Swagger está disponible para documentar y probar la API REST.

Ruta:

```text
/swagger
```

Desde Swagger se puede:

* Probar el login API
* Obtener un token JWT
* Autorizar endpoints protegidos
* Consultar clientes, productos e inventario bajo en formato JSON

---

## Procedimientos almacenados

El proyecto incluye procedimientos almacenados en:

```text
AcreFacturacion.Web/Database/03_stored_procedures.sql
```

Procedimientos incluidos:

```sql
sp_top_productos_vendidos
sp_clientes_mayor_facturacion
sp_inventario_bajo
sp_facturas_por_fecha
```

Ejemplos de ejecución:

```sql
CALL sp_top_productos_vendidos();
CALL sp_clientes_mayor_facturacion();
CALL sp_inventario_bajo();
CALL sp_facturas_por_fecha('2026-01-01', '2026-12-31');
```

---

## Cache

Se implementó `IMemoryCache` para optimizar consultas repetidas en secciones de lectura.

Aplicado en:

* Dashboard
* Reportes

No se aplica cache en facturación ni en actualización de inventario para mantener consistencia en operaciones críticas.

---

## Estructura general del proyecto

```text
AcreFacturacion
│
├── AcreFacturacion.Web
│   ├── Controllers
│   │   ├── AccountController.cs
│   │   ├── ClientesController.cs
│   │   ├── ProductosController.cs
│   │   ├── FacturasController.cs
│   │   ├── ReportesController.cs
│   │   ├── HomeController.cs
│   │   └── Api
│   │       ├── AuthApiController.cs
│   │       ├── ClientesApiController.cs
│   │       ├── ProductosApiController.cs
│   │       └── ReportesApiController.cs
│   │
│   ├── Data
│   ├── Models
│   ├── Services
│   ├── ViewModels
│   ├── Views
│   ├── Database
│   ├── Logs
│   ├── Migrations
│   ├── wwwroot
│   ├── appsettings.json
│   └── Program.cs
│
├── README.md
└── .gitignore
```

---

## Configuración de base de datos

El proyecto utiliza **MySQL** como motor de base de datos.

La aplicación no se conecta a una base remota incluida en el repositorio. Cada equipo que ejecute el proyecto debe tener MySQL instalado y preparar su propia base de datos local.

La cadena de conexión se configura en:

```text
AcreFacturacion.Web/appsettings.json
```

Credenciales sugeridas para entorno local de prueba:

```text
Base de datos: acrefacturacion_db
Usuario MySQL: acrefacturacion_user
Contraseña MySQL: Acre2026*
```

Estas credenciales son únicamente para ambiente local de prueba. Pueden modificarse según la configuración del equipo donde se ejecute el proyecto.

Ejemplo de cadena de conexión:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "server=localhost;database=acrefacturacion_db;user=acrefacturacion_user;password=Acre2026*;"
  }
}
```

Si el evaluador utiliza otro usuario o contraseña de MySQL, debe actualizar el valor de `DefaultConnection` en `appsettings.json`.

---

## Archivos SQL incluidos

Dentro de la carpeta `Database` se incluyen scripts para creación, reportes, procedimientos almacenados, datos demo y respaldo:

```text
AcreFacturacion.Web/Database/01_create_database.sql
AcreFacturacion.Web/Database/02_reportes.sql
AcreFacturacion.Web/Database/03_stored_procedures.sql
AcreFacturacion.Web/Database/04_seed_demo_data.sql
AcreFacturacion.Web/Database/backup_acrefacturacion_final.sql
```

Método recomendado para preparar la base de datos:

```text
1. Ejecutar 01_create_database.sql
2. Ejecutar dotnet ef database update
3. Ejecutar 03_stored_procedures.sql
4. Ejecutar 04_seed_demo_data.sql
```

El archivo `backup_acrefacturacion_final.sql` se incluye como respaldo de referencia. Para una instalación limpia se recomienda usar los scripts en el orden indicado.

---

## Preparación rápida de la base de datos

### 1. Crear base de datos y usuario

Entrar a MySQL como usuario administrador:

```bash
mysql -u root -p
```

Ejecutar el script de creación:

```sql
SOURCE C:/ruta-del-proyecto/AcreFacturacion.Web/Database/01_create_database.sql;
```

Ejemplo en Windows:

```sql
SOURCE C:/Repos/AcreFacturacion/AcreFacturacion.Web/Database/01_create_database.sql;
```

Este script prepara la base de datos `acrefacturacion_db` y el usuario local sugerido `acrefacturacion_user`.

Si se prefiere crear la base manualmente, se puede usar esta estructura:

```sql
CREATE DATABASE IF NOT EXISTS acrefacturacion_db
CHARACTER SET utf8mb4
COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'acrefacturacion_user'@'localhost'
IDENTIFIED BY 'Acre2026*';

GRANT ALL PRIVILEGES ON acrefacturacion_db.*
TO 'acrefacturacion_user'@'localhost';

FLUSH PRIVILEGES;
```

Salir de MySQL:

```sql
EXIT;
```

---

### 2. Aplicar migraciones

Desde la carpeta del proyecto web:

```bash
cd AcreFacturacion.Web
dotnet ef database update
```

Esto crea las tablas principales del sistema:

```text
Clientes
Productos
Facturas
FacturaDetalles
ErrorLogs
Usuarios
```

---

### 3. Cargar procedimientos almacenados

Entrar nuevamente a MySQL:

```bash
mysql -u acrefacturacion_user -p acrefacturacion_db
```

Ejecutar:

```sql
SOURCE C:/ruta-del-proyecto/AcreFacturacion.Web/Database/03_stored_procedures.sql;
```

Ejemplo en Windows:

```sql
SOURCE C:/Repos/AcreFacturacion/AcreFacturacion.Web/Database/03_stored_procedures.sql;
```

---

### 4. Cargar datos demo

Desde MySQL:

```sql
SOURCE C:/ruta-del-proyecto/AcreFacturacion.Web/Database/04_seed_demo_data.sql;
```

Ejemplo en Windows:

```sql
SOURCE C:/Repos/AcreFacturacion/AcreFacturacion.Web/Database/04_seed_demo_data.sql;
```

Este script carga datos de prueba para clientes, productos, facturas y detalles de factura.

Verificación rápida:

```sql
SELECT COUNT(*) FROM clientes;
SELECT COUNT(*) FROM productos;
SELECT COUNT(*) FROM facturas;
SELECT COUNT(*) FROM facturadetalles;
```

Resultado esperado:

```text
clientes: 5
productos: 7
facturas: 3
facturadetalles: 7
```

Salir de MySQL:

```sql
EXIT;
```

---

## Cómo ejecutar el proyecto

### 1. Clonar el repositorio

```bash
git clone https://github.com/JoseDevAmaya/AcreFacturacion.git
cd AcreFacturacion
```

### 2. Entrar al proyecto web

```bash
cd AcreFacturacion.Web
```

### 3. Restaurar paquetes

```bash
dotnet restore
```

### 4. Configurar la cadena de conexión

Editar el archivo:

```text
AcreFacturacion.Web/appsettings.json
```

Confirmar que la cadena de conexión coincida con la configuración local de MySQL:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "server=localhost;database=acrefacturacion_db;user=acrefacturacion_user;password=Acre2026*;"
  }
}
```

### 5. Aplicar migraciones

```bash
dotnet ef database update
```

### 6. Ejecutar el proyecto

```bash
dotnet run
```

Luego abrir en el navegador la URL indicada por consola, por ejemplo:

```text
http://localhost:5119
```

o:

```text
http://localhost:5000
```

---

## Acceso al sistema

```text
Usuario: admin
Contraseña: Admin123*
```

---

## Pruebas recomendadas

### Flujo MVC

1. Iniciar sesión.
2. Revisar el panel principal.
3. Crear un cliente.
4. Crear un producto.
5. Crear una factura.
6. Validar cálculo de subtotal, ISV y total.
7. Confirmar descuento automático de inventario.
8. Revisar reportes.
9. Imprimir detalle de factura.
10. Cerrar sesión.
11. Intentar acceder a una ruta protegida sin sesión.

### Flujo API / JWT

1. Abrir `/swagger`.
2. Ejecutar `POST /api/auth/login`.
3. Copiar el token generado.
4. Autorizar Swagger con Bearer Token.
5. Probar:

   * `GET /api/clientes`
   * `GET /api/productos`
   * `GET /api/reportes/inventario-bajo`
6. Confirmar respuesta `200 OK`.
7. Probar sin token y confirmar respuesta `401 Unauthorized`.

### Procedimientos almacenados

En MySQL:

```sql
CALL sp_top_productos_vendidos();
CALL sp_clientes_mayor_facturacion();
CALL sp_inventario_bajo();
CALL sp_facturas_por_fecha('2026-01-01', '2026-12-31');
```

---

## Decisiones técnicas

### ASP.NET Core MVC

Se utilizó MVC para construir un sistema administrativo con separación clara entre controladores, modelos, vistas y servicios.

### Entity Framework Core

Se usó EF Core para manejar el acceso a datos, relaciones, migraciones, restricciones e índices.

### MySQL

La base de datos se diseñó en MySQL, cumpliendo con el requerimiento de trabajar con una base relacional, llaves primarias, foráneas e índices.

### Autenticación por cookies

Las vistas MVC utilizan autenticación por cookies, adecuada para navegación web tradicional.

### JWT para API

Los endpoints API utilizan JWT Bearer para permitir consumo externo seguro desde Swagger, Postman u otros clientes.

### Logs

Se implementó una bitácora para registrar eventos importantes tanto en base de datos como en archivos de texto.

### Cache

Se aplicó cache únicamente en consultas de lectura, evitando usarlo en facturación o inventario para no comprometer la consistencia de datos.



@JOSE OLIVEROS
