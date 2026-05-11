

<!-- README.md is generated from README.qmd. Please edit that file -->

# Hikmah Quarto templates

> ḥikmah (حكمة): Arabic;
> n. [wisdom](https://en.wikipedia.org/wiki/Hikmah); cf. [House of
> Wisdom](https://en.wikipedia.org/wiki/House_of_Knowledge)

------------------------------------------------------------------------

I’ve been using custom LaTeX templates (based in part on [Kieran Healy’s
template](https://github.com/kjhealy/latex-custom-kjh)) for years. With
the advent of Quarto, I decided to clean up [my
templates](https://github.com/andrewheiss/portable-pandoc-magic),
simplify them, and Quarto-ify them. Yay.

- Nice fancy PDF (`hikmah-pdf`)
- Nice fancy PDF through Typst (`hikmah-typst`)
- Manuscripty double-spaced PDF (`hikmah-manuscript-pdf`)
- Manuscripty double-spaced PDF through Typst
  (`hikmah-manuscript-typst`)
- Manuscripty double-spaced Word (`hikmah-manuscript-docx`)
- Manuscripty double-spaced OpenDocument (`hikmah-manuscript-pdf`)
- Reviewer response memo through Typst (`hikmah-response-typst`)

This repository is *really* meant as an example of how to create Quarto
templates and formats. Fork it, copy it, and adjust it all you want! Use
it as a way to learn how to make your own templates.

## Installation

Run this command to install the templates in your Quarto project:

``` bash
quarto add andrewheiss/hikmah-academic-quarto
```

## Features

(will be documented better soon!)

- Bibliography generation with either (1) `citeproc` or (2) `biblatex`
  and `biblatex-chicago`
- Support for Quarto’s complex [author/affiliation
  schema](https://quarto.org/docs/journals/authors.html)
- Fancy title block
- ~~Epigraphs~~ Use
  [`fancy-epigraphs`](https://github.com/andrewheiss/fancy-epigraphs-quarto)
  for epigraph support
- Title page in manuscripty PDF
- Ability to move floats and notes to the end of the document in
  manuscripty PDF
- Styles for peer review response memos
- Lots of other stuff that I’ll document later

## Examples

- Default version of `template.qmd`:
  - [template.qmd](template.qmd)
  - Fancy PDF version:
    [examples/hikmah-testing-default.pdf](examples/hikmah-testing-default.pdf)
  - Fancy PDF version through Typst:
    [examples/hikmah-testing-default-typst.pdf](examples/hikmah-testing-default-typst.pdf)
  - Manuscripty double spaced version:
    [examples/hikmah-testing-default-manuscript.pdf](examples/hikmah-testing-default-manuscript.pdf)
  - Manuscripty double spaced version through Typst:
    [examples/hikmah-testing-default-manuscript-typst.pdf](examples/hikmah-testing-default-manuscript-typst.pdf)
  - Manuscripty double spaced APA-like .docx version:
    [examples/hikmah-testing-default-manuscript.docx](examples/hikmah-testing-default-manuscript.docx)
  - Manuscripty double spaced APA-like .odt version (open with
    [LibreOffice](https://www.libreoffice.org/)):
    [examples/hikmah-testing-default-manuscript.odt](examples/hikmah-testing-default-manuscript.odt)
- Custom fonts + `biblatex-chicago`:
  - [hikmah-testing-custom.qmd](hikmah-testing-custom.qmd)
  - Fancy PDF version:
    [examples/hikmah-testing-custom.pdf](examples/hikmah-testing-custom.pdf)
  - Fancy PDF version through Typst:
    [examples/hikmah-testing-custom-typst.pdf](examples/hikmah-testing-custom-typst.pdf)
  - Manuscripty double spaced version:
    [examples/hikmah-testing-custom-manuscript.pdf](examples/hikmah-testing-custom-manuscript.pdf)
  - Manuscripty double spaced version through Typst:
    [examples/hikmah-testing-custom-manuscript-typst.pdf](examples/hikmah-testing-custom-manuscript-typst.pdf)

### Fancy PDF, default settings

[<img src="examples/thumbnails/hikmah-testing-default-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-default-pdf.png)

### Fancy PDF, custom fonts + `biblatex-chicago`

[<img src="examples/thumbnails/hikmah-testing-custom-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-custom-pdf.png)

### Fancy PDF through typst, default settings

[<img src="examples/thumbnails/hikmah-testing-default-typst-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-default-typst-pdf.png)

### Fancy PDF through typst, custom fonts

[<img src="examples/thumbnails/hikmah-testing-custom-typst-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-custom-typst-pdf.png)

### Manuscripty PDF through Typst, default settings

[<img
src="examples/thumbnails/hikmah-testing-default-manuscript-typst-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-default-manuscript-typst-pdf.png)

### Manuscripty PDF through Typst, custom fonts

[<img
src="examples/thumbnails/hikmah-testing-custom-manuscript-typst-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-custom-manuscript-typst-pdf.png)

### Manuscripty PDF, default settings

[<img src="examples/thumbnails/hikmah-testing-default-manuscript-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-default-manuscript-pdf.png)

### Manuscripty PDF, custom fonts + `biblatex-chicago`

[<img src="examples/thumbnails/hikmah-testing-custom-manuscript-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-custom-manuscript-pdf.png)

### Manuscripty Word (.docx), default settings

[<img
src="examples/thumbnails/hikmah-testing-default-manuscript-docx.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-default-manuscript-docx.png)

### Manuscripty OpenDocument (.odt), default settings

[<img src="examples/thumbnails/hikmah-testing-default-manuscript-odt.png"
style="width:100.0%" />](examples/thumbnails/hikmah-testing-default-manuscript-odt.png)

### Reviewer response memo, default settings

[<img src="examples/thumbnails/hikmah-response-memo-pdf.png"
style="width:100.0%" />](examples/thumbnails/hikmah-response-memo-pdf.png)
