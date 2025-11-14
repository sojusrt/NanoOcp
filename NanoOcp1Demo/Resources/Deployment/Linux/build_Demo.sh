# we are in NanoOcp1Demo/Resources/Deployment/Linux/ -> change directory to demo root
cd ../../..

Cores=8
if ! [ -z "$1" ]
then
  Cores="$1"
fi
echo Using "$Cores" cores to build

# set convenience variables
JUCEDir=../submodules/JUCE
ProjucerMakefilePath="$JUCEDir"/extras/Projucer/Builds/LinuxMakefile
ProjucerBinPath="$ProjucerMakefilePath"/build/Projucer
JucerProjectPath=NanoOcp1Demo.jucer
ProjectMakefilePath=Builds/LinuxMakefile

# manually get JUCE
if test ! -d "$JUCEDir"; then git clone https://github.com/juce-framework/JUCE "$JUCEDir"
fi
cd "$JUCEDir"
git checkout master
git pull
cd ..

# build projucer
echo Build Projucer
cd "$ProjucerMakefilePath"
make -j "$Cores" "LDFLAGS=-latomic" "CONFIG=Release"
cd "../../../../../../NanoOcp1Demo"

# export projucer project
echo Export Projucer Project
"$ProjucerBinPath" --resave "$JucerProjectPath"

# start building the project
echo Build the project
cd "$ProjectMakefilePath"
make -j "$Cores" "LDFLAGS=-latomic" "CONFIG=Release"
