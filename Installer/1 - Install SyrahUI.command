#!/bin/bash
echo "Please provide your password to install the necessary component..."
SCRIPTADDITION="$(dirname "$0")/.FinderSyrahUI.osax"
sudo touch /Library/ScriptingAdditions/FinderSyrahUI.osax
sudo rm -Rf /Library/ScriptingAdditions/FinderSyrahUI.osax
sudo cp -R "$SCRIPTADDITION" /Library/ScriptingAdditions/FinderSyrahUI.osax
echo "Done!"
exit 0