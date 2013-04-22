sqlshare.session <- new.env()

loadconfig <- function(sqlsharedir, config) {

  #create config directory if necessary
  dir.create(file.path(sqlsharedir), showWarnings = FALSE)

  cfile <- file.path(sqlsharedir, config)
  
  #check if config file exists
  if(!file.exists(cfile)) {
    sqlshare.session$loaded <- FALSE
    cat(paste("Please create a config file at", cfile,"\n"))
    cat("Following this format\n[sqlshare]\nhost=rest.sqlshare.escience.washington.edu\nuser=your_username\npassword=your_api_key\n")

  } else {
    params <- read.delim(cfile, sep="=", skip=1, header=F)
    params.seq <- sapply(c("host" ,"user", "password"), function(x) {as.character(params[params[,1] == x,2])})
    names(params.seq) <- NULL
    if(sum(grep("@", params.seq[2])) == 0) {
      params.seq[2] <- paste(params.seq[2],"washington.edu", sep="@")
    }
    #set the login details to the sqlshare.session environment
    sqlshare.session$loaded <- TRUE
    sqlshare.session$host <- params.seq[1]
    sqlshare.session$user <- params.seq[2]
    sqlshare.session$key <- params.seq[3]
  }
}

fetch.data.frame <- function(sql, session = sqlshare.session) {

  if(!session$loaded) {
    cat("No valid session found\n")
    return(NULL)
  }
  
  host <- with(session, paste("https://", host, sep=""))
  selector <- "/REST.svc/v1/db/file"
  query <- paste("?sql=",URLencode(sql),sep="")

  data <- getURL(paste(host,selector,query,sep=""),
                 httpheader=c(Authorization =with(session, paste("ss_apikey ", user," :", key, sep=""))),
                 verbose = FALSE,
                 ssl.verifypeer= FALSE,
                 ssl.verifyhost=FALSE,
                 .encoding="UTF-8")
  #generally returns "" if there is no data
  if(nchar(data) == 0) {
    return(NULL)
  }

  #parse it in using the read.csv file reader
  con <- textConnection(data)
  rdata <- read.csv(con, header=T)

  return(rdata)
}

#when the library loads, read in config file
.onLoad <- function(libname, pkgname) {
  loadconfig(file.path(path.expand("~"), ".sqlshare"), "config")  
}
