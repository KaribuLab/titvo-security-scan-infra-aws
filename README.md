# Titvo Security Scan - Infraestructura AWS

Este repositorio contiene la infraestructura como código (IaC) para el sistema de escaneo de seguridad de Titvo. La infraestructura está definida utilizando Terraform y orquestada con Terragrunt para facilitar la gestión de múltiples entornos y regiones.

## Estructura del Proyecto

```
.
├── .github/            # Configuraciones de GitHub y flujos de CI/CD
├── .vscode/            # Configuraciones del IDE VSCode
├── common/             # Módulos de Terraform compartidos entre entornos
│   └── dynamodb/       # Configuración de DynamoDB compartida
├── module/             # Módulos de Terraform reutilizables
│   ├── iam-role/       # Módulo para crear roles IAM
│   ├── s3-static/      # Módulo para crear buckets S3 para contenido estático
│   └── s3-upload/      # Módulo para crear buckets S3 para subida de archivos
├── prod/               # Entorno de producción
│   └── us-east-1/      # Región us-east-1 para producción
│       ├── account/    # Recursos a nivel de cuenta
│       ├── iam/        # Configuración de roles y políticas IAM
│       ├── parameter/  # Parámetros de SSM Parameter Store
│       ├── s3/         # Configuración de buckets S3
│       └── task/       # Recursos específicos de tareas
│           ├── apigateway/ # Configuración de API Gateway
│           └── dynamo/     # Configuración de DynamoDB
├── .gitignore          # Patrones de archivos a ignorar por Git
├── LICENSE             # Licencia Apache 2.0
├── common.hcl          # Variables comunes para todos los entornos
└── terragrunt.hcl      # Configuración principal de Terragrunt
```

## Requisitos Previos

### Herramientas

- [Terraform](https://www.terraform.io/downloads.html) (v1.9.8+)
- [Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/install/) (v0.69.1+)
- Variables de entorno AWS configuradas

### VPC

Para simplificar el despliegue de la infraestructura, se ha creado un script que despliega la infraestructura de VPC y subnets.

> [!NOTE]
> Esto es opcional, si ya tienes una VPC y subnets configuradas puedes omitir este paso.

```bash
cd utils/prod/us-east-1/vpc
terragrunt apply
```

Para que esto sea usado por otros componentes de la plataforma es necesario configurar un parámetro en el SSM Parameter Store.

```bash
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/vpc-id" --type "String" --value "vpc-0577524a0e9871789" --region us-east-1
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/subnet1" --type "String" --value "subnet-0577524a0e9871789" --region us-east-1
```

> [!IMPORTANT]
> El prefijo de la ruta de parámetros se construye a partir de lo que está en el archivo `common.hcl` en la variable `project_name` y el `environment` que se está usando. Es importante mantener el nombre que viene después del prefijo para que el secreto se pueda usar en la aplicación.

### Secret Manager

Para encriptar información sensible se utiliza una key que está almacenada en AWS Secret Manager. Con esta key se encripta la información sensible en tablas de DynamoDB. Es necesario crear un secreto en AWS Secret Manager con la siguiente información:

```bash
aws secretsmanager create-secret --name "/tvo/security-scan/prod/aes_secret" --secret-string "my-secret-key" --region us-east-1
```

Luego necesitamos almacenar el ARN y el nombre del secreto en el SSM Parameter Store.

```bash
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/encryption-key-name" --type "String" --value "tvo/security-scan/prod/aes_secret" --region us-east-1
aws ssm put-parameter --name "/tvo/security-scan/prod/infra/secret-manager-arn" --type "String" --value "arn:aws:secretsmanager:us-east-1:123456789012:secret:tvo/security-scan/prod/aes_secret-a1b2c3" --region us-east-1
```

> [!IMPORTANT]
> El prefijo de la ruta de parámetros se construye a partir de lo que está en el archivo `common.hcl` en la variable `project_name` y el `environment` que se está usando. Es importante mantener el nombre que viene después del prefijo para que el secreto se pueda usar en la aplicación.

## Configuración

1. Clona este repositorio:
   ```bash
   git clone https://github.com/KaribuLab/titvo-security-scan-infra-aws
   cd titvo-security-scan-infra-aws
   ```

## Uso

### Despliegue de Infraestructura

Como paso opcional puedes crear un archivo `common_tags.json` en la raíz del proyecto con las etiquetas que quieres aplicar a todos los recursos.

```json
{
  "Project": "Titvo Security Scan",
  "Customer": "Titvo",
  "Team": "Area Creacion"
}
```

1. Configura las variables de entorno para AWS:
   ```bash
   export AWS_ACCESS_KEY_ID="tu_access_key"
   export AWS_SECRET_ACCESS_KEY="tu_secret_key"
   export AWS_DEFAULT_REGION="us-east-1"
   export PROJECT_NAME="titvo-security-scan" # Opcional si quiere mantener los valores por defecto. Esto se usará como prefijo para los recursos
   export PARAMETER_PATH="/titvo/security-scan" # Opcional si quiere mantener los valores por defecto. Esto se usará como prefijo para los parámetros
   export BUCKET_STATE_NAME="titvo-security-scan-terraform-state" # Opcional, si no se especifica se usará el nombre del proyecto. Por ejemplo: titvo-security-scan-terraform-state
   ```
   
   También puedes añadir estas variables a tu archivo `.env` (asegúrate de no incluirlo en el control de versiones):
   ```bash
   export AWS_ACCESS_KEY_ID="tu_access_key"
   export AWS_SECRET_ACCESS_KEY="tu_secret_key"
   export AWS_DEFAULT_REGION="us-east-1"
   export PROJECT_NAME="titvo-security-scan" # Opcional si quiere mantener los valores por defecto. Esto se usará como prefijo para los recursos
   export PARAMETER_PATH="/titvo/security-scan" # Esto se usará como prefijo para los parámetros
   export BUCKET_STATE_NAME="titvo-security-scan-terraform-state" # Opcional, si no se especifica se usará el nombre del proyecto. Por ejemplo: titvo-security-scan-terraform-state
   ```
   
   Y cargarlas con:
   ```bash
   source .env
   ```

   > [!IMPORTANT]
   > Se recomienda usar la variable `BUCKET_STATE_NAME` para mantener el estado de la infraestructura, ya que estos son únicos y podrían haber conflictos si se usa el mismo nombre para diferentes proyectos.

2. Ahora deberá crear todos los recursos sin incluir el API Gateway:

    ```bash
    cd prod/us-east-1
    cwd=$(pwd)
    cd $cwd/account/dynamo/apikey
    terragrunt apply
    cd $cwd/account/dynamo/repository
    terragrunt apply
    cd $cwd/account/dynamo/user
    terragrunt apply
    cd $cwd/parameter/dynamo/parameter
    terragrunt apply
    cd $cwd/s3/cli-files
    terragrunt apply
    cd $cwd/s3/reports
    terragrunt apply
    cd $cwd/task/dynamo/cli-files
    terragrunt apply
    cd $cwd/task/dynamo/task
    terragrunt apply
    ```

3. Luego, debes desplegar Batch Job Definition y Job Queue (y otros recursos necesarios):

   - [titvo-security-scan](https://github.com/KaribuLab/titvo-security-scan)

4. Luego, deberá desplegar todas las funciones lambda:

   - [titvo-auth-setup](https://github.com/KaribuLab/titvo-auth-setup)
   - [titvo-task-cli-files](https://github.com/KaribuLab/titvo-task-cli-files)
   - [titvo-task-trigger](https://github.com/KaribuLab/titvo-task-trigger)
   - [titvo-task-status](https://github.com/KaribuLab/titvo-task-status)

   > [!IMPORTANT]
   > Cada repositorio tiene su propio README con instrucciones para desplegar la infraestructura.

5. Por último, deberá desplegar el API Gateway:

  ```bash
  cd prod/us-east-1
  cwd=$(pwd)
  cd $cwd/account/apigateway
  terragrunt apply
  cd $cwd/task/apigateway
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

- **DynamoDB**:
  - **apikey**: Almacena las claves de API para la autenticación de clientes.
  - **repository**: Almacena información sobre los repositorios escaneados.
  - **user**: Gestiona los usuarios del sistema.
  - **task**: Almacena las tareas de escaneo y sus estados.
  - **cli-files**: Guarda información sobre los archivos de resultados del CLI.

- **S3**:
  - **cli-files**: Almacena los archivos subidos por el CLI de escaneo.
  - **reports**: Almacena los informes generados de los escaneos.

- **IAM**:
  - Roles y políticas para los distintos servicios y funciones Lambda.

- **API Gateway**: 
  - Endpoints para interactuar con el sistema de escaneo.
  - Rutas para la autenticación y operaciones de escaneo.

- **Parameter Store**:
  - Almacena parámetros de configuración y secretos.

- **Lambda**:
  - **auth-setup**: Gestiona la autenticación y configuración inicial.
  - **task-cli-files**: Procesa los archivos subidos por el CLI.
  - **task-trigger**: Inicia tareas de escaneo.
  - **task-status**: Actualiza y consulta el estado de las tareas.

- **Batch**:
  - **Job Definition**: Define el trabajo a realizar.
  - **Job Queue**: Cola de trabajos.

## Contribución

1. Crea una rama para tu característica (`git checkout -b feature/amazing-feature`)
2. Realiza tus cambios
3. Haz commit de tus cambios (`git commit -m 'Add some amazing feature'`)
4. Sube tu rama (`git push origin feature/amazing-feature`)
5. Abre un Pull Request

## Contacto

Equipo de Area Creación - Titvo 

## Licencia

Este proyecto está licenciado bajo los términos de la [Licencia Apache 2.0](LICENSE). Consulte el archivo LICENSE para más detalles. 