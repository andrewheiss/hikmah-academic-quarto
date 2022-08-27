library(quarto)

quarto_render(
  input = "hikmah-testing-default.qmd",
  output_format = "hikmah-pdf",
  output_file = "hikmah-testing-default.pdf"
)

quarto_render(
  input = "hikmah-testing-default.qmd",
  output_format = "hikmah-manuscript-pdf",
  output_file = "hikmah-testing-manuscript-default.pdf"
)

quarto_render(
  input = "hikmah-testing-custom.qmd",
  output_format = "hikmah-pdf",
  output_file = "hikmah-testing-custom.pdf"
)

quarto_render(
  input = "hikmah-testing-custom.qmd",
  output_format = "hikmah-manuscript-pdf",
  output_file = "hikmah-testing-manuscript-custom.pdf"
)
