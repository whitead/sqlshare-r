\name{sqlshare-package}
\alias{sqlshare-package}
\alias{sqlshare}
\docType{package}
\title{
API for SQLShare web application
~~ package title ~~
}
\description{
Provides API for SQL statements on databases hosted on SQLShare (\url{http://http://escience.washington.edu/sqlshare})
}
\details{
\tabular{ll}{
Package: \tab sqlshare\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-04-02\cr
License: \tab What license is it under?\cr
}
}
\author{
Andrew D White
}
\references{
  Information on SQLShare may be found here: \url{http://http://escience.washington.edu/sqlshare}
}

\keyword{ package }
\keyword{ IO }
\examples{


  ##Maybe replace with REST call to get default account
  \dontshow{if(!exists("sqlshare.session") || is.null(sqlshare.session)) sqlshare.session <-
  list(host="https://sqlshare-rest.cloudapp.net", user="sqlshare2012@gmail.com", key="4916f21df583c0e0bc5361c42d2e6b58")}

  #get the periodic table of elements
  sql <- "select * from [sqlshare@uw.edu].[periodic_table]"
  elements <- fetch.data.frame(sql)
  #plot the ionization potential as a function of atomic number
  plot(first_ionization_ev~z, elements, type="l")
}
