<!-- README.md is generated from README.Rmd. Please edit that file -->
erosivity
=========

[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/kvantas/erosivity?branch=master&svg=true)](https://ci.appveyor.com/project/kvantas/erosivity) [![Travis-CI Build Status](https://travis-ci.org/kvantas/erosivity.svg?branch=master)](https://travis-ci.org/kvantas/erosivity) [![codecov](https://codecov.io/github/kvantas/erosivity/branch/master/graphs/badge.svg)](https://codecov.io/gh/kvantas/erosivity) [![minimal R version](https://img.shields.io/badge/R%3E%3D-3.4.0-6666ff.svg)](https://cran.r-project.org/) [![packageversion](https://img.shields.io/badge/Package%20version-0.0.9000-orange.svg?style=flat-square)](https://github.com/kvantas/erosivity)

The goal of `erosivity` is to compute the rainfall erosivity using precipitation data.

Installation
------------

You can install the development version from GitHub with:

``` r
# install.packages("devtools")
devtools::install_github("kvantas/erosivity")
```

Erosivity calculation
---------------------

The R coefficient (MJ.mm/ha/h/yr) is defined as the long-term average of the product of the kinetic energy of a storm and the maximum 30 min intensity (Renard et. al, 1987):

$R = \\frac{1}{n} \\sum\_{j=1}^{n} \\sum\_{k=1}^{m\_j} (EI\_{30})\_{k}$

where *n* is the number of years with rainfall records, *m*<sub>*j*</sub> the number of storms during year *j* and *E**I*<sub>30</sub> the erosivity of storm *k*. The erosivity *E**I*<sub>30</sub> (MJ.mm/ha/h) is equal to:

$EI\_{30} = \\left( \\sum\_{r=1}^{m} e\_r \\cdot v\_{r} \\right) \\cdot I\_{30}$

where *e*<sub>*r*</sub> is the energy of rainfall (MJ/ha/mm), *v*<sub>*r*</sub> the rainfall depth (mm) for the time interval *r* of the hyetograph, which has been divided into *r* = 1, 2, ..., *m* sub-intervals, such that each one of these is characterized by constant rainfall intensity and *I*<sub>30</sub> is the maximum rainfall intensity for a 30 minutes duration. The quantity *e*<sub>*r*</sub> is calculated for *r* from the relation:

*e*<sub>*r*</sub> = 0.29(1−0.72*e*<sup>−0.05 ⋅ *i*<sub>*r*</sub></sup>)

where *i*<sub>*r*</sub> is the rainfall intensity (mm/h). The rules that apply in order to single out the storms causing erosion and to divide rainfalls of large duration are:

1.  A rainfall event is divided into two parts, if its cumulative depth for duration of 6 hours at a certain location is less than 1.3 mm.
2.  A rainfall is considered erosive:

-   if it has a cumulative value greater than 12.7 mm or
-   during a time period of 15 mins a cumulative value of at least 6.4 mm is recorded.

Using erosivity
---------------

Example
-------

Meta
----

-   Please report any [issues or bugs](https://github.com/kvantas/hydroscoper/issues).

-   Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.

References
----------

1.  Renard, K. G., Foster, G. R., Weesies, G. A. and Porter, J. P. (1991), ‘RUSLE: Revised Universal Soil Loss Equation’, *Journal of Soil and Water Conservation* **46**(1), 30–33.
