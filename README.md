<!-- README.md is generated from README.Rmd. Please edit that file -->

# erosivity

[![AppVeyor Build
Status](https://ci.appveyor.com/api/projects/status/github/kvantas/erosivity?branch=master&svg=true)](https://ci.appveyor.com/project/kvantas/erosivity)
[![Travis-CI Build
Status](https://travis-ci.org/kvantas/erosivity.svg?branch=master)](https://travis-ci.org/kvantas/erosivity)
[![codecov](https://codecov.io/github/kvantas/erosivity/branch/master/graphs/badge.svg)](https://codecov.io/gh/kvantas/erosivity)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![DOI](https://zenodo.org/badge/118612265.svg)](https://zenodo.org/badge/latestdoi/118612265)

`erosivity` (Vantas 2018) is an R package (R Core Team 2016) that can be
used to compute the rainfall erosivity, \(EI\), from the Universal Soil
Loss Equation (Kenneth G Renard et al. 1991).

## Universal Soil Loss Equation (USLE)

From Ministry of Agriculture and Rural Afairs (2018):

The USLE predicts the long-term average annual rate of erosion on a
field slope based on rainfall pattern, soil type, topography, crop
system and management practices. USLE only predicts the amount of soil
loss that results from sheet or rill erosion on a single slope and does
not account for additional soil losses that might occur from gully, wind
or tillage erosion. This erosion model was created for use in selected
cropping and management systems, but is also applicable to
non-agricultural conditions such as construction sites. The USLE can be
used to compare soil losses from a particular field with a specific crop
and management system to “tolerable soil loss” rates. Alternative
management and crop systems may also be evaluated to determine the
adequacy of conservation measures in farm planning.

Five major factors are used to calculate the soil loss for a given site.
Each factor is the numerical estimate of a specific condition that
affects the severity of soil erosion at a particular location. The
erosion values reflected by these factors can vary considerably due to
varying weather conditions. Therefore, the values obtained from the USLE
more accurately represent long-term averages.

\[A = R \cdot K \cdot LS \cdot C \cdot P\] Where:

1.  \(A\) represents the potential long-term average annual soil loss
    \(\frac{t}{ha}\).
2.  \(R\) is the rainfall and runoff factor
    \(\frac{MJ \cdot mm}{ha \cdot h \cdot yr})\)
3.  \(K\) is the soil erodibility factor for a particular soil
    ((\({t \cdot ha \cdot h} \over {ha \cdot MJ \cdot mm}\)))
4.  \(LS\) is the slope length-gradient factor.
5.  \(C\) is the crop/vegetation and management factor.
6.  \(P\) is the support practice factor.

USLE and its later improvements are empirical models which in order to
be applied to different places around the world, require the
determination of the appropriate values of the above six different
factors. Although land data, terrain and land uses may be used to
calculate the values of \(K\), \(C\), \(L\) and \(S\), long-term
rainfall intensity data are required for the estimation of \(R\) and
\(P\) (Kenneth G. Renard and Freimund 1994).

## Installation

You can install the development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("kvantas/erosivity")
```

## Using erosivity

## Example

## Meta

  - Please report any [issues or
    bugs](https://github.com/kvantas/erosivity/issues).

  - Please note that this project is released with a [Contributor Code
    of Conduct](CONDUCT.md). By participating in this project you agree
    to abide by its terms.

## References

<div id="refs" class="references">

<div id="ref-USLE">

Ministry of Agriculture, Food, and Ontario Rural Afairs. 2018.
“Universal Soil Loss Equation (Usle).”
<http://www.omafra.gov.on.ca/english/engineer/facts/12-051.htm>.

</div>

<div id="ref-CRAN">

R Core Team. 2016. *R: A Language and Environment for Statistical
Computing*. Vienna, Austria: R Foundation for Statistical Computing.

</div>

<div id="ref-renard1991rusle">

Renard, Kenneth G, George R Foster, Glenn A Weesies, and Jeffrey P
Porter. 1991. “RUSLE: Revised Universal Soil Loss Equation.” *Journal of
Soil and Water Conservation* 46 (1). Soil; Water Conservation
Society:30–33.

</div>

<div id="ref-Renard1994">

Renard, Kenneth G., and Jeremy R. Freimund. 1994. “Using Monthly
Precipitation Data to Estimate the R-Factor in the Revised USLE.”
*Journal of Hydrology* 157:287–306.

</div>

<div id="ref-vantas2018">

Vantas, Konstantinos. 2018. *Erosivity: Calculation of the Rainfall
Erosivity EI from RUSLE*. <https://doi.org/10.5281/zenodo.1185379>.

</div>

</div>
