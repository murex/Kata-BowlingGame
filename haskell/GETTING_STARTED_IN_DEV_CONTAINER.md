# Getting Started with Bowling Game kata in Haskell using a Dev Container

> ***Important Note***
>
> This feature is still at an experimental stage.
> 
> We are exploring different options allowing people to run the kata without the need
> to install any language-specific SDK and tools locally.
> We see Dev Containers as a promising solution allowing us to achieve this goal.
> 
> Feel free to give it a try, and let us know what you think!

## Prerequisites

- macOS, Linux or Windows
- A [GitHub](https://github.com/) account
- A web browser supporting [VS Code for the Web](https://code.visualstudio.com/docs/editor/vscode-web)
- Alternatively, have [VS Code](https://code.visualstudio.com/docs/setup/setup-overview)
  installed locally along with
  [VS Code Remote Development](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.vscode-remote-extensionpack) extension pack

## About Dev Containers

In case you're not familiar with Dev Containers, you may have a look at
[this page](https://code.visualstudio.com/docs/devcontainers/containers)
for further details.

Our current implementation leverages on
[GitHub Codespaces](https://github.com/features/codespaces)
and [VS Code](https://code.visualstudio.com).

We may extend it in the future to alternate Dev Containers hosting solutions and IDEs.

## Step 1 - Create a new codespace

- Open [GitHub Codespaces page](https://github.com/codespaces) in a browser.
  If not done yet, log in with your GitHub account
- Click on `New codespace`
- Enter the "Repository": `murex/Kata-BowlingGame`
- Enter the "Branch" you intend to work on (we recommend creating a dedicated branch)
- Choose the "Dev container configuration": `Haskell`
- Use the proposed values for "Region" and "Machine type"
- Click on `Create codespace` button
- Give GitHub Codespaces a few minutes to create and initialize the new codespace.
- When done, GitHub Codespaces opens a new browser window or tab running VS Code for the web.

## Step 2 - Rename your codespace `Optional`

GitHub Codespaces give a random name to the codespaces it creates.

This is fine as long as you're using one single codespace, but as soon as you have more than
one it can become painful to know which is one. For this reason we recommend renaming
your codespace so that you know right away what it is about:

- Go back to your [GitHub Codespaces page](https://github.com/codespaces) in a browser
- The newly created codespace should appear in the list of your owned codespaces (refresh the page if you don't see it)
- Click on the `...` button to the right of the codespace, and select `Rename`
- Pick whichever name makes sense to you. If you plan to run `Kata-BowlingGame` with more
  than one language, we recommend renaming it to `haskell` to differentiate it with other codespaces 
  created from the same repository but for a different language
- Click `Save` button to apply the new codespace name

## Step 3 - Run the kata

You can either:
- 🅰 Run the kata directly from VS Code for the Web
- 🅱 Run VS Code locally on your machine and attach it to the dev container that you've just created

While option 🅰 is the most straightforward approach (zero-install),
its capabilities so far are more limited than a locally running IDE.
It may also feel less responsive than using a local IDE.

For these reasons you may prefer to go with option 🅱 in order to take full benefit
of using your local IDE.

### 🅰 Run the kata in VS Code for the Web

- Go back to your [GitHub Codespaces page](https://github.com/codespaces) in a browser
- The newly created codespace should appear in the list of your owned codespaces (refresh the page if you don't see it)
- Click on the `...` button to the right of the codespace, and select `Open in Browser`
- From VS Code page in the browser, follow the instructions from either of these sections:
  - [Running the kata from Visual Studio Code](GETTING_STARTED.md#running-the-kata-from-visual-studio-code)
  - [Running the kata from Visual Studio Code with TCR](GETTING_STARTED.md#running-the-kata-from-visual-studio-code-with-tcr)

### 🅱 Run the kata through attaching locally running VS Code to the dev container

- Go back to your [GitHub Codespaces page](https://github.com/codespaces) in a browser
- The newly created codespace should appear in the list of your owned codespaces (refresh the page if you don't see it)
- Click on the `...` button to the right of the codespace, and select `Open in Visual Studio Code`
- This will open VS Code on your machine. Once VS Code is done syncing with the remote dev container,
  follow the instructions from either of these sections:
  - [Running the kata from Visual Studio Code](GETTING_STARTED.md#running-the-kata-from-visual-studio-code)
  - [Running the kata from Visual Studio Code with TCR](GETTING_STARTED.md#running-the-kata-from-visual-studio-code-with-tcr)

