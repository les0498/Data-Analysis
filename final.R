install.packages("readxl")
setwd("D:/ds_gimal/final_ds_color")
library(readxl)

install.packages("ggplot2")
library(ggplot2)

#꾸미기
install.packages("ggthemes")
library(ggthemes)

#역대시즌 컬러&주기
SEASONCOLOR<-read_excel("SEASONCOLOR.xlsx")
str(SEASONCOLOR)
Hexcode<-c("#9BB7D4", "#C74375", "#BF1932", "#7BC4C4", "#E2583E", "#53B0AE", "#DECDBE", "#9B1B30", "#5A5B9F", "#F0C05A", "#45B5AA", "#D94F70", "#DD4124", "#009473", "#AD5E99", "#964F4C", "#F7CACA", "#93A9D1", "#88B04B", "#5F4B8B", "#FF6F61", "#0F4C81", "#F5DF4D", "#939597", "#6667AB")
SC<-ggplot(SEASONCOLOR,aes(x=YEAR,y=COLOR))+geom_point(size=10,shape=15,color=Hexcode)+geom_text(aes(label=COLORNAME),nudge_y = 0.5, size=3)+labs(title = "역대 시즌 컬러",y="COLOR(색)", x="YEAR(년도)")+scale_x_continuous(breaks=seq(0,2022,by=1))

#mysql 연결
install.packages("RMySQL")
library(RMySQL)
library(DBI)

ds_color<- dbConnect(
  MySQL(),
  user = 'root',
  password = '1234',
  host = '127.0.0.1',
  dbname = 'ds_color'
)

dbSendQuery(ds_color, 'set character set "utf8"')

#2023 시즌 컬러
RN23 <- dbGetQuery( ds_color,
                    "SELECT colorname,Hexcode,cv, COUNT(Hexcode),count(colorname),count(cv) FROM ds_color.RN2223
GROUP BY Hexcode
HAVING COUNT(Hexcode) > 1")
class(RN23)
str(RN23)

Hexcode2<-c('#58575C','#7AD1D8')
sc23 <-ggplot(RN23,aes(x=colorname))+geom_bar(fill=Hexcode2)+labs(title = "23년도 시즌컬러")

#시즌 컬러(Waterspout)가 있는 색조합의 좋아요수
Like58575C <- dbGetQuery( ds_color,
                          "SELECT HexCol1, HexCol2, HexCol3, HexCol4, Popular FROM ds_color.likecolor 
WHERE HexCol1 = '58575C' OR HexCol2 = '58575C' OR HexCol3 = '58575C' OR HexCol4 = '58575C' 
ORDER BY Popular  DESC limit 5")
class(Like58575C)
str(Like58575C)

#시즌 컬러(Poppy Seed)가 있는 색조합의 좋아요수
Like7AD1D8 <- dbGetQuery( ds_color,
                          "SELECT HexCol1, HexCol2, HexCol3, HexCol4, Popular FROM ds_color.likecolor 
WHERE HexCol1 = '7AD1D8' OR HexCol2 = '7AD1D8' OR HexCol3 = '7AD1D8' OR HexCol4 = '7AD1D8' 
ORDER BY Popular  DESC limit 5")
class(Like7AD1D8)
str(Like7AD1D8)


# Waterspout 산점도
L7<-ggplot(Like7AD1D8,aes(x=HexCol3,y=Popular))+geom_point(size=3,shape=16, color='#ECECEC')+  scale_color_economist()+ geom_text(aes(label=Popular),nudge_y= 0.15, size=5)+labs(title = "Waterspout",y="Popular(인기순)", x="색조합") + 
  scale_x_discrete( labels = c("3D84A8" = "7AD1D8\nABEDD8\n3D84A8\n48466D","7AD1D8" = "7AD1D8\nFC5185\nF5F5F5\n364F6B", "BBDED6" = "7AD1D8\nFFB6B9\nFAE3D9\nBBDED6","C6FCE5" = "7AD1D8\nF3E8CB\nF2C6B4\nFBAFAF","F2C6B4" = "7AD1D8\n6EF3D6\nC6FCE5\nEBFFFA"))+
  
  #12850
  annotate("rect", xmin = 0.75, xmax = 1.25, ymin = 0, ymax = 3100,fill="#48466D", alpha = 1)+
  annotate("rect", xmin = 0.75, xmax = 1.25, ymin = 3100, ymax = 6200,fill="#3D84A8", alpha = 1)+
  annotate("rect", xmin = 0.75, xmax = 1.25, ymin = 6200, ymax = 9300,fill="#ABEDD8", alpha = 1)+
  annotate("rect", xmin = 0.75, xmax = 1.25, ymin = 9300, ymax = 12400,fill="#7AD1D8", alpha = 1)+
  #18743
  annotate("rect", xmin = 1.75, xmax = 2.25, ymin = 0, ymax = 4575,fill="#364F6B", alpha = 1)+
  annotate("rect", xmin = 1.75, xmax = 2.25, ymin = 4575, ymax = 9150,fill="#F5F5F5", alpha = 1)+
  annotate("rect", xmin = 1.75, xmax = 2.25, ymin = 9150, ymax = 13725,fill="#FC5185", alpha = 1)+
  annotate("rect", xmin = 1.75, xmax = 2.25, ymin = 13725, ymax = 18300,fill="#7AD1D8", alpha = 1)+
  #10847
  annotate("rect", xmin = 2.75, xmax = 3.25, ymin = 0, ymax = 2600,fill="#BBDED6", alpha = 1)+
  annotate("rect", xmin = 2.75, xmax = 3.25, ymin = 2600, ymax = 5200,fill="#FAE3D9", alpha = 1)+
  annotate("rect", xmin = 2.75, xmax = 3.25, ymin = 5200, ymax = 7800,fill="#FFB6B9", alpha = 1)+
  annotate("rect", xmin = 2.75, xmax = 3.25, ymin = 7800, ymax = 10400,fill="#7AD1D8", alpha = 1)+
  #8855
  annotate("rect", xmin = 3.75, xmax = 4.25, ymin = 0, ymax = 2050,fill="#FBAFAF", alpha = 1)+
  annotate("rect", xmin = 3.75, xmax = 4.25, ymin = 2050, ymax = 4100,fill="#F2C6B4", alpha = 1)+
  annotate("rect", xmin = 3.75, xmax = 4.25, ymin = 4100, ymax = 6150,fill="#F3E8CB", alpha = 1)+
  annotate("rect", xmin = 3.75, xmax = 4.25, ymin = 6150, ymax = 8200,fill="#7AD1D8", alpha = 1)+
  #9375
  annotate("rect", xmin = 4.75, xmax = 5.25, ymin = 0, ymax = 2200,fill="#EBFFFA", alpha = 1)+
  annotate("rect", xmin = 4.75, xmax = 5.25, ymin = 2200, ymax = 4400,fill="#C6FCE5", alpha = 1)+
  annotate("rect", xmin = 4.75, xmax = 5.25, ymin = 4400, ymax = 6600,fill="#6EF3D6", alpha = 1)+
  annotate("rect", xmin = 4.75, xmax = 5.25, ymin = 6600, ymax = 8800,fill="#7AD1D8", alpha = 1)
Poppy Seed 산점도
L5<-ggplot(Like58575C,aes(x=HexCol3,y=Popular))+geom_point(size=3,shape=16, color='#FFFFFF')+  scale_color_economist()+ geom_text(aes(label=Popular),nudge_y = 0.15, size=5)+labs(title = "Poppy Seed",y="Popular(인기순)", x="색조합") + 
  scale_x_discrete( labels = c("4ECCA3" = "58575C\n232931\n4ECCA3\nEEEEEE","58575C" = "58575C\nEEEEEE\nD72323\n303841", "B5CFD8" = "58575C\n7393A7\nB5CFD8\nE8ECF1","FF9999" = "58575C\n444F5A\nFF9999\nFFC8C8","FFD369" = "58575C\n222831\nFFD369\nEEEEEE"))+ theme_light()+
  
  #8347
  annotate("rect", xmin = 0.75, xmax = 1.25, ymin = 0, ymax = 2000,fill="#EEEEEE", alpha = 1)+
  annotate("rect", xmin = 0.75, xmax = 1.25, ymin = 2000, ymax = 4000,fill="#4ECCA3", alpha = 1)+
  annotate("rect", xmin = 0.75, xmax = 1.25, ymin = 4000, ymax = 6000,fill="#232931", alpha = 1)+
  annotate("rect", xmin = 0.75, xmax = 1.25, ymin = 6000, ymax = 8000,fill="#58575C", alpha = 1)+
  
  #9511
  annotate("rect", xmin = 1.75, xmax = 2.25, ymin = 0, ymax = 2300,fill="#303841", alpha = 1)+
  annotate("rect", xmin = 1.75, xmax = 2.25, ymin = 2300, ymax = 4600,fill="#D72323", alpha = 1)+
  annotate("rect", xmin = 1.75, xmax = 2.25, ymin = 4600, ymax = 6900,fill="#EEEEEE", alpha = 1)+
  annotate("rect", xmin = 1.75, xmax = 2.25, ymin = 6900, ymax = 9200,fill="#58575C", alpha = 1)+
  
  #6115
  annotate("rect", xmin = 2.75, xmax = 3.25, ymin = 0, ymax = 1450,fill="#E8ECF1", alpha = 1)+
  annotate("rect", xmin = 2.75, xmax = 3.25, ymin = 1450, ymax = 2900,fill="#B5CFD8", alpha = 1)+
  annotate("rect", xmin = 2.75, xmax = 3.25, ymin = 2900, ymax = 4350,fill="#7393A7", alpha = 1)+
  annotate("rect", xmin = 2.75, xmax = 3.25, ymin = 4350, ymax = 5800,fill="#58575C", alpha = 1)+
  
  #12956
  annotate("rect", xmin = 3.75, xmax = 4.25, ymin = 0, ymax = 3125,fill="#FFC8C8", alpha = 1)+
  annotate("rect", xmin = 3.75, xmax = 4.25, ymin = 3125, ymax = 6250,fill="#FF9999", alpha = 1)+
  annotate("rect", xmin = 3.75, xmax = 4.25, ymin = 6250, ymax = 9375,fill="#444F5A", alpha = 1)+
  annotate("rect", xmin = 3.75, xmax = 4.25, ymin = 9375, ymax = 12500,fill="#58575C", alpha = 1)+
  
  #7556
  annotate("rect", xmin = 4.75, xmax = 5.25, ymin = 0, ymax = 1800,fill="#EEEEEE", alpha = 1)+
  annotate("rect", xmin = 4.75, xmax = 5.25, ymin = 1800, ymax = 3600,fill="#FFD369", alpha = 1)+
  annotate("rect", xmin = 4.75, xmax = 5.25, ymin = 3600, ymax = 5400,fill="#222831", alpha = 1)+
  annotate("rect", xmin = 4.75, xmax = 5.25, ymin = 5400, ymax = 7200,fill="#58575C", alpha = 1)


install.packages("gridExtra")
library(gridExtra)


#최종결과
grid.arrange(SC, sc23, L7, L5, nrow=2, ncol=2)


