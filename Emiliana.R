# Script to plot barplots of resistant genes for each ensambler
library(ggplot2)
library(dplyr)
library(viridis)
library(forcats)

# set working directory
setwd("/home/j/Downloads/resfamsdados/")



get_figure <- function(data1, data2, data3, assembler1, assembler2, assembler3, figure_name){
# Load data
test1 <- read.table(data1)
# get resistance genes
rg1 <- test1 %>% select(V1)
# get counts
t_rg1 <- as.data.frame(table(rg1))
# add column with ensambler
t_rg1 <- mutate(t_rg1, Assembler = assembler1)
# change column names
colnames(t_rg1) <- c("gene", "Freq", "Assembler")

# Load data
test2 <- read.table(data2)
# get resistance genes
rg2 <- test2 %>% select(V1)
# get counts
t_rg2 <- as.data.frame(table(rg2))
# add column with ensambler
t_rg2 <- mutate(t_rg2 ,Assembler = assembler2)
# change column names
colnames(t_rg2) <- c("gene", "Freq", "Assembler")

# Load data
test3 <- read.table(data3)
# get resistance genes
rg3 <- test3 %>% select(V1)
# get counts
t_rg3 <- as.data.frame(table(rg3))
# add column with ensambler
t_rg3 <- mutate(t_rg3 ,Assembler = "megahit")
# change column names
colnames(t_rg3) <- c("gene", "Freq", "Assembler")

df <- rbind(t_rg1, t_rg2, t_rg3)

top20 <- top_n(df,133,Freq)

top20 %>% mutate(gene = fct_reorder(gene, desc(Freq))) %>%
ggplot(aes(x = gene, y = Freq, color = Assembler, fill = Assembler)) +
  ggtitle(figure_name) +
  geom_bar(stat = "identity",
           width = 0.4,
           position=position_dodge(width = 0.5)) +
  scale_color_viridis_d() +
  scale_fill_viridis_d() +
  theme_classic() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1),
        text=element_text(family="Times New Roman", size=25))
ggsave( filename = paste0(figure_name,".png") , units = "mm", width = 550, height = 200, dpi = 200, device = "png")
}

# Abomasum_Albendazole
get_figure("Abomasum_Albendazole___resfams_idba_ud.out.dm.ps.stringent",
           "Abomasum_Albendazole___resfams_metaspades.out.dm.ps.stringent",
           "Abomasum_Albendazole___resfams_megahit.out.dm.ps.stringent",
           "idba_ud",
           "metaspades",
           "megahit",
           "Abomasum_Albendazole")
# Abomasum_NoDrug
get_figure("Abomasum_NoDrug___resfams_idba_ud.out.dm.ps.stringent",
           "Abomasum_NoDrug___resfams_metaspades.out.dm.ps.stringent",
           "Abomasum_NoDrug___resfams_megahit.out.dm.ps.stringent",
           "idba_ud",
           "metaspades",
           "megahit",
           "Abomasum_NoDrug")
# Faeces_Albendazole
get_figure("Faeces_Albendazole___resfams_idba_ud.out.dm.ps.stringent",
           "Faeces_Albendazole___resfams_metaspades.out.dm.ps.stringent",
           "Faeces_Albendazole___resfams_megahit.out.dm.ps.stringent",
           "idba_ud",
           "metaspades",
           "megahit",
           "Faeces_Albendazole")
# Faeces_NoDrug
get_figure("Faeces_NoDrug___resfams_idba_ud.out.dm.ps.stringent",
           "Faeces_NoDrug___resfams_metaspades.out.dm.ps.stringent",
           "Faeces_NoDrug___resfams_megahit.out.dm.ps.stringent",
           "idba_ud",
           "metaspades",
           "megahit",
           "Faeces_NoDrug")
# Rumen_Albendazole
get_figure("Rumen_Albendazole___resfams_idba_ud.out.dm.ps.stringent",
           "Rumen_Albendazole___resfams_metaspades.out.dm.ps.stringent",
           "Rumen_Albendazole___resfams_megahit.out.dm.ps.stringent",
           "idba_ud",
           "metaspades",
           "megahit",
           "Rumen_Albendazole")
# Rumen_NoDrug
get_figure("Rumen_NoDrug___resfams_idba_ud.out.dm.ps.stringent",
           "Rumen_NoDrug___resfams_metaspades.out.dm.ps.stringent",
           "Rumen_NoDrug___resfams_megahit.out.dm.ps.stringent",
           "idba_ud",
           "metaspades",
           "megahit",
           "Rumen_NoDrug")


