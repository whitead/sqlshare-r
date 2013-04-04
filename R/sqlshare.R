loadconfig <- function(sqlsharedir, config) {

  #create config directory if necessary
  dir.create(file.path(sqlsharedir), showWarnings = FALSE)

  cfile <- file.path(sqlsharedir, config)
  
  #check if config file exists
  if(!file.exists(cfile)) {
    assign("sqlshare.session", NULL, envir=.GlobalEnv)
    cat(paste("Please create a config file at", cfile,"\n"))
    cat("Following this format\n[sqlshare]\nhost=sqlshare-rest.cloudapp.net\nuser=your_username\npassword=your_api_key\n")

  } else {
    #params <- yaml.load_file(cfile)
    params <- read.delim(cfile, sep="=", skip=1, header=F)
    params.seq <- sapply(c("host" ,"user", "password"), function(x) {as.character(params[params[,1] == x,2])})
    names(params.seq) <- NULL
    if(sum(grep("@", params.seq[2])) == 0) {
      params.seq[2] <- paste(params.seq[2],"washington.edu", sep="@")
    }
    #add the sqlshare session information to the global environemnt (make global var)
    assign("sqlshare.session", list(host=params.seq[1], user=params.seq[2], key=params.seq[3]), envir=.GlobalEnv)
  }
}


fetch.data.frame <- function(sql, session=sqlshare.session) {
  if(is.null(session)) {
    cat("No valid sqlshare.session found\n")
    return(NULL)
  }
  
  host <- paste("https://", sqlshare.session$host, sep="")
  selector <- "/REST.svc/v1/db/file"
  query <- paste("?sql=",URLencode(sql),sep="")

  data <- getURL(paste(host,selector,query,sep=""),
                 httpheader=c(Authorization =paste("ss_apikey ", sqlshare.session$user," :", sqlshare.session$key, sep="")),
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
