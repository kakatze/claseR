###library
library(tidyverse)
library(ggplot2)
library(lubridate)
columnas = names(origen_de_datos)
summary(origen_de_datos)


resumen_d = origen_de_datos %>% filter(!str_detect(`SCHEDULE NAME`,"ARCH"))
resumen_d = resumen_d %>% filter(!str_detect(STATUS,'completed'))
resumen_d = resumen_d %>% group_by(`DOMAIN NAME`,STATUS) %>% 
    summarise(cantidad = n())

##resumen_dt = resumen_d  %>% spread(STATUS, cantidad)


ggplot(resumen_d, aes(x = `DOMAIN NAME`, y = cantidad, fill = STATUS)) + geom_bar(stat='identity')


resumen = origen_de_datos %>% filter(`DOMAIN NAME` == "PD_ORA")
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


resumen_actual = resumen %>% group_by(ACTUAL,STATUS) %>% 
  summarise(cantidad = n())

ggplot(resumen_actual, aes(x = ACTUAL , y = cantidad, fill = STATUS)) + geom_bar(stat='identity')

# hacer un histograma en ggplot2
ggplot(data = n_resumen,
       mapping = aes(x = SCHEDULE_START)) +
  geom_histogram(bins = 30)


ggplot(data=n_resumen, aes(x=ACTUAL, y="SCHEDULE NAME")) + 
  geom_bar(stat="identity", position="stack")



