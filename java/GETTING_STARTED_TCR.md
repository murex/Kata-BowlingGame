# Getting Started with Bowling Game kata in Java with TCR

## Prerequisites

- macOS, Linux or Windows
- [JDK 11](https://www.oracle.com/java/technologies/downloads/#JDK11)
- [git](https://git-scm.com/) client
- [curl](https://curl.se/download.html) command line utility

## Quick Start

### From a terminal

```shell
> git clone https://github.com/murex/Kata-BowlingGame.git
> cd Kata-BowlingGame/java
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
> - Instructions below are provided for [Intellij IDEA](https://www.jetbrains.com/idea/).
> - This should also work with any other IDE assuming it provides a built-in terminal that can run a shell interpreter.

<details><summary>1 - Clone the kata repository</summary>

```shell
> git clone https://github.com/murex/Kata-BowlingGame.git
```

</details>
<details><summary>2 - Open the kata in your IDE</summary>

Open Intellij IDEA and select:

`File` > `Open` > `Kata-Bowling-Game` > `java`

</details>
<details><summary>3 - Disable auto-save in your IDE</summary>

TCR is constantly watching the filesystem for changes.
For this reason you need to disable auto-save in your IDE in order for it to behave as expected.

From Intellij IDEA:

`File` > `Settings` > `Appearance & Behavior` > `System Settings`

Under `Autosave` section, uncheck the 2 following options:

- Save files if the IDE is idle for ___ seconds
- Save files when switching to a different application or a built-in terminal

</details>
<details><summary>4 - Configure the IDE's built-in terminal to run git bash</summary>

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

Intellij IDEA for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell. 

From Intellij IDEA:

`File` > `Settings` > `Tools` > `Terminal`

Under `Application Settings` section, set the `Shell path:` to `C:\Program Files\Git\bin\bash.exe`

The above path is for a default git installation location. You may need to adjust it in case you have installed git at a
different location.

</details>
<details><summary>5 - Open a built-in terminal</summary>

`View` > `Tool Windows` > `Terminal`

</details>
<details><summary>6 - Launch TCR</summary>

From your IDE's built-in terminal:

```shell
> # Make sure to run tcrw from the kata's java directory
> pwd
(...)/Kata-Bowling-Game/java
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

