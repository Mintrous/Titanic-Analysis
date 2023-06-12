titanic = read.csv("titanic.csv", header = TRUE, sep = ",")

titanicTeste = read.csv("test_titanic.csv", header = TRUE, sep = ",")
titanicTeste

titanicTreino = read.csv("train_titanic.csv", header = TRUE, sep = ",")
passangerId = titanicTreino$PassengerId

titanicTreino = titanicTreino[, -c(9,11,12)]


library(sjmisc)

nrow(titanicTreino)

# Tratamento para Mr.

mr = str_contains(titanicTreino$Name[2], "Mr.", ignore.case = FALSE, logic = NULL, switch = FALSE)
mr

grepl("Mr.", titanicTreino$Name, fixed = TRUE)
idadesMr = c()

for(i in 1:891){
  mr = str_contains(titanicTreino$Name[i], "Mr.", ignore.case = FALSE, logic = NULL, switch = FALSE)
  
  if(mr == TRUE){
    if(is.na(titanicTreino$Age[i])){
      
    }
    else{
      idadesMr[i] = titanicTreino$Age[i]
    }
  }
}
idadesMr

median(idadesMr, na.rm = TRUE)

for(i in 1:891){
  
  mr = str_contains(titanicTreino$Name[i], "Mr.", ignore.case = FALSE, logic = NULL, switch = FALSE)
  
  if(is.na(idadesMr[i]) && mr == TRUE){
    titanicTreino$Age[i] = 30
  }
}
titanicTreino$Age


# Tratamento para Mrs.

mrs = str_contains(titanicTreino$Name[2], "Mrs.", ignore.case = FALSE, logic = NULL, switch = FALSE)
mrs

grepl("Mrs.", titanicTreino$Name, fixed = TRUE)
idadesMrs = c()

for(i in 1:891){
  mrs = str_contains(titanicTreino$Name[i], "Mrs.", ignore.case = FALSE, logic = NULL, switch = FALSE)
  
  if(mrs == TRUE){
    if(is.na(titanicTreino$Age[i])){
      
    }
    else{
      idadesMrs[i] = titanicTreino$Age[i]
    }
  }
}
idadesMrs

median(idadesMrs, na.rm = TRUE)

for(i in 1:891){
  
  mrs = str_contains(titanicTreino$Name[i], "Mrs.", ignore.case = FALSE, logic = NULL, switch = FALSE)
  
  if(is.na(idadesMrs[i]) && mrs == TRUE){
    titanicTreino$Age[i] = 35
  }
}
titanicTreino$Age


# Tratamento para Miss

miss = str_contains(titanicTreino$Name[2], "Miss.", ignore.case = FALSE, logic = NULL, switch = FALSE)
miss

grepl("Miss.", titanicTreino$Name, fixed = TRUE)
idadesMiss = c()

for(i in 1:891){
  miss = str_contains(titanicTreino$Name[i], "Miss.", ignore.case = FALSE, logic = NULL, switch = FALSE)
  
  if(miss == TRUE){
    if(is.na(titanicTreino$Age[i])){
      
    }
    else{
      idadesMiss[i] = titanicTreino$Age[i]
    }
  }
}
idadesMiss

median(idadesMiss, na.rm = TRUE)

for(i in 1:891){
  
  miss = str_contains(titanicTreino$Name[i], "Miss.", ignore.case = FALSE, logic = NULL, switch = FALSE)
  
  if(is.na(idadesMiss[i]) && miss == TRUE){
    titanicTreino$Age[i] = 21
  }
}
titanicTreino$Age


# coletar dados

table(titanicTreino$Sex, titanicTreino$Survived)

titanicTreino$kids = ifelse(titanicTreino$Age < 18, 1, 0)
titanicTreino$kids = as.factor(titanicTreino$kids)

titanicTeste$kids = ifelse(titanicTeste$Age < 18, 1, 0)
titanicTeste$kids = as.factor(titanicTeste$kids)

summary(titanicTeste)
summary(titanicTreino)

titanicTeste = titanicTeste[,-7]
titanicTreino = titanicTreino[,-8]

titanicTeste$Name = as.character(titanicTeste$Name)
titanicTeste$Sex = as.factor(titanicTeste$Sex)
titanicTeste$Pclass = as.factor(titanicTeste$Pclass)

titanicTeste = titanicTeste[, -c(3,9,10)]
str(titanicTeste)

titanicTreino = titanicTreino[, -c(1,4)]
str(titanicTreino)

titanicTreino$Survived = as.factor(titanicTreino$Survived)
titanicTreino$Sex = as.factor(titanicTreino$Sex)
titanicTreino$Pclass = as.factor(titanicTreino$Pclass)


table(titanicTreino$kid, titanicTreino$Survived)

table(titanicTreino$Pclass, titanicTreino$Survived, titanicTreino$Sex)

# 64% dos adultos morreram
# 36% dos adultos sobreviveram

# 46% das crianças morreram
# 54% das crianças sobreviveram

# 26% das mulheres morreram
# 74% das mulheres sobreviveram

# 81% dos homens morreram
# 19% dos homens sobreviveram

# 3% das mulheres de 1ª classe morreram
# 7% das mulheres de 2ª classe morreram
# 50% das mulheres de 3ª classe morreram

# 63% das homens de 1ª classe morreram
# 84% das homens de 2ª classe morreram
# 86% das homens de 3ª classe morreram


library(randomForest)
library(rpart)
library(rpart.plot)

arvoreDecisaoSurvived = rpart(Survived~., data = titanicTreino)
rpart.plot(arvoreDecisaoSurvived)

summary(titanicTeste)
summary(titanicTreino)

previsao = predict(arvoreDecisaoSurvived, newdata = titanicTeste, type = "class")
previsao
summary(previsao)
summary(titanicTeste)
summary(titanicTeste$Survived)

florestaSurvived = randomForest(Survived~., data = titanicTreino, importance = TRUE, prOximity = TRUE, na.action = na.roughfix)
florestaSurvived
summary(titanicTreino)

previsaoForest = predict(florestaSurvived, newdata = titanicTeste, type = "class")
previsaoForest
titanicTeste

sum(is.na(previsaoForest))

submissao = data.frame(PassengerId = titanicTeste$PassengerId, Survived = previsaoForest)
submissao
write.csv(submissao,"Submissao.csv", row.names = FALSE)
head(submissao)
nrow(submissao)

summary(titanicTeste)
