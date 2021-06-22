# r-logger
Simple logger for R scripts.

Declare an instance of the Logger class and you are free to go!

```{r}
source('logger.R')
logger <- Logger(log_level = 'INFO', filename = 'default')
logger$deb("This is a debug message. It won't show as INFO level is below DEBUG.")
logger$info("This is an info message.")
logger$warn("This is a warning message.")
logger$error("This is an error message.")
logger$fatal("This is a fatal message.")
logger$traces("This is a traces message. It will go to a different file and will not show!")
```

Log levels included by default are:
 - DEBUG
 - INFO
 - WARN
 - ERROR
 - FATAL
 - OFF

Each level includes all levels below, with "OFF" meaning that no message will be displayed and "DEBUG" meaning that all messages will be included.

I recommend to initialise the Logger instance on .GlobalEnv (i.e. `assign('logger', Logger(log_level = 'INFO', filename = 'default'), envir = .GlobalEnv)` for better availability.
