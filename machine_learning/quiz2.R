#q2
library(AppliedPredictiveModeling)
data(concrete)
library(caret)
set.seed(975)
inTrain = createDataPartition(mixtures$CompressiveStrength, p = 3/4)[[1]]
training = mixtures[ inTrain,]
testing = mixtures[-inTrain,]

qplot(, CompressiveStrength, data = training,)

#q3
qplot(Superplasticizer, data = training)

#q4
set.seed(3433)
data(AlzheimerDisease)
adData = data.frame(diagnosis,predictors)
inTrain = createDataPartition(adData$diagnosis, p = 3/4)[[1]]
training = adData[ inTrain,]
testing = adData[-inTrain,]

library(dplyr)
train.IL <- select(training, diagnosis, starts_with('IL'))
preProcess(select(train.IL, starts_with('IL')), thresh = .8, method='pca')

#q5
train(diagnosis ~ ., data = train.IL, method = 'glm')
train(diagnosis ~ ., data = train.IL, method = 'glm', preProcess=c('pca'))

install.packages('caret', dependencies = TRUE)

