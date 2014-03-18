FinderSyrahUI
=============

An experiment showing how Finder might look like on the next OSX (codename "Syrah"). Inspired by [Mac OS X Syrah - Concept](https://www.behance.net/gallery/Mac-OS-X-Syrah-Concept/15338159).

How to install
==============

Open the "Installer" folder, run "1 - Install SyrahUI" then run "2 - Load SyrahUI". When you want to reverse back to the original Finder, run "3 - Unload SyrahUI".

![screenshot](https://raw.github.com/insidegui/FinderSyrahUI/master/Screenshots/screenshot_1.png)

How It works
============

SyrahUI is a bundle which, when injected in another process, swizzles some methods on some classes to change how things look. 

The "installer" just copies a file to /Library/ScriptingAdditions, allowing any app to be injected with the bundle by running an AppleScript command, which is executed when you run "Load SyrahUI".

Disclaimer
==========

I don't give support regarding this experiment, It is probably pretty safe, but use It at your own risk.

Finder and OS X are trademarks of Apple Inc., registered in the U.S. and other countries.