# Getting Started with Bowling Game kata in Rust

## Prerequisites

- macOS, Linux or Windows
- [git](https://git-scm.com/) client
- [curl](https://curl.se/download.html) command line utility
- [Rust](https://www.rust-lang.org/tools/install) compiler and tools

## Getting ready

### 1 - Clone the kata repository

```shell
git clone https://github.com/murex/Kata-BowlingGame.git
```

### 2 - Go to the kata's `rust` directory

```shell
cd Kata-BowlingGame/rust
```

## Running the kata

You can run the kata from the command line or from your IDE of choice.

You may also run it using [TCR](../tcr/TCR.md) if you want to add a bit of spice.

- [From a terminal](#running-the-kata-from-a-terminal)
- [From a terminal with TCR](#running-the-kata-from-a-terminal-with-tcr)
- [From RustRover](#running-the-kata-from-rustrover)
- [From RustRover with TCR](#running-the-kata-from-rustrover-with-tcr)
- [From IntelliJ](#running-the-kata-from-intellij)
- [From IntelliJ with TCR](#running-the-kata-from-intellij-with-tcr)
- [From Visual Studio Code](#running-the-kata-from-visual-studio-code)
- [From Visual Studio Code with TCR](#running-the-kata-from-visual-studio-code-with-tcr)

<a name="running-the-kata-from-a-terminal"/></a>

### Running the kata from a terminal

> ***Reminder***: the commands below should be run from [Kata-BowlingGame/rust](.) directory

To build the project:

```shell
cargo build
```

To run the tests:

```shell
cargo test
```

<a name="running-the-kata-from-a-terminal-with-tcr"/></a>

### Running the kata from a terminal with TCR

> ***Note to Windows users***
>
> Use a **git bash** terminal for running the command below.
> _Windows CMD and PowerShell are not supported_


> ***Reminder***: the command below should be run from [Kata-BowlingGame/rust](.) directory

Type the following to start TCR:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-rustrover"/></a>

### Running the kata from RustRover

Open RustRover and select:

`File` > `Open` > `Kata-BowlingGame` > `rust`

Run all the tests in the project.

The "**Run**" tool window should display all the executed tests.

<a name="running-the-kata-from-rustrover-with-tcr"/></a>

### Running the kata from RustRover with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from RustRover directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open RustRover and select:

`File` > `Open` > `Kata-BowlingGame` > `rust`

#### 2. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to turn off RustRover's auto-save in order for it to behave as expected.

`File` > `Settings` > `Appearance & Behavior` > `System Settings`

Under `Autosave` section, uncheck the 2 following options:

- [ ] Save files if the IDE is idle for ___ seconds
- [ ] Save files when switching to a different application or a built-in terminal

#### 3. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

RustRover for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`File` > `Settings` > `Tools` > `Terminal`

Under `Application Settings` section, set the `Shell path` to `C:\Program Files\Git\bin\bash.exe`

The above path is for a default git installation location. You may need to adjust it in case you have installed git at a
different location.

#### 4. Open a built-in terminal

`View` > `Tool Windows` > `Terminal`

#### 5. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/rust](.) directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-intellij"/></a>

### Running the kata from IntelliJ

> ***Important***: This requires to have `IntelliJ IDEA Ultimate` edition.
>
> IntelliJ's Rust plugin is not available with the Community edition.
> You can still use it as an editor for Rust files, but you will not
> be able to use the benefits brought by the Rust plugin, such as syntax highlighting,
> code refactoring or integration with IntelliJ's test navigator.

#### 1. Install `Rust plugin`

- Open IntelliJ and select:`File` > `Settings` > `Plugins` > `Marketplace`
- Search for `Rust` and click `Install`
- Restart `IntelliJ` to activate the plugin

#### 2. Launch IntelliJ and open the project

`File` > `Open` > `Kata-BowlingGame` > `rust`

#### 3. Run the tests

From the `Project` navigator window, right click on `rust` directory and select
`Run All Tests`.

The "**Run**" tool window should display all the executed tests.

<a name="running-the-kata-from-intellij-with-tcr"/></a>

### Running the kata from IntelliJ with TCR

> ***Important***: This requires to have `IntelliJ IDEA Ultimate` edition.
>
> Refer to the section [Running the kata from IntelliJ](#running-the-kata-from-intellij)
> for instructions related to installation of IntelliJ's Rust plugin.

TCR is provided as a command line utility running in a terminal.
You can run it from IntelliJ directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open IntelliJ and select:

`File` > `Open` > `Kata-BowlingGame` > `rust`

#### 2. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to turn off IntelliJ's auto-save in order for it to behave as expected.

`File` > `Settings` > `Appearance & Behavior` > `System Settings`

Under `Autosave` section, uncheck the 2 following options:

- [ ] Save files if the IDE is idle for ___ seconds
- [ ] Save files when switching to a different application or a built-in terminal

#### 3. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

IntelliJ for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`File` > `Settings` > `Tools` > `Terminal`

Under `Application Settings` section, set the `Shell path` to `C:\Program Files\Git\bin\bash.exe`

The above path is for a default git installation location. You may need to adjust it in case you have installed git at a
different location.

#### 4. Open a built-in terminal

`View` > `Tool Windows` > `Terminal`

#### 5. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/rust](.) directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-visual-studio-code"/></a>

### Running the kata from Visual Studio Code

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `rust`
then click `Select Folder`.

In order to run the tests, select `View` > `Terminal` to open a terminal,
then type the following:

```shell
cargo test
```

<a name="running-the-kata-from-visual-studio-code-with-tcr"/></a>

### Running the kata from Visual Studio Code with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from Visual Studio Code directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `rust`
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

> ***Reminder***: the command below should be run from [Kata-BowlingGame/rust](.) directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="using-tcr"/></a>

## Using TCR

### Cheat Sheet

Here are the main shortcuts available once TCR utility is running:

| Shortcut  | Description                                  |
|-----------|----------------------------------------------|
| `o` / `O` | Open in browser (with `web` subcommand only) |
| `d` / `D` | Enter driver role                            |
| `n` / `N` | Enter navigator role                         |
| `t` / `T` | Query timer status                           |
| `p` / `P` | Toggle on/off git auto-push                  |
| `l` / `L` | Pull from remote                             |
| `s` / `S` | Push to remote                               |
| `q` / `Q` | Quit current role / Quit TCR                 |
| `?`       | List available options                       |

### Additional Details

Refer to [TCR - Test && Commit || Revert](../tcr/TCR.md) page
for additional details and explanations about TCR utility.
