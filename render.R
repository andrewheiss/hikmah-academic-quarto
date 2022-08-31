library(tidyverse)
library(quarto)
library(magick)

files_to_render <- tribble(
  ~file,                    ~format,                  ~ext,   ~suffix,
  "hikmah-testing-default", "hikmah-pdf",             "pdf",  "",
  "hikmah-testing-default", "hikmah-manuscript-pdf",  "pdf",  "-manuscript",
  "hikmah-testing-default", "hikmah-manuscript-docx", "docx", "-manuscript",
  "hikmah-testing-default", "hikmah-manuscript-odt",  "odt",  "-manuscript",
  "hikmah-testing-custom",  "hikmah-pdf",             "pdf",  "",
  "hikmah-testing-custom",  "hikmah-manuscript-pdf",  "pdf",  "-manuscript"
)

rendered_files <- files_to_render %>% 
  rowwise() %>% 
  mutate(rendered = pmap_chr(list(file, format, suffix, ext), ~{
    quarto_render(
      input = paste0(file, ".qmd"),
      output_format = format,
      output_file = paste0(file, suffix, ".", ext)
    )
    return(paste0(file, suffix, ".", ext))
  })) %>% 
  ungroup() %>% 
  mutate(thumbnail_name = str_replace_all(rendered, "\\.", "-"))


thumbify <- function(ext, rendered, thumbnail_name) {
  # docx and odt files aren't images, so we can't actually read them with
  # image_read_pdf(). So we first convert them to PDFs using LibreOffice's
  # terminal command (soffice) and store the resulting PDFs temporarily
  if (ext %in% c("docx", "odt")) {
    outdir_temp <- tempdir()
    system2("/Applications/LibreOffice.app/Contents/MacOS/soffice",
            c("--headless", "--convert-to", "pdf:writer_pdf_Export",
              paste0("examples/", rendered), "--outdir", outdir_temp))
    
    to_convert <- paste0(outdir_temp, "/", tools::file_path_sans_ext(basename(rendered)), ".pdf")
  } else {
    to_convert <- paste0("examples/", rendered)
  }
  
  # Convert each rendered PDF to a collage and save as PNG
  image_read_pdf(to_convert) %>% 
    image_montage(geometry = "x2000+25+35", tile = "3", bg = "grey92", shadow = TRUE) %>% 
    image_convert(format = "png") %>%
    image_write(paste0("examples/thumbnails/", thumbnail_name, ".png"))
  
  return(paste0(thumbnail_name, ".png"))
}

# Create thumbnail collages for each rendered file
thumbified_files <- rendered_files %>% 
  rowwise() %>% 
  mutate(thumbnail = pmap_chr(list(ext, rendered, thumbnail_name), ~{
    thumbify(ext, rendered, thumbnail_name)
  })) %>% 
  ungroup()
