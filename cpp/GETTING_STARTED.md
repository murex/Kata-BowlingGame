# Getting Started with Bowling Game kata in C++

## Prerequisites

- macOS, Linux or Windows
- [git](https://git-scm.com/) client
- [curl](https://curl.se/download.html) command line utility
- a working build environment (Visual Studio, GCC or Clang) for C++ 17
  <details><summary>Details</summary>

  - **C++ Version**
  
    By default, the kata's CMake file is referencing C++ version 17. We also tested and
    compiled the code with versions 11 and 14.

    To use a version other than 17, simply modify the line below in the [CMake](CMakeLists.txt)
    configuration file to reference 11 or 14.

    ```text
    set(CMAKE_CXX_STANDARD 17)
    ```

  - **Compiler**
  
    When running on Windows, the code is compiled with [MSVC](https://docs.microsoft.com/en-us/cpp/build/reference/compiling-a-c-cpp-program?view=msvc-160).

    On other platforms, the script uses the default C++ compiler set on the machine.
    Both GCC and Clang are supported.
  
  </details>

## Getting ready

### 1 - Clone the kata repository
```shell
git clone https://github.com/murex/Kata-BowlingGame.git
```
### 2 - Go to the kata's `cpp` directory
```shell
cd Kata-BowlingGame/cpp
```

### 3 - Run the build setup script

The kata comes with a setup script to simplify initializing the project.

This setup script does the following:

- Create a build directory: ***Kata-BowlingGame/cpp/build***. All build-related files are generated under this directory.
- Download a copy of cmake compatible with your platform.
- Download the dependencies required to build and test the kata (such as GoogleTest).
- Generate the solution file ***Kata-BowlingGame.sln*** for **Visual Studio 2017** on Windows,
 or the project file ***Kata-BowlingGame.xcodeproj*** for **Xcode** on macOS.
- Run an initial build and test of the kata to ensure that everything is set up properly.

```shell
./cpp_easy_setup.sh
```

## Running the kata

You can run the kata from the command line or from your IDE of choice.

You may also run it using [TCR](../tcr/TCR.md) if you want to add a bit of spice.

- [From a terminal with CMake](#running-the-kata-from-a-terminal-with-cmake)
- [From a terminal with TCR](#running-the-kata-from-a-terminal-with-tcr)
- [From Visual Studio](#running-the-kata-from-visual-studio)
- [From Visual Studio with TCR](#running-the-kata-from-visual-studio-with-tcr)
- [From CLion](#running-the-kata-from-clion)
- [From CLion with TCR](#running-the-kata-from-clion-with-tcr)
- [From Visual Studio Code](#running-the-kata-from-visual-studio-code)
- [From Visual Studio Code with TCR](#running-the-kata-from-visual-studio-code-with-tcr)
- [From Xcode](#running-the-kata-from-xcode)
- [From Xcode with TCR](#running-the-kata-from-xcode-with-tcr)

<a name="running-the-kata-from-a-terminal-with-cmake"/></a>
### Running the kata from a terminal with CMake

If you already have CMake 3.21.0 or higher installed on your machine,
you can run one of the below commands to build the project.

> ***Reminder***: the commands below should be run from [Kata-BowlingGame/cpp]() directory

To build the project:
```shell
cmake --build . --config Debug
```

To run the tests:
```shell
ctest --output-on-failure -C Debug
```

<a name="running-the-kata-from-a-terminal-with-tcr"/></a>
### Running the kata from a terminal with TCR

> ***Note to Windows users***
>
> Use a **git bash** terminal for running the command below.
> _Windows CMD and PowerShell are not supported_


> ***Reminder***: the command below should be run from [Kata-BowlingGame/cpp]() directory

Type the following to start TCR:
```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-visual-studio"/></a>
### Running the kata from Visual Studio

> ***Supported Versions***: Visual Studio 2017 or later

Open Visual Studio, choose `Open a project or solution`, navigate to
the location containing the cloned kata repository, and open the solution file:

`Kata-BowlingGame` / `cpp` / `build` / `Kata-BowlingGame.sln`

After loading the solution:

1. Make sure the 'Kata-BowlingGame-test' project is set as the Start-up Project.
2. Run the project (press `F5` or click on `Local Window Debugger` in the toolbar).
3. You can also use the `Test Explorer` window to run and browse all the executed tests.

<a name="running-the-kata-from-visual-studio-with-tcr"/></a>
### Running the kata from Visual Studio with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from Visual Studio directly, through leveraging on its built-in terminal.

> ***Notes***
> - Supported Versions: Visual Studio 2019 or later
> - Visual Studio 2017 and earlier versions are not supported as they do not have a built-in terminal.

#### 1. Open the kata

Open Visual Studio, choose `Open a project or solution`, navigate to
the location containing the cloned kata repository, and open the solution file:

`Kata-BowlingGame` / `cpp` / `build` / `Kata-BowlingGame.sln`

#### 2. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

Visual Studio for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`Tools` > `Options` > `Environment` > `Terminal` > `Add`

| Parameter         | Set value to                          |
|-------------------|---------------------------------------|
| `Name:`           | Git Bash                              |
| `Shell location:` | C:\Program Files\Git\bin\bash.exe |
| `Arguments:`      |                                       |

The above `Shell location` value is for a default git installation location.
You may need to adjust it in case you have installed git at a different location.

Don't forget to click the `Apply` button when done.

#### 3. Open a built-in terminal

`View` > `Terminal`

If Git Bash is not set as the default environment for Visual Studio built-in terminal,
click in the terminal title bar on the dropdown arrow button to the right of title,
and select `Git Bash` from the dropdown list.

#### 4. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/cpp]() directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-clion"/></a>
### Running the kata from CLion

Open CLion and select:

`File` > `Open` > `Kata-BowlingGame` > `cpp`

CLion should automatically build the CMake file.

Run the test file [BowlingGameTest.cpp](./test/BowlingGameTest.cpp)

The "**Run**" tool window should display all the executed tests.

<a name="running-the-kata-from-clion-with-tcr"/></a>
### Running the kata from CLion with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from CLion directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open CLion and select:

`File` > `Open` > `Kata-BowlingGame` > `cpp`

#### 2. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to turn off CLion's auto-save in order for it to behave as expected.

`File` > `Settings` > `Appearance & Behavior` > `System Settings`

Under `Autosave` section, uncheck the 2 following options:

- [ ] Save files if the IDE is idle for ___ seconds
- [ ] Save files when switching to a different application or a built-in terminal

#### 3. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

CLion for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`File` > `Settings` > `Tools` > `Terminal`

Under `Application Settings` section, set the `Shell path` to `C:\Program Files\Git\bin\bash.exe`

The above path is for a default git installation location. You may need to adjust it in case you have installed git at a
different location.

#### 4. Open a built-in terminal

`View` > `Tool Windows` > `Terminal`

#### 5. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/cpp]() directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-visual-studio-code"/></a>
### Running the kata from Visual Studio Code

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `cpp`
then click `Select Folder`.

Once the project is opened in Visual Studio Code, click on `Build`
in the bottom toolbar to build the project.

In order to run the tests, select `View` > `Testing`, then click on the `Play` button.

<a name="running-the-kata-from-visual-studio-code-with-tcr"/></a>
### Running the kata from Visual Studio Code with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from Visual Studio Code directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `cpp`
then click `Select Folder`.

#### 2. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to make sure that Visual Studio Code's auto-save is turned off
in order for TCR to behave as expected.

`File` > `Preferences` > `Settings`

In `Text Editor` > `Files` section, make sure that `Auto Save` setting is set to `off`

#### 3. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

Visual Studio Code for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`File` > `Preferences` > `Settings`

In `Features` > `Terminal` section, set `External: Windows Exec`
to `C:\Program Files\Git\bin\bash.exe`

The above path is for a default git installation location. You may need to adjust it in case you have installed git at a
different location.

#### 4. Open a built-in terminal

`Terminal` > `New Terminal`

#### 5. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/cpp]() directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-xcode"/></a>
### Running the kata from Xcode

Open Xcode, choose `Open a project or file`, navigate to `Kata-BowlingGame` / `cpp` / `build` / `Kata-BowlingGame.xcodeproj`
then click `Open`.

Once the project is opened in Xcode, select `Product` / `Scheme` / `Kata-BowlingGame-test` to set it as the current active scheme.

Select `Product` / `Run` to build the project and run the tests.

<a name="running-the-kata-from-xcode-with-tcr"/></a>
### Running the kata from Xcode with TCR

TCR is provided as a command line utility running in a terminal.

Xcode does not provide a built-in terminal.
You can still use Xcode as an editor while running TCR in a separate terminal window.

#### 1. Open the kata

Open Xcode, choose `Open a project or file`, navigate to `Kata-BowlingGame` / `cpp` / `build` / `Kata-BowlingGame.xcodeproj`
then click `Open`.

Once the project is opened in Xcode, select `Product` / `Scheme` / `Kata-BowlingGame-test` to set it as the current active scheme.

> ***No need to build and test from Xcode***
>
> TCR takes care of building the project and running the tests.
> For this reason you should not build and test the project from Xcode when TCR is running.
> The only thing you should pay attention to is when saving your changes, which will trigger TCR's build and test.
> 

#### 2. Open a terminal

You can use any terminal application available on macOS.

If you're not familiar with terminals, macOS comes with a built-in terminal application available under 
`Applications` > `Utilities` > `Terminal.app`.

#### 3. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/cpp]() directory

From the terminal window:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="using-tcr"/></a>
## Using TCR

### Cheat Sheet

Here are the main shortcuts available once TCR utility is running:

| Shortcut  | Description                                   |
|-----------|-----------------------------------------------|
| `?`       | List available options                        |
| `d` / `D` | Enter driver role (from main menu)            |
| `n` / `N` | Enter navigator role (from main menu)         |
| `q` / `Q` | Quit current role - Quit TCR (from main menu) |
| `t` / `T` | Query timer status (from driver role only)    |
| `p` / `P` | Toggle on/off git auto-push (from main menu)  |

### Additional Details

Refer to [TCR - Test && Commit || Revert](../tcr/TCR.md) page
for additional details and explanations about TCR utility.
