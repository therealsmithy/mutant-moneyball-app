library(shiny)
library(shinythemes)
library(ggplot2)

# Load in what is needed
charactercounts <- readRDS('G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/charactercounts.rds')
open <- readRDS('G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/open.rds')
appearances <- read.csv('G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/MutantMoneyballAppearanceData.csv')
ppiebay <- readRDS('G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/ppiebay.rds')
ppiheritage <- readRDS('G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/ppiheritage.rds')
ppioStreet <- readRDS('G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/ppioStreet.rds')
ppiwiz <- readRDS('G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/ppiwiz.rds')
appearancepercentages <- readRDS('G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/appearancepercentages.rds')

# Define UI for the app
ui <- fluidPage(theme = shinytheme("superhero"),
  titlePanel("Mutant Moneyball App"),
  tags$style(HTML('
      .big-text {
        font-size: 50px;
    }
                  ')),
  sidebarLayout(
    sidebarPanel(
      selectInput("member", "Select a Member:",
                  choices = open$Member)
    ),
    mainPanel(
          fluidRow(
            column(6, uiOutput("numissues")),
            column(6, uiOutput("totalvalue")
          ),
          fluidRow(
            column(6, plotOutput("scatterplot1")),
            column(6, plotOutput("scatterplot2"))
          )
    )
  )
))

# Define server logic for app
server <- function(input, output) {
  output$numissues <- renderUI({
    div(class = 'big-text',paste("Number of Issues:", open$TotalIssues[open$Member == input$member]))
  })
  
  output$totalvalue <- renderUI({
    div(class = 'big-text' ,paste("Total Value: $", prettyNum(open$TotalValue_heritage[open$Member == input$member]), big.mark = ","))
  })
  
  output$scatterplot2 <- renderPlot({
    ggplot(ppiheritage[ppiheritage$Member == input$member,], 
           aes(x = Decade, y = TotalValue_Heritage)) +
      geom_point() +
      geom_line(group = 1) +
      labs(title = paste("PPI for", input$member),
           x = "Decade",
           y = "PPI")
  })
  
  output$scatterplot1 <- renderPlot({
    ggplot(appearancepercentages[appearancepercentages$Member == input$member,], 
           aes(x = Decade, y = Appearance_Percent)) +
      geom_point() +
      geom_line(group = 1) +
      labs(title = paste("Appearance Percentages for", input$member),
           x = "Decade",
           y = "Percentage")
  })
}

shinyApp(ui = ui, server = server)
