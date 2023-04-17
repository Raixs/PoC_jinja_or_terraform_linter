Este script verifica si un archivo contiene sintaxis Jinja, Terraform o ambas.

Y ejecuta un linter diferente según el tipo de archivo.

## Requisitos previos

Para utilizar este script, asegúrate de tener instalado lo siguiente:

-   [TFLint](https://github.com/terraform-linters/tflint) para comprobar la sintaxis de Terraform.
-   [j2lint](https://pypi.org/project/j2lint/) para comprobar la sintaxis de Jinja.

Crea dos carpetas, una llamada `jinja` y la otra llamada `terraform`
Y añade a cada carpeta un fichero valido correspondiente de cada sintaxis.

#### Prueba cada caso de uso:

Jinja:
```sh
./linter2.sh jinja/jinja.tf
```

Terraform:
```sh
./linter2.sh terraform/terraform.tf
```
