// Font Awesome for ORCID icon
#import "@preview/fontawesome:0.5.0": *

// Make a more global variable for the callout font so that it can get set and
// updated inside article()
#let callout-font = state("callout-font", none)

#let article(
  title: none,
  subtitle: none,
  authors: none,
  keywords: (),
  date: none,
  abstract-title: none,
  abstract: none,
  thanks: none,
  cols: 1,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 11pt,
  title-size: 1.4em,
  subtitle-size: 1.25em,
  heading-family: none,
  heading-weight: "bold",
  heading-style: "normal",
  heading-color: black,
  heading-line-height: 0.65em,
  mathfont: none,
  codefont: none,
  linestretch: 1,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc_title: none,
  toc_depth: none,
  toc_indent: 1.5em,

  // ---------------------------
  // ↓ New arguments I added ↓
  // ---------------------------
  short-title: none,
  published: none,
  code-repo: none,
  correspondence-prefix: "Correspondence concerning this article should be addressed to",
  additional-info: none,
  first-line-indent: 1em,
  spacing: 0.65em,
  running-header: false,
  running-header-content: none,

  // Back to Quarto's stuff
  doc,
) = {
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()
  set par(
    justify: true,
    leading: linestretch * 0.65em,
    // -----------------------------------------------
    // ↓ These are new and come from YAML settings ↓
    // -----------------------------------------------
    first-line-indent: first-line-indent,
    spacing: spacing
  )
  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  // ---------------------------------------------------------------------------
  // -------------------------------------
  // ↓ START CUSTOM STUFF ↓
  // ----------------------

  let heading-font = if heading-family != none { heading-family } else if font != none { font } else { none }
  callout-font.update(heading-font)

  // Headings
  show heading: set text(font: heading-font) if heading-font != none
  show heading: set text(fill: heading-color) if heading-color != black

  show heading.where(level: 1): it => {
    set text(size: fontsize * 1.25, weight: "bold")
    set block(above: 2.5em, below: 0.65em)
    it
  }

  show heading.where(level: 2): it => {
    set text(size: fontsize * 1.1, weight: "bold")
    set block(above: 2.3em, below: 0.65em)
    it
  }

  show heading.where(level: 3): it => {
    set text(size: fontsize * 0.95, weight: "bold")
    set block(above: 2em, below: 0.65em)
    it
  }

  show heading.where(level: 4): it => {
    set text(size: fontsize * 0.9, weight: "bold")
    it.body
    sym.space.quad
  }

  // Floaty things
  // show figure.where(kind: "quarto-float-fig"): set block(
  //   width: 100%, above: spacing * 3, below: spacing * 3
  // )
  set figure(gap: 1em)  // Gap between figure and caption

  show figure.where(kind: "quarto-float-fig"): set block(
    above: spacing * 3, below: spacing * 3
  )

  show figure.where(kind: "quarto-float-tbl"): set block(
    above: spacing * 3, below: spacing * 3
  )

  show table: it => {
    set text(font: heading-font) if heading-font != none
    set text(size: fontsize * 0.85)
    it
  }

  // Captions
  show figure.caption: it => {
    set align(left)
    set par(first-line-indent: 0em)
    set text(font: heading-font) if heading-font != none
    set text(size: 0.88em)
    text(weight: "bold")[#it.supplement #context it.counter.display(it.numbering)]
    sym.space.quad
    it.body
  }

  // Lists
  // Up at the beginning in set par(), `spacing` gets set so that there's no
  // space between paragraphs, since paragraphs are indented instead. That
  // `spacing` parameters messes up Typst's list spacing, so we have to override
  // it here for lists.
  //
  // The default is 1.2; going beyond that adds space above/below each list
  // show list: set par(spacing: 2em)
  // show enum: set par(spacing: 2em)
  set list(body-indent: first-line-indent * 0.9)
  show list: it => {
    set par(spacing: 2em)
    // set block(inset: (left: first-line-indent, right: first-line-indent))
    it
  }

  set enum(body-indent: first-line-indent * 0.8)
  show enum: it => {
    set par(spacing: 2em)
    // set block(inset: (left: first-line-indent, right: first-line-indent))
    it
  }

  show terms.item: it => {
    set par(first-line-indent: 0em, spacing: spacing)
    let term-text = text.with(size: fontsize * 0.9, weight: "bold")
    if heading-font != none { term-text = term-text.with(font: heading-font) }
    term-text[#it.term]
    block(inset: (left: first-line-indent))[#it.description]
  }

  // Block quotes
  show quote.where(block: true): it => {
    set block(above: spacing * 2, below: spacing * 2)
    set pad(left: 1.5em, right: 1.5em)
    set par(first-line-indent: 0em)
    it
  }

  // Math blocks
  show math.equation.where(block: true): it => {
    set block(above: spacing * 2, below: spacing * 2)
    it
  }

  // References section
  show <refs>: it => {
    set par(hanging-indent: 1em)
    set text(size: 0.9em)
    it
  }

  // --------------------
  // ↑ END CUSTOM STUFF ↑
  // -------------------------------------
  // ---------------------------------------------------------------------------

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }

  // ---------------------------------------------------------------------------
  // -------------------------------------
  // ↓ START MORE CUSTOM STUFF ↓
  // ---------------------------

  // Running header/footer
  // Font settings
  // let hfont = if heading-font != none { heading-font } else { font }
  // let htext(it) = text(size: 0.75em, font: hfont, it)
  let htext(it) = if heading-font != none { 
    text(size: 0.75em, font: heading-font, it) 
  } else { 
    text(size: 0.75em, it) 
  }

  set page(
    numbering: none,

    // Running header on pp. 2–n if `running-header` is true
    // If it's true, use `running-header-content` > `short-title` > `title` as content
    header: if running-header {
      context {
        if counter(page).get().first() > 1 {
          let running = if running-header-content != none { running-header-content }
                        else if short-title != none { short-title }
                        else { title }
          grid(
            columns: (1fr, auto),
            htext(running),
            htext(counter(page).display()),
          )
        }
      }
    },
    footer: if not running-header {
      context {
        if counter(page).get().first() > 1 {
          align(center, htext(counter(page).display()))
        }
      }
    },
  )

  let corr-author = if authors != none and authors != () {
    authors.find(a => a.keys().contains("corresponding") and a.corresponding == true)
  } else { none }

  {
    set par(first-line-indent: 0em)
    set text(font: heading-font) if heading-font != none

    // Top area with date, published, code repo
    if date != none or published != none or code-repo != none {
      v(5.5em)
      block(width: 100%, below: 3em)[
        #set text(size: 0.7em)
        #stack(
          dir: ltr,
          spacing: 1.5em,
          if date != none { text(weight: "bold")[#date] },
          if published != none { published },
        )
        #v(0.3em)
        #if code-repo != none {
          parbreak()
          text(size: 0.92em)[#code-repo]
        }
      ]
    }

    // Title
    if title != none {
      block(width: 100%, above: 4em, below: 0.7em)[
        #set par(leading: 0.55em, first-line-indent: 0em)
        #set text(
          weight: heading-weight,
          size: title-size,
        )
        #title
        #if thanks != none {
          footnote(thanks, numbering: "*")
          counter(footnote).update(n => n - 1)
        }
      ]
    }

    // Subtitle
    if subtitle != none {
      block(width: 100%, above: 1.1em)[
        #set text(
          weight: heading-weight,
          size: subtitle-size,
        )
        #subtitle
      ]
    }

    // Author grid
    if authors != none and authors != () {
      block(width: 100%, below: 2em, above: 4em)[
        #grid(
          // This 1fr thing makes the columns stretch equally to fit the page
          // columns: (1fr,) * calc.min(authors.len(), 3),
          columns: (auto,) * calc.min(authors.len(), 3),
          column-gutter: 2em,
          ..authors.map(a => {
            set text(size: 0.7em)
            set par(justify: false)
            stack(
              dir: ttb,
              spacing: 0.65em,  // Space between name/affiliation/email rows
              // Name + ORCID + corresponding marker
              {
                set text(size: 1.3em, weight: "semibold")
                a.name
                if a.keys().contains("orcid") {
                  h(0.15em)
                  link(
                    "https://orcid.org/" + a.orcid,
                    fa-orcid(fill: rgb("a6ce39"), size: 0.8em),
                  )
                }
                if corr-author != none and corr-author == a {
                  footnote([Corresponding author.], numbering: _ => [†])
                  counter(footnote).update(n => n - 1)
                }
              },
              // Affiliations
              if a.keys().contains("affiliations") {
                stack(
                  dir: ttb,
                  spacing: 0.65em,  // Leading between affiliations
                  ..a.affiliations.map(aff => [#aff]),
                )
              },
              // Email
              if a.keys().contains("email") {
                text(fill: if linkcolor != none { rgb(content-to-string(linkcolor)) })[#a.email]
              },
            )
          }),
        )
      ]
    }

    // Abstract, keywords, additional info
    let label-style(body) = text(weight: "bold", size: 0.82em)[#upper(body)]

    block(width: 100%, inset: (left: 2em, right: 2em), below: 2.5em)[
      #set par(first-line-indent: 0em)
      #set text(size: 0.79em)
      #if abstract != none {
        label-style(if abstract-title != none { abstract-title } else { "Abstract" })
        sym.space.quad
        abstract
      }
      #if keywords != none and keywords != () {
        v(0.5em)
        label-style([Keywords])
        sym.space.quad
        if type(keywords) == array { keywords.join([; ]) } else { keywords }
      }
      #if additional-info != none {
        v(0.5em)
        additional-info
      }
    ]

    counter(footnote).update(0)
  }

  // ---------------------------
  // ↑ END MORE CUSTOM STUFF ↑
  // -------------------------------------
  // ---------------------------------------------------------------------------

  if toc {
    let title = if toc_title == none {
      auto
    } else {
      toc_title
    }
    block(above: 0em, below: 2em)[
    #outline(
      title: toc_title,
      depth: toc_depth,
      indent: toc_indent
    );
    ]
  }

  doc
}

#set table(
  inset: 6pt,
  stroke: none
)


// -----------------------------------------------------------------------------
// -----------------------------------------------------
// ↓ HEY LOOK IT'S MORE CUSTOM STUFF ↓
// -------------------------------------

// This stuff has to go outside of article()

// Restyle Quarto callout boxes since they're a little too spacy
#let callout(body: [], title: "Callout", background_color: rgb("#dddddd"), icon: none, icon_color: black, body_background_color: white) = {
  // Gotta style the title and content separately here so that the icons don't
  // get assigned the custom font
  let styled-title = context if callout-font.get() != none {
    text(font: callout-font.get(), icon_color, weight: "bold")[#title]
  } else {
    text(icon_color, weight: "bold")[#title]
  }
  let styled-body = context if callout-font.get() != none {
    text(font: callout-font.get())[#body]
  } else {
    body
  }

  [
    #v(0.65em)
    #block(
      stroke: (left: 5pt + icon_color, top: 1pt + icon_color, right: 1pt + icon_color, bottom: 1pt + icon_color),
      // radius: 2pt,
      width: 100%,
      [
        #set text(size: 0.8em)
        #set par(leading: 0.65em, first-line-indent: 0em)
        #block(fill: background_color, inset: 0.5em, width: 100%, below: 0pt, sticky: true,
          text(icon_color, weight: "bold")[#icon ] + styled-title
        )
        #block(fill: body_background_color, inset: 0.5em, width: 100%, styled-body)
      ]
    )
    #v(0.65em)
  ]
}
