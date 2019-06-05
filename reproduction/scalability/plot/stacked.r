#!/usr/bin/env Rscript

library(ggplot2)
library(plyr)

args <- commandArgs(trailingOnly=TRUE)
data <- read.csv(args[1], sep=" ")

ggplot(data) +
    geom_bar(aes(x=factor(NumFlows), y=Value, fill=Type), stat="identity") +
    labs(x="Flows", y="CPU Utilization %") + 
    facet_wrap(~Impl)

ggsave(args[2], width=6, height=2)

