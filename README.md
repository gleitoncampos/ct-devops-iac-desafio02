
### Projeto usando Terraform para subir Wordpress + DB na AWS

### Ajustes e melhorias

O projeto ainda está em desenvolvimento e as próximas atualizações serão voltadas nas seguintes tarefas:

- [x] Iniciar...;
- [x] Replicar manualmente passos a serem feitos;
- [x] Definir se existirão pré-requisitos;
- [x] Replicar em Terraform os passos necessarios
- [ ] Migrar para serviços serverless;
- [ ] Adicionar auto scalling;
- [ ] Substituir resources por modules;
- [ ] Fracionar o projeto em niveis, reduzindo ou eliminando os pré-requisitos;
- [ ] Tornar o projeto flexivel, de forma a ser viavel em mais cenarios;
- [ ] Usar backend remoto com o Terraform;

> More to come...

## 💻 Pré-requisitos

Antes de começar a usar este reopsitorio, é preciso seguir alguns pré-requisotos (que podem mudar ou ser eliminados a qualquer momento, em uma atualização futura):
<!---Estes são apenas requisitos de exemplo. Adicionar, duplicar ou remover conforme necessário--->
* [Criar conta na AWS](https://portal.aws.amazon.com/billing/signup#/start/email) e escolher a região onde irá fazer o deploy (Dar preferencia para us-east1);
* [Criar um usuario  no IAM da AWS para uso com o Terraform:](https://us-east-1.console.aws.amazon.com/iamv2/home?region=us-east-1#/users)
* Criar no sistema local as variaveis de ambiente AWS_ACCESS_KEY_ID e AWS_SECRET_ACCESS_KEY com seus respectivos valores, conforme o user do terraform;
* [Criar na AWS um KeyPair](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#KeyPairs:), anotar seu nome e fazer o download. Ele será usado no processo.
* [Criar na AWS um Elastic IP](https://us-west-1.console.aws.amazon.com/ec2/v2/home?region=us-west-1#KeyPairs:) e anotar seu ID;
* [Criar um volume Elastic Block Store](https://console.aws.amazon.com/ec2/v2/home?region=us-east-1#Volumes:) e anotar seu ID;
* [Instalar o Terraform no ambiente local](https://learn.hashicorp.com/tutorials/terraform/install-cli);

## ☕ Usando o projeto

Para usar o projeto, siga estas etapas:

1. Clone o Repsitorio:
```
git clone https://gitlab.com/gleiton.campos/desafio02-iac.git
cd desafio02-iac/
```
2. Faça uma copia do arquivo "variables.tf.example", renomeie para "variables.tf";
3. Edite o novo arquivo "variables.tf" conforme os dados que forem sendo solicitados;
4. Inicie o Terraform:
```
terraform init
```
5. Valide os arquivos:
```
terraform plan
```
6. Caso tudo esteja ok, executar o deploy:
```
terraform apply
```

No final do processo, após o termino das ações do Terraform, a instancia ainda estará executando o script fornecido. Aguardar cerva de 3~5 minutos para que o site Wordpress esteja no ar no Elastic IP associado.


## 📫 Contribuindo com o projeto
<!---Se o seu README for longo ou se você tiver algum processo ou etapas específicas que deseja que os contribuidores sigam, considere a criação de um arquivo CONTRIBUTING.md separado--->
Este é um lab que será aprimorado com o passar do tempo. Para contribuir com, siga estas etapas:

1. Faça um fork  deste repositório.
2. Crie um branch: `git checkout -b <nome_branch>`.
3. Faça suas alterações e confirme-as: `git commit -m '<mensagem_commit>'`
4. Envie para o branch original: `git push origin <nome_do_projeto> / <local>`
5. Crie a solicitação de pull.

Como alternativa, consulte a documentação do GitLab em [como criar uma solicitação pull](https://help.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-a-pull-request).
