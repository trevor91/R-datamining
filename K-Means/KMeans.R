#6����
#k-means

my_func<-function(data,k)
{
  # point<-matrix(rnorm(k*ncol(data)),ncol=ncol(data)) #���� �߽���.
  index<-sample(1:nrow(data),k) #Forgy ������� �߽��� ����
  point<-data[index,]
  
  colnames(point)<-colnames(data) #�̸��� ���ƾ� rbind�� �ȴ�.
  rownames(point)<-1:k
  combine<-rbind(point,data) #matrix��ܿ� �߽��� ����
  while(1)
  {
    dis<-as.matrix(dist(combine)) #�Ÿ� ���ϰ�
    dis<-dis[,1:k] #�޺κ� �ʿ� ������ cut
    dis[which(dis==0)]<-NA #0 -> NA
    label<-as.factor(apply(dis,1,which.min)) #������ ������ �ε��� ����
    combine<-cbind(combine,label)
    #
    center_coordinate<-aggregate(combine[1:(ncol(combine)-1)], by=list(combine$label), FUN=mean) #�߽��� ����
    line_index<-as.integer(as.character(center_coordinate[,1])) #� �߽����� ���ŵȰ��� Ȯ��
    point[line_index,]<-as.matrix(center_coordinate[,2:ncol(center_coordinate)]) #�߽����� ���ŵȰ͸� ����ȭ���ش�.
    same<-point==combine[1:nrow(point),1:ncol(point)]
    same<-which(same==FALSE) #��ġ���� �ʴ°� �ִٸ� ����
    if(!length(same)) #�� �߽����� ������ �߽����� ���ٸ�
    {
#       combine<-combine[(k+1):nrow(combine),]
#       rownames(combine)<-1:nrow(combine)
      levels(combine[,ncol(combine)])<-c(1:k,"center")
      combine[1:k,ncol(combine)]<-"center"
      return(combine)
    }
    #�߽����� ���� �ٸ��ٸ�
    combine<-combine[,-ncol(combine)] #label ����
    combine[1:k,]<-point #�߽��� combine�� ����.
  }
}
# test<-my_func(iris[,-5],3)
test<-my_func(iris[,1:2],4) #�׸� �׷��ַ��� 2���� ���� �����͸� �־����ϴ�.
table(test[ncol(test)])


#�׸��׸���
library(plotly)
paint<-plot_ly(test, x = Sepal.Length, y = Sepal.Width, text = paste("label: ", label),
        mode = "markers", color = label)
#�� �׸��� �غ�....
a<-which(test[,3]==1)
a1_min<-a[which.min(test[a,1])]
a2_min<-a[which.min(test[a,2])]
a1_max<-a[which.max(test[a,1])]
a2_max<-a[which.max(test[a,2])]
b<-which(test[,3]==2)
b1_min<-b[which.min(test[b,1])]
b2_min<-b[which.min(test[b,2])]
b1_max<-b[which.max(test[b,1])]
b2_max<-b[which.max(test[b,2])]
c<-which(test[,3]==3)
c1_min<-c[which.min(test[c,1])]
c2_min<-c[which.min(test[c,2])]
c1_max<-c[which.max(test[c,1])]
c2_max<-c[which.max(test[c,2])]
d<-which(test[,3]==4)
d1_min<-d[which.min(test[d,1])]
d2_min<-d[which.min(test[d,2])]
d1_max<-d[which.max(test[d,1])]
d2_max<-d[which.max(test[d,2])]

layout(paint, shapes = list(
         list(type = 'square',
              xref = 'x', x0 = test[a1_min,1], x1 = test[a1_max,1],
              yref = 'y', y0 = test[a2_min,2], y1 = test[a2_max,2],
              fillcolor = 'blue', line = list(color = 'black'),
              opacity = 0.2),
         list(type = 'square',
              xref = 'x', x0 = test[b1_min,1], x1 = test[b1_max,1],
              yref = 'y', y0 = test[b2_min,2], y1 = test[b2_max,2],
              fillcolor = 'green', line = list(color = 'black'),
              opacity = 0.2),
         list(type = 'square',
              xref = 'x', x0 = test[c1_min,1], x1 = test[c1_max,1],
              yref = 'y', y0 = test[c2_min,2], y1 = test[c2_max,2],
              fillcolor = 'red', line = list(color = 'black'),
              opacity = 0.2),
         list(type = 'square',
              xref = 'x', x0 = test[d1_min,1], x1 = test[d1_max,1],
              yref = 'y', y0 = test[d2_min,2], y1 = test[d2_max,2],
              fillcolor = 'yellow', line = list(color = 'black'),
              opacity = 0.2)))