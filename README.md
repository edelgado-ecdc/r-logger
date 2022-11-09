# r-logger
Simple logger for R scripts.

Using the forgeLogger method you can create your own and custom Logger class! Simply specify the additional fields you need and their type (character, numeric, etc.). Once declared, you can use it to set instances of the logger and use it anywhere.

```{r}
source('logger.R')
Logger <- forgeLogger(name = 'Logger', execGUID = 'character', stage = 'character', step = 'character')
logger <- Logger(log_level = 'INFO', execGUID = '5eff70ab-000f0f00e-0283473-fafff90ff', stage = 'setup', step = 'init')
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

## Installation
You will need Stringi v. 1.6.2.

Just source the script and follow the example in the previous section.

## Configuration
If you want your logs to be output to a file, you will need to set the parameter filename to a location of your choice (.e.g. 'logs/execution.log'). There is a flag that can be also configured to override each type of outputs: `console_output`, for direct output to stdio; `file_output`, to write into a file (A+ mode).

This new version also includes a simple memory monitor with minimal performance impact. To activate this simply declare the logger object with the flag `memory_monitor` set to `True`.

## To Do
 - Better self-documentation.
 - Testing.
 - Database support.
 - Checks.
 
## Known issues
 - Windows may show weird results in text-based logging because of the behaviour of `cat()` with Windows when printing formatted strings.