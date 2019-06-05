#!/usr/bin/env Rscript

library(ggplot2)
library(plyr)

args <- commandArgs(trailingOnly=TRUE)
data <- read.csv(args[1], sep=" ")

dodge <- position_dodge(width=0.9)
ggplot(data, aes(x=factor(NumFlows), y=Throughput, fill=Impl)) +
    geom_col(aes(x=factor(NumFlows), y=Throughput, fill=Impl), position=dodge) +
    scale_fill_manual(
        labels=c(
            "ccp-10-ms" = "CCP (10ms)",
            "ccp-per-ack" = "CCP (Ack)",
            "kernel" = "Kernel"
        ),
        values=c(
            "ccp-10-ms" = "#88419d",
            "ccp-per-ack" = "#8c96c6",
            "kernel" = "#b3cde3"
        ),
        guide=guide_legend(title=NULL)
    ) +
    labs(x="Flows", y="Throughput (Gbps)") +
    facet_wrap(~Algorithm)

ggsave(args[2], width=6, height=2)

