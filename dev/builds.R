#+TITLE: Building snippets

* Documentation and namespace

#+begin_src R

# package building scripts
	setwd(file.path(Sys.getenv("WorkSpace"),"2021-04-08_grabber/grabber"))
	
	devtools::document()

	# 1. render vignettes
		# replace '' and –

		# a. manually render for testing and development (faster)
##		rmarkdown::render("vignettes/handout.Rmd")

		# run all the tests!

		# b. use tools to 
		# vignette render for the archive (produces the .R file too, and index entries!)
##		tools::buildVignettes(dir = '.', tangle=TRUE)

	# 2. run ghostscript compaction for the handout
##		tools::compactPDF(paths="vignettes/handout.pdf", gs_quality = "ebook")

	# 3. copy the outputs of this to inst/doc (otherwise the windows binaries won't have the vignettes) 
#+end_src

* Package building

** Regular install:

#+begin_src shell
cd $WorkSpace/2021-04-08_grabber

sudo env "PATH=$PATH" R CMD INSTALL --clean grabber
#+end_src


** Source tarballs

Regular, without redoing the vignettes (faster - produces vignetteindexentry note/warning)

#+begin_src shell
cd $WorkSpace/2021-04-08_grabber
sudo R CMD build --resave-data --no-build-vignettes grabber
#+end_src


With redoing the vignettes (adds VignetteIndexEntries required for CRAN submission)

#+begin_src shell
sudo env "PATH=$PATH" R CMD build --resave-data --compact-vignettes="gs" grabber 
#+end_src

** Binaries

* CRAN checks

** Stable --as-cran
As cran checks.

#+begin_src shell
sudo env "PATH=$PATH" R CMD check --as-cran grabber_0.0.1.tar.gz 
#+end_src

** R-devel
#+begin_src shell
# after this, download R-devel, set the path variable and rerun 

cp $WorkSpace/2017-04-05_divDyn/divDyn_0.8.1.tar.gz ~/Desktop
sudo env "PATH=$PATH" R CMD check --as-cran divDyn_0.8.1.tar.gz --run-donttest
   
#+end_src

