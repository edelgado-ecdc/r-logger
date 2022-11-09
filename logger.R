#####################################
## Basic logger for R development  ##
#####################################
## Coded by Enrique Delgado        ##
#####################################

library(stringi)

forgeLogger = function(name = 'Logger',
                       ...) {
  setRefClass(
    name,
    fields = c(
      log_level = "character",
      filename = "character",
      console_output = "logical",
      file_output = "logical",
      memory_monitor = "logical",
      field_list = "character",
      list(...)
    ),
    methods = list(
      initialize = function(...) {
        callSuper(...)
        .self$log_level <-
          ifelse(length(as.character(log_level)) == 0,
                 "OFF",
                 as.character(log_level))
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
        .self$memory_monitor <-
          ifelse(length(as.logical(memory_monitor)) == 0,
                 FALSE,
                 as.logical(memory_monitor))
        .self$field_list = setdiff(
          names(.self)[stri_detect(str = names(.self),
                                   regex = "^[a-zA-Z]")],
          c(
            'log_level',
            'filename',
            'console_output',
            'file_output',
            'memory_monitor',
            'field_list',
            'initFields',
            'initialize'
          )
        )
        for (field in .self$field_list) {
          .self[[field]] <- get(field)
        }
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
          cat(
            stri_replace_all_regex(
              msg,
              "\u001b\\[[0-9m]+\u001b\\[[0-9m]+\u001b\\[[0-9m]+",
              ""
            ),
            file = filename,
            append = T
          )
        }
      },
      debug = function(msg) {
        if (get_level() >= 6) {
          msg <-
            stri_c(
              "\u001b[95m\u001b[1m\u001b[1m[",
              Sys.time(),
              "]",
              if (memory_monitor)
                "["
              else
                "",
              if (memory_monitor)
                ceiling(sum(.Internal(gc(
                  F, F, F
                ))[c(3, 4)]) * 1024 * 1024)
              else
                "",
              if (memory_monitor)
                " bytes]"
              else
                "",
              paste0('[', paste0(
                lapply(.self$field_list, function(x)
                  get(x))
              ), ']', collapse = ""),
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
              if (memory_monitor)
                "["
              else
                "",
              if (memory_monitor)
                ceiling(sum(.Internal(gc(
                  F, F, F
                ))[c(3, 4)]) * 1024 * 1024)
              else
                "",
              if (memory_monitor)
                " bytes]"
              else
                "",
              paste0('[', paste0(
                lapply(.self$field_list, function(x)
                  get(x))
              ), ']', collapse = ""),
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
              if (memory_monitor)
                "["
              else
                "",
              if (memory_monitor)
                ceiling(sum(.Internal(gc(
                  F, F, F
                ))[c(3, 4)]) * 1024 * 1024)
              else
                "",
              if (memory_monitor)
                " bytes]"
              else
                "",
              paste0('[', paste0(
                lapply(.self$field_list, function(x)
                  get(x))
              ), ']', collapse = ""),
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
              if (memory_monitor)
                "["
              else
                "",
              if (memory_monitor)
                ceiling(sum(.Internal(gc(
                  F, F, F
                ))[c(3, 4)]) * 1024 * 1024)
              else
                "",
              if (memory_monitor)
                " bytes]"
              else
                "",
              paste0('[', paste0(
                lapply(.self$field_list, function(x)
                  get(x))
              ), ']', collapse = ""),
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
              if (memory_monitor)
                "["
              else
                "",
              if (memory_monitor)
                ceiling(sum(.Internal(gc(
                  F, F, F
                ))[c(3, 4)]) * 1024 * 1024)
              else
                "",
              if (memory_monitor)
                " bytes]"
              else
                "",
              paste0('[', paste0(
                lapply(.self$field_list, function(x)
                  get(x))
              ), ']', collapse = ""),
              "[FATAL] ",
              msg,
              "\u001b[39m\u001b[22m\u001b[49m\n"
            )
          output(msg)
        }
      }
    )
  )
}