rm(list=ls(all=TRUE))
biot<-read.table("C:\\Users\\Nicholas\\Documents\\Nicholas\\Publicações\\Artigos\\Invert Comm Struc - Insect Cons Div\\Input\\bioticos.txt", row.names="brom", header=TRUE)
env<-read.table("C:\\Users\\Nicholas\\Documents\\Nicholas\\Publicações\\Artigos\\Invert Comm Struc - Insect Cons Div\\Input\\ambiental.txt", row.names="brom", header=TRUE)
attach(env)
ins<-biot[,1:20]

brom_sp<-as.factor(brom_sp)
size1<-ifelse(vol_max <= 500, "asmall", ifelse(vol_max  >= 1500, "zhigh", "med"))
size1<-as.factor(size1)
size2<-ifelse(copos <= 8, "asmall", ifelse(copos  > 16, "zhigh", "med"))
size2<-as.factor(size2)
a<-rep("big", 16)
b<-rep("small", 16)
c<-rep("small", 15)
brom_sz<-c(a,c,b,a)
brom_sz<-as.factor(brom_sz)

library(vegan)

ins.log<-log(ins+1)
ins.bin<-ifelse(ins > 0, 1, 0)


#BRAY-CURTIS *com* LOG
#Usar esse
ins.perm.bray<-adonis(ins.log ~ brom_sp, method="bray", permutations=9999)
ins.perm.bray

ins.bray<-vegdist(ins.log, method="bray")

ins.disp.bray<-betadisper(ins.bray, brom_sp, type="median")
ins.disp.bray
permutest(ins.disp.bray, perm=9999, pairwise=TRUE)

ins.disp.bray<-betadisper(ins.bray, brom_sz, type="median")
ins.disp.bray
permutest(ins.disp.bray, perm=9999, pairwise=TRUE)

ins.disp.bray1<-betadisper(ins.bray, size1, type="median")
ins.disp.bray1
permutest(ins.disp.bray1, perm=9999, pairwise=TRUE, strata=brom_sp)
boxplot(ins.disp.bray1, names=c("Small", "Medium", "Large"), xlab="Bromeliad Size", outline=FALSE, ylim=c(0.2, 0.8))

ins.disp.bray2<-betadisper(ins.bray, size2, type="median")
ins.disp.bray2
permutest(ins.disp.bray2, perm=9999, pairwise=TRUE, strata=brom_sp)
boxplot(ins.disp.bray2, names=c("Small", "Medium", "Large"), xlab="Bromeliad Size", outline=FALSE, ylim=c(0.2, 0.8))





#BRAY-CURTIS *sem* LOG
ins.perm.bray2<-adonis(ins ~ brom_sp, method="bray", permutations=9999)
ins.perm.bray2

ins.bray2<-vegdist(ins, method="bray")

ins.disp.bray2<-betadisper(ins.bray2, brom_sp, type="median")
ins.disp.bray2
permutest(ins.disp.bray2, perm=9999, pairwise=TRUE)

ins.disp.bray2<-betadisper(ins.bray2, size, type="median")
ins.disp.bray2
permutest(ins.disp.bray2, perm=9999, pairwise=TRUE, strata=brom_sp)





#JACCARD
ins.perm.jac<-adonis(ins.bin ~ brom_sp, method="jac", permutations=9999)
ins.perm.jac

ins.jac<-vegdist(ins.bin, method="jac")

ins.disp.jac<-betadisper(ins.jac, brom_sp, type="median")
ins.disp.jac
permutest(ins.disp.jac, perm=9999, pairwise=TRUE)

ins.disp.jac<-betadisper(ins.jac, brom_sz, type="median")
ins.disp.jac
permutest(ins.disp.jac, perm=9999, pairwise=TRUE)

ins.disp.jac1<-betadisper(ins.jac, size1, type="median")
ins.disp.jac1
permutest(ins.disp.jac1, perm=9999, pairwise=TRUE, strata=brom_sp)
boxplot(ins.disp.jac1, xlab="Bromeliad Size", names=c("Small", "Medium", "Large"), xlab="Bromeliad Size", outline=FALSE, ylim=c(0.2, 0.8))

ins.disp.jac2<-betadisper(ins.jac, size2, type="median")
ins.disp.jac2
permutest(ins.disp.jac2, perm=9999, pairwise=TRUE, strata=brom_sp)
boxplot(ins.disp.jac2, xlab="Bromeliad Size", names=c("Small", "Medium", "Large"), xlab="Bromeliad Size", outline=FALSE, ylim=c(0, 0.8))





################GRAPHING FOR ALL#########################################

#BRAY-CURTIS
grap1<-ordiplot(ins.disp.bray, type="n", xlim=c(-0.5,0.65), ylim=c(-0.4,0.4), bty="l", xlab="Coordinate 1", ylab="Coordinate 2")
points(grap1, "sites", brom_sp=="AN", pch=0,col="black", bg="black")
points(grap1, "sites", brom_sp=="NC", pch=6,col="black", bg="black")
points(grap1, "sites", brom_sp=="VN", pch=19,col="black", bg="black", cex=1.2)
points(grap1, "sites", brom_sp=="AL", pch=17,col="black", bg="black", cex=1.2)
ordihull(grap1, groups=brom_sp, "sites", draw="lines", show.groups=("AN"), col="black", lty=1)
ordihull(grap1, groups=brom_sp, "sites", draw="lines", show.groups=("NC"), col="black", lty=2)
ordihull(grap1, groups=brom_sp, "sites", draw="lines", show.groups=("VN"), col="black", lty=3)
ordihull(grap1, groups=brom_sp, "sites", draw="lines", show.groups=("AL"), col="black", lty=4)
text(0.6, 0.5, "(b)")




#JACCARD
pdf("Fig01.pdf", width=8.18, height=8.16, pointsize=14)
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
dev.off()
text(0.6, 0.5, "(a)")
legend("topright",legend=c("Aechmea nudicaulis","Neoregelia cruenta","Vriesia neoglutinosa","Aechmea lingulata"),pch=c(0,6,19,17),
                                    lty=c(1,1,1.2,1.2),col=c("black","black","black","black"),bty="o")



################GRAPHING BOX PLOT#########################################
par(mfrow=c(1,2), mar=c(3,3,0.5,0.5), oma=c(2,1,2,1))


#BRAY VOL
ins.disp.bray1<-betadisper(ins.bray, size1, type="median")
ins.disp.bray1
boxplot(ins.disp.bray1, names=c("Small", "Medium", "Large"), outline=FALSE, ylim=c(0, 0.8))
text("(a)", x=3.4,y=0.77, cex=1, font=1)


#JAC VOL
ins.disp.jac1<-betadisper(ins.jac, size1, type="median")
ins.disp.jac1
boxplot(ins.disp.jac1, xlab="Bromeliad Size", names=c("Small", "Medium", "Large"), outline=FALSE, ylim=c(0, 0.8))
text("(b)", x=3.4,y=0.77, cex=1, font=1)


#BRAY TANK
ins.disp.bray2<-betadisper(ins.bray, size2, type="median")
ins.disp.bray2
boxplot(ins.disp.bray2, names=c("Small", "Medium", "Large"), outline=FALSE, ylim=c(0, 0.8))
text("(c)", x=3.4,y=0.77, cex=1, font=1)


#JAC TANK
ins.disp.jac2<-betadisper(ins.jac, size2, type="median")
ins.disp.jac2
boxplot(ins.disp.jac2, xlab="Bromeliad Size", names=c("Small", "Medium", "Large"), outline=FALSE, ylim=c(0, 0.8))
text("(d)", x=3.4,y=0.77, cex=1, font=1)

mtext("Bromeliad Size", outer=TRUE, side=1)
mtext("Distance to Centroid", outer=TRUE, side=2, padj=1)


