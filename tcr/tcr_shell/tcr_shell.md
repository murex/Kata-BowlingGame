# TCR - Shell Version

# About

This is a POSIX Shell implementation of TCR.

## Usage

### Prerequisites

#### Linux Users

- Have a [git client](https://git-scm.com/downloads) installed
- Have [inotify-tools](https://github.com/inotify-tools/inotify-tools/wiki) installed

#### MacOS Users

- Have a [git client](https://git-scm.com/downloads) installed
- Have [fswatch](https://emcrisostomo.github.io/fswatch/getting.html) installed

#### Windows Users

- Have a [git client](https://git-scm.com/downloads) installed

### Launching the script

#### C++ version of the kata

```shell
> cd cpp
> env TCR_ENGINE=shell ./tcrw
```

#### Java version of the kata

```shell
> cd java
> env TCR_ENGINE=shell ./tcrw
```

### Main menu

After starting the script, you will see a menu that looks like the following:

```text
[TCR] -------------------------------------------------------------------------
[TCR] Language=java, Toolchain=gradle
[TCR] Running on git branch "<my-branch>" with auto-push enabled
[TCR] -------------------------------------------------------------------------
[TCR] What shall we do?
[TCR]   D -> Driver mode
[TCR]   N -> Navigator mode
[TCR]   Q -> Quit
```

If you're not familiar with the Driver and Navigator modes,
you can refer to [here](https://mobprogramming.org/mob-programming-basics/).

In the TCR script the driver is primarily the participant actively interacting with the keyboard,
while the navigators are all other participants.

### Driver mode

- To enter in Driver mode, hit `D` from the main menu.
- You remain in Driver mode until you hit `Ctrl-C` to go back to the main menu.

When running in Driver mode, the TCR process enters in action:
each time you save a file (either a source file or a test file), TCR triggers
a build, then runs all tests.

- If the build fails, TCR does not commit or revert anything. It goes back to the
  idle state and waits for you to fix compilation errors.
- If the build passes, TCR triggers the test execution.
- If all tests pass, TCR commits all changes to git.
- If one or more tests fail, TCR reverts all changes on source files, but leaves
  test files unchanged.

__Important__

- __Make sure to turn off your IDE's auto-save mode while using TCR!!!__
  TCR constantly watches the file system, triggering builds,
  tests, commits and reverts as soon as it detects changes.
  For this reason, it does not get along well with your IDE's auto-save mode. 
- __There should not be more than one driver per branch at a time!__
  You will likely face occasional merge conflicts otherwise.

### Navigator mode

- To enter in Navigator mode, hit `N` from the main menu.
- You remain in Navigator mode until you hit `Ctrl-C` to go back to the main menu.

When running in Navigator mode, the script periodically pulls changes from the git repository
to your local clone. It does not push any change that you might make locally.

### Ending the script

- If you're in driver or navigator mode, go back to the main menu by hitting `Ctrl-C`.
- Type `Q` to end the script.

## Contribution Workflow

The TCR script provides the basic mechanics to run TCR and synchronize files between contributors,
however it does not replace collaboration discipline.

So make sure that at the end of each driver rotation:

- The former driver switches back to Navigator mode: `Ctrl-C` + `N`.
- The new driver switches to Driver mode: `Ctrl-C` + `D`.

Other contributors have nothing to do as long as they remain navigators.

## Command Line Options

The `tcrw` script utility provides the following options:

### Basic Command Line Help Display

In order to display available options:

```shell
> env TCR_ENGINE=shell ./tcrw -h
```

### Git Auto-Push Switch

#### When using TCR on your own

By default, the TCR script runs on your local clone only:
it does not push any change to the `origin` git repository.

This is the preferred way of using it when you're running TCR on your own.

When you're done with it, it's up to you to decide what you want to do with it (squash, push, revert, etc.) 

#### When using TCR in pair or in mob

When using TCR together with others, sharing changes regularly becomes important.

For this situation, the script provides the command line option `-p` (or `--auto-push`).

With this option enabled, when in driver mode, the script performs a `git push` to origin
after every `git commit`.
This allows all participants running the script in Navigator mode to get the changes as soon as they
are committed by the Driver.

```shell
> env TCR_ENGINE=shell ./tcrw -p
```

### Toolchain Selection

The TCR script can use different toolchains when running build and test.

Here are the toolchains currently supported:

| Toolchain | Language | Default |
| --- | --- | --- |
| gradle | Java | &check; |
| maven | Java | |
| cmake | C++ | &check; |

Please note that you do not need to install any of these toolchains on your machine in order to use them.
We provide the wrappers allowing to download and run them in the context of the kata.

For example, to use Maven instead of Gradle when running the TCR script for a kata in Java:

```shell
> env TCR_ENGINE=shell ./tcrw -t maven
```

## Supporting new languages

Initially, the TCR shell implementation only supported Java and C++. Don't worry, it should be easy to add your favorite language.

The shell TCR features a plugin system for languages and toolchains.

TCR shell detects the language you want to use with the name of the directory where you are running `tcrw`.

Suppose you want to add TCR support for the Javascript language. Here is what you would do:

1. `mkdir js` from the root of the repo
2. `cp java/tcrw js/`
3. `cp tcr/tcr_shell/languages/java tcr/tcr_shell/languages/js`
4. Update the variables defined in `tcr/tcr_shell/languages/js` according to Javascript. Let's assume you want to build your js with `yarn`, you'll use it both in `TOOLCHAIN` and `SUPPORTED_TOOLCHAINS` variables. `yarn` is not yet defined as a build toolchain though! You'll need to do the following to define it:
5. `cp tcr/tcr_shell/toolchains/gradle tcr/tcr_shell/toolchains/yarn`
6. Update the variables defined in `tcr/tcr_shell/toolchains/yarn` according to yarn.

That's it! Don't forget to contribute back when it works!
