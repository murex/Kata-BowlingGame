# Getting Started - C++

## Prerequisites 

### Build Tools 

[CMake](https://cmake.org/) is our main build tool for the C++ version of this Kata.

Don't worry if you don't have CMake installed! 
We provided you with a setup script that handles compiling and building the project. 
 
### Required Versions 

#### C++ 

By default, our CMake file is referencing C++ version 17. But, we also tested and 
compiled the code with versions 11 and 14. 

To use a version other than 17, simply modify the below line in the [CMake](./CMakeLists.txt)
file to reference 11 or 14.  

```shell
set(CMAKE_CXX_STANDARD 17)
```

#### CMake
The minimum required version of CMake is "***3.10.0***". 

However, in our setup script, we are using the version "***3.19.3***"

#### Compilers 

When running on Windows, the code is compiled with [MSVC](https://docs.microsoft.com/en-us/cpp/build/reference/compiling-a-c-cpp-program?view=msvc-160). 

On other platforms, the script will be using the default C++ compiler set on the machine. 
For that, we have tested the with GCC and Clang

### IDEs 
We have successfully tested loading, compiling and running this kata on the below 3 IDEs: 
1. [Microsoft Visual Studio](https://visualstudio.microsoft.com/)
1. [Xcode](https://developer.apple.com/xcode/)
1. [Visual Studio Code](https://code.visualstudio.com/)

***Note:*** 

1. When executed on Windows and Mac, our script will, by default, generate the solution files ***Kata-BowlingGame.sln*** for **'Visual Studio 2017'** & ***Kata-BowlingGame.xxcodeproj*** for **'Xcode'** respectively. 
1. The script doesn't generate the VSCode Workspace files. However, loading and running the project into VSCode is straight forward. You can check the tutorial '[Getting started with CMake Tools on Linux](https://code.visualstudio.com/docs/cpp/cmake-linux#:~:text=ready%20to%20build.-,Open%20the%20Command%20Palette%20(Ctrl%2BShift%2BP)%20and,CMake%20Tools%20builds%20all%20targets.)' for reference. 

## Running the Kata 

Before running the kata in your IDE, you need to the CMake files in order to generate the Solution Files

> ***Reminder***:  You need to run the commands below from the [cpp](.) folder!

### Build Steps
#### Manual Build  

If you already have CMake installed on your machine, you can simply run one of the below commands to build the project. 

```shell
# For Visual Studio 2017 
> cmake -G "Visual Studio 15 2017 Win64" -S . -B build

# For XCode  
> cmake -G "XCode" -S . -B build

# For Linux (Visual Studio Code)
> cmake -G "Unix Makefiles" -S . -B build
```

#### Setup Script 

As mentioned earlier, we prepared a setup script to assist you in compiling and building the project. 

You can run the script using the below commands: 

```shell
# Windows
> ./cpp_easy_setup.bat

# Mac & Linux 
> ./cpp_easy_setup.sh
```

If executed successfully, the last 3 lines of the output should be the following: 

```shell
    Start 1: ctest-Kata-BowlingGame
1/1 Test #1: ctest-Kata-BowlingGame ...........   Passed    1.21 sec

100% tests passed, 0 tests failed out of 1
```

### Expected Folder Structure

After running any of the above steps, the following folders and files should be generated:
1. A [build](./build) folder that includes the files outputted from running CMake.
1. For *Windows*: The **'Visual Studio 2017'** solution file [Mikado-TestBuilders-Workshop.sln](./build/Kata-BowlingGame.sln)
1. For *Mac*: The **'Xcode'** project file [Mikado-TestBuilders-Workshop.xcodeproj](./build/Kata-BowlingGame.xcodeproj)

### Visual Studio 2017

To run the kata from your Visual Studio:

The CMake file we provided generates the target 'Kata-BowlingGame-test' 
which in turn runs the test class [BowlingGameTest.cpp](./test/BowlingGameTest.cpp). 

After loading the project into your IDE: 
1. Make sure the 'Kata-BowlingGame-test' project is set as the StartUp Project then run the project. 
1. Run the project (in VS use '**F5**' or click on '**Local Window Debugger**' in the tool bar). The following output should be generated: 
```shell
Running main() from ...\Kata-BowlingGame\cpp\build\_deps\googletest-src\googletest\src\gtest_main.cc
[==========] Running 0 tests from 0 test suites.
[==========] 0 tests from 0 test suites ran. (2 ms total)
[  PASSED  ] 0 tests.

  YOU HAVE 1 DISABLED TEST
```
1. You can also use the 'Test Explorer' window to run and view all the executed tests 
![Bowling Game_CPP_Tests](../images/BowlingGame-CPP-Tests.png)
