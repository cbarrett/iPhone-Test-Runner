#!/bin/sh

# RunUnitTests.sh
# UIKit Unit Test
#
# Created by Colin Barrett on 2/28/10.
# Copyright 2010 __MyCompanyName__. All rights reserved.

# Most of this is cribbed from GTM. Thanks guys!

# We kill the iPhone simulator because otherwise we run into issues where
# the unittests fail becuase the simulator is currently running, and 
# at this time the iPhone SDK won't allow two simulators running at the same
# time.
/usr/bin/killall "iPhone Simulator" 1> /dev/null 2> /dev/null

export DYLD_ROOT_PATH="$SDKROOT"
export DYLD_FRAMEWORK_PATH="$CONFIGURATION_BUILD_DIR"
export IPHONE_SIMULATOR_ROOT="$SDKROOT"
export CFFIXED_USER_HOME="$TEMP_FILES_DIR/iPhone Simulator User Dir"

# Cleanup user home directory
if [ -d "$CFFIXED_USER_HOME" ]; then
rm -rf "$CFFIXED_USER_HOME"
fi
mkdir "$CFFIXED_USER_HOME"
mkdir "$CFFIXED_USER_HOME/Documents"
mkdir -p "$CFFIXED_USER_HOME/Library/Caches"

export TEST_RIG="$TARGET_BUILD_DIR/$EXECUTABLE_PATH"
export OTHER_TEST_FLAGS="-RegisterForSystemEvents"
export TEST_BUNDLE_PATH=" "

"${SYSTEM_DEVELOPER_DIR}/Tools/RunUnitTests"
