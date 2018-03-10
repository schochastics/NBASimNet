shinyServer(function(input, output,session) {

  #update stats selector ----
  observe({
    sel <- input$stat_col
    x <- names(player_stats[[input$sel_season]])[!names(player_stats[[input$sel_season]])%in%c("player","tm")]
    x <- c("none",x)
    updateSelectInput(session, "stat_col",
                      choices = x,
                      selected = sel
    )
  })
  
  #update team selector ----
  observe({
    sel2 <- input$team_col
    x <- c("none",sort(unique(player_stats[[input$sel_season]]$tm)))
    updateSelectInput(session, "team_col",
                      choices = x,
                      selected = sel2
    )
  })
  #update network ----
  observeEvent(input$sel_season, {
      V(g[[input$sel_season]])$label <- player_stats[[input$sel_season]]$player
  })
  
  #draw net 1----
  output$plot1 <- renderVisNetwork({
    if(!is.null(g[[input$sel_season]])){
    V(g[[input$sel_season]])$title <- paste0("<p><b>", 
                         player_stats[[input$sel_season]]$player,
                         "(",player_stats[[input$sel_season]]$tm,") </b><br>",
                         input$stat_col," ",player_stats[[input$sel_season]][[input$stat_col]],"</p>")
    
    if(is.numeric(player_stats[[input$sel_season]][[input$stat_col]]) & input$stat_col!=" "){
      V(g[[input$sel_season]])$color <- colfunc_grad(200)[ntile(player_stats[[input$sel_season]][[input$stat_col]],200)]
    } else if(input$stat_col!="none"){
      V(g[[input$sel_season]])$color <- col_qual[as.numeric(as.factor(player_stats[[input$sel_season]][[input$stat_col]]))]
    } else {
      V(g[[input$sel_season]])$color <- "grey"
    }
    visIgraph(g[[input$sel_season]],layout = "layout.norm",layoutMatrix = as.matrix(xy[[input$sel_season]]),
              physics = T) }
  })
  output$plot2 <- renderVisNetwork({
    if(!is.null(g[[input$sel_season]])){
    V(g[[input$sel_season]])$title <- paste0("<p><b>", player_stats[[input$sel_season]]$player,
                         "(",player_stats[[input$sel_season]]$tm,") </b><br>",
                         input$stat_col," ",player_stats[[input$sel_season]][[input$stat_col]],"</p>")
    V(g[[input$sel_season]])$color <- ifelse(player_stats[[input$sel_season]]$tm==input$team_col,"#8B1A1A","#D9D9D9")
    visIgraph(g[[input$sel_season]],layout = "layout.norm",layoutMatrix = as.matrix(xy[[input$sel_season]]),
              physics = T) }
  })

})

# sort(unique(player_stats$tm)))