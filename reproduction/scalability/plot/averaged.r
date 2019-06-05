#!/usr/bin/env Rscript

library(ggplot2)
library(plyr)

args <- commandArgs(trailingOnly=TRUE)
data <- read.csv(args[1], sep=" ")

ggplot(data, aes(x=factor(NumFlows), y=Average, fill=Impl)) +
    geom_col(aes(x=factor(NumFlows), y=Average, fill=Impl), position="dodge") +
    geom_errorbar(aes(ymin=Average-StdDev,ymax=Average+StdDev), position="dodge") +
    facet_wrap(~Alg) +
    labs(x="Flows", y="CPU Utilization %")


# ggplot(summarized, aes(x=factor(NumFlows), y=m, fill=Impl)) +
#     geom_col(aes(x=factor(NumFlows), y=m, fill=Impl)) +
#     geom_errorbar(aes(ymin=m-sd,ymax=m+sd)) +
#     facet_wrap(~Impl) +
#     labs(x="Flows", y="CPU Utilizaiton %") 

ggsave(args[2], width=6, height=2)

