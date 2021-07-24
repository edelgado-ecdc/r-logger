#####################################
## Basic logger for R development  ##
#####################################
## Coded by Enrique Delgado        ##
#####################################

library(stringi)

Logger = setRefClass(
  "Logger",
  fields = list(
    log_level = "character",
    filename = "character",
    topic = "character",
    console_output = "logical",
    file_output = "logical",
    database_output = "logical"
  ),
  methods = list(
    initialize = function(...) {
      callSuper(...)
      .self$log_level <-
        ifelse(length(as.character(log_level)) == 0,
               "OFF",
               as.character(log_level))
      .self$topic <-
        ifelse(length(as.character(topic)) == 0,
               "",
               stri_c("[", as.character(topic), "]"))
      .self$filename <-
        ifelse(length(as.character(filename)) == 0,
               "",
               as.character(filename))
      .self$console_output <-
        ifelse(length(as.logical(console_output)) == 0,
               TRUE,
               as.logical(console_output))
      .self$file_output <-
        ifelse(
          length(as.logical(file_output)) == 0,
          ifelse(filename == "",
                 FALSE,
                 TRUE),
          as.logical(file_output)
        )
      .self$database_output <-
        ifelse(length(as.logical(database_output)) == 0,
               FALSE,
               as.logical(database_output))
      .self
    },
    get_level = function() {
      levels = c("OFF", "FATAL", "ERROR",
                 "WARN", "INFO", "DEBUG")
      return(which(levels %in% .self$log_level))
    },
    output = function(msg) {
      if (console_output) {
        cat(msg)
      }
      if (file_output) {
        cat(msg, file = filename, append = T)
      }
      if (database_output) {
      }
    },
    debug = function(msg) {
      if (get_level() >= 6) {
        msg <- stri_c(
          "\u001b[95m\u001b[1m\u001b[1m[",
          Sys.time(),
          "]",
          topic,
          "[DEBUG] ",
          msg,
          "\u001b[39m\u001b[22m\u001b[49m\n"
        )
        output(msg)
      }
    },
    info = function(msg) {
      if (get_level() >= 5) {
        msg <-
          stri_c(
            "\u001b[92m\u001b[1m\u001b[1m[",
            Sys.time(),
            "]",
            topic ,
            "[INFO] ",
            msg,
            "\u001b[39m\u001b[22m\u001b[49m\n"
          )
        output(msg)
      }
    },
    warning = function(msg) {
      if (get_level() >= 4) {
        msg <-
          stri_c(
            "\u001b[93m\u001b[1m\u001b[1m[",
            Sys.time(),
            "]",
            topic ,
            "[WARNING] ",
            msg,
            "\u001b[39m\u001b[22m\u001b[49m\n"
          )
        output(msg)
      }
    },
    error = function(msg) {
      if (get_level() >= 3) {
        msg <-
          stri_c(
            "\u001b[91m\u001b[1m\u001b[1m[",
            Sys.time(),
            "]",
            topic ,
            "[ERROR] ",
            msg,
            "\u001b[39m\u001b[22m\u001b[49m\n"
          )
        output(msg)
      }
    },
    fatal = function(msg) {
      if (get_level() >= 2) {
        msg <-
          stri_c(
            "\u001b[31m\u001b[1m\u001b[40m[",
            Sys.time(),
            "]",
            topic ,
            "[FATAL] ",
            msg,
            "\u001b[39m\u001b[22m\u001b[49m\n"
          )
        output(msg)
      }
    },
    traces = function(msg) {
      ts_label = stri_c("[", Sys.time(), "]", topic , "[FATAL]\n")
      cat(
        stri_c(ts_label, msg, "\n"),
        file = stri_c(filename, "_TRACE.log"),
        append = TRUE
      )
    }
    
  )
)
