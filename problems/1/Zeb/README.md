# Problem 1

I would probably use a solution similar to Jing's for this problem. However, as
the project grows, from one file to many, and from one file type (GFF) to
several types, and as the requirements of validating them grows, a shell script
can soon become insufficient.

I've seen this same trend over and over again in my work. Where the analysis
starts with a few shell scripts. These are very easy to write. I spend hours
every day typing commands into a Bash terminal, so Bash is the most natural
language to use. But as they grow, they become very difficult to maintain.

I hack together code like:

``` Bash
# This is a particularly ugly excerpt from Fagin
$parse_script --select=CDS --reduce=Parent $input_gff |
    sort -k9 -k4n |
    awk '
        BEGIN{FS="\t";OFS="\t"}
        {$3 = $9" "$7; print}
    ' |
    bedtools getfasta   \
        -fi $input_fna  \
        -bed /dev/stdin \
        -fo /dev/stdout \
        -name |
    sed 's/::.*//' |
    awk '$1 ~ /^>/ && $1 in seqids { next }; {seqids[$1]++; print}' > $x
cat <($smof grep ' +' $x) \
    <($smof grep ' -' $x | $smof reverse -cV | sed 's/|.*//' ) |
    transeq -filter |
    $smof clean -sux |
    perl -pe 's/_\d+$//' > $output_faa
rm $x
```

It is so easy to write, since I know AWK and sed so well, but it is fragile.
There are a lot of things wrong with this:

  1. I deal with column numbers (e.g. `sort -k9 -k4n`) rather than column names.
     This reduces readability and makes the program sensitive to the order of
     columns or column insertions.

  2. I solve problems through regular expressions, but the reason for the
     expression is not usually clear. (I have no idea why I have to remove the
     `::.*` pattern)

  3. I glue together pieces from lots of languages or stand alone programs. This
     results in three problems:

     - Reading the code requires knowing all of these languages (above I use the
       languags `sed`, `AWK`, `Bash` and `perl`, as well as several standalone
       programs).

     - All of these have to be installed, in the correct version. This
       necessitates lots of dependency management.

     - Passing data between languages is often awkward.

  4. There is no error reporting, especially for steps inside the pipeline.

  5. If one step in the pipeline fails, the error may not appear until much
     later. Making debugging hard.

Now, some of these problems could be fixed with better shellscripting. But
a cleaner approach is to just leave shell scripting altogether. I think
scientific analysis code should be held to the same standard as software. With
unit testing, dependency management, and all that.

I think one solution is to replace shell scripts more formal code in a single
language. Given we do so much work with tables of data, R is a good solution.
R scripts can be a bit more verbose than Bash scripts, but they scale better.
