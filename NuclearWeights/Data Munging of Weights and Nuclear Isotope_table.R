# Script to build a clean isotope database that can be used for calculations such as nuclear binding energy.

install.packages("data.table")
library(data.table)

# Load the Symbols and Observed Weights into a data table
# Sourcefile for weights here: http://www.sisweb.com/referenc/source/exactmas.htm
DF <- fread("C:/Users/Nick/Documents/Projects/Project - FirstPrinciples.Energy/R/Learning R/Weights.txt")

# Set the symbol field to be the key
setkey(DF, Symbol)

# Split the 2 char string out from the symbol column
DF$StrSymbol = as.character(lapply(strsplit(as.character(DF$Symbol), split="\\("), "[", 1))
DF$A_tmp = as.character(lapply(strsplit(as.character(DF$Symbol), split="\\("), "[", 2))
DF$A = as.character(lapply(strsplit(as.character(DF$A_tmp), split="\\)"), "[", 1))
DF[, A_tmp:=NULL]

# Load the 2nd data set on isotopes including protons, stability, spin, gn, abundance and quadrupole moment
# http://easyspin.org/documentation/isotopetable.html
# Note: I removed the % lines in the field to give a r a clean import set
DTT <- fread("C:/Users/Nick/Documents/Projects/Project - FirstPrinciples.Energy/R/Learning R/Nuclear_Isotope_Table")
DTT$neutrons = DTT$nucleons - DTT$protons
DTT$Symbol <- paste(DTT$symbol, "(", DTT$nucleons, ")", sep="")
setkey(DTT, Symbol)

IsotopeTable = merge(DF, DTT)
IsotopeTable[, A:=NULL]
IsotopeTable[, Abund.:=NULL]

write.table (IsotopeTable, 
      file = "C:/Users/Nick/Documents/Projects/Project - FirstPrinciples.Energy/R/Learning R/IsoTope_Database")

# Graph the outputs
Sys.setenv("plotly_username"="nick.barsley")
Sys.setenv("plotly_api_key"="q269yzfmvp")


library(plotly)

p <- plot_ly(data = IsotopeTable, x = ~protons, y = ~neutrons, text = ~paste(Symbol, '$<br>Natural abundance: ',round(natural_abudance,1),'%'), size = ~natural_abudance, color = ~natural_abudance)
p

chart_link = plotly_POST(p, filename="Isotopes")
chart_link
  
