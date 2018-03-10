library(shiny)
library(shinydashboard)

dashboardPage(skin = "red",
  dashboardHeader(title = "NBASimNet"),
  dashboardSidebar(
    selectInput("sel_season", "Select Season", as.character(2018:1990), selected = "2017", multiple = FALSE,
                               selectize = TRUE, width = NULL, size = NULL),
    sidebarMenu(
      menuItem("SimNet (Stats)", tabName = "simnet1", icon = icon("connectdevelop")),
      menuItem("SimNet (Teams)", tabName = "simnet2", icon = icon("connectdevelop")),
      menuItem("Help", tabName = "help", icon = icon("question"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab ------
      tabItem(tabName = "simnet1",
              h2("Compare player stats in a network"),
        fluidRow(
          column(6,selectInput("stat_col","Select Stat",
                               c("none"),
                      selected = "none")
          )
        ),
        fluidRow(
          column(12,
            visNetworkOutput("plot1",width=1000)
          )
        )
      ),
      # Second tab ----
      tabItem(tabName = "simnet2",
              h2("Locate players of a Team in a network"),
          fluidRow(    
              column(6,
                     selectInput("team_col","Select Team",
                                 c("none"),selected = "none")
              )
          ),
          fluidRow(
            column(12,
                   visNetworkOutput("plot2",width=1000) 
            )
          )
          
      ),
      # third tab ----
      tabItem(tabName = "help",
              h2("Help and Resources"),
              fluidRow(    
                column(8,
                       p("The R package visNetwork must be installed."),
                       p("Click on nodes to reveal player names and stats"),
                       p("Data source:", a(href="basketball-reference.com","basketball-reference.com")),
                       p(a(href="http://blog.schochastics.net/post/analyzing-nba-player-data-iii-similarity-networks/","Blog post"), "explaining this app"),
                       p("app created by" , a(href="https://twitter.com/schochastics","@schochastics"))
                       
                )
              )
            )
    )
  )
)