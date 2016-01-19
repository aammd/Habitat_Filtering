### make the png file names into pdfs

png_to_pdf_filename <- function(md_file){
  "sed -i 's/r2_plot.png/r2_plot.pdf/g' %s" %>% 
    sprintf(md_file) %>% 
    system()
  
  "sed -i 's/individual_responses.png/individual_responses.pdf/g' %s" %>% 
    sprintf(md_file) %>% 
    system()
}

render_pdf <- function(filename, ...){
  png_to_pdf_filename(filename)
  render(filename, ...)
}