\name{fetch.data.frame}
\alias{fetch.data.frame}
\title{
fetch.data.frame
}
\description{
Executes the given SQL statement and returns the result as a data.frame.
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
  sqlshare package.
    }
}

\value{
  A \code{\link{data.frame}} containing the result. A \code{NULL} is
  returned if the query failed due to a SQL syntax error,
  authentication, or missing dataset. A \link{data.frame} with no rows
  indicates an empty result.
}
\references{
  Information on SQLShare may be found at \url{http://escience.washington.edu/sqlshare}.
}
\author{
Andrew D White
}
\examples{

 \dontshow{guest.session <-
  list(loaded=TRUE, host="sqlshare-rest.cloudapp.net", user="sqlshare2012@gmail.com",
  key="4916f21df583c0e0bc5361c42d2e6b58") }

  #get the periodic table of elements
  sql <- "select * from [sqlshare@uw.edu].[periodic_table]"

  #execute the sqlshare statement. Note, the extra session argument
  #isn't necessary if a config file is created

  elements <- fetch.data.frame(sql, session=guest.session)

  #plot the ionization potential as a function of atomic number
  plot(first_ionization_ev~z, elements, type="l")
}
\keyword{ IO }
