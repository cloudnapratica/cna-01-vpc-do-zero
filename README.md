# Construindo na AWS #1: Criando uma VPC do Zero Utilizando Terraform

Esse projeto contém o código fonte escrito no episódio 1 da série [Construindo na AWS: Criando uma VPC do Zero Utilizando Terraform](https://www.youtube.com/watch?v=5AI7mbh4p08).

## Ambiente de Desenvolvimento

Para rodar esse projeto, você vai precisar ter o Terraform versão 0.14.3 ou superior instalado na sua máquina. Caso você precise baixar o Terraform, você pode fazer isso [clicando aqui](https://www.terraform.io/downloads.html).

## Deploy do Projeto

Para fazer o deploy do projeto você pode executar os comandos listados abaixo. Lembre-se de configurar as credenciais para que o Terraform possa se comunicar com a sua conta na AWS.

O primeiro passo é iniciar o seu projeto Terraform executando o comando abaixo.

```
$ terraform init
```

Depois disso, caso você queria ver apenas um plano do que será feito na sua conta, você pode executar o seguinte comando:

```
$ terraform plan
```

Para criar os recursos na sua conta, você pode executar o comando abaixo e confirmar o plano apresentado.

```
$ terraform apply
```

Se você não quiser manter os recursos na sua conta, você pode destruir toda a infraestrutura com o seguinte comando:

```
$ terraform destroy
```

## Meta

Desenvolvido por [Cloud na Prática](https://cloudnapratica.com).

Distribuído sob a licença do [MIT](LICENSE).
