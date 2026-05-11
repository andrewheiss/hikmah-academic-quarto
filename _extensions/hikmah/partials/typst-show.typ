#show: doc => article(
$if(title)$
  title: [$title$],
// ↓ New stuff
$if(title-size)$
  title-size: $title-size$,
$endif$
// ↑ New stuff
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
// ↓ New stuff
$if(subtitle-size)$
  subtitle-size: $subtitle-size$,
$endif$
// ↑ New stuff
$endif$
$if(short-title)$
  short-title: [$short-title$],
$endif$
$if(published)$
  published: [$published$],
$endif$
$if(code-repo)$
  code-repo: [$code-repo$],
$endif$
$if(correspondence-prefix)$
  correspondence-prefix: [$correspondence-prefix$],
$endif$
$if(by-author)$
  authors: (
$for(by-author)$
    (
      name: [$it.name.literal$],
$if(it.orcid)$
      orcid: "$it.orcid$",
$endif$
$if(it.email)$
      email: [$it.email$],
$endif$
$if(it.attributes.corresponding)$
      corresponding: $it.attributes.corresponding$,
$endif$
      affiliations: (
$for(it.affiliations)$
        "$it.name$, $it.department$",
$endfor$
      ),
    ),
$endfor$
  ),
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(lang)$
  lang: "$lang$",
$endif$
$if(region)$
  region: "$region$",
$endif$
$if(abstract)$
  abstract: [$abstract$],
$if(hide-abstract-title)$
$else$
  abstract-title: "$labels.abstract$",
$endif$
$endif$
$if(mainfont)$
  font: ("$mainfont$",),
$elseif(brand.typography.base.family)$
  font: $brand.typography.base.family$,
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$elseif(brand.typography.base.size)$
  fontsize: $brand.typography.base.size$,
$endif$
$if(title)$
// ↓ New stuff
$if(heading-family)$
  heading-family: ("$heading-family$",),
$elseif(brand.typography.headings.family)$
  heading-family: $brand.typography.headings.family$,
$elseif(mainfont)$
  heading-family: ("$mainfont$",),
$endif$
// ↑ New stuff
$if(brand.typography.headings.weight)$
  heading-weight: $brand.typography.headings.weight$,
$endif$
$if(brand.typography.headings.style)$
  heading-style: "$brand.typography.headings.style$",
$endif$
$if(brand.typography.headings.color)$
  heading-color: $brand.typography.headings.color$,
$endif$
$if(brand.typography.headings.line-height)$
  heading-line-height: $brand.typography.headings.line-height$,
$endif$
$endif$
$if(section-numbering)$
  sectionnumbering: "$section-numbering$",
$endif$
$if(mathfont)$
  mathfont: ($for(mathfont)$"$mathfont$",$endfor$),
$endif$
$if(codefont)$
  codefont: ($for(codefont)$"$codefont$",$endfor$),
$elseif(brand.typography.monospace.family)$
  codefont: $brand.typography.monospace.family$,
$endif$
$if(linestretch)$
  linestretch: $linestretch$,
$endif$
$if(thanks)$
  thanks: [$thanks$],
$endif$
$if(additional-info)$
  additional-info: [$additional-info$],
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
$if(keywords)$
  keywords: ($for(keywords)$"$keywords$",$endfor$),
$endif$
  running-header: $if(running-header)$true$else$false$endif$,
$if(running-header-content)$
  running-header-content: [$running-header-content$],
$endif$
$if(toc)$
  toc: $toc$,
$endif$
$if(toc-title)$
  toc_title: [$toc-title$],
$endif$
$if(toc-indent)$
  toc_indent: $toc-indent$,
$endif$
$if(toc-depth)$
  toc_depth: $toc-depth$,
$endif$
  doc,
)
