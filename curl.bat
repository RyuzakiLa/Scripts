@echo off
setlocal

REM Set the proxy information
set PROXY_HOST=127.0.0.1
set PROXY_PORT=8080

REM Set the list of URLs
set URLS_FILE=wuff.txt

REM Iterate over each URL and send the request using curl
for /f "delims=" %%i in (%URLS_FILE%) do (
    curl -k -x %PROXY_HOST%:%PROXY_PORT% "%%i"
)

endlocal
