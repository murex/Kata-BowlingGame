# Getting Started with Bowling Game kata in Go

## Prerequisites

- macOS, Linux or Windows
- [git](https://git-scm.com/) client
- [curl](https://curl.se/download.html) command line utility
- [Go SDK](https://go.dev/dl/)
  <details><summary>Go Version</summary>

  The kata is configured to run with Go version 1.20 by default.

  To use a different version, simply modify the line below in [go.mod](go.mod).

    ```text
    go 1.20
    ```
  </details>

## Getting ready

### 1 - Clone the kata repository

```shell
git clone https://github.com/murex/Kata-BowlingGame.git
```

### 2 - Go to the kata's `go` directory

```shell
cd Kata-BowlingGame/go
```

### 3 - Install `gotestsum`

When running tests, we use [`gotestsum`](https://github.com/gotestyourself/gotestsum)
instead of `go test` so that we can easily capture test results in Xunit format.

```shell
go install gotest.tools/gotestsum@latest
```

### 4 - Download 3rd-party packages used by the kata

We recommend running this command before starting the kata to ensure that you have
all the required 3rd party packages installed and up to date in you local environment.

```shell
go get -u -t -d ./...
```

## Running the kata

You can run the kata from the command line or from your IDE of choice.

You may also run it using [TCR](../tcr/TCR.md) if you want to add a bit of spice.

- [From a terminal](#running-the-kata-from-a-terminal)
- [From a terminal with TCR](#running-the-kata-from-a-terminal-with-tcr)
- [From GoLand](#running-the-kata-from-goland)
- [From GoLand with TCR](#running-the-kata-from-goland-with-tcr)
- [From IntelliJ](#running-the-kata-from-intellij)
- [From IntelliJ with TCR](#running-the-kata-from-intellij-with-tcr)
- [From Visual Studio Code](#running-the-kata-from-visual-studio-code)
- [From Visual Studio Code with TCR](#running-the-kata-from-visual-studio-code-with-tcr)

<a name="running-the-kata-from-a-terminal"/></a>

### Running the kata from a terminal

> ***Reminder***: the commands below should be run from [Kata-BowlingGame/go](.) directory

To build the project:

```shell
go build ./...
```

To run the tests:

- Using `gotestsum`:
  ```shell
  gotestsum ./...
  ```
- Using `go` built-in tools:
  ```shell
  go test -v ./...
  ```

<a name="running-the-kata-from-a-terminal-with-tcr"/></a>

### Running the kata from a terminal with TCR

> ***Note to Windows users***
>
> Use a **git bash** terminal for running the command below.
> _Windows CMD and PowerShell are not supported_


> ***Reminder***: the command below should be run from [Kata-BowlingGame/go](.) directory

Type the following to start TCR:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-goland"/></a>

### Running the kata from GoLand

Open GoLand and select:

`File` > `Open` > `Kata-BowlingGame` > `go`

Run all the tests in the project.

The "**Run**" tool window should display all the executed tests.

<a name="running-the-kata-from-goland-with-tcr"/></a>

### Running the kata from GoLand with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from GoLand directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open GoLand and select:

`File` > `Open` > `Kata-BowlingGame` > `go`

#### 2. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to turn off GoLand's auto-save in order for it to behave as expected.

`File` > `Settings` > `Appearance & Behavior` > `System Settings`

Under `Autosave` section, uncheck the 2 following options:

- [ ] Save files if the IDE is idle for ___ seconds
- [ ] Save files when switching to a different application or a built-in terminal

#### 3. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

GoLand for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`File` > `Settings` > `Tools` > `Terminal`

Under `Application Settings` section, set the `Shell path` to `C:\Program Files\Git\bin\bash.exe`

The above path is for a default git installation location. You may need to adjust it in case you have installed git at a
different location.

#### 4. Open a built-in terminal

`View` > `Tool Windows` > `Terminal`

#### 5. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/go](.) directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-intellij"/></a>

### Running the kata from IntelliJ

> ***Important***: This requires to have `IntelliJ IDEA Ultimate` edition.
>
> IntelliJ's Go plugin is not available with the Community edition.
> You can still use it as an editor for Go files, but you will not
> be able to use the benefits brought by the Go plugin, such as syntax highlighting,
> code refactoring or integration with IntelliJ's test navigator.

Installing `Go plugin`:

- Open IntelliJ and select:`File` > `Settings` > `Plugins` > `Marketplace`
- Search for `Go` and click `Install`
- Restart `IntelliJ` to activate the plugin

Open IntelliJ and select:

`File` > `Open` > `Kata-BowlingGame` > `go`

Run all the tests in the project.

The "**Run**" tool window should display all the executed tests.

<a name="running-the-kata-from-intellij-with-tcr"/></a>

### Running the kata from IntelliJ with TCR

> ***Important***: This requires to have `IntelliJ IDEA Ultimate` edition.
>
> Refer to the section [Running the kata from IntelliJ](#running-the-kata-from-intellij)
> for instructions related to installation of IntelliJ's Go plugin.

TCR is provided as a command line utility running in a terminal.
You can run it from IntelliJ directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open IntelliJ and select:

`File` > `Open` > `Kata-BowlingGame` > `go`

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

> ***Reminder***: the command below should be run from [Kata-BowlingGame/go](.) directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-visual-studio-code"/></a>

### Running the kata from Visual Studio Code

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `go`
then click `Select Folder`.

In order to run the tests, select `View` > `Testing`, then click on the `Play` button.

<a name="running-the-kata-from-visual-studio-code-with-tcr"/></a>

### Running the kata from Visual Studio Code with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from Visual Studio Code directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `go`
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

> ***Reminder***: the command below should be run from [Kata-BowlingGame/go](.) directory

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
