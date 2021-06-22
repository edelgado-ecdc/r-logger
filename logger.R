#####################################
## Basic logger for R development  ##
#####################################
## Coded by Enrique Delgado        ##
#####################################

Logger = setRefClass("Logger",
            fields = list(filename="character", 
                          log_level="character",
                          topic="character"),
            methods = list(
              get_level=function(){
                levels = c("OFF","FATAL","ERROR",
                           "WARN","INFO","DEBUG")
                return(which(levels %in% .self$log_level))
              },
              deb = function(msg){
                ts_label = paste0("[", Sys.time(), "][", topic ,"][DEBUG] ")
                if(get_level() >= 6){
                  cat(paste0("\u001b[95m\u001b[1m",ts_label,msg,"\u001b[39m\u001b[22m\n"))
                  if(length(filename) != 0){
                    cat(paste0(ts_label,msg,"\n"), file = glue("{filename}.log"),
                        append = TRUE) 
                  }
                }
              },
              info = function(msg){
                ts_label = paste0("[", Sys.time(), "][", topic ,"][INFO] ")
                if(get_level() >= 5){
                  cat(paste0("\u001b[92m\u001b[1m",ts_label,msg,"\u001b[39m\u001b[22m\n"))
                  if(length(filename) != 0){
                    cat(paste0(ts_label,msg,"\n"), file = glue("{filename}.log"),
                        append = TRUE) 
                  }
                }
              },
              warn = function(msg){
                ts_label = paste0("[", Sys.time(), "][", topic ,"][WARN] ")
                if(get_level() >= 4){
                  cat(paste0("\u001b[93m\u001b[1m",ts_label,msg,"\u001b[39m\u001b[22m\n"))
                  if(length(filename) != 0){
                    cat(paste0(ts_label,msg,"\n"), file = glue("{filename}.log"),
                        append = TRUE) 
                  }
                }
              },
              error = function(msg){
                ts_label = paste0("[", Sys.time(), "][", topic ,"][ERROR] ")
                if(get_level() >= 3){
                  cat(paste0("\u001b[91m\u001b[1m",ts_label,msg,"\u001b[39m\u001b[22m\n"))
                  if(length(filename) != 0){
                    cat(paste0(ts_label,msg,"\n"), file = glue("{filename}.log"),
                        append = TRUE) 
                  }
                }
              },
              fatal = function(msg){
                ts_label = paste0("[", Sys.time(), "][", topic ,"][FATAL] ")
                if(get_level() >= 2){
                  cat(paste0("\u001b[31m\u001b[1m\u001b[40m",ts_label,msg,"\u001b[39m\u001b[22m\u001b[49m\n"))
                  if(length(filename) != 0){
                    cat(paste0(ts_label,msg,"\n"), file = glue("{filename}.log"), 
                        append = TRUE) 
                  }
                }
              },
              traces = function(msg){
                ts_label = paste0("[", Sys.time(), "][", topic ,"][FATAL] ")
                cat(paste0(ts_label,msg,"\n"), file = glue("{filename}_TRACE.log"),
                    append = TRUE)
              }
            ))
