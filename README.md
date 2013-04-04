SQLShare API for R
===================
This provides a minimal API for accessing [SQLShare](http://escience.washington.edu/sqlshare) in the [R programming language](http://r-project.org). Here's the syntax for
obtaining a data.frame from a table:

    sql <- "select * from [sqlshare@uw.edu].[periodic_table]"
    elements <- fetch.data.frame(sql)

That's it! It loads a config file for authentication from:

    ~/.sqlshare/config

The format of the file should look like:

    [sqlshare]
    host=sqlshare-rest.cloudapp.net
    user=your-user-name@your-domain
    password=your-api-key

Use this link to generate an [API key](https://sqlshare.escience.washington.edu/sqlshare/#s=credentials).

Install
----------

To install from the source here, use:

    wget https://github.com/whitead/sqlshare-r/archive/master.zip
    unzip master.zip && rm master.zip
    R CMD build sqlshare-master
    sudo R CMD INSTALL sqlshare_*.tar.gz

Once I get the package on r-cran you may install the package in R using

    install.packages("sqlshare")