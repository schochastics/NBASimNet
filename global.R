library(shiny)
library(igraph)
library(visNetwork)
library(dplyr)
player_stats <- readRDS("player_stats.RDS")
g <- readRDS("networks.RDS")
xy <- readRDS("layouts.RDS")
colfunc_grad <- colorRampPalette(c("#104E8B", "#CD2626"))
col_qual <- c("#332288", "#88CCEE", "#44AA99", "#117733", "#999933", 
              "#DDCC77", "#661100", "#CC6677", "#882255", "#AA4499")


