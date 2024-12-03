# TCR - Test && Commit || Revert

## What is TCR

TCR is a programming workflow, which stands for **Test && Commit || Revert**.
Kent Beck, Oddmund Strømme, Lars Barlindhaug and Ole Johannessen came up with this concept
as described in [this post](https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864).

Since then several people experimented with this idea.

## Why TCR

Although probably a bit challenging to use on real production code, we found it quite beneficial when
used as a learning and practicing tool in our development katas.

TCR enforces developing in baby steps, with a strong focus on always keeping the green light on tests.
We came up with a small script implementing this process, and decided to provide it with each
of our katas so that people can use it if they like.

## Usage

You can use TCR either when practicing alone, in a pair or in a mob.

Just make sure every participant's environment is ready.

### Prerequisites

- Supported Operating Systems: macOS, Linux, Windows
- Have a [git client](https://git-scm.com/downloads) installed
- Have [curl](https://curl.se/download.html) command line utility installed
- Have a fully operational development environment for the language you're working with
- **Linux only** - have [kdialog](https://apps.kde.org/kdialog/) installed
  <details><summary>Details</summary>
  TCR leverages on the OS desktop notification framework to send timer reminders.
  On Linux, it relies on kdialog for that purpose. Make sure to have it installed
  in order to be able to see TCR's timer notifications.
  </details>

### Before starting

Clone the kata repository and create the branch that you will use.

Open a git bash window and type the following,
replacing `<kata-repository-url>`, `<kata-root-directory>` and `<my-branch>`
with the appropriate value.

#### First participant (the one creating the branch)

```shell
git clone <kata-repository-url>
cd <kata-root-directory> 
git checkout -b <my-branch>
git push origin <my-branch>
```

You can name `<my-branch>` as you wish, as long as all contributors in a pair or mob work on the same branch!

TCR script applies a great number of commits to your git repository (every time it detects changes and tests are green).
For this reason we strongly advise you to avoid running it directly on your repository's `master` or `main` branch,
or even on your features/commit/dev branches!

#### Other participants

```shell
git clone <kata-repository-url>
cd <kata-root-directory> 
git checkout <my-branch>
git pull origin <my-branch>
```

### Launching TCR

- Go to the directory for the language you're willing to work with.
  For example in Java:
  ```shell
  cd java
  ```

- Run TCR wrapper:
  ```shell
  ./tcrw
  ```

### Main menu

After starting the script, you will see a menu that looks like the following:

```text
[TCR] Loading configuration: (...)
[TCR] Loading toolchains configuration
[TCR] Loading languages configuration
[TCR] Starting TCR version 1.4.0...
[TCR] Base directory is (...)
[TCR] Found 1 source and 1 test file(s) for java language
[TCR] Work directory is (...)
[TCR] Git auto-push is turned on
[TCR] Timer duration is 5m0s
[TCR] ─────────────────────────────────────────────────────────────────────────
[TCR] Running in mob mode
[TCR] ─────────────────────────────────────────────────────────────────────────
[TCR] Base Directory: (...)
[TCR] Work Directory: (...)
[TCR] Language=java, Toolchain=gradle-wrapper
[TCR] Running on git branch "(...)" with auto-push enabled
[TCR] Variant is relaxed
[TCR] ─────────────────────────────────────────────────────────────────────────
[TCR] What shall we do?
[TCR]   D ─▶ Driver role
[TCR]   N ─▶ Navigator role
[TCR]   T ─▶ Timer status
[TCR]   P ─▶ Turn on/off git auto-push
[TCR]   L ─▶ Pull from remote
[TCR]   S ─▶ Push to remote
[TCR]   Q ─▶ Quit
[TCR]   ? ─▶ List available options
```

If you're not familiar with the Driver and Navigator roles,
you can refer to [here](https://mobprogramming.org/mob-programming-basics/).

In TCR the driver is primarily the participant actively interacting with the keyboard,
while the navigators are all other participants.

### Driver role

- To take Driver role, hit `d` from the main menu.
- You remain with Driver role until you hit `q` to go back to the main menu.

When running with Driver role, TCR workflow enters into action:
every time you save a file (either a source file or a test file), TCR triggers
a build, then runs all tests.

- If the build fails, TCR does not commit or revert anything. It goes back to an
  idle state and waits for you to fix compilation errors.
- If the build passes, TCR triggers tests execution.
- If all tests pass, TCR commits all changes.
- If one or more tests fail, TCR reverts all changes on source files, but leaves
  test files unchanged.

> ***Important***
> - __Make sure to turn off your IDE's auto-save mode while using TCR!!!__
>
>   TCR constantly watches the file system, triggering builds,
>   tests, commits and reverts as soon as it detects changes.
>   For this reason, it does not get along well with your IDE's auto-save mode.
> - __There should not be more than one driver at a time!__
>
>   You will likely face occasional merge conflicts otherwise.

### Navigator role

- To take Navigator role, hit `n` from the main menu.
- You remain with Navigator role until you hit `q` to go back to the main menu.

When running with Navigator role, TCR periodically pulls changes from the repository.
It does not push any change that you may make locally.

### Exiting TCR

- If you're running driver or navigator role, go back to the main menu by hitting `q`.
- Type `q` a second time to exit TCR.

## Contribution Workflow

TCR utility provides the basic mechanisms to run TCR and synchronize files between contributors,
however it does not replace collaboration discipline.

So make sure that at the end of each driver rotation:

- The former driver switches back to Navigator role: `q` + `n`.
- The new driver switches to Driver role: `q` + `d`.

Other contributors have nothing to do as long as they remain navigators.

## Additional Information

Refer to [TCR repository on GitHub](https://github.com/murex/TCR) for additional information
about available command line options, supported languages and toolchains, and more.
