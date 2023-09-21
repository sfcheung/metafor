### library(metafor); library(testthat); Sys.setenv(NOT_CRAN="true")

### see also: https://www.metafor-project.org/doku.php/plots:meta_analytic_scatterplot

source("settings.r")

context("Checking plots example: meta-analytic scatterplot")

test_that("plot can be drawn.", {

   expect_equivalent(TRUE, TRUE) # avoid 'Empty test' message

   skip_on_cran()

   png("test_plots_meta_analytic_scatterplot.png", res=200, width=1800, height=1500, type="cairo")

   ### adjust margins so the space is better used
   par(mar=c(5,5,1,2))

   ### calculate log risk ratios and corresponding sampling variances
   dat <- escalc(measure="RR", ai=tpos, bi=tneg, ci=cpos, di=cneg, data=dat.bcg)

   ### fit mixed-effects model with absolute latitude as predictor
   res <- rma(yi, vi, mods = ~ ablat, data=dat)

   ### draw plot
   regplot(res, xlim=c(10,60), predlim=c(10,60), xlab="Absolute Latitude", refline=0,
           atransf=exp, at=log(seq(0.2,1.6,by=0.2)), digits=1, las=1, bty="l",
           label=c(4,7,12,13), offset=c(1.6,0.8), labsize=0.9)

   dev.off()

   expect_true(.vistest("test_plots_meta_analytic_scatterplot.png", "images/test_plots_meta_analytic_scatterplot.png"))

})

rm(list=ls())
