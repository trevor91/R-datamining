data<-read.csv("NBA.csv",stringsAsFactors=T)

ppm<-data[,"games"] * data[,"point"] / data[,"minutes"] #�д� ������
data<-cbind(data,ppm)

# erase<-which(colnames(data)=="Name")
erase<-which(colnames(data)=="games") #������ index ã��
erase<-c(erase,which(colnames(data)=="minutes"))
erase<-c(erase,which(colnames(data)=="point"))
data<-data[,-erase] #Name, games, point, minutes ���� ����

# step1
# �ּ��км������� �������� ������ �ٸ� raw data�� ������� �ʰ�
# ��հ� ǥ�������� ������ ǥ��ȭ(standadization)�� �����͸� ����մϴ�.
# �׷��� scale�� �ٸ� ������ ���� ������ �ְ��� ���� �� �ֱ� �����Դϴ�.
#�Ƹ� �����ð��� log�� �������ɷ� ����մϴ�. �̰͵� �غ���,,,���͵� �غ���,,,
data_trans<-transform(data,
                height_s = scale(height),
                age_s = scale(age),
                assist_s = scale(assist),
                rebound_s = scale(rebound),
                fieldgoal_s = scale(fieldgoal),
                freethrow_s = scale(freethrow))
#�ٵ� ���� ���� �Ŀ� �ٸ��� ���׿�.

#step2
# ������ ���� �� ���� ũ�� ������, ������ �������� �Ǵ��մϴ�.
# ũ�� ���� ������ ������ ���� ������ ���� �ݴ� �������� �����̴µ�
# �̸� ���� �������� �����ؼ� ������� ���� ����, ���� �ּ��п� �ݿ��ǵ����մϴ�.
# height, age, assist, rebound, fieldgoal, freethrow ��κ� ������ ���� �����ε�...
# ���̰� ���� �ɸ��׿�.���� ������ ������ ���Ƽ� ����ѵ�, ���� �ȵ����ִ°͵� �ְ�,,
# ���̰� ������ ���ٰ� �����ϰ�! �� ����� �߿��ϰڽ��ϱ�? �������� ���°���.
# ��� �� ũ�� �������̸� step2���� �Ұ� �����ϴ�.
# data_trans <- transform(data_trans, age_s2 = max(age_s) - age_s)
data_trans_2 <- data_trans[,c("Name", "height_s", "age_s2", "assist_s", "rebound_s", "fieldgoal_s", "freethrow_s","ppm")]

#step3
# �����鰣�� �������� �м��غ��ڽ��ϴ�.
# �ּ��км��� ������ ���� ������谡 ���ٴ� ���� �����ϰ� �ֱ� ������
# �ѹ� Ȯ���غ����� �ϰڽ��ϴ�.
library(psych)
pairs.panels(data_trans_2[,-1])
#reboud�� assist�� 60%������ ������谡 ���׿�.

#step4
# ���� �ּ��� �м��ؾ���. prcomp()�� ����մϴ�.
data_prcomp <- prcomp(data_trans_2[,c(2:7)]) #ppm�� ����
summary(data_prcomp) #80% �̻��� ������ ������ PC4���� ����ϳ׿�...(��� ����..)
# 1������ ǥ�������� 1.4�� ���� ũ�׿�.

print(data_prcomp)
# 1������ assist�� rebound�� ������ ũ��,,������ ���õȰͰ� ���ݾ� ������ �ִµ�..?
# 2������ Ű�� ������ ũ��
# 3������ �������� ������ �ְ�...
# 4������ ���̿� ������ ������ ũ��
# 5������ �ʵ��,����� ������ �ְ�...6������..��ý�Ʈ,Ű

# �׷��ٸ� 1������ ������ ������ ���� �ϴ°Ŵϱ� "Ȱ����"�̶�� �̸��� ���� �� ������ ����
# 4������ ���̿� ������ ���õȰŴ� "�����"�̶� �� �� ������ �����ϴ�.

#step5 �׷�����
biplot(data_prcomp, cex = c(0.6, 0.7))
pc1 <- predict(data_prcomp)[,1] #Ȱ����
pc4 <- predict(data_prcomp)[,4] #�����
text(pc1, pc4, labels = data_trans_2$Name, 
     cex = 0.7, pos = 3, col = "blue")

#step6
# ������ ���ΰɷ� ȸ�ͺм��� �غ���.
data.lm <- lm(ppm ~ PC1+PC2+PC3+PC4, family ="binomial", data = as.data.frame(data_prcomp$x))
summary(data.lm)
data.lm.const<-lm(ppm~1,data = as.data.frame(data_prcomp$x))
summary(data.lm.const)
# data.forward<-step(data.lm,scope=list(lower=data.lm.const,upper=data.lm),direction="forward")
# summary(data.forward)
# data.backward<-step(data.lm,scope=list(lower=data.lm.const,upper=data.lm),direction="backward")
# summary(data.forward)
# data.both<-step(data.lm,scope=list(lower=data.lm.const,upper=data.lm),direction="both")
# summary(data.forward)
pred <- predict(data.lm, type="response")
plot(ppm, pred)
abline(a=0, b=1)