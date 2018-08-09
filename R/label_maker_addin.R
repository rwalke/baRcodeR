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
  # base::library(qrcode)
  ui<-miniUI::miniPage(
    miniUI::gadgetTitleBar("baRcodeR"),
    miniUI::miniTabstripPanel(id = NULL, selected = NULL, between = NULL,
                              # simple label tab
      miniUI::miniTabPanel("Simple Label Generation", value = graphics::title, icon = shiny::icon("bars"),
                   miniUI::miniContentPanel(
                     shiny::fillRow(
                       shiny::fillCol(shiny::tagList(# user input elements
                         shiny::tags$h1("Simple Labels", id = "title"),
                         shiny::textInput("prefix", "Label String", value = "", width=NULL, placeholder="Type in ... ..."),
                         shiny::numericInput("start_number", "From (integer)", value = NULL, min = 1, max = Inf, width=NULL),
                         shiny::numericInput("end_number", "To (integer)", value = NULL, min = 1, max = Inf, width=NULL),
                         shiny::numericInput("digits", "digits", value = 3, min = 1, max = Inf, width=NULL),
                         # textOutput("check"),
                         shiny::actionButton("make", "Create Label.csv"))),
                       shiny::fillRow(shiny::tagList(# output code snippet for reproducibility
                         shiny::tags$h3("Reproducible code"),
                         shiny::verbatimTextOutput("label_code"),
                         # output showing label preview
                         shiny::tags$h3("Preview"),
                         DT::DTOutput("label_df")))
                     )

                                   )),
      # hierarchy label tab
      miniUI::miniTabPanel("Hierarchical Label Generation", value = graphics::title, icon = shiny::icon("sitemap"),
                           miniUI::miniContentPanel(
                             shiny::fillRow(
                               shiny::fillCol(shiny::tagList(
                                 # ui elements
                                 shiny::tags$h1("Hierarchical Labels", id = "title"),
                                 shiny::numericInput("hier_digits", "digits", value = 2, min = 1, max = Inf, width=NULL),
                                 shiny::textInput("hier_prefix", "Label String", value = "", width=NULL, placeholder="Type in ... ..."),
                                 shiny::numericInput("hier_start_number", "From (integer)", value = NULL, min = 1, max = Inf, width=NULL),
                                 shiny::numericInput("hier_end_number", "To (integer)", value = NULL, min = 1, max = Inf, width=NULL),
                                 shiny::actionButton('insertBtn', 'Add level'),
                                 shiny::actionButton('removeBtn', 'Remove level'),
                                 # shiny::actionButton("hier_label_preview", "Preview Labels"),
                                 shiny::actionButton("hier_label_make", "Create Labels.csv")
                               )),
                               shiny::fillCol(shiny::tagList(
                                 # code snippet
                                 shiny::tags$h3("Reproducible Code"),
                                 shiny::verbatimTextOutput("hier_code"),
                                 # output elements
                                 shiny::tags$h3("Hierarchy"),
                                 # output hierarchy as df
                                 shiny::verbatimTextOutput("list_check"),
                                 shiny::tags$h3("Label Preview"),
                                 # label preview
                                 DT::DTOutput("hier_label_df")
                               ))
                             )

                           )),
      # tab for pdf output
      miniUI::miniTabPanel("Barcode Creation", value= graphics::title, icon = shiny::icon("qrcode"),
                   miniUI::miniContentPanel(
                     shiny::fillRow(
                       shiny::fillCol(
                         shiny::tagList(
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
                     # conditional doesn't work in miniContent panel but doesn't matter
                     shiny::conditionalPanel(
                       condition = "input.cust_spacing == T",
                       shiny::numericInput("x_space", "Space between barcode and text", value = 215, min = 190, max = 250, width=NULL)
                     )
                         )
                       ),
                       shiny::fillCol(
                         shiny::tagList(shiny::tags$body("Click 'Import Label File' to import and check format of file."),
                     shiny::actionButton("label_check", "Import Label File"),
                     # output elements
                     # label preview datatable
                     DT::DTOutput("check_make_labels"),
                     # code snippet
                     shiny::tags$h3("Reproducible Code"),
                     shiny::verbatimTextOutput("PDF_code_render"),
                     shiny::tags$body("Click 'Make PDF' and wait for 'Done' to show up before opening PDF file"),
                     shiny::actionButton("make_pdf", "Make PDF"),
                     # status of pdf making
                     shiny::textOutput("PDF_status"))
                       )
                     )

                   )
                      )
    ## content panel end
  )
)
  # Define server logic required to draw a histogram
  server <- function(input, output, session) {
    # simple label serverside
    output$check <- shiny::renderText({paste0(input$prefix, input$start_number, input$end_number)})
    # making simple labels
    Labels <- shiny::reactive({
      shiny::validate(
        shiny::need(input$prefix != "", "Please enter a prefix"),
        shiny::need(input$start_number != "", "Please enter a starting value"),
        shiny::need(input$end_number != "", "Please enter an ending value"),
        shiny::need(input$digits != "", "Please enter the number of digits")
      )
      baRcodeR::label_maker(user=F, string = input$prefix, level = seq(input$start_number, input$end_number), digits = input$digits)
    })
    # preview of simple labels
    output$label_df<-DT::renderDataTable(Labels())
    # writing simple labels
    shiny::observeEvent(input$make, {
      fileName<-sprintf("Labels_%s.csv", Sys.Date())
      utils::write.csv(Labels(), file = file.path(getwd(), fileName), row.names=F)

    })
    output$label_code<-shiny::renderPrint(noquote(paste0("label_maker(user = F, string = \'", input$prefix, "\', ", "level = c(", input$start_number, ",", input$end_number, "), digits = ", input$digits, ")")))
    # pdf making server side
    # check label file
    Labels_pdf<-shiny::eventReactive(input$label_check, {
      shiny::req(input$labels)
      Labels<-utils::read.csv(input$labels$datapath, header=input$header)
      Labels
    })
    # preview label file
    output$check_make_labels<-DT::renderDataTable(Labels_pdf(), server = F, selection = list(mode = "single", target = "column", selected = 1))
    # text indicator that pdf finished making
    PDF_done<-shiny::eventReactive(input$make_pdf, {
      baRcodeR::custom_create_PDF(user=F, Labels = Labels_pdf()[, input$check_make_labels_columns_selected], name = input$filename, ErrCorr = input$err_corr, Fsz = input$font_size, Across = input$across, ERows = input$erow, ECols = input$ecol, trunc = input$trunc, numrow = input$numrow, numcol = input$numcol, height_margin = input$height_margin, width_margin = input$width_margin, cust_spacing = input$cust_spacing, x_space = input$x_space)
      status<-"Done"
      status
    })
    PDF_code_snippet<-shiny::reactive({
      noquote(paste0("custom_create_PDF(user=F, Labels = label_csv[,", input$check_make_labels_columns_selected, "], name = \'", input$filename, "\', ErrCorr = ", input$err_corr, ", Fsz = ", input$font_size, ", Across = ", input$across, ", ERows = ", input$erow, ", ECols = ", input$ecol, ", trunc = ", input$trunc, ", numrow = ", input$numrow, ", numcol = ", input$numcol, ", height_margin = ", input$height_margin, ", width_margin = ", input$width_margin, ", cust_spacing = ", input$cust_spacing, ", x_space = ", input$x_space, ")"))
      })
    csv_code_snippet<-shiny::reactive({noquote(paste0("label_csv <- read.csv( \'", input$labels$name, "\', header = ", input$header, ")"))})
    output$PDF_code_render<-shiny::renderText({
      paste(csv_code_snippet(), PDF_code_snippet(), sep = "\n")
      })
    # rendering of pdf indicator
    output$PDF_status<-shiny::renderPrint({print(PDF_done())})
    # server-side for hierarchical values
    # set reactiveValues to store the level inputs
    values<-shiny::reactiveValues()
    # set up data frame within reactiveValue function
    values$df<-data.frame(Prefix = character(0), start=integer(), end=integer(), stringsAsFactors = F)
    # delete row from the df if button is pressed.
    shiny::observeEvent(input$removeBtn, {
      shiny::isolate(values$df<-values$df[-(nrow(values$df)),])
    })
    # add level to df
    shiny::observeEvent(input$insertBtn, {
      # level_name<-input$insertBtn
      shiny::validate(
        shiny::need(input$hier_prefix != "", "Please enter a prefix"),
        shiny::need(input$hier_start_number != "", "Please enter a starting value"),
        shiny::need(input$hier_end_number != "", "Please enter an ending value"),
        shiny::need(input$hier_digits != "", "Please enter the number of digits")
      )
      shiny::isolate(values$df[nrow(values$df) + 1,]<-c(input$hier_prefix, input$hier_start_number, input$hier_end_number))
      shiny::updateTextInput(session = session, "hier_prefix", "Label String", value = character(0))
      shiny::updateNumericInput(session = session, "hier_start_number", "From (integer)", value = numeric(0), min = 1, max = Inf)
      shiny::updateNumericInput(session = session, "hier_end_number", "To (integer)", value = numeric(0), min = 1, max = Inf)
    })
    # make hierarchical labels
    hier_label_df<-shiny::reactive({
      # shiny::validate(
      #   shiny::need(input$hier_prefix != "", "Please enter a prefix"),
      #   shiny::need(input$hier_start_number != "", "Please enter a starting value"),
      #   shiny::need(input$hier_end_number != "", "Please enter an ending value"),
      #   shiny::need(input$hier_digits != "", "Please enter the number of digits")
      # )
      shiny::validate(
        shiny::need(nrow(values$df) != 0, "Please add a level")
      )
      hierarchy <- split(values$df, seq(nrow(values$df)))
      hier_Labels <- baRcodeR::label_hier_maker(user=F, hierarchy = hierarchy, end = NULL, digits = input$hier_digits)
      hier_Labels
    })
    hier_code_snippet_obj<-shiny::reactive({
      begin_string<-noquote(strsplit(paste(split(values$df, seq(nrow(values$df))), collapse=', '), ' ')[[1]])
      replace_string<-gsub(pattern = "list\\(", replacement = "c\\(", begin_string)
      replace_string<-paste(replace_string, sep="", collapse="")
      noquote(paste0("label_hier_maker(user = F, hierarchy = list(", replace_string, "), end = NULL, digits = ", input$hier_digits, ")"))

      })
    output$hier_code<-shiny::renderText(hier_code_snippet_obj())
    # rough df of the level df
    output$list_check<-shiny::renderPrint(values$df)
    # preview of hierarchical labels
    output$hier_label_df<-DT::renderDataTable(hier_label_df())
    # make the csv file
    shiny::observeEvent(input$hier_label_make, {
      fileName<-sprintf("Labels_%s.csv", Sys.Date())
      utils::write.csv(hier_label_df(), file = file.path(getwd(), fileName), row.names=F)
    })

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
  viewer <- shiny::dialogViewer("Subset", width = 800, height = 1000)
  shiny::runGadget(ui, server, viewer = viewer)

}


