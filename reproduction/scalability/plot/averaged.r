#!/usr/bin/env Rscript

library(ggplot2)
library(plyr)

args <- commandArgs(trailingOnly=TRUE)
data <- read.csv(args[1], sep=" ")

ggplot(data, aes(x=factor(NumFlows), y=Average, fill=Impl)) +
    geom_col(aes(x=factor(NumFlows), y=Average, fill=Impl), position="dodge") +
    geom_errorbar(aes(ymin=Average-StdDev,ymax=Average+StdDev), position="dodge") +
    scale_fill_manual(
        labels=c(
            "ccp" = "ccp",
            "kernel" = "kernel"
        ),
        values=c(
            "ccp" = "#88419d",
            "kernel" = "#b3cde3"
        ),
        guide=guide_legend(title=NULL)
    ) +
    labs(x="Flows", y="CPU Utilization %") +
    facet_wrap(~Alg)

ggsave(args[2], width=6, height=2)

