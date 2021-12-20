###library
library(tidyverse)
library(ggplot2)
library(lubridate)
columnas = names(origen_de_datos)
summary(origen_de_datos)


resumen = origen_de_datos %>% filter(str_detect(`SCHEDULE NAME`,"TRON|TERCE|"))
resumen = resumen %>% filter(`DOMAIN NAME` == "PD_ORA")
resumen = resumen %>% filter(!str_detect(`SCHEDULE NAME`,"ARCH"))
resumen = resumen %>% filter(str_detect(`SCHEDULE NAME`,"_DIA_"))
##resumen = resumen %>% dmy_hms(resumen$COMPLETED)
##resumen = transform(resumen, COMPLETED = ymd_hms("COMPLETED"))
start = c(resumen$`SCHEDULE START`)
start = dmy_hms(start)
resumen$SCHEDULE_START = c(start)

com = c(resumen$COMPLETED)
com = dmy_hms(com)
resumen$COMPLETED_NEW = c(com)

summary(resumen)

n_resumen = resumen  %>%  select(STATUS,SCHEDULE_START,ACTUAL,START,`SCHEDULE NAME`,`NODE NAME...7`,`NODE NAME...8`,`DOMAIN NAME`,`tiempo de backup`,COMPLETED_NEW)

summary(n_resumen)


# hacer un histograma en ggplot2
ggplot(data = n_resumen,
       mapping = aes(x = SCHEDULE_START)) +
  geom_histogram(bins = 30)


ggplot(data=n_resumen, aes(x=ACTUAL, y="SCHEDULE NAME")) + 
  geom_bar(stat="identity", position="stack")
