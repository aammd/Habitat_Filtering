### make the png file names into pdfs

png_to_pdf_filename <- function(md_file){
  "sed -i 's/.png)/.pdf)/g' %s" %>% 
    sprintf(md_file) %>% 
    system()

}

pdf_to_png_filename <- function(md_file){
  "sed -i 's/.pdf)/.png)/g' %s" %>% 
    sprintf(md_file) %>% 
    system()

}

render_pdf <- function(filename, ...){
  png_to_pdf_filename(filename)
  render(filename, ...)
  pdf_to_png_filename(filename)
}