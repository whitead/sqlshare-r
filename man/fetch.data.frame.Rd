\name{fetch.data.frame}
\alias{fetch.data.frame}
\title{
fetch.data.frame
}
\description{
Executes the given sql statement and returns the result as a data.frame.
}
\usage{
fetch.data.frame(sql, session=sqlshare.session)
}

\arguments{
  \item{sql}{
    A SQL statement to be executed. 
  }
  \item{session}{
    A list containing a \code{host}, \code{key}, and \code{user}. The
  default is read from \code{~/.sqlshare/config} upon loading the
  sqlshare pacakge.
    }
}

\value{
  A \code{\link{data.frame}} containing the result. A \code{NULL} is
  returned if the result is empty.
}
\references{
  Information on SQLShare may be found here: \url{http://http://escience.washington.edu/sqlshare}
}
\author{
Andrew D White
}
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
\keyword{ IO }
