## 
# 
# Service Launcher 
# Chris Malcolm 2018
#
# Launch all your services by runnning
#
#
# $> ./launch.sh
#
#
# A file of npmDirectories and command per directory  is required, see below for example.
#
# Ex File (./npmDirs.txt)
# =====================
#
# ../../../paths-service > npm run server-dev
# ../../../reviews-service > npm run server-dev
# ../../../trail-service > npm run server-dev
# ../../../not-a-service > npm run server-dev
# <line break>
#
#
##

# Adjust settings below
# ----------------------
#1 folder per line of url to download
listOfNPMDirsFile="./npmDirs.txt"

# DONT EDIT
# ----------------------
if [ -f "$listOfNPMDirsFile" ]
    then
        while IFS= read -r entry;do
            #get pieces 
            dir="$(echo $entry | cut -d'>' -f 1 | xargs)";
            task="$(echo $entry | cut -d'>' -f 2 | xargs)";
                if [ -d "$dir" ]
                then
                    # make a message
                    echo "starting '$task' in '$dir'..."
                    sleep 1s
                       osascript 2>/dev/null <<EOF
                       tell application "Terminal"
                            activate
                        end tell
                        delay 1
                        tell application "System Events"
                          tell process "Terminal" to keystroke "t" using command down
                        end
                        tell application "Terminal"
                          activate
                          #do script
                          do script with command "cd '$PWD/$dir' && $task" in window 1
                        end tell
EOF
                else
                    echo "$dir does not exist...skipping."
                fi
                  
        done < "$listOfNPMDirsFile"
    else
        echo
        echo 
        echo "npmDirs.txt file must be in this same directory. Each line represents the relative path of npm directory with a > cmd"
        echo "also end with an empty line!"
        echo 
        echo "[path/to/npmDir] --> [cmd] "
        echo
        echo "ex."
        echo "../../../paths-service > npm run server-dev"
        echo "../../../reviews-service > npm run server-dev"
        echo "[empty line]"
        echo
fi
