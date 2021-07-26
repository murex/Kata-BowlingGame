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

- [TCR Shell](./tcr_shell/tcr_shell.md)
- [TCR Go](./tcr_go/tcr_go.md)

These 2 flavors are functionally equivalent.

TCR-Shell was written first, and is currently the most robust.
This was for us a way to quickly have a usable solution for TCR.
However, shell scripts are not the best in class when it comes to
maintainability and changeability.

For these reasons we decided to develop a new implementation of TCR,
written in [Go](https://golang.org/) this time.

We have now reached the stage where the Go version is at the same functional
level as the Shell version. We still need to play with it to stress its robustness.

The TCR-Shell implementation is still the one used by default in our katas,
but you can already try the TCR-Go implementation if you feel like it.

Future developments will come in the Go implementation, while we expect
to freeze the shell implementation.
Later on we will switch the 2 implementations and have the Go implementation
become the default one in our katas.

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
For this reason we strongly advise you to avoid running it directly on your repository's `master` branch,
or even on your features/commit/dev branches!

#### Other participants

```shell
> git clone <kata-repository-url>
> cd <kata-root-directory> 
> git checkout <my-branch>
> git pull origin <my-branch>
```

### Launching the script

Refer to [TCR Shell](./tcr_shell/tcr_shell.md) usage-specifics is you're using
the default TCR implementation.

Refer to [TCR Go](./tcr_go/tcr_go.md) if you're willing to give it a try.
