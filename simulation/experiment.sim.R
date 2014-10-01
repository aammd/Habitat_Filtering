## simulationsof my experiment

spp <- read.csv("spp.csv",row.names=1)
env <- read.csv("env.csv",stringsAsFactors=FALSE)

names(env)

library(vegan)


head(env)

env.list <- split(env,env$brom.spp)


## make species a matrix
spp.matrix <- t(as.matrix(spp))
str(spp.matrix)

spp.ord <- prcomp(x=spp.matrix,scale=TRUE)

print(spp.ord)
summary(spp.ord)
str(spp.ord)

center <- spp.ord$center
scale <- spp.ord$scale


axis1 <-
  drop(scale(spp.matrix,center=center,scale=scale)%*%spp.ord$rotation[,1])
axis2 <-
  drop(scale(spp.matrix,center=center,scale=scale)%*%spp.ord$rotation[,2])

plot(axis1,axis2)

biplot(spp.ord,var.axes=FALSE)


## PCoA
spp.presabs <- (spp.matrix>0)*1
spp.dist <- vegdist(spp.presabs,method="jaccard")
ord.spp <- cmdscale(spp.dist,eig=TRUE)

write.csv(as.matrix(spp.dist),file="dist.csv")

str(ord.spp)

library(vegan)

betadisper(d=spp.dist,group=as.factor(env$brom.spp))

ord.points <- split(data.frame(ord.spp$points),env$brom.spp)

plot(ord.spp$points,type="n")

for(i in 1:4){
  points(ord.points[[i]]$X1,ord.points[[i]]$X2,pch=i)
}



spp.data <- data.frame(ord.spp$points,brom.spp=env$brom.spp)

library(ggplot2)

pdf("ordination.macae.pdf")
ggplot(spp.data,aes(x=X1,y=X2,color=brom.spp))+geom_point()
dev.off()


### from Nicolas
## bray-curtis log abd
spp.presabs <- (spp.matrix>0)*1
ins.perm.jac <- adonis(spp.presabs~as.factor(env$brom.spp),method="jac",permutations=999)
ins.perm.jac


ins.jac<-vegdist(spp.presabs, method="jac")

ins.disp.jac<-betadisper(ins.jac, as.factor(env$brom.spp), type="median")
boxplot(ins.disp.jac)

brom_sp <- as.factor(env$brom.spp)

#pdf("Fig01.pdf", width=8.18, height=8.16, pointsize=14)
grap2<-ordiplot(ins.disp.jac, type="n", xlim=c(-0.5,0.65), ylim=c(-0.4,0.4), bty="o", 
                     xlab="Coordinate 1", ylab="Coordinate 2", cex.axis=1.2, cex.lab=1.2)
points(grap2, "sites", brom_sp=="AN", pch=0,col="black", bg="black", cex=1.2, lwd=1.5)
points(grap2, "sites", brom_sp=="NC", pch=6,col="black", bg="black", cex=1.2, lwd=1.5)
points(grap2, "sites", brom_sp=="VN", pch=19,col="black", bg="black", cex=1.5, lwd=1.5)
points(grap2, "sites", brom_sp=="AL", pch=17,col="black", bg="black", cex=1.5, lwd=1.5)
ordihull(grap2, groups=brom_sp, "sites", draw="lines", show.groups=("AN"), col="black", lty=1, lwd=1.5)
ordihull(grap2, groups=brom_sp, "sites", draw="lines", show.groups=("NC"), col="black", lty=2, lwd=1.5)
ordihull(grap2, groups=brom_sp, "sites", draw="lines", show.groups=("VN"), col="black", lty=3, lwd=1.5)
ordihull(grap2, groups=brom_sp, "sites", draw="lines", show.groups=("AL"), col="black", lty=4, lwd=1.5)
#dev.off()
