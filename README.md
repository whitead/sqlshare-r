SQLShare API for R
===================
This provides a minimal API for accessing [SQLShare](http://escience.washington.edu/sqlshare) in the [R programming language](http://r-project.org). Here's the syntax for
obtaining a data.frame from a table located on SQLShare:

    sql <- "select * from [sqlshare@uw.edu].[periodic_table]"
    elements <- fetch.data.frame(sql)

That's it! It loads a config file for authentication from:

    ~/.sqlshare/config

The format of the file should look like:

    [sqlshare]
    host=rest.sqlshare.escience.washington.edu
    user=your-user-name@your-domain
    password=your-api-key

Use this link to generate an [API key](https://sqlshare.escience.washington.edu/sqlshare/#s=credentials).

Installing Dependencies
----------
Before installing, you must install the [RCurl package](http://cran.r-project.org/package=RCurl). If you are using a Linux system, you need to install the libcurl header files. For example, if you're using Ubuntu install the `libcurl-dev` package (using the variant with secure connections enabled) from the command line with

    sudo apt-get install libcurl4-openssl-dev

If you're using RedHat, install libcurl with

    sudo yum -y install curl-devel

Next, regardless of your operating system you must install RCurl. Open
an R session and type

    install.packages("RCurl")

Installing From CRAN (preferred)
----------
To install from CRAN, type the following command from 
an R session

    install.packages("sqlshare")


Installing From Source
----------

To install the latest version from the source here, use:

    wget https://github.com/whitead/sqlshare-r/archive/master.zip
    unzip master.zip && rm master.zip
    R CMD build sqlshare-r-master
    sudo R CMD INSTALL sqlshare_*.tar.gz

