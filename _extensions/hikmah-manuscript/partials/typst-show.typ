#show: doc => article(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(short-title)$
  short-title: [$short-title$],
$endif$
$if(by-author)$
  authors: (
$for(by-author)$
$if(it.name.literal)$
    (
      name: [$it.name.literal$],
$if(it.email)$
      email: "$it.email$",
$endif$
$if(it.orcid)$
      orcid: "$it.orcid$",
$endif$
$if(it.attributes.corresponding)$
      corresponding: true,
$endif$
      affiliations: ($for(it.affiliations)$(name: "$it.name$", full: "$if(it.department)$$it.department$, $endif$$it.name$$if(it.address)$, $it.address$$endif$$if(it.city)$, $it.city$$endif$$if(it.region)$, $it.region$$endif$$if(it.postal-code)$ $it.postal-code$$endif$$if(it.country)$, $it.country$$endif$"),$endfor$),
    ),
$endif$
$endfor$
  ),
$endif$
$if(abstract)$
  abstract: [$abstract$],
  abstract-title: "$labels.abstract$",
$endif$
$if(keywords)$
  keywords: ($for(keywords)$"$keywords$",$endfor$),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(thanks)$
  thanks: [$thanks$],
$endif$
$if(additional-info)$
  additional-info: [$additional-info$],
$endif$
$if(published)$
  published: [$published$],
$endif$
$if(correspondence-prefix)$
  correspondence-prefix: [$correspondence-prefix$],
$endif$
$if(code-repo)$
  code-repo: [$code-repo$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(mathfont)$
  mathfont: ($for(mathfont)$"$mathfont$",$endfor$),
$endif$
$if(codefont)$
  codefont: ($for(codefont)$"$codefont$",$endfor$),
$endif$
$if(linkcolor)$
  linkcolor: [$linkcolor$],
$endif$
$if(citecolor)$
  citecolor: [$citecolor$],
$endif$
$if(filecolor)$
  filecolor: [$filecolor$],
$endif$
$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc-title: [$toc-title$],
$endif$
$if(toc-depth)$
  toc-depth: $toc-depth$,
$endif$
$if(toc-indent)$
  toc-indent: $toc-indent$,
$endif$
  doc,
)
