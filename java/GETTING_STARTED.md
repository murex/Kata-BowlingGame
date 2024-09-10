# Getting Started with Bowling Game kata in Java

## Prerequisites

- macOS, Linux or Windows
- [git](https://git-scm.com/) client
- [curl](https://curl.se/download.html) command line utility
- [Java JDK-17](https://www.oracle.com/java/technologies/downloads/#java17)
  <details><summary>Details</summary>

  The source code of this project is compatible with Java 17 and above.
  Remember to update the java version in the kata's [pom.xml](pom.xml)
  and/or [build.gradle](build.gradle) if you're planning to use a different version.

  </details>

## Getting ready

### 1 - Clone the kata repository

```shell
git clone https://github.com/murex/Kata-BowlingGame.git
```

### 2 - Go to the kata's `java` directory

```shell
cd Kata-BowlingGame/java
```

## Running the kata

You can run the kata from the command line or from your IDE of choice.

You may also run it using [TCR](../tcr/TCR.md) if you want to add a bit of spice.

- [From a terminal with Gradle](#running-the-kata-from-a-terminal-with-gradle)
- [From a terminal with Maven](#running-the-kata-from-a-terminal-with-maven)
- [From a terminal with TCR](#running-the-kata-from-a-terminal-with-tcr)
- [From IntelliJ IDEA](#running-the-kata-from-intellij-idea)
- [From IntelliJ IDEA with TCR](#running-the-kata-from-intellij-idea-with-tcr)
- [From Visual Studio Code](#running-the-kata-from-visual-studio-code)
- [From Visual Studio Code with TCR](#running-the-kata-from-visual-studio-code-with-tcr)
- [From Eclipse](#running-the-kata-from-eclipse)
- [From Eclipse with TCR](#running-the-kata-from-eclipse-with-tcr)

<a name="running-the-kata-from-a-terminal-with-gradle"/></a>

### Running the kata from a terminal with Gradle

> ***Reminder***: the command below should be run from [Kata-BowlingGame/java]() directory

The kata comes with Gradle wrapper pre-installed. Just type the following to run it.

```shell
./gradlew clean test
```

<a name="running-the-kata-from-a-terminal-with-maven"/></a>

### Running the kata from a terminal with Maven

> ***Reminder***: the command below should be run from [Kata-BowlingGame/java]() directory

The kata comes with Maven wrapper pre-installed. Just type the following to run it.

```shell
./mvnw clean test
```

<a name="running-the-kata-from-a-terminal-with-tcr"/></a>

### Running the kata from a terminal with TCR

> ***Note to Windows users***
>
> Use a **git bash** terminal for running the command below.
> _Windows CMD and PowerShell are not supported_

Type the following to start TCR:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-intellij-idea"/></a>

### Running the kata from IntelliJ IDEA

Open Intellij IDEA and select:

`File` > `Open` > `Kata-BowlingGame` > `java`

After loading the project into IntelliJ, you can build the project
using either the Maven or Gradle built-in build tools.

Run all the tests in the [BowlingGameTest](./src/test/java/com/murex/BowlingGameTest.java)
class.

The "**Run**" tool window should display all the executed tests.

<a name="running-the-kata-from-intellij-idea-with-tcr"/></a>

### Running the kata from IntelliJ IDEA with TCR

TCR is provided as a command line utility running in a terminal.
You can run it from IntelliJ IDEA directly, through leveraging on its built-in terminal.

#### 1. Open the kata

Open Intellij IDEA and select:

`File` > `Open` > `Kata-BowlingGame` > `java`

#### 2. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to turn off Intellij IDEA's auto-save in order for it to behave as expected.

`File` > `Settings` > `Appearance & Behavior` > `System Settings`

Under `Autosave` section, uncheck the 2 following options:

- [ ] Save files if the IDE is idle for ___ seconds
- [ ] Save files when switching to a different application or a built-in terminal

#### 3. Configure the built-in terminal to run git bash

> ***Windows Only***
>
> Skip this step if you're on macOS or Linux

Intellij IDEA for Windows is usually set up to run PowerShell by default in its built-in terminal.
TCR does not run in PowerShell.

`File` > `Settings` > `Tools` > `Terminal`

Under `Application Settings` section, set the `Shell path` to `C:\Program Files\Git\bin\bash.exe`

The above path is for a default git installation location. You may need to adjust it in case you have installed git at a
different location.

#### 4. Open a built-in terminal

`View` > `Tool Windows` > `Terminal`

#### 5. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/java]() directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-visual-studio-code"></a>

### Running the kata from Visual Studio Code

Open Visual Studio Code and select:

`File` > `Open Folder` > `Kata-BowlingGame` > `java`

After loading the project into Visual Studio Code, you can build the project
using either the Maven or Gradle built-in build tools.

Run all the tests in the [BowlingGameTest](./src/test/java/com/murex/BowlingGameTest.java)
class.

Open the `Testing` tab to view all the executed tests.

<a name="running-the-kata-from-visual-studio-code-with-tcr"></a>

### Running the kata from Visual Studio Code with TCR

#### 1. Open the kata

Open Visual Studio Code and select:

`File` > `Open Folder` > `Kata-BowlingGame` > `java`

#### 2. Turn off auto-save

TCR is constantly watching the filesystem for changes.
For this reason you need to turn off the IDE's auto-save in order for it to behave as expected.

`File` > `Preferences` > `Settings` > `Text Editor` > `Files`

Ensure that `Auto Save` is set to `off`

#### 3. Open a Git Bash terminal

Select `View` > `Terminal` or `Terminal` > `New Terminal`

If the opened terminal is not a "Git Bash" terminal, use the drop-down list next to the "+"
button to open a new "Git Bash" terminal.

#### 4. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/java]() directory

From the built-in terminal:

```shell
./tcrw
```

Refer to [Using TCR](#using-tcr) section for additional details about TCR and available options.

<a name="running-the-kata-from-eclipse"></a>

### Running the kata from Eclipse

Open the kata in Eclipse:

`File` > `Open Projects from File System...` > `Kata-BowlingGame`

After loading the project into Eclipse, you can build the project
using either the Maven or Gradle built-in build tools.

Run all the tests in the [BowlingGameTest](./src/test/java/com/murex/BowlingGameTest.java)
class.

Navigate to the test class then:

`Right click` > `Run As` > `JUnit Test` or `Alt+Shift+X,T`

A `JUnit` tab should be opened that displays all the executed tests.

<a name="running-the-kata-from-eclipse-with-tcr"></a>

### Running the kata from Eclipse with TCR

#### 1. Open the kata

Open the kata in Eclipse:

`File` > `Open Projects from File System...` > `Kata-BowlingGame`

#### 2. Open a Git Bash terminal

Select `Window` > `Show View` > `Terminal`

A new `Terminal` window should be opened.

To start a `git bash` terminal:

1. Click on the `Open Terminal` button or use the shortcut `(Ctrl+Alt+Shift+T)`.
2. From the opened pop-up window select `Git Bash` then `OK`
3. From the terminal navigate to [Kata-BowlingGame/java]() directory

#### 3. Launch TCR

> ***Reminder***: the command below should be run from [Kata-BowlingGame/java]() directory

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
| `a` / `A` | Abort current command (when in driver role)  |
| `q` / `Q` | Quit current role / Quit TCR                 |
| `?`       | List available options                       |

### Additional Details

Refer to [TCR - Test && Commit || Revert](../tcr/TCR.md) page
for additional details and explanations about TCR utility.
