#generator
#1~4999������ Self-Number���� ���� ���Ͽ���.
area<-1:4999
gen<-c()
for(i in 1:4999) #area�� �ش��ϴ� genarator�� ã�´�
{
  if(i<10) #���ڸ� ��
  {
    temp<-i*2
  }else if(i<100) #���ڸ� ��
  {
    temp <- i%/%10 + i%%10 + i
  }else if(i<1000) #���ڸ� ��
  {
    temp<-i%/%100 + i%/%10%%10 + i%%10 + i
  }else #���ڸ� ��
  {
    temp<-i%/%1000 + i%/%100%%10 + i%/%10%%10 + i%%10 + i
  }
  gen<-c(gen,temp)
}
gen<-unique(gen[gen<5000]) #5000�̸� ���ڸ� �̰� �ߺ� ����
#duplicated(gen) #�ߺ� ���� Ȯ��
selfNumber <- setdiff(area,gen) #������
#������ union
#������ intersect
result<-sum(selfNumber)


#%%%%%another
library(stringr)

func<-function(setNum)
{
  area<-1:setNum
  gen<-c()
  for(i in 1:setNum)
  {
    temp<-str_split(i,'')
    temp<-as.integer(temp[[1]])
    gen<-c(gen,sum(temp)+i)
  }
  selfNumber<-setdiff(area,gen)
  return (sum(selfNumber))
}
system.time(func(4999))

##%%%%%another
library(stringr)
aaa<-function(set)
{
  range<-1:set
  a<-str_split(range,'')
  a<-sapply(a,function(a){
    sum(as.integer(a))
  })
  a<-a+range
  a<-unique(a)
  a<-a[a<set+1]
  result<-setdiff(range,a)
  sum(result)
}
#as.integer(unlist(a))
system.time(aaa(4999))
