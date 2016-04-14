w.13.hell.geno.rda <- rda(w.13.hell.pos2 ~ Condition(Wind.Exposure) + Condition(Block) + Genotype, data = w.arth.13.pos2)
summary(w.13.hell.geno.rda)$cont$importance[ ,1:2]

plot(w.13.hell.geno.rda, type = "n")
points(w.13.hell.geno.rda, display = "sites", col = "gray50")
ordiellipse(w.13.hell.geno.rda, groups = w.arth.13.pos2$Genotype, col = "gray50",draw = "polygon")
text(w.13.hell.geno.rda, display = "cn", labels = levels(w.arth.13.pos2$Genotype))