setmfopt <- function(...) {

   mstyle <- .get.mstyle("crayon" %in% .packages())

   mfopts <- getOption("metafor")

   if (is.null(mfopts) || !is.list(mfopts)) {
      options("metafor" = list(space=TRUE))
      mfopts <- getOption("metafor")
   }

   newopts <- list(...)

   for (opt in names(newopts)) {
      if (opt == "space" && !is.logical(newopts[[opt]]))
         stop(mstyle$stop("'space' must be a logical."))
      if (opt == "digits" && !is.null(newopts[[opt]]) && !is.vector(newopts[[opt]], mode="numeric"))
         stop(mstyle$stop("'digits' must be a numeric vector."))
      if (opt == "style" && !is.null(newopts[[opt]]) && !is.list(newopts[[opt]]))
         stop(mstyle$stop("'style' must be a list."))
      if (opt == "theme" && !is.null(newopts[[opt]]) && !is.element(newopts[[opt]], c("default", "light", "dark", "auto", "default2", "light2", "dark2", "auto2")))
         stop(mstyle$stop("'theme' must be either 'default(2)', 'light(2)', 'dark(2)', or 'auto(2)'."))
      mfopts[[opt]] <- newopts[[opt]]
   }

   options("metafor" = mfopts)

}

getmfopt <- function(x, default=NULL) {

   opt <- getOption("metafor")

   if (!missing(x)) {
      x <- as.character(substitute(x))
      opt <- opt[[x]]
   }

   if (is.null(opt)) {
      return(default)
   } else {
      return(opt)
   }

}
