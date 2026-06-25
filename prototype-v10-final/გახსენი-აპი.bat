@echo off

REM FMG Community — ბოლო ვერსია (v10-final). საწყისი ფოლდერი: W2 APP\prototype-v10-final

set "LOCAL=%~dp0index.html"

set "BACKUP=c:\Users\MS\Desktop\სამეზობლოს აპლიაკცია\prototype\index.html"

if exist "%LOCAL%" (
  echo გაიხსნება W2 APP: %LOCAL%
  start "" "%LOCAL%"
  exit /b 0
)

if exist "%BACKUP%" (
  echo ყურადღება: იხსნება ძველი backup — გადააკოპირე W2 APP\prototype\index.html
  start "" "%BACKUP%"
  exit /b 0
)

echo index.html ვერ მოიძებნა. გაათავისუფლეთ დისკის ადგილი და დააკოპირეთ BACKUP -^> LOCAL.

pause

