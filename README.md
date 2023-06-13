# Titanic data analysis
Fazendo previsões utilizando dados do Titanic

Making predictions using data from the Titanic

# Instruções (Ambiente Linux)

## Comandos de instalação:

- sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9
- sudo add-apt-repository 'deb https://cloud.r-project.org/bin/linux/ubuntu focal-cran40/'
- sudo apt-get update
- R --version

## Bibliotecas:

- install.packages("sjmisc")
- install.packages("randomForest")
- install.packages("rpart")
- install.packages("rpart.plot")

## Execução:

- Acesse a pasta "Titanic" e execute o seguinte comando: Rscript titanicProblem.R

## Observações:

Para obter o plot da árvore de decisão gerada basta acessar o diratório Titanic e lá estará o plot em formato pdf gerado pelo código. O nome do arquivo é "Rplots"

Caso esteja utilizando o RStudio o plot aparecerá na seção de plots no canto direito da interface da ferramenta.
