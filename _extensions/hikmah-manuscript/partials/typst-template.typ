// Font Awesome for ORCID icon
#import "@preview/fontawesome:0.5.0": fa-orcid

// Some variables
#let double-spacing = 2em
#let first-indent = 0.5in
#let default-typst-font = "Libertinus Serif"

// Collect unique affiliations; return (unique-list, per-author index lists)
#let process-affiliations(authors) = {
  let unique = ()
  let per-author = ()
  for author in authors {
    let affs = author.at("affiliations", default: ())
    let nums = ()
    for aff in affs {
      let idx = unique.position(u => u.at("full", default: "") == aff.at("full", default: ""))
      if idx == none {
        unique.push(aff)
        nums.push(unique.len())
      } else {
        nums.push(idx + 1)
      }
    }
    per-author.push(nums)
  }
  (unique, per-author)
}

// Format author names with superscript affiliation numbers
#let format-author-line(authors, aff-nums, show-superscripts) = {
  let parts = authors.enumerate().map(((i, author)) => {
    let name = author.name
    let nums = aff-nums.at(i)
    if show-superscripts and nums.len() > 0 {
      [#name#super(nums.map(str).join(","))]
    } else {
      name
    }
  })
  if parts.len() == 1 {
    parts.at(0)
  } else if parts.len() == 2 {
    parts.join([ and ])
  } else {
    parts.slice(0, -1).join([, ]) + [, and ] + parts.last()
  }
}

// Build the author note for the title page. Follows this structure:
// 
// Author name [icon] https://orcid.org/...
// additional-info
// thanks
// code-repo
// correspondence paragraph

#let build-author-note(authors, thanks, additional-info, correspondence-prefix, code-repo) = {
  let parts = ()

  // Author name [icon] https://orcid.org/...
  for author in authors {
    let orcid = author.at("orcid", default: none)
    if orcid != none and orcid != "" {
      let url = "https://orcid.org/" + orcid
      let icon = fa-orcid(fill: rgb("#a6ce39"), size: 0.8em)
      parts.push([#author.name #link(url, icon) #link(url)[#url]])
    }
  }

  // Miscellaneous things
  if additional-info != none { parts.push(additional-info) }
  if thanks != none { parts.push(thanks) }
  if code-repo != none { parts.push(code-repo) }

  // Correspondence line: "prefix Name (email), affiliation string"
  if correspondence-prefix != none {
    for author in authors {
      if author.at("corresponding", default: false) {
        let email = author.at("email", default: none)
        let email-part = if email != none {
          [ (#link("mailto:" + email)[#email])]
        } else { [] }
        let aff-part = if "affiliations" in author and author.affiliations.len() > 0 {
          [, ] + author.affiliations.at(0).at("full")
        } else { [] }
        parts.push([#correspondence-prefix #author.name#email-part#aff-part])
      }
    }
  }

  if parts.len() == 0 { return none }
  parts.join(parbreak())
}

// Restyle Quarto callout boxes since they're a little too spacy, especially
// with APA double spacing. Here they're single spaced with no first-line indent
#let callout(
  body: [],
  title: "Callout",
  background_color: rgb("#dddddd"),
  icon: none,
  icon_color: black,
  body_background_color: white,
) = {
  block(
    breakable: false,
    fill: background_color,
    stroke: (paint: icon_color, thickness: 0.5pt, cap: "round"),
    width: 100%,
    radius: 2pt,
    block(
      inset: 1pt,
      width: 100%,
      below: 0pt,
      block(
        fill: background_color,
        width: 100%,
        inset: 8pt,
      )[#if icon != none [#text(icon_color, weight: 900)[#icon] ]#title]
    ) +
    if body != [] {
      block(
        inset: 1pt,
        width: 100%,
        block(fill: body_background_color, width: 100%, inset: 8pt, {
          set par(leading: 0.65em, spacing: 0.65em, first-line-indent: 0in)
          body
        }),
      )
    },
  )
}

// Actual article definition
#let article(
  title: none,
  subtitle: none,
  short-title: none,
  authors: (),
  abstract: none,
  abstract-title: none,
  keywords: (),
  date: none,
  thanks: none,
  additional-info: none,
  published: none,
  correspondence-prefix: none,
  code-repo: none,
  lang: "en",
  region: "US",
  font: none,
  fontsize: 12pt,
  mathfont: none,
  codefont: none,
  sectionnumbering: none,
  linkcolor: none,
  citecolor: none,
  filecolor: none,
  toc: false,
  toc-title: none,
  toc-depth: none,
  toc-indent: 0.5in,
  doc,
) = {

  // Default Quarto things
  //
  // Set document metadata for PDF accessibility
  set document(title: title, keywords: keywords)
  set document(
    author: authors.map(author => content-to-string(author.name)).join(", ", last: " & "),
  ) if authors != none and authors != ()

  set text(lang: lang,
           region: region,
           size: fontsize)
  set text(font: font) if font != none
  show math.equation: set text(font: mathfont) if mathfont != none
  show raw: set text(font: codefont) if codefont != none

  set heading(numbering: sectionnumbering)

  show link: set text(fill: rgb(content-to-string(linkcolor))) if linkcolor != none
  show ref: set text(fill: rgb(content-to-string(citecolor))) if citecolor != none
  show link: this => {
    if filecolor != none and type(this.dest) == label {
      text(this, fill: rgb(content-to-string(filecolor)))
    } else {
      text(this)
    }
   }
  
  // End default Quarto things

  // ---------------------------------------------------------------------------
  // General page settings
  // ---------------------------------------------------------------------------
  // Title page has no PDF page label (numbering: none) so that the abstract
  // page is page 1 (so that I can manually remove the title page from the
  // manuscript PDF for anonymized submission) 
  //
  // I use 
  //
  //   is-past-title.update(true) + counter(page).update(0) + set page(numbering: "1")
  //
  // after the title page pagebreak to make that happen
  
  // Running header content logic
  let rh-text = if short-title != none {
    upper(content-to-string(short-title))
  } else if title != none {
    upper(content-to-string(title))
  } else { "" }

  // Binary flag indicating that we're done with the title page; necessary to
  // get the custom PDF metadata pagination right
  let is-past-title = state("is-past-title", false)

  set page(
    paper: "us-letter",
    // Scootch the running header up a tiny bit because Typst is referencing the
    // baseline or something and the text isn't quite centered in the margin
    margin: (top: 1in + 10pt, rest: 1in),
    header-ascent: 30% + 10pt,
    numbering: none,
    footer: [],
    header: context {
      set text(size: fontsize)
      if not is-past-title.get() {
        // Title page has running header only, no page number
        align(left, rh-text)
      } else {
        // All other pages have running header + page number at bottom
        grid(columns: (1fr, auto), align: (left + horizon, right + horizon),
          rh-text, counter(page).display("1"))
      }
    },
  )

  // ---------------------------------------------------------------------------
  // Custom APA-esque styles
  // ---------------------------------------------------------------------------

  // Double space, indent, and don't justify all the text
  set par(
    leading: double-spacing,
    spacing: double-spacing,
    justify: false,
    first-line-indent: (amount: first-indent, all: true),
  )

  // Headings
  // Explicitly set font to stop _brand.yml fonts from sneaking in
  show heading: set text(
    font: if font != none { font } else { default-typst-font },
    // font: if font != none { font } else { () },
    size: fontsize
  )

  show heading: set block(above: double-spacing, below: double-spacing, sticky: true)

  // H1: centered, bold
  show heading.where(level: 1): it => {
    set par(leading: 0.65em)
    set align(center)
    set text(weight: "bold")
    it
  }

  // H2: left, bold
  show heading.where(level: 2): it => {
    set par(leading: 0.65em)
    set align(left)
    set text(weight: "bold")
    it
  }

  // H3: left, bold italic
  show heading.where(level: 3): it => {
    set par(leading: 0.65em)
    set align(left)
    set text(style: "italic", weight: "bold")
    it
  }

  // H4: inline, bold
  show heading.where(level: 4): it => {
    strong(it.body) + [. ]
  }

  // H5: inline, bold italic
  show heading.where(level: 5): it => {
    strong(emph(it.body)) + [. ]
  }

  // Tables: top border, rule below header, bottom border, no vertical borders
  set table(
    inset: 6pt,
    stroke: (x, y) => if y == 0 {
      (top: 1pt + black, bottom: 0.5pt + black)
    } else { none },
  )
  show table.cell.where(y: 0): set text(weight: "bold")
  // Add border to the block so it stays table-width, not page-width
  show table: it => block(
    stroke: (bottom: 1pt + black),
    breakable: true,
    it,
  )

  // Caption stuff
  set figure.caption(separator: [: ])
  show figure.caption: set par(first-line-indent: 0in)
  // "Figure 1: caption text"
  show figure.caption: it => block(width: 100%, {
    set align(center)
    it.supplement + [ ] + context it.counter.display(it.numbering) + it.separator + it.body
  })

  // Blockquotes
  show quote.where(block: true): it => block(
    inset: (left: first-indent),
    par(first-line-indent: 0in, it.body),
  )

  // Bibliography
  // Native Typst with no citeproc
  show bibliography: it => {
    pagebreak()
    set bibliography(style: "apa")
    set par(first-line-indent: 0in, hanging-indent: first-indent)
    it
  }

  // With citeproc
  show <refs>: it => {
    set par(hanging-indent: first-indent, first-line-indent: 0in)
    it
  }

  // Math
  set math.equation(numbering: equation-numbering)

  // ---------------------------------------------------------------------------
  // Build title page
  // ---------------------------------------------------------------------------
  {
    set par(first-line-indent: 0in, spacing: double-spacing, leading: double-spacing)

    v(double-spacing * 3)

    // Single space the title bc it looks nincer
    align(center, {
      set par(leading: 0.65em)
      strong(title)
      if subtitle != none {
        linebreak()
        subtitle
      }
    })

    v(double-spacing)

    let (unique-affs, aff-nums) = process-affiliations(authors)
    let show-super = unique-affs.len() > 1

    align(center, format-author-line(authors, aff-nums, show-super))

    parbreak()

    if unique-affs.len() > 0 {
      align(center, {
        set par(leading: 0.65em, spacing: 0.65em)
        if show-super {
          unique-affs.enumerate().map(((i, aff)) =>
            [#super(str(i + 1)) #aff.at("name")]
          ).join(parbreak())
        } else {
          unique-affs.map(aff => aff.at("name")).join(parbreak())
        }
      })
    }

    if published != none {
      v(12pt * 3)
      parbreak()
      align(center, published)
    }

    let author-note = build-author-note(
      authors, thanks, additional-info, correspondence-prefix, code-repo,
    )
    if author-note != none {
      v(1fr)
      align(center, strong[Author Note])
      parbreak()
      {
        set par(first-line-indent: (amount: first-indent, all: true))
        author-note
      }
    }
  }

  // We're done with the title page, so mark is-past-title true to reset page
  // counter so that the abstract page = internal page 1
  is-past-title.update(true)
  counter(page).update(0)
  set page(numbering: "1")

  pagebreak()

  // ---------------------------------------------------------------------------
  // Build abstract page
  // ---------------------------------------------------------------------------
  if abstract != none {
    {
      set par(first-line-indent: 0in)
      heading(level: 1, outlined: false, abstract-title)
      // I ordinarily indent both sides of my manuscript abstracts, even though
      // that's technically wrong for APA, so set the inset to 0 here if you
      // super care
      // block(inset: (left: 0, right: 0), {
      block(inset: (left: first-indent, right: first-indent), {
        abstract
        if keywords != () and keywords.len() > 0 {
          v(double-spacing)
          emph[Keywords:] + [ ] + keywords.map(k => [#k]).join([, ])
        }
      })
    }
    pagebreak()
  }

  // ---------------------------------------------------------------------------
  // TOC on its own page if it exists
  // ---------------------------------------------------------------------------
  if toc {
    outline(
      title: toc-title,
      depth: toc-depth,
      indent: toc-indent,
    )
    pagebreak()
  }

  // ---------------------------------------------------------------------------
  // And finally, the document
  // ---------------------------------------------------------------------------
  // Place the title first, styled like H1 (bold centered)
  if title != none {
    heading(level: 1, outlined: false, title)
  }
  doc
}
