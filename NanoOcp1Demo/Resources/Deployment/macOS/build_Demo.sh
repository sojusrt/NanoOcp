# we are in NanoOcp1Demo/Resources/Deployment/macOS/ -> change directory to demo root
cd ../../..

# set convenience variables
JUCEDir=../submodules/JUCE
ProjucerPath="$JUCEDir"/extras/Projucer/Builds/MacOSX
ProjucerBinPath="$ProjucerPath"/build/Release/Projucer.app/Contents/MacOS/Projucer
JucerProjectPath=NanoOcp1Demo.jucer
XCodeProjectPath=Builds/MacOSX/NanoOcp1Demo.xcodeproj

# manually get JUCE
if test ! -d "$JUCEDir"; then git clone https://github.com/juce-framework/JUCE "$JUCEDir"
fi
cd "$JUCEDir"
git checkout master
git pull
cd ../../NanoOcp1Demo

# build projucer
xcodebuild -project "$ProjucerPath"/Projucer.xcodeproj -configuration Release -jobs 8

# export projucer project
"$ProjucerBinPath" --resave "$JucerProjectPath"

# start building the project
xcodebuild -project "$XCodeProjectPath" -configuration Release -jobs 8 CODE_SIGNING_ALLOWED=NO
