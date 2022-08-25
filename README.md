# Hikmah Quarto templates

> ḥikmah (حكمة): Arabic; n. [wisdom](https://en.wikipedia.org/wiki/Hikmah); cf. [House of Wisdom](https://en.wikipedia.org/wiki/House_of_Knowledge)

---

I've been using custom LaTeX templates (based in part on [Kieran Healy's template](https://github.com/kjhealy/latex-custom-kjh)) for years. With the advent of Quarto, I decided to clean up [my templates](https://github.com/andrewheiss/portable-pandoc-magic), simplify them, and Quarto-ify them. Yay.

Eventually this repository will hold all my templates:

- Nice fancy PDF (`hikmah-pdf`) [Done!]
- Manuscripty double-spaced PDF [Not here yet]
- Nice fancy HTML [Not here yet]
- Manuscripty double-spaced Word (.docx) [Not here yet]

This repository is *really* meant as an example of how to create Quarto templates and formats. Fork it, copy it, and adjust it all you want! Use it as a way to learn how to make your own templates.


## Installation

Run this command to install the templates in your Quarto project:

```bash
quarto use template andrewheiss/hikmah-academic-quarto
```

## Features

(will be documented better soon!)

- Bibliography generation with both `biblatex` and `biblatex-chicago`
- Support for Quarto's complex [author/affiliation schema](https://quarto.org/docs/journals/authors.html)
- Fancy title block
- Epigraphs
- Title page in manuscripty PDF
- Ability to move floats and notes to the end of the document in manuscripty PDF
- Styles for peer review response memos
- Lots of other stuff that I'll document later


## Examples

- Default version of `template.qmd`:
  - [template.qmd](template.qmd)
  - [examples/hikmah-testing-default.pdf](examples/hikmah-testing-default.pdf)
- Custom fonts + `biblatex-chicago`:
  - [hikmah-testing-custom.qmd](hikmah-testing-custom.qmd)
  - [examples/hikmah-testing-custom.pdf](examples/hikmah-testing-custom.pdf)
