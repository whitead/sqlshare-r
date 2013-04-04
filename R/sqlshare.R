loadconfig <- function(sqlsharedir, config) {

  #create config directory if necessary
  dir.create(file.path(sqlsharedir), showWarnings = FALSE)

  cfile <- file.path(sqlsharedir, config)
  
  #check if config file exists
  if(!file.exists(cfile)) {
    assign("sqlshare.session", NULL, envir=.GlobalEnv)
    cat(paste("Please create a config file at", cfile,"\n"))
    cat("Following this format\n[sqlshare]\nhost=https://sqlshare-rest.cloudapp.net\nuser=your_username\npassword=your_api_key\n")

  } else {
    #params <- yaml.load_file(cfile)
    params <- read.delim(cfile, sep="=", skip=1, header=F)
    params.seq <- sapply(c("host" ,"user", "password"), function(x) {as.character(params[params[,1] == x,2])})
    names(params.seq) <- NULL
    if(sum(grep("@", params.seq[2])) == 0) {
      params.seq[2] <- paste(params.seq[2],"washington.edu", sep="@")
    }
    assign("sqlshare.session", list(host=params.seq[1], user=params.seq[2], key=params.seq[3]), envir=.GlobalEnv)
  }
}


#Get raw data for the given query
fetch.data.frame <- function(sql, session=sqlshare.session) {
  if(is.null(session)) {
    cat("No valid sqlshare.session found\n")
    return(NULL)
  }
  
  host <- sqlshare.session$host
  selector <- "/REST.svc/v1/db/file"
  query <- paste("?sql=",URLencode(sql),sep="")

  data <- getURL(paste(host,selector,query,sep=""),
                 httpheader=c(Authorization =paste("ss_apikey ", sqlshare.session$user," :", sqlshare.session$key, sep="")),
                 verbose = FALSE,
                 ssl.verifypeer= FALSE,
                 ssl.verifyhost=FALSE,
                 .encoding="UTF-8")

  if(nchar(data) < 3) {
    return(NULL)
  }
  
  con <- textConnection(data)
  rdata <- read.csv(con, header=T)

  return(rdata)
}

.onLoad <- function(libname, pkgname) {
  loadconfig(file.path(path.expand("~"), ".sqlshare"), "config")
}
