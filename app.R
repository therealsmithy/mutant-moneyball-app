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

# Define UI for the app
# The UI should have two rows of two graphs
ui <- fluidPage(theme = shinytheme("superhero"),
  titlePanel("Mutant Moneyball App"),
  sidebarLayout(
    sidebarPanel(
      selectInput("member", "Select a Member:",
                  choices = open$Member)
    ),
    mainPanel(
          fluidRow(
            column(6, plotOutput("scatterplot1")),
            column(6, plotOutput("scatterplot2"))
          ),
          fluidRow(
            column(6, plotOutput("scatterplot3")),
            column(6, plotOutput("scatterplot4"))
          )
    )
  )
)

# Define server logic for app
server <- function(input, output) {
  output$scatterplot1 <- renderPlot({
    ggplot(ppiebay[ppiebay$Member == input$member,], 
           aes(x = Decade, y = TotalValue_eBay)) +
      geom_point() +
      geom_line(group = 1) +
      labs(title = paste("PPI for", input$member),
           x = "Date",
           y = "PPI")
  })
  output$scatterplot2 <- renderPlot({
    ggplot(ppiheritage[ppiheritage$Member == input$member,],
           aes(x = Decade, y = TotalValue_Heritage)) +
      geom_point() +
      geom_line(group = 1) +
      labs(title = paste("PPI for", input$member),
           x = "Date",
           y = "PPI")
  })
  output$scatterplot3 <- renderPlot({
    ggplot(ppiwiz[ppiwiz$Member == input$member,],
           aes(x = Decade, y = TotalValue_Wiz)) +
      geom_point() +
      geom_line(group = 1) +
      labs(title = paste("PPI for", input$member),
           x = "Date",
           y = "PPI")
  })
  output$scatterplot4 <- renderPlot({
    ggplot(ppioStreet[ppioStreet$Member == input$member,],
           aes(x = Decade, y = TotalValue_oStreet)) +
      geom_point() +
      geom_line(group = 1) +
      labs(title = paste("PPI for", input$member),
           x = "Date",
           y = "PPI")
  })
}

shinyApp(ui = ui, server = server)
