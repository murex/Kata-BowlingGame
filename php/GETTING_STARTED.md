# Getting Started with Bowling Game kata in PHP

## Prerequisites

- macOS, Linux or Windows
- [git](https://git-scm.com/) client
- [curl](https://curl.se/download.html) command line utility
- [PHP](https://www.php.net/manual/en/install.php)
    <details><summary>PHP version</summary>

    The kata is configured to run with PHP version 8.1 or above.

    To use a different version, simply update the value for `php` in [composer.json](composer.json).
    </details>
- [Composer](https://getcomposer.org/) dependency manager

## Getting ready

### 1 - Clone the kata repository

```shell
git clone https://github.com/murex/Kata-BowlingGame.git
```

### 2 - Go to the kata's `php` directory

```shell
cd Kata-BowlingGame/php
```

### 3 - Setup environment with Composer

```shell
composer update
```

## Running the kata

You can run the kata from the command line or from your IDE of choice.

You may also run it using [TCR](../tcr/TCR.md) if you want to add a bit of spice.

- [From a terminal](#running-the-kata-from-a-terminal)
- [From a terminal with TCR](#running-the-kata-from-a-terminal-with-tcr)
- [From WebStorm](#running-the-kata-from-webstorm)
- [From WebStorm with TCR](#running-the-kata-from-webstorm-with-tcr)
- [From IntelliJ](#running-the-kata-from-intellij)
- [From IntelliJ with TCR](#running-the-kata-from-intellij-with-tcr)
- [From Visual Studio Code](#running-the-kata-from-visual-studio-code)
- [From Visual Studio Code with TCR](#running-the-kata-from-visual-studio-code-with-tcr)

<a name="running-the-kata-from-a-terminal"/></a>

### Running the kata from a terminal

> ***Reminder***: the commands below should be run from [Kata-BowlingGame/php](.) directory

To check the code syntax:

```shell
./vendor/bin/parallel-lint --exclude vendor .
 ```

To run the tests:

```shell
./vendor/bin/phpunit tests
 ```

<a name="running-the-kata-from-a-terminal-with-tcr"/></a>

### Running the kata from a terminal with TCR

> ***Note to Windows users***
>
> Use a **git bash** terminal for running the command below.
> _Windows CMD and PowerShell are not supported_

> ***Reminder***: the commands below should be run from [Kata-BowlingGame/php](.) directory

Type the following to start TCR:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-webstorm"/></a>

### Running the kata from WebStorm

Open WebStorm and select:

`File` > `Open` > `Kata-BowlingGame` > `php`

Run all the tests in the project.

The "**Run**" tool window should display all the executed tests.

<a name="running-the-kata-from-webstorm-with-tcr"/></a>

### Running the kata from WebStorm with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from WebStorm directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open WebStorm and select:

`File` > `Open` > `Kata-BowlingGame` > `php`

#### 2. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to turn off WebStorm's auto-save in order for it to behave as expected.

`File` > `Settings` > `Appearance & Behavior` > `System Settings`

Under `Autosave` section, uncheck the 2 following options:

- [ ] Save files if the IDE is idle for ___ seconds
- [ ] Save files when switching to a different application or a built-in terminal

#### 3. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

WebStorm for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`File` > `Settings` > `Tools` > `Terminal`

Under `Application Settings` section, set the `Shell path` to `C:\Program Files\Git\bin\bash.exe`

The above path is for a default git installation location. You may need to adjust it in case you have installed git at a
different location.

#### 4. Open a built-in terminal

`View` > `Tool Windows` > `Terminal`

#### 5. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/php](.) directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-intellij"/></a>

### Running the kata from IntelliJ

> ***Important***: This requires to have `IntelliJ IDEA Ultimate` edition.
>
> IntelliJ's PHP plugin is not available with the Community edition.
> You can still use it as an editor for PHP files, but you will not
> be able to use the benefits brought by the PHP plugin, such as syntax highlighting,
> code refactoring or integration with IntelliJ's test navigator.

#### 1. Install `PHP plugin`

- Open IntelliJ and select:`File` > `Settings` > `Plugins` > `Marketplace`
- Search for `PHP` and click `Install`
- Restart `IntelliJ` to activate the plugin

#### 2. Configure the PHP Interpreter

- `File` > `Settings` > `Languages & Frameworks` > `PHP` > `CLI Interpreter`
- Enter the path to the PHP interpreter on your machine
- Click `OK`

#### 3. Open the project

`File` > `Open` > `Kata-BowlingGame` > `php`

#### 4. Run the tests

From the `Project` navigator window, right click on `tests` directory and select
`Run 'tests'`.

The "**Run**" tool window should display all the executed tests.

<a name="running-the-kata-from-intellij-with-tcr"/></a>

### Running the kata from IntelliJ with TCR

> ***Important***: This requires to have `IntelliJ IDEA Ultimate` edition.
>
> Refer to the section [Running the kata from IntelliJ](#running-the-kata-from-intellij)
> for instructions related to installation of IntelliJ's PHP plugin.

TCR is provided as a command line utility running in a terminal.
You can run it from IntelliJ directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open IntelliJ and select:

`File` > `Open` > `Kata-BowlingGame` > `php`

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

> ***Reminder***: the command below should be run from [Kata-BowlingGame/php](.) directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-visual-studio-code"/></a>

### Running the kata from Visual Studio Code

#### 1. Prerequisite: install PHP extension for Visual Studio Code

- Menu `View` > `Extensions`
- Search for `php`
- Select [PHP](https://marketplace.visualstudio.com/items?itemName=DEVSENSE.phptools-vscode) and click `Install`

#### 2. Open the kata

Choose `Open Folder`, navigate to `Kata-BowlingGame` / `php` then click `Select Folder`.

#### 3. Run the tests

From the `Test Explorer` window (menu `View` > `Testing`):

- Click on the `Play` button to run the tests.

<a name="running-the-kata-from-visual-studio-code-with-tcr"/></a>

### Running the kata from Visual Studio Code with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from Visual Studio Code directly, through leveraging on its built-in terminal.

#### 1. Prerequisite: install PHP extension for Visual Studio Code

- Menu `View` > `Extensions`
- Search for `php`
- Select [PHP](https://marketplace.visualstudio.com/items?itemName=DEVSENSE.phptools-vscode) and click `Install`

#### 2. Open the kata

Open Visual Studio Code, choose `Open Folder`, navigate to `Kata-BowlingGame` / `php`
then click `Select Folder`.

#### 3. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to make sure that Visual Studio Code's auto-save is turned off
in order for TCR to behave as expected.

`File` > `Preferences` > `Settings`

In `Text Editor` > `Files` section, make sure that `Auto Save` setting is set to `off`

#### 4. Configure the built-in terminal to run git bash

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

#### 5. Open a built-in terminal

`Terminal` > `New Terminal`

#### 6. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/php](.) directory

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
