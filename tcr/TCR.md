# TCR - Test && Commit || Revert

## What is TCR

TCR is a programming workflow, which stands for **Test && Commit || Revert**.
Kent Beck and Oddmund Strømme came up with this concept in [this post](https://medium.com/@kentbeck_7670/test-commit-revert-870bbd756864).

Since then several people experimented with this idea.

## Why TCR

Although probably a bit challenging to use on real production code, we found it quite beneficial when
used as a learning and practicing tool in our development katas.

TCR enforces developing in baby steps, with a strong focus on always keeping the green light on tests.
We came up with a small script implementing this process, and decided to provide it with each
of our katas so that people can use it if they like.

## TCR Flavors

We currently provide TCR in 2 flavors:

- [TCR Shell](tcr_shell/tcr_shell.md)
- [TCR Go](tcr_go/tcr_go.md)

These 2 flavors are functionally equivalent.

TCR-Shell was written first.
This was for us a way to quickly have a usable solution for TCR.
However, shell scripts are not the best in class when it comes to
maintainability and changeability.

For these reasons we decided to develop a new implementation of TCR,
written in [Go](https://golang.org/) this time.

We have now reached a stage where we believe the Go flavor to robust enough,
while providing the same level of features as the Shell flavor<sup id="a1">[1](#f1)</sup>.

Thus, the Go flavor of TCR is now the one used by default in our katas.

The Shell flavor is still available, and you can still use it if you feel like it.

The Shell flavor is now frozen, and new features will arrive primarily in the Go implementation.

## Usage

You can use TCR either when practicing alone, in a pair or in a mob.

Just make sure every participant's environment is ready.

### Before starting

Clone the kata repository and create the branch that you will use.

Open a git bash window and type the following,
replacing `<kata-repository-url>`, `<kata-root-directory>` and `<my-branch>`
with the appropriate value.

#### First participant (the one creating the branch)

```shell
> git clone <kata-repository-url>
> cd <kata-root-directory> 
> git checkout -b <my-branch>
> git push origin <my-branch>
```

You can name `<my-branch>` as you wish, as long as all contributors in a pair or mob work on the same branch!

TCR script applies a great number of commits to your git repository (every time it detects changes and tests are green).
For this reason we strongly advise you to avoid running it directly on your repository's `master` or `main` branch,
or even on your features/commit/dev branches!

#### Other participants

```shell
> git clone <kata-repository-url>
> cd <kata-root-directory> 
> git checkout <my-branch>
> git pull origin <my-branch>
```

### Launching the script

```shell
> ./tcrw
```

Refer to [TCR Go](tcr_go/tcr_go.md) usage-specifics is you're using the default TCR implementation.

Refer to [TCR Shell](tcr_shell/tcr_shell.md) if you're willing to use it instead.

## Notes

<b id="f1">1</b> There is currently one exception related to the possibility to add custom programming
languages/toolchains (in addition to Java/Gradle, Java/Maven and C++/CMake provided with both flavors),
which was recently added to TCR-Shell flavor but is not yet available in TCR-Go flavor.[↩](#a1)

