# r-logger
Simple logger for R scripts.

Declare an instance of the Logger class and you are free to go!

```{r}
source('logger.R')
logger <- Logger(log_level = 'INFO', topic = 'main')
logger$debug("This is a debug message. It won't show as INFO level is below DEBUG.")
logger$info("This is an info message.")
logger$warning("This is a warning message.")
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

An additional parameter is set (topic) to include further information about the execution circumstances, to be added as the name of a file or subprocess. 

## Installation
You will need Stringi v. 1.6.2.

Just source the script and follow the example in the previous section.

## Configuration
If you want your logs to be output to a file, you will need to set the parameter filename to a location of your choice (.e.g. 'logs/execution.log'). There is a flag that can be also configured to override each type of outputs: `console_output`, for direct output to stdio; `file_output`, to write into a file (A+ mode), `database_output`, to write directly to a database (unsupported).

## To Do
 - Better self-documentation.
 - Testing.
 - Database support.
 - Checks.
 
## Known issues
 - Windows may show weird results in text-based logging because of the behaviour of `cat()` with Windows when printing formatted strings.