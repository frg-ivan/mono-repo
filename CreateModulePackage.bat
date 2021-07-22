@echo off
title Create Module Package

:askName
rem Ask user for the module name
set /p moduleName="Enter Module Name (exclude spaces and prefixes such as 'FRG'): "

rem Make a directory for the package with the name
cd CoreBuild/Packages
if exist "%moduleName%\" (
	echo The module name '%moduleName%' is taken. Please choose a different name.
	goto askName
)
md %moduleName%

set fullModuleName=FRG.Core.%moduleName%

rem Got this from the internet to make all the characters lowercase
set locase=for /L %%n in (1 1 2) do if %%n==2 ( for %%# in (a b c d e f g h i j k l m n o p q r s t u v w x y z) do set "lowerName=!lowerName:%%#=%%#!") ELSE setlocal enableDelayedExpansion ^& set lowerName=
%locase%%fullModuleName%

rem Create the package.json file
cd %moduleName%
(
echo {
echo   "name": "com.%lowerName%",
echo   "version": "1.0.0",
echo   "displayName": "%moduleName%",
echo   "description": "ADD YOUR DESCRIPTION HERE.",
echo   "keywords": [],
echo   "author": {
echo     "name": "Free Range Games",
echo     "url": "https://github.com/freerangegames/unity-core/CoreBuild/Packages/%moduleName%"
echo   }
echo }) > package.json

rem Create the readme template
(
echo # Module Name
echo Brief description of the module.
echo.
echo **Used In:** List of projects that this tool is used in.
echo.
echo ## Dependencies
echo Description of other libraries or modules this code uses. If this module only works on certain platforms or Unity versions, specify that here.
echo.
echo ## How to Use
echo Description or steps of how to use it. Screenshots, sample code, and/or demos are also welcome.
) > README.md

rem Make the asmdef
(
echo {
echo   "name": "%fullModuleName%"
echo }
) > %fullModuleName%.asmdef

rem Create the proper folder structure
md Editor
md Runtime
md Tests

rem Opens the folder of the new package
start .