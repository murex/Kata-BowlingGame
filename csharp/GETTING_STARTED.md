# Getting Started with Bowling Game kata in C#

## Prerequisites

- macOS, Linux or Windows
- [git](https://git-scm.com/) client
- [curl](https://curl.se/download.html) command line utility
- a working build environment (.NET 6.0) for C#

## Getting ready

### 1 - Clone the kata repository
```shell
git clone https://github.com/murex/Kata-BowlingGame.git
```
### 2 - Go to the kata's `csharp` directory
```shell
cd Kata-BowlingGame/csharp
```

## Running the kata

You can run the kata from the command line or from your IDE of choice.

You may also run it using [TCR](../tcr/TCR.md) if you want to add a bit of spice.

- [From a terminal](#running-the-kata-from-a-terminal)
- [From a terminal with TCR](#running-the-kata-from-a-terminal-with-tcr)
- [From Visual Studio](#running-the-kata-from-visual-studio)
- [From Visual Studio with TCR](#running-the-kata-from-visual-studio-with-tcr)
- [From Visual Studio Code](#running-the-kata-from-visual-studio-code)
- [From Visual Studio Code with TCR](#running-the-kata-from-visual-studio-code-with-tcr)

<a name="running-the-kata-from-a-terminal"/></a>
### Running the kata from a terminal

> ***Reminder***: the commands below should be run from [Kata-BowlingGame/csharp]() directory

To build the project:
```shell
dotnet build
```

To run the tests:
```shell
dotnet test
```

<a name="running-the-kata-from-a-terminal-with-tcr"/></a>
### Running the kata from a terminal with TCR

> ***Note to Windows users***
>
> Use a **git bash** terminal for running the command below.
> _Windows CMD and PowerShell are not supported_


> ***Reminder***: the command below should be run from [Kata-BowlingGame/csharp]() directory

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

`Kata-BowlingGame` / `csharp` / `Kata-BowlingGame.sln`

After loading the solution:

1. Make sure the 'BowlingGame.Test' project is set as the Start-up Project.
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

`Kata-BowlingGame` / `csharp` / `Kata-BowlingGame.sln`

#### 2. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

Visual Studio for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`Tools` > `Options` > `Environment` > `Terminal` > `Add`

| Parameter         | Set value to                      |
|-------------------|-----------------------------------|
| `Name:`           | Git Bash                          |
| `Shell location:` | C:\Program Files\Git\bin\bash.exe |
| `Arguments:`      |                                   |

The above `Shell location` value is for a default git installation location.
You may need to adjust it in case you have installed git at a different location.

Don't forget to click the `Apply` button when done.

#### 3. Open a built-in terminal

`View` > `Terminal`

If Git Bash is not set as the default environment for Visual Studio built-in terminal,
click in the terminal title bar on the dropdown arrow button to the right of title,
and select `Git Bash` from the dropdown list.

#### 4. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/csharp]() directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-visual-studio-code"/></a>
### Running the kata from Visual Studio Code

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `csharp`
then click `Select Folder`.

Once the project is opened in Visual Studio Code, click on `Build`
in the bottom toolbar to build the project.

In order to run the tests, select `View` > `Testing`, then click on the `Play` button.

<a name="running-the-kata-from-visual-studio-code-with-tcr"/></a>
### Running the kata from Visual Studio Code with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from Visual Studio Code directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `csharp`
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

> ***Reminder***: the command below should be run from [Kata-BowlingGame/csharp]() directory

From the built-in terminal:

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
