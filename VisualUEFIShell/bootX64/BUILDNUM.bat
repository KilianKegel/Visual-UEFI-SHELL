@echo off
set ONE=1
for /F "tokens=1-3" %%a in ('type BUILDNUM.h') do set BUILDOLD=%%c

set /a "BUILD=%BUILDOLD%+%ONE%"
echo #define BUILDNUM %BUILD% > BUILDNUM.h
type BUILDNUM.h

set BUILDOLD=
set BUILD=
