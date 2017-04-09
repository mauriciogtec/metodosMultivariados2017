## ----echo=FALSE----------------------------------------------------------

library(knitr)


## ------------------------------------------------------------------------

library(PCAmixdata)


## ------------------------------------------------------------------------

library(MASS)

data <- MASS::Cars93

colnames(data)


## ------------------------------------------------------------------------

grupos <- c(1:25)

nombres_grupos <- c('Type', 'Min_price', 'Price', 'Max_price', 'MPG_city', 'MPG_Highway', 'Airbags', 'Drivetrain', 'Cyinders', 'Engine_size', 'Horsepower', 'RPM', 'Rev_per_mile', 'Man_trans_avail', 'Fuel_tank_capacity', 'Passengers', 'Length', 'Wheelbase', 'Width', 'Turn_circle', 'Rear_seat_room', 'Luggage_room', 'Weight', 'Origin', 'Make')

res <- MFAmix(data=data[ , c(3:27)],groups=grupos,
              name.groups=nombres_grupos, rename.level=TRUE, ndim=2, graph = FALSE)

## ------------------------------------------------------------------------

summary(res)
print(res)


## ---- echo = FALSE-------------------------------------------------------

kable(res$groups[1])


## ------------------------------------------------------------------------

res <- MFAmix(data=data[ , c(3:27)],groups=grupos,
              name.groups=nombres_grupos, rename.level=TRUE, ndim=2)


## ------------------------------------------------------------------------

data(gironde)

colnames(gironde$employment)
colnames(gironde$housing)
colnames(gironde$services)
colnames(gironde$environment)


## ------------------------------------------------------------------------

class.var <- c(rep(1,9),rep(2,5),rep(3,9),rep(4,4))
names <- c("employment","housing","services","environment")

dat <- cbind(gironde$employment[1:20, ],gironde$housing[1:20, ],
             gironde$services[1:20, ],gironde$environment[1:20, ])

res <- MFAmix(data=dat,groups=class.var,
              name.groups=names, rename.level=TRUE, ndim=2, graph = FALSE)


## ---- echo = FALSE-------------------------------------------------------

kable(res$groups[1])


## ------------------------------------------------------------------------

res <- MFAmix(data=dat,groups=class.var,
              name.groups=names, rename.level=TRUE, ndim=2)


## ------------------------------------------------------------------------
municipal <- read.csv("https://s3-us-west-2.amazonaws.com/proyecto-sdv/amenazas_vulnerabilidad.csv")
names <- c("vulnerabilidad","amenazas")
class.var <- c(rep(1,8),rep(2,4))
colnames(municipal)
dat <- cbind(municipal[,3:10],municipal[,11:14])
row.names(dat) <- municipal$cve_muni

res <- MFAmix(data=dat,groups=class.var,
              name.groups=names, rename.level=TRUE, ndim=2, graph = TRUE)



## ------------------------------------------------------------------------
municipal <- read.csv("https://s3-us-west-2.amazonaws.com/proyecto-sdv/amenazas_vulnerabilidad.csv")
names <- c("vulnerabilidad","amenazas","entidad")
class.var <- c(rep(1,8),rep(2,4),rep(3,1))
colnames(municipal)
dat <- cbind(municipal[,3:10],municipal[,11:14],municipal$nom_ent)
dat$nom_ent <- dat$`municipal$nom_ent`
dat$`municipal$nom_ent`<- NULL
row.names(dat) <- municipal$cve_muni

res <- MFAmix(data=dat,groups=class.var,
              name.groups=names, rename.level=TRUE, ndim=2, graph = TRUE)


