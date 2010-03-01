# Let's Unit Test with UIKit!
Ever wanted to test UIKit classes without otest crashing? Now you can.

## Wait, what?
The test runner that's distributed with Xcode is a Mac application and isn't set up to host instances of UIKit classes. There are other options, but none of them just simply ran SenTestCase test cases at build time, so I wrote my own.

## How do I use this?
1. Create a new Cocoa Touch application target called 'Test Runner'.
1. Edit the 'Test Runner' target and make it link against:
    - UIKit
    - Foundation
    - CoreGraphics
    - SenTestingKit (this is located in /Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/&lt;SDK&gt;/Developer/Library/Frameworks/SenTestingKit.framework)
1. Add `TestRunnerMain.m` to your target.
1. Add a new Run Script build phase to 'Test Runner'.
1. Edit that phase by double clicking on it, make sure the shell is set to /bin/sh, and the script to "PATH/TO/RunUnitTests.sh". Note that you can use the `$SRCROOT` environment variable. See the example project for an example.
1. Edit the target's Info.plist:
    - Remove the 'Main nib file base name' key.
    - Add the SenTestTool key with a value of YES.
1. To run all tests at build time, edit your main target and add Test Runner as a direct dependecy.

### Target Template
For a little automation love, open the Templates folder and copy the Target Templates folder into ~/Library/Application Support/Developer/Shared/Xcode. Now you can use the Test Runner template to create a Test Runner target. You still need to add the TestRunnerMain.m file and make sure that the Run Script phase actually points to the RunUnitTests.sh script.

That's it! From now on, add any tests to the Test Runner target. Patches welcome to automate this process, perhaps with an Applescript?