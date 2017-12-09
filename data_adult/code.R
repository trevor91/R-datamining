train<-read.csv("train_adult.csv",stringsAsFactors=T)
test<-read.csv("test_adult.csv",stringsAsFactors=T)
train<-train[,-(1:2)] #�������� �κ� ����
test<-test[,-(1:2)]
#------------------------------
# Age (����) : continuous (������ ����)
# Workclass(����) : private (�ڿ���), 
# Self-emp-not-inc (������ ���� ���λ����), 
# Self-emp-inc ( ������ �ִ� ���λ����)��.
# fnlwgt(������ ����) : continuous(������ ����)
# Education(����) : Bachelors (�л�), 
# Some-college (������)��
# 
# Marital ??? status(��ȥ����) : Married-civ-spouse(��ȥ),
# Divorced (��ȥ), Never-married (��ȥ)
# Ooccupation : Tech-support(�����)Craft-repair (��ɰ�), Other-service (��3���񽺾�)
# Relationship : Wife (�Ƴ�), Own-child (�ڳ�)
# Husband (����)
# Race(����) : Asian-Pac-Islander (�ƽþư�), White (����)	
# Class ( Target���� ) : 1 (�ҵ� 50000$ �̻�), 0 (50000$ ����) 
#----------------------------------

#������ ������ Ȯ��
# $ age           : int  52 32 25 40 43 20 45 22 48 21 ...
# boxplot(train$age)
# summary(train$age)
# hist(train$age)
train$age<-cut(train$age,c(-Inf,28,37,48,52,56,62,Inf)) #���� �ǹ̴� 4�������ϰ�,,75%~100%�� �� 4������ ���Դϴ�.
test$age<-cut(test$age,c(-Inf,28,37,48,52,56,62,Inf))

# $ workclass     : Factor w/ 8 levels "Federal-gov",..: 6 4 6 4 4 4 4 7 4 4 ...
# summary(train$workclass)
# plot(train[which(train$income=="small"),"workclass"])
# plot(train[which(train$income=="large"),"workclass"])

# $ fnlwgt        : int  209642 205019 176756 193524 117037 266015 386940 311512 242406 197200 ...
train<-train[,-3]
test<-test[,-3]
# $ education     : Factor w/ 16 levels "10th","11th",..: 12 8 12 11 2 16 10 16 2 16 ...
# summary(train$education)
# plot(train[which(train$income=="small"),"education"])
# plot(train[which(train$income=="large"),"education"])

# $ education.num : int  9 12 9 16 7 10 13 10 7 10 ...
# boxplot(train$education.num)
# summary(train$education.num)
# hist(train$education.num)
# hist(train[which(train$income=="small"),"education.num"])
# hist(train[which(train$income=="large"),"education.num"])

# $ marital.status: Factor w/ 7 levels "Divorced","Married-AF-spouse",..: 3 5 5 3 3 5 1 3 5 5 ...
# summary(train$marital.status)
# plot(train[which(train$income=="small"),"marital.status"])
# plot(train[which(train$income=="large"),"marital.status"])

# $ occupation    : Factor w/ 14 levels "Adm-clerical",..: 4 12 5 10 14 12 4 8 7 7 ...
# summary(train$occupation)
# plot(train[which(train$income=="small"),"occupation"])
# plot(train[which(train$income=="large"),"occupation"])

# $ relationship  : Factor w/ 6 levels "Husband","Not-in-family",..: 1 2 4 1 1 4 4 1 5 4 ...
# summary(train$relationship)
# plot(train[which(train$income=="small"),"relationship"])
# plot(train[which(train$income=="large"),"relationship"])

# $ race          : Factor w/ 5 levels "Amer-Indian-Eskimo",..: 5 3 5 5 5 3 5 3 5 5 ...
# summary(train$race)
# par(mfrow=c(1,2))
# plot(train[which(train$income=="small"),"race"])
# plot(train[which(train$income=="large"),"race"]) #race�� �ʿ���ٰ� �Ǵ�.

# $ sex           : Factor w/ 2 levels "Female","Male": 2 2 2 2 2 2 2 2 2 2 ...
# summary(train$sex)
# plot(train[which(train$income=="small"),"sex"])
# plot(train[which(train$income=="large"),"sex"])

# $ capital.gain  : int  0 0 0 0 0 0 0 0 0 0 ...
# boxplot(train$capital.gain)
# summary(train$capital.gain)
# hist(train$capital.gain)
# par(mfrow=c(1,1))
# plot(train[which(train$income=="small"),"capital.gain"]) #small�� �Ǵ��� ��� �ʿ� ������,,,
# plot(train[which(train$income=="large"),"capital.gain"]) #large�� �Ǵ��Ҷ� ����... ������...
temp<-which(train$capital.gain==0)
train[temp,"capital.gain"]<-NA
temp<-which(test$capital.gain==0)
test[temp,"capital.gain"]<-NA
#�̻�ġ ����
upperQ<-fivenum(train$capital.gain)[4] #3rd Qu.
lowerQ<-fivenum(train$capital.gain)[2] #1rd Qu.
IQR<-upperQ-lowerQ
train[which(train$capital.gain > upperQ+IQR*1.5),"capital.gain"]<-NA
train[which(train$capital.gain < lowerQ-IQR*1.5),"capital.gain"]<-NA


# $ capital.loss  : int  0 0 0 0 2042 0 1408 0 0 0 ...
# boxplot(train$capital.loss)
# summary(train$capital.loss)
# hist(train$capital.loss)
# plot(train[which(train$income=="small"),"capital.loss"])
# plot(train[which(train$income=="large"),"capital.loss"])
temp<-which(train$capital.loss==0)
train[temp,"capital.loss"]<-NA
temp<-which(test$capital.loss==0)
test[temp,"capital.loss"]<-NA
upperQ<-fivenum(train$capital.loss)[4] #3rd Qu.
lowerQ<-fivenum(train$capital.loss)[2] #1rd Qu.
IQR<-upperQ-lowerQ
train[which(train$capital.loss > upperQ+IQR*1.5),"capital.loss"]<-NA
train[which(train$capital.loss < lowerQ-IQR*1.5),"capital.loss"]<-NA

# $ hours.per.week: int  45 50 35 60 40 44 40 15 40 40 ...
# boxplot(train$hours.per.week)
# summary(train$hours.per.week)
# hist(train$hours.per.week)
# par(mfrow=c(1,2))
# plot(train[which(train$income=="small"),"hours.per.week"])
# plot(train[which(train$income=="large"),"hours.per.week"])#�ʿ��� ��������.

# $ native.country: Factor w/ 40 levels "Cambodia","Canada",..: 38 38 38 38 38 38 38 38 32 38 ...
# summary(train$native.country)
# plot(train[which((train$income=="small")&!(train$native.country=="United-States")),"native.country"])
# plot(train[which((train$income=="large")&!(train$native.country=="United-States")),"native.country"])

# 100% small�� ����
groupA<-c("Holand-Netherlands","Honduras","Outlying-US(Guam-USVI-etc)","Trinadad&Tobago")
for(i in 1:length(groupA))
{
  temp<-which(train$native.country==groupA[i])
  train[temp,"native.country"]<-"Holand-Netherlands"
  temp<-which(test$native.country==groupA[i])
  test[temp,"native.country"]<-"Holand-Netherlands"
}
# small ������ ���� ����
groupB<-c("Columbia","Dominican-Republic","Ecuador","El-Salvador",
          "Guatemala","Haiti","Mexico","Nicaragua",
          "Peru","Portugal","Vietnam","Puerto-Rico")
for(i in 1:length(groupB))
{
  temp<-which(train$native.country==groupB[i])
  train[temp,"native.country"]<-"Columbia"
  temp<-which(test$native.country==groupB[i])
  test[temp,"native.country"]<-"Columbia"
}
# large ������ ���� ����
groupC<-c("Cambodia","Canada","England","France","Germany","India","Iran",
          "Japan","Scotland","Taiwan","Yugoslavia","Philippines")
for(i in 1:length(groupC))
{
  temp<-which(train$native.country==groupC[i])
  train[temp,"native.country"]<-"Cambodia"
  temp<-which(test$native.country==groupC[i])
  test[temp,"native.country"]<-"Cambodia"
}
# $ income        : Factor w/ 2 levels "large","small": 1 2 2 1 2 2 2 2 2 2 ...

##�м�##
library(rpart)
tree<-rpart(income~
              age+
              # workclass+
              # education+
              education.num+
              marital.status+
              occupation+
              relationship+
              # race+
              # sex+
              capital.gain+
              capital.loss+
              hours.per.week+
              native.country
            ,data=train)
plot(tree)
text(tree)
pre<-predict(tree, newdata = test, type = "class")
table(pre, test$income)

library(e1071)
#�̷��� ���� �������ָ� �� �� ã�ư���..?�Ƹ���.-> ���� �ణ �ٸ��� ��
train$capital.gain<-cut(train$capital.gain,c(-Inf,3325,5000,6497,8614,11080,Inf))
test$capital.gain<-cut(test$capital.gain,c(-Inf,3325,5000,6497,8614,11080,Inf))
train$capital.loss<-cut(train$capital.loss,c(-Inf,1000,1300,1500,2100,2206,Inf))
test$capital.loss<-cut(test$capital.loss,c(-Inf,1000,1300,1500,2100,2206,Inf))
# train$hours.per.week<-cut(train$hours.per.week,c(-Inf,20,25,30,35,40,45,50,55,60,65,Inf))
# test$hours.per.week<-cut(test$hours.per.week,c(-Inf,20,25,30,35,40,45,50,55,60,65,Inf))
nb<-naiveBayes(income~
                 age+
                 # workclass+ # �ʿ����
                 # education+ # �Ʒ��� ���� �ǹ�
                 education.num+
                 marital.status+
                 occupation+
                 relationship+
                 # race+ #
                 # sex+ # ������ ����
                 capital.gain+
                 capital.loss+
                 hours.per.week+
                 native.country+
                 income,data=train)
table(predict(nb,test),test$income) # �� 80%�ʹݴ� ���߷�..