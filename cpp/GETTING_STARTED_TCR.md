# Getting Started with Bowling Game kata in C++ with TCR

## Prerequisites

- macOS, Linux or Windows
- a working build environment (Visual Studio, GCC or Clang) for C++ 17
- [git](https://git-scm.com/) client
- [curl](https://curl.se/download.html) command line utility

## Quick Start

### From a terminal

```shell
> git clone https://github.com/murex/Kata-BowlingGame.git
> cd Kata-BowlingGame/cpp
> ./cpp_easy_setup.sh
> ./tcrw
```

> ***Note for Windows users***
>
> Use git bash terminal for running the above commands.
> _Windows CMD and PowerShell are not supported_

### From within your IDE

TCR is provided as a command line utility running in a terminal.
You can run it from your IDE directly, through leveraging on the IDE's built-in terminal.

> ***Notes***
> - Instructions below are provided for [Visual Studio 2019](https://visualstudio.microsoft.com/vs/older-downloads/#visual-studio-2019-and-other-products).
> - This should also work with any other IDE assuming it provides a built-in terminal that can run a shell interpreter.
> - This is not applicable to Visual Studio 2017 and earlier versions as they do not have a built-in terminal.

<details><summary>1 - Clone the kata repository and initialize the build environment</summary>

```shell
> git clone https://github.com/murex/Kata-BowlingGame.git
> ./cpp_easy_setup.sh
```

</details>
<details><summary>2 - Open the kata in your IDE</summary>

Open Visual Studio 2019, choose `Open a project or solution`, navigate to
the location containing the cloned kata repository, and open the solution file:

`Kata-Bowling-Game` / `cpp` / `build` / `Kata-Bowling-Game.sln`

</details>
<details><summary>3 - Disable auto-save in your IDE</summary>

TCR is constantly watching the filesystem for changes.
For this reason you need to disable auto-save in your IDE in order for it to behave as expected.

> ***Notes***
>
> - Visual Studio 2019 does not have auto-save. Thus, there is nothing to change if you are using it.
> - This step is here mainly as a reminder to turn it off if you are using an IDE that has an auto-save feature.

</details>
<details><summary>4 -Configure the IDE's built-in terminal to run git bash</summary>

> ***Windows Only***
> 
> Skip this step if you're on macOS or Linux

Visual Studio 2019 for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

From Visual Studio 2019:

`Tools` > `Options` > `Environment` > `Terminal` > `Add`

| Parameter | Set value to |
| --- | --- |
| `Name:` | Git Bash
|`Shell location:` | C:\Program Files\Git\bin\bash.exe
|`Arguments:` | 

The above `Shell location` value is for a default git installation location.
You may need to adjust it in case you have installed git at a different location.

Don't forget to click the `Apply` button when done.

</details>
<details><summary>5 - Open a built-in terminal</summary>

From Visual Studio 2019:

`View` > `Terminal`

If Git Bash is not set as the default environment for Visual Studio built-in terminal,
click in the terminal title bar on the dropdown arrow button to the right of title,
and select `Git Bash` from the dropdown list.

</details>
<details><summary>6 - Launch TCR</summary>

From your IDE's built-in terminal:

```shell
# Make sure to run tcrw from the kata's cpp directory
> pwd
(...)/Kata-Bowling-Game/cpp/build
> cd ..
> pwd
(...)/Kata-Bowling-Game/cpp
> ./tcrw
```

</details>

## Using TCR

### Cheat Sheet

Here are the main shortcuts available once TCR utility is running:

| Shortcut | Description |
| --- | --- |
| `?` | List available options
| `d` / `D` | Enter driver role (from main menu) |
| `n` / `N` | Enter navigator role (from main menu) |
| `q` / `Q` | Quit current role - Quit TCR (from main menu) |
| `t` / `T` | Query timer status (from driver role only) |
| `p` / `P` | Toggle on/off git auto-push (from main menu) |

### Additional Details

Refer to [TCR - Test && Commit || Revert](../tcr/TCR.md) page
for additional details and explanations about TCR utility.


