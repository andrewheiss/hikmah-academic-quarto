#let horizontalrule = [
  #show line: set block(spacing: 3em)
  #line(
    start: (25%,0%), 
    end: (75%,0%), 
    stroke: (paint: black, thickness: 0.5pt)
  )
]

#set par(
  first-line-indent: 1em,
  justify: true,
  spacing: 0.65em
)

#show heading: set block(above: 2em, below: 1em)

#show heading.where(
  level: 1
): it => block(width: 100%)[
  /* Setting the heading size to 1em doesn't make it match the body font because 
     it stacks on top of the default body size. By default, heading 1 is 1.4em, 
     heading 2 is 1.2 em, and heading 3 is 1em; to get them to the same size as 
     the body font, they'd need to be set to 0.7em (H1) and 0.8em (H2) 
     
     See https://github.com/typst/typst/discussions/2919 */
  #set text(0.8em, weight: "bold")
  #it.body
]

#show heading.where(
  level: 2
): it => block(width: 100%)[
  #set text(0.8em, weight: "bold")
  #it.body
]
