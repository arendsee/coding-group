# Problem 2

In this problem I will deviate a bit from my original goal and just focus on
developing on skill, R package development. R is a great language for data
analysis and allows cleaner, more reliable, than is possible through pure
shellscripting.

I have a made an R toy package, `toyr`. It contains a single function,
`read_gff`, for reading a GFF file. You can install it with devtools:

```R
R> install_github("arendsee/toyr")
R> library(toyr)
R> read_gff("unicorn.gff")
```

This function will read local files as well as URLs. It will also automatically
extract data from zipped files. (Thanks to Hadley's `readr` package).

Of course, you can also clone or fork the repository, which is where Problem
2 starts. In this problem, we won't need to post any code here in the
`coding-group` repo, rather you can fork the `toyr` repo.

Here it what you can you for this problem:

 1. Look over the git commit messages on the `arendsee/toyr` repo. Note these
    messages are not just one line. Git/github allow long descriptions of the
    commit to follow the required commit title. These messages can serve as
    a lab notebook, or journal, where you describe the reasoning behind the
    changes you have made or outline your plans for the future. In the case of
    `toyr`, I have a description of what I have done so far on the package and
    how I did it.

 2. Fork the `toyr` repository. You can make all changes on your own fork, then
    make a pull request, and I can merge your changes into the main repo. This
    is the usual method for open source contributions, so is a workflow worth
    practicing.

 3. Look over the DESCRIPTION file, there are several stub values left in it
    (temporary values created by devtools). If you want to see what
    a DESCRIPTION file looks like for a larger R package, you can checkout
    `arendsee/synder`.

 4. Add Doxygen documentation to the `read_gff` function. Devtools can use this
    documentation to generate help documents (e.g. lets users see docs with the
    `?read_gff` command). For information on this, see Hadley's "R Packages"
    online book, under the documentation section.

 5. Add package level documentation, which will let the user type `?rtoy`.
    Don't worry about what you write there (this is just a toy repo). Note,
    devtools has a function that builds a template for you:
    `devtools::use_package_doc`.

 6. Make a simple vignette (doesn't matter what you write in it).
    `devtools::use_vignette` will build a template for you. Vignettes are most
    easily written in RMarkdown, which is a flavor of Markdown that allows
    figures and R code to be cleanly interwoven. If you don't know Markdown,
    take some time to figure it out.

 7. Add a `validate_gff` exported function that returns TRUE if the GFF start
    and stop fields make sense (e.g. start <= stop, start >= 0).  You do not
    have to check whether the GFF has the appropriate columns and column types,
    this is handled by `read_gff`.

 8. Add a test (use `devtools::use_testthat` to make a template). Test whether
    `read_gff` raises an error when an invalid file is passed to it.


We'll develop the package a bit more in the future, but this is fine for now.
Remember to commit frequently as your work and write good commit messages.
