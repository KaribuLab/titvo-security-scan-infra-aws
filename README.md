# Titvo Security Scan - Infraestructura AWS

Este repositorio contiene la infraestructura como código (IaC) para el sistema de escaneo de seguridad de Titvo. La infraestructura está definida utilizando Terraform y orquestada con Terragrunt para facilitar la gestión de múltiples entornos y regiones.

## Estructura del Proyecto

```
.
├── .github/            # Configuraciones de GitHub y flujos de CI/CD
├── common/             # Módulos de Terraform compartidos entre entornos
│   └── dynamodb/       # Configuración de DynamoDB compartida
├── prod/               # Entorno de producción
│   └── us-east-1/      # Región us-east-1 para producción
│       ├── account/    # Recursos a nivel de cuenta
│       └── task/       # Recursos específicos de tareas
│           ├── apigateway/ # Configuración de API Gateway
│           └── dynamo/     # Configuración de DynamoDB
├── common.hcl          # Variables comunes para todos los entornos
└── terragrunt.hcl      # Configuración principal de Terragrunt
```

## Requisitos Previos

- [Terraform](https://www.terraform.io/downloads.html) (v1.9.8+)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) (v0.69.1+)
- Variables de entorno AWS configuradas

## Configuración

1. Clona este repositorio:
   ```bash
   git clone https://github.com/KaribuLab/titvo-security-scan-infra-aws
   cd titvo-security-scan-infra
   ```

2. Configura las variables de entorno para AWS:
   ```bash
   export AWS_ACCESS_KEY_ID="tu_access_key"
   export AWS_SECRET_ACCESS_KEY="tu_secret_key"
   export AWS_DEFAULT_REGION="us-east-1"
   ```
   
   También puedes añadir estas variables a tu archivo `.env` (asegúrate de no incluirlo en el control de versiones):
   ```bash
   export AWS_ACCESS_KEY_ID="tu_access_key"
   export AWS_SECRET_ACCESS_KEY="tu_secret_key"
   export AWS_DEFAULT_REGION="us-east-1"
   ```
   
   Y cargarlas con:
   ```bash
   source .env
   ```

## Uso

### Despliegue de Infraestructura

Antes desplegar la infraestructura deberá desplegar todas las funciones lambda:

- [titvo-auth-setup](https://github.com/KaribuLab/titvo-auth-setup)
- [titvo-task-cli-files](https://github.com/KaribuLab/titvo-task-cli-files)
- [titvo-task-trigger](https://github.com/KaribuLab/titvo-task-trigger)
- [titvo-task-status](https://github.com/KaribuLab/titvo-task-status)

> [!IMPORTANT]
> Cada repositorio tiene su propio README con instrucciones para desplegar la infraestructura.

Luego, modificar el archivo `common.hcl` para ajustar los valores usados en el proyecto para tu cuenta de AWS.

```hcl
locals {
  project_name   = "my-project"
  parameter_path = "/my-project"
  bucket_name    = "${local.project_name}-terraform-state"
  dynamodb_table = "${local.project_name}-tfstate-lock"
  tags = {
    my_tag = "my_value"
  }
}
```

Para desplegar todos los recursos en un entorno específico:

```bash
cd prod/us-east-1
terragrunt run-all apply
```

Para desplegar un componente específico:

```bash
cd prod/us-east-1/task/dynamo
terragrunt apply
```

### Destrucción de Infraestructura

Para destruir todos los recursos en un entorno específico:

```bash
cd prod/us-east-1
terragrunt run-all destroy
```

## Entornos

El proyecto está configurado para soportar múltiples entornos:

- **prod**: Entorno de producción

## Componentes Principales

- **DynamoDB**: Almacenamiento de datos para los resultados de escaneo de seguridad
- **API Gateway**: Endpoints para interactuar con el sistema de escaneo

## Contribución

1. Crea una rama para tu característica (`git checkout -b feature/amazing-feature`)
2. Realiza tus cambios
3. Haz commit de tus cambios (`git commit -m 'Add some amazing feature'`)
4. Sube tu rama (`git push origin feature/amazing-feature`)
5. Abre un Pull Request

## Contacto

Equipo de Area Creación - Titvo 