#let reviewer(body) = [
  #set text(
    fill: rgb("$color-reviewer$"), size: 0.92em, style: "italic"
  )

  #block(inset: (x: 2em), spacing: 2em, body)
]

#let excerpt(body) = [
  #set text(
    fill: rgb("$color-excerpt$"), size: 0.92em
  )
  
  #block(inset: (x: 2em), spacing: 2em, body)
]

#let footnote-excerpt(body) = [
  #set text(
    fill: rgb("$color-excerpt$"), size: 0.84em
  )
  
  #block(inset: (x: 2em), spacing: 2em, body)
]

#let reviewer-inline(x) = text(rgb("$color-reviewer$"), style: "italic", x)
#let excerpt-inline(x) = text(rgb("$color-excerpt$"), x)

#let article(
  title: none,
  authors: none,
  date: none,
  abstract: none,
  cols: 1,
  margin: (x: 1.25in, y: 1.25in),
  paper: "us-letter",
  lang: "en",
  region: "US",
  font: (),
  fontsize: 11pt,
  sectionnumbering: none,
  pagenumbering: "1",
  toc: false,
  toc_title: none,
  toc_depth: none,
  doc,
) = {
  set page(
    paper: paper,
    margin: margin,
    numbering: "1",
  )
  set par(justify: true)
  set text(lang: lang,
           region: region,
           font: font,
           size: fontsize)
  set heading(numbering: sectionnumbering)

  if title != none {
    align(left)[#block(inset: (bottom: 1em))[
      #text(weight: "bold", size: 1.4em)[#title]
    ]]
  }
  
  if authors != none {
    let count = authors.len()
    let ncols = calc.min(count, 3)
    grid(
      columns: (1fr,) * ncols,
      row-gutter: 1.5em,
      inset: (bottom: 1em),
      ..authors.map(author =>
          align(left)[
            #if author.name != [] { [#author.name \ ] }
            #if author.affiliation != [] { [#author.affiliation \ ] }
            #if author.email != [] { [#author.email] }
          ]
      )
    )
  }

  if date != none {
    align(left)[#block(inset: (bottom: 1em))[
      #date
    ]]
  }

  if abstract != none {
    block(inset: 2em)[
    #text(weight: "semibold")[Abstract] #h(1em) #abstract
    ]
  }

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth
    );
    ]
  }

  if cols == 1 {
    doc
  } else {
    columns(cols, doc)
  }
}
