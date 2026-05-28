# Acre Facturación

Sistema administrativo desarrollado en **ASP.NET Core MVC, Entity Framework Core y MySQL** para gestionar clientes, productos, inventario, facturación básica, reportes y bitácora de eventos.

El proyecto fue desarrollado como prueba técnica, aplicando buenas prácticas de organización, validaciones, manejo de errores, persistencia con base de datos relacional, control de versiones con Git y documentación técnica.

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

## Funcionalidades principales
### Clientes

El sistema permite:

* Crear clientes
* Editar clientes
* Listar clientes
* Buscar clientes por nombre, identidad/RTN o correo
* Activar y desactivar clientes
* Validar campos obligatorios
* Paginación en el listado
Campos principales:
* Nombre
* Identidad / RTN
* Teléfono
* Correo
* Fecha de registro
* Estado
### Productos
El sistema permite:
* Crear productos
* Editar productos
* Listar productos
* Buscar productos por nombre o código
* Activar y desactivar productos
* Controlar stock disponible
* Validar datos de entrada
* Paginación en el listado
Campos principales:
* Nombre
* Código
* Precio
* Stock
* Estado
### Facturación

El módulo de facturación permite:

* Crear facturas
* Seleccionar cliente
* Agregar múltiples productos
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

### Reportes

El sistema incluye reportes administrativos:

* Top productos más vendidos
* Clientes con mayor facturación
* Inventario bajo

Los reportes se encuentran disponibles desde la interfaz web y también mediante procedimientos almacenados SQL

### Logs / Bitácora

El sistema registra eventos relevantes como:

* Errores del sistema
* Excepciones importantes
* Intentos fallidos de login
* Stock insuficiente
* Inicio y cierre de sesión

Los logs se almacenan en:

* Tabla `ErrorLogs`
* Archivos `.txt` dentro de la carpeta `Logs`

## Seguridad y autenticación

El sistema incluye autenticación para proteger las vistas principales.

Usuario inicial:

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
---

## Cache

Se implementó `IMemoryCache` para optimizar consultas repetidas en secciones de lectura.

Aplicado en:

* Dashboard
* Reportes

No se aplica cache en facturación ni en actualización de inventario, para mantener consistencia en operaciones críticas.

## Estructura del proyecto

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

## Base de datos

La cadena de conexión se configura en:

```text
AcreFacturacion.Web/appsettings.json
```

Ejemplo:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "server=localhost;database=acrefacturacion_db;user=acrefacturacion_user;password=TU_PASSWORD;"
  }
}
```

---

## Archivos SQL incluidos

Dentro de la carpeta `Database` se incluyen scripts para creación, reportes, procedimientos almacenados y respaldo:

```text
AcreFacturacion.Web/Database/01_create_database.sql
AcreFacturacion.Web/Database/02_reportes.sql
AcreFacturacion.Web/Database/03_stored_procedures.sql
AcreFacturacion.Web/Database/backup_acrefacturacion_final.sql
```

---

## Cómo ejecutar el proyecto

### 1. Clonar el repositorio

```bash
git clone https://github.com/JoseDevAmaya/AcreFacturacion.git
cd AcreFacturacion
```
### 2. Restaurar paquetes

```bash
cd AcreFacturacion.Web
dotnet restore
```

### 3. Configurar la cadena de conexión

Editar el archivo:

```text
AcreFacturacion.Web/appsettings.json
```

Configurar los datos de conexión a MySQL.

### 4. Aplicar migraciones

```bash
dotnet ef database update
```

### 5. Ejecutar

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

