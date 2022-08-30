# PDF formats

- [ ] Landscape things in PDFs
- [ ] Better conditional handling of authors and correspondence information. There's currently no `else` condition when there's no corresponding author or correspondence prefix

# ODT manuscript format

- [ ] Author affiliation details
- [ ] Why isn't the bibliography getting assigned the bibliography style?
- [ ] Running header?

# HTML

- [ ] Adapt my old template to Quarto


---

How to generate blank reference files with all necessary pandoc styles:

```sh
pandoc -o custom-reference.docx --print-default-data-file reference.docx
pandoc -o custom-reference.odt --print-default-data-file reference.odt
```
