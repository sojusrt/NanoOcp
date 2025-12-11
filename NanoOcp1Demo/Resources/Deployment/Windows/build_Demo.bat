@echo off

set VSDIR=C:\Program Files\Microsoft Visual Studio\2022\Community\Common7\IDE
set WORKSPACE=..\..\..
set JUCEDIR=%WORKSPACE%\..\submodules\JUCE
set PROJUCERVSDIR=%JUCEDIR%\extras\Projucer\Builds\VisualStudio2022
echo.

echo Using variables:
echo JUCEDIR = %JUCEDIR%
echo VSDIR = %VSDIR%
echo PROJUCERVSDIR = %PROJUCERVSDIR%
echo WORKSPACE = %WORKSPACE%
echo.

IF NOT EXIST %JUCEDIR% (
    echo manually get JUCE
    git clone https://github.com/juce-framework/JUCE %JUCEDIR%
)
cd %JUCEDIR%
git checkout master
git pull
cd ..\..\NanoOcp1Demo\Resources\Deployment\Windows\

echo Building Projucer binary
"%VSDIR%\devenv.com" %PROJUCERVSDIR%\Projucer.sln /build Release
echo.

echo Exporting Projucer project
"%PROJUCERVSDIR%\x64\Release\App\Projucer.exe" --resave %WORKSPACE%\NanoOcp1Demo.jucer --fix-missing-dependencies
echo.

echo Build release
"%VSDIR%\devenv.com" %WORKSPACE%\Builds\VisualStudio2022\NanoOcp1Demo.sln /build Release
echo.
