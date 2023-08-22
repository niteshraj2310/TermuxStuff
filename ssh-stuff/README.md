<h1 align="left">Generating SSH keys.</h1>


1. Install the openssh package in Termux by running `yes|pkg install openssh`.

2. Once the installation is complete, generate a new SSH key by running `ssh-keygen -t ed25519 -C <your_email>`,
   Replace `<your_email>` with your Mail which is associated with GitHub.

3. The `ssh-keygen` command will prompt you to enter a file name for the key pair.
   You can leave the default value by pressing Enter.

4. You will then be prompted to enter a passphrase. You can leave this blank if you don't want to use a passphrase,
   or enter a passphrase if you want to add an extra layer of security.

5. Once the key pair is generated, you can view the public key by running `cat ~/.ssh/id_ed25519.pub`.

6. Now just add the SSH key to you github account, if need assistence check [this](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account).


<h2 align="left">Now let's integrate termux into the GitHub account.</h2>


1. Open the terminal in Termux and run `eval $(ssh-agent -s)` to start the SSH agent

2. Add your private SSH key to the SSH agent by running `ssh-add ~/.ssh/id_ed25519`
   > If you used a different file name for your SSH key, replace `id_ed25519` with the appropriate file name.

3. To verify that the SSH key has been added to the SSH agent, run `ssh-add -l`.
   You should see the fingerprint of your SSH key listed.

4. Finally, you can connect to your GitHub account by running `ssh -T git@github.com`
   The first time you connect to GitHub, you may see a message asking you to confirm the authenticity of the host. Type `yes` to confirm.

5. If everything is set up correctly, you should see a message that says *`"Hi {your GitHub username}! You've successfully authenticated, but GitHub does not provide shell access."`*
   You can now use Git commands to clone, push and pull code to and from your GitHub account using the SSH protocol in Termux 
   by running `git clone git@github.com:<your git username>/<Your Repo name>.git`.


### _To fix the error while authenticating the SSH with github:_
> _Hi USER! You've successfully authenticated, but GitHub does not provide shell access_.
* Add this to the `~/.gitconfig` file to use ssh instead of https for github.
```
[url "ssh://git@github.com/"]
        insteadOf = https://github.com/
```


### THE [MANUAL](https://cli.github.com/manual).
>Manual for understanding GIT-CLI interface.
