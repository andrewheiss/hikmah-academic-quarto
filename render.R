library(tidyverse)
library(quarto)

files_to_render <- tribble(
  ~file,                    ~format,                  ~ext,  ~suffix,
  "hikmah-testing-default", "hikmah-pdf",             "pdf", "",
  "hikmah-testing-default", "hikmah-manuscript-pdf",  "pdf", "-manuscript",
  "hikmah-testing-default", "hikmah-manuscript-docx", "docx", "-manuscript",
  "hikmah-testing-custom",  "hikmah-pdf",             "pdf", "",
  "hikmah-testing-custom",  "hikmah-manuscript-pdf",  "pdf", "-manuscript"
)

rendered_files <- files_to_render %>% 
  rowwise() %>% 
  mutate(rendered = pmap(list(file, format, suffix, ext), ~{
    quarto_render(
      input = paste0(file, ".qmd"),
      output_format = format,
      output_file = paste0(file, suffix, ".", ext)
    )
  }))
