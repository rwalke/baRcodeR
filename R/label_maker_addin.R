#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#library(shiny)
#library(miniUI)
#library(baRcodeR)

make_labels<-function() {
  # user interface
  ui<-miniUI::miniPage(
    miniUI::gadgetTitleBar("Make labels"),
    miniUI::miniTabstripPanel(id = NULL, selected = NULL, between = NULL,
      miniUI::miniTabPanel("Simple Labels", value = graphics::title, icon = NULL,
                   miniUI::miniContentPanel(
                                     shiny::textInput("prefix", "Label String", value = "", width=NULL, placeholder="Type in ... ..."),
                                     shiny::numericInput("start_number", "From (integer)", value = NULL, min = 1, max = Inf, width=NULL),
                                     shiny::numericInput("end_number", "To (integer)", value = NULL, min = 1, max = Inf, width=NULL),
                                     shiny::numericInput("digits", "digits", value = 3, min = 1, max = Inf, width=NULL),
                                     # textOutput("check"),
                                     shiny::actionButton("make", "Create Label.csv"),
                                     shiny::tags$h2("Preview"),
                                     DT::DTOutput("label_df")
                                   )),
      miniUI::miniTabPanel("PDF_maker", value= graphics::title, icon = NULL,
                   miniUI::miniContentPanel(
                     shiny::fileInput("labels", "Choose a text file of labels.", multiple=F,
                               accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                     shiny::checkboxInput("header", "Header in file?", value=T),
                     # radioButtons("header", "Header in file?", choices = c(Yes = T, No = F), selected = T),
                     shiny::textInput("filename", "PDF file name", value = "LabelsOut"),
                     shiny::selectInput(inputId = "err_corr", label = "Error Correction", choices = c("L (up to 7% damage)"="L", "M (up to 15% damage)"= "M", "Q (up to 25% damage)" = "Q", "H (up to 30% damage)" = "H"), multiple=F),
                     shiny::numericInput("font_size", "Font Size", value = 2.5, min = 2.2, max = 4.7, width=NULL),
                     shiny::radioButtons("across", "Print across?", choices = c(Yes = T, No = F), selected = T),
                     shiny::numericInput("erow", "# of rows to skip", value = 0, min = 0, max = 20, width=NULL),
                     shiny::numericInput("ecol", "# of columns to skip", value = 0, min = 0, max = 20, width=NULL),
                     shiny::checkboxInput("trunc", "Truncate label text?", value=F),
                     shiny::numericInput("numrow", "Number of label rows on sheet", value = 20, min = 1, max = 100, width=NULL, step = 1),
                     shiny::numericInput("numcol", "Number of label columbs on sheet", value = 4, min = 1, max = 100, width=NULL, step = 1),
                     shiny::numericInput("height_margin", "Height margin (in)", value = 0.5, min = 0, max = 20, width=NULL, step = 0.05),
                     shiny::numericInput("width_margin", "Width margin (in)", value = 0.25, min = 0, max = 20, width=NULL, step = 0.05),
                     shiny::checkboxInput("cust_spacing", "Custom spacing between barcode and text", value=F),
                     # radioButtons("cust_spacing", "Custom Spacing between barcode and text?", choices = c(Yes = T, No = F), selected = F),
                     shiny::conditionalPanel(
                       condition = "input.cust_spacing == T",
                       shiny::numericInput("x_space", "Space between barcode and text", value = 215, min = 190, max = 250, width=NULL)
                     ),
                     shiny::tags$li("Click 'Import Label File' to import and check format of file."),
                     shiny::actionButton("label_check", "Import Label File"),
                     DT::DTOutput("check_make_labels"),
                     shiny::tags$li("Click 'Make PDF' and wait for 'Done' to show up before opening PDf file"),
                     shiny::textOutput("PDF_status"),
                     shiny::actionButton("make_pdf", "Make PDF")

                   )
                      )
    ## content panel end
  )
)
  # Define server logic required to draw a histogram
  server <- function(input, output, session) {

    output$check <- shiny::renderText({paste0(input$prefix, input$start_number, input$end_number)})
    Labels <- shiny::reactive({
      shiny::validate(
        shiny::need(input$prefix != "", "Please enter a prefix"),
        shiny::need(input$start_number != "", "Please enter a starting value"),
        shiny::need(input$end_number != "", "Please enter an ending value"),
        shiny::need(input$digits != "", "Please enter the number of digits")
      )
      baRcodeR::label_maker(user=F, string = input$prefix, level = seq(input$start_number, input$end_number), digits = input$digits)
    })
    output$label_df<-DT::renderDataTable(Labels())
    shiny::observeEvent(input$make, {
      fileName<-sprintf("Labels_%s.csv", Sys.Date())
      utils::write.csv(Labels(), file = file.path(getwd(), fileName), row.names=F)

    })
    Labels_pdf<-shiny::eventReactive(input$label_check, {
      shiny::req(input$labels)
      Labels<-utils::read.csv(input$labels$datapath, header=input$header)
      shiny::validate(
        shiny::need(ncol(Labels) == 1, "Your label file contains more than one column. Please modify your file.")
      )
      Labels
    })
    output$check_make_labels<-DT::renderDataTable(Labels_pdf())
    PDF_done<-shiny::eventReactive(input$make_pdf, {
      baRcodeR::custom_create_PDF(user=F, Labels = Labels(), name = input$filename, ErrCorr = input$err_corr, Fsz = input$font_size, Across = input$across, ERows = input$erow, ECols = input$ecol, trunc = input$trunc, numrow = input$numrow, numcol = input$numcol, height_margin = input$height_margin, width_margin = input$width_margin, cust_spacing = input$cust_spacing, x_space = input$x_space)
      status<-"Done"
      status
    })
    output$PDF_status<-shiny::renderPrint({print(PDF_done())})

    ## Your reactive logic goes here.

    # Listen for the 'done' event. This event will be fired when a user
    # is finished interacting with your application, and clicks the 'done'
    # button.
    shiny::observeEvent(input$done, {

      # Here is where your Shiny application might now go an affect the
      # contents of a document open in RStudio, using the `rstudioapi` package.
      #
      # At the end, your application should call 'stopApp()' here, to ensure that
      # the gadget is closed after 'done' is clicked.
      shiny::stopApp()
    })
  }
  # Run the application
  # shinyApp(ui = ui, server = server)
  viewer <- shiny::dialogViewer("Subset", width = 1000, height = 1000)
  shiny::runGadget(ui, server, viewer = viewer)

}


