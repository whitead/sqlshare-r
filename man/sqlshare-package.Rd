\name{sqlshare-package}
\alias{sqlshare-package}
\alias{sqlshare}
\docType{package}
\title{
API for SQLShare web application
}
\description{
Provides API for SQL statements on databases hosted on \href{http://escience.washington.edu/sqlshare}{SQLShare}. An
authentication file should be created at \code{$HOME/.sqlshare/config}
and be formatted as follows:


\preformatted{[sqlshare]
host=sqlshare-rest.cloudapp.net
user=your-sql-share-account-name@your-domain
password=your-sql-share-account-key
}

After creating a SQLShare account, the account-key may be created \href{https://sqlshare.escience.washington.edu/sqlshare/\#s=credentials}{here}.
}
\details{
\tabular{ll}{
Package: \tab sqlshare\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-04-02\cr
License: \tab MIT\cr
}
}
\author{
Andrew D White
}
\references{
  Information on SQLShare may be found at \url{http://escience.washington.edu/sqlshare}
}

\keyword{ package }
\keyword{ IO }
\examples{



  \dontshow{if(!exists("sqlshare.session") || is.null(sqlshare.session)) sqlshare.session <-
  list(host="sqlshare-rest.cloudapp.net", user="sqlshare2012@gmail.com", key="4916f21df583c0e0bc5361c42d2e6b58")}

  #get the periodic table of elements
  sql <- "select * from [sqlshare@uw.edu].[periodic_table]"
  elements <- fetch.data.frame(sql)
  #plot the ionization potential as a function of atomic number
  plot(first_ionization_ev~z, elements, type="l")
}
