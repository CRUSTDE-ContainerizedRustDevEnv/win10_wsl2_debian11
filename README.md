[//]: # (auto_md_to_doc_comments segment start A)

# win10_wsl2_debian11

**01. Tutorial to install Linux on Windows. Linux everywhere! (win10_wsl2_debian11) (2022-03)**  
***version: 2024.326.1347  date: 2024-03-26 author: [bestia.dev](https://bestia.dev) repository: [GitHub](https://github.com/CRUSTDE-ContainerizedRustDevEnv/win10_wsl2_debian11)***  

 ![maintained](https://img.shields.io/badge/maintained-green)
 ![ready_for_use](https://img.shields.io/badge/ready_for_use-green)
 ![tutorial](https://img.shields.io/badge/tutorial-yellow)
 ![win10_wsl2_debian11](https://bestia.dev/webpage_hit_counter/get_svg_image/556625040.svg)

 ![logo](https://raw.githubusercontent.com/CRUSTDE-ContainerizedRustDevEnv/CRUSTDE_Containerized_Rust_DevEnv/main/images/crustde_250x250.png)
 win10_wsl2_debian11 is a member of the [CRUSTDE-ContainerizedRustDevEnv](https://github.com/orgs/CRUSTDE-ContainerizedRustDevEnv/repositories?q=sort%3Aname-asc) project.

Hashtags: #rustlang #tutorial  
My projects on GitHub are more like a tutorial than a finished product: [bestia-dev tutorials](https://github.com/bestia-dev/tutorials_rust_wasm).

For 30 years of my professional life, I programmed in Windows. It was good.  
I am on a long vacation now and is time to learn something new.  

This project has also a YouTube video tutorial. Watch it:
<!-- markdownlint-disable MD033 -->
[<img src="https://bestia.dev/youtube/win10_wsl2_debian11.jpg" width="400px">](https://bestia.dev/youtube/win10_wsl2_debian11.html)
<!-- markdownlint-enable MD033 -->

## Linux everywhere

My conclusion is that Windows (and MacOS) should just die a long death and be replaced by Linux.  
Microsoft obviously concluded the same, therefor they introduced WSL (Windows Subsystem for Linux). Now we can run more and more Linux programs inside Windows. So Windows is less and less interesting to programmers.  
MacOS and iOS are already similar to Linux because they are based on BSD, a cousin of Unix.  
Android is basically a bastard child of Linux and Google.  
Almost all the web servers and servers in the cloud are Linux today.  
So today it makes sense to do all the programming only for Linux.  

## standard modern GUI

The "elephant in the room" is the GUI. Every OS has on purpose made the GUI different and completely incompatible. Sadly!
But we have a strong international standard for GUI that works literally everywhere: it is HTML+CSS+JavascriptEngine.  
I explicitly didn't say Javascript, let's call it by its true name **ECMAScript** because it is an abomination.  
Fortunately, we have now [WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly) abbreviated as [WASM](https://webassembly.org/) to save the day.  
We can finally make client programs for the browser in some "normal" programming languages like Rust and many others.

## Win10

Win10 is so ubiquitous that I have nothing interesting to say. It works just fine with all the drivers and peripherals and it comes preinstalled on most of the notebooks. We can say it is a winning OS in the desktop/notebook segment. In the enterprise world, Microsoft still has a firm grip with its Office suite. Blue-collar workers are just hooked to it like drug addicts even when there are good alternatives.  
But Windows lost completely in the server segment and shamefully in the smartphone segment.  
We "must" use it on notebooks because of the drivers, but it is slowly dying.  
I don't have any opinion of Win11. Microsoft "promised" that Win10 was the last version of Windows and that the number would last forever and be free. In the background, there will be minor and major updates. They broke their promise. I think nobody really loves Win11.  
It looks more like they are trying to push people away from Windows on purpose.  

## Installing WSL2  
  
WSL2 is a revolution. With it, I have a lightweight virtual machine with a true Linux kernel. On my Lenovo notebook, I have Win10 and it works fine with all the drivers and peripherals, but now I have also Linux, so I can do some serious programming for the Linux cloud servers. Not just one Linux, I can have multiple Linux OS simultaneously on the same machine because they run in a VM.  
Let's install/enable it on Win10:  
<https://docs.microsoft.com/en-us/windows/wsl/install-win10#update-to-wsl-2>  
Open `Windows git-bash Run as Administrator`:  

```bash
export MSYS_NO_PATHCONV=1
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
# restart and update to WSL2
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
unset MSYS_NO_PATHCONV
# Set WSL2 as default
wsl --set-default-version 2
# I can update the wsl now
wsl --update
```

If needed restart Windows for this changes to be 100% in effect.

## Debian11 - Bullseye

Debian is considered the grandfather of Linux-based operating systems. The Linux OSes are called "distribution" or "distro". All of them have in common the Linux Kernel developed firstly by Linux Torvald, but they differ in other components that make an Operating system.  
Debian is conservative in its release cycle to ensure high stability. Some say that it is boringly stable ;-) I am old and I like "stable".  
Some distros are derived from Debian and share a lot with it. Everybody has heard of Ubuntu, a big Linux popularity success for desktops.  
The new version of Debian is 11. Every version has its unique name, version 11 is called Bullseye. Nice name.  
Use the Microsoft Store to install Debian inside WSL2:  

<https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6>  

or in `Windows git-bash` a few lines:

```bash
# list the distros
wsl --list --online
# install Debian
wsl --install -d Debian
```

It takes a minute! Now we can open the Debian bash terminal using the provided "Debian" icon in Start Menu. This Debian is without the GUI desktop. We could additionally install it, but we will rarely need it. A lot of Linux programs for programmers work just fine in the non-GUI mode inside a bash terminal.  
The Windows user is automatically also a Debian user.  

In the bash terminal we can type these commands to update/upgrade Debian packages:  

```bash
sudo apt update
sudo apt -y full-upgrade
cat /etc/debian_version
# 12.5
```

WSL2 works very fast with its own filesystem.  
From Linux, we can access the win10 filesystem mounted on `/mnt/c/`, but this is very slow.  
From Windows, we can access the Linux files on `\\wsl$\Debian\`.  But sometimes when we copy files, we get an additional annoying file "*.attr" for attributes that differ on the 2 filesystems. I always delete it.  

## Updates 2024 and new knowledge

Debian is now 12 bookworm. But that doesn't change much. It is easy to uninstall the old Debian and install the new one just with the same commands.  
First, store the important configuration of Debian somehow and restore it later.  
The same commands will install the latest version. That takes just a minute! Great!.  

## nano - simple editor in bash terminal

I configured `nano` as my default editor in the bash terminal for simple text editing. It is easy to use.  

I like to use the mouse:

- Select text with the mouse to copy. Nothing to click, just select.
- Right-click to paste.
- mouse 

This works with the Windows clipboard and is used to transfer text from and to the bash terminal.
This useful functionality comes from the terminal and not from the nano editor.
Don't use `set mouse` in file `~/.nanorc` because it will disable this useful terminal mouse functionality.

Editor `nano` important functions:

- Arrows move the cursor intuitively
- Delete and backspace work intuitively
- `Ctrl-K` to delete a line. Press longer to delete many lines.
- `Ctrl-O` save file
- `Ctrl-X` to exit

## WSL2: disable auto-mount of Windows drives

My main OS Windows can see the files inside WSL using paths like this: `\\wsl$\Debian\home\` or `\\wsl.localhost\Debian\home\`. I think this is fine. The host can see the guest.

I don't like that programs in WSL can see the files of my host OS Windows. The win drives are mounted like `/mnt/c/`, `/mnt/d/`,... It is called WSL auto-mount. I want to disable that.  
For "security" I don't want WSL to see Windows drives, folders and files by default. It is never good that the guest can see the host. This access is even read/write. Bad.

There is a half-baked solution from Microsoft, but workable for my use case.  
A malicious actor could still mount any Windows folder he wants if he gets admin privilege in WSL because then he can change the `/etc/wsl.conf` file.  
This is not a good sandbox. It just makes exploits a little bit trickier, but possible nonetheless.  
<https://github.com/microsoft/WSL/issues/7236>  
Microsoft always does everything unsafe by default! On purpose. Bad Microsoft!

First, disable the `virtio9p` protocol that is used by WSL to access the files in Windows. At least I hope I understood that right.  

In `Windows git-bash` create the file with the command:

```bash
code ~/.wslconfig
```

```conf
[wsl2]
# disable wsl from accessing windows files
virtio9p=false
```

Second, write the file in the `Debian bash` with `nano`:

```bash
sudo nano /etc/wsl.conf
```

```conf
# Automatically mount Windows drive when the distribution is launched
[automount]

# disable auto-mounting of win drives
enabled = false

# process fstab entries to allow some folders to be mounted
mountFsTab = true

# disable launching windows exe files
[interop]
enabled = false
appendWindowsPath = false
```

For the changes to take effect, in `Windows git-bash` shutdown WSL with:

```bash
wsl --shutdown
```

After restart, the win drives are not automounted anymore, but the mounting points are still here.  
In Debian bash:

```bash
ls /mnt
# c  d  wsl  wslg
sudo rmdir /mnt/c
sudo rmdir /mnt/d
# mounting points c and d are now deleted
ls /mnt
# wsl  wslg
```

Now when starting WSL I get a stupid error:  
<3>WSL (9) ERROR: UtilTranslatePathList:2866: Failed to translate C:\Users\luciano  
And I don't know from where it comes from.  
The `appendWindowsPath` is already set to false. Usually, this is the main reason for errors like that.  

## Git and SSH on Debian

Git and SSH are essential to developers. We need to securely access our remote repositories on GitHub and our production Web servers. All over SSH. The installation of Git brings SSH with it.
Install Git in Debian:

```bash
sudo apt install -y git
git --version
# git version 2.39.2
ssh -V
# OpenSSH_9.2p1 Debian-2+deb12u2, OpenSSL 3.0.11 19 Sep 2023
```

```bash

# config git globally
git config --global user.name "Your Name"
```

```bash
git config --global user.email "youremail@yourdomain.com"
```

```bash
# for windows only:
git config --global core.eol lf
git config --global core.autocrlf input
# I like to use the nano editor in the terminal
git config --global core.editor "nano"
git config --global -l
```

Config SSH:

```bash
mkdir -vp ~/.ssh
chmod 700 ~/.ssh
# From Windows from your encrypted vault, copy your existing ssh keys (private and public) for Github and your web server into ~/.ssh. Mine are called github_com_git_ssh_1 and bestia_dev_luciano_bestia_ssh_1. 
# Windows can read/write the Linux Filesystem. Linux should NOT read/write the Windows file system. Host->Guest ok. Guest->Host no-no.
```

```bash
# config appropriate security for the private key files
sudo chmod 600 ~/.ssh/github_com_git_ssh_1
sudo chmod 600 ~/.ssh/bestia_dev_luciano_bestia_ssh_1
```

Create the file `~/.ssh/config` with [this content](configuration_files/debian_files/.ssh/config):

```bash
nano ~/.ssh/config
```

Create the file `~/.ssh/sshadd.sh` with  [this content](configuration_files/debian_files/.ssh/sshadd.sh)

```bash
nano ~/.ssh/sshadd.sh
```

## .bashrc

To activate the `ssh-agent` and config other stuff on start of bash terminal,
copy [this content](configuration_files/debian_files/.bashrc) to file `~/.bashrc`.  

First, use `Ctrl-K` multiple times to delete all existing lines.

```bash
nano ~/.bashrc
```

## Removing Debian

If you want a fresh new installation of Debian it is easy to remove the existing one in `Windows git-bash`.  
Warning: You will lose all the content.

```bash
# get the exact distro name
wsl -l -v
wsl --unregister Debian
```

## Removing WSL2

If you need to remove WSL2 open `Windows git-bash Run as Administrator`.  
Warning: You will lose all the content.

```bash
MSYS_NO_PATHCONV=1 dism.exe /online /disable-feature /featurename:Microsoft-Windows-Subsystem-Linux
```

## Quirks

### network connection after sleep

After putting the laptop to sleep, sometimes the WSL2 does not work right. When I need to use `localhost` or `127.0.0.1` connection from Win10 to a Linux program, the connection is broken. I have to restart the WSL in `Windows git-bash Run as Administrator` with  
`Get-Service LxssManager | Restart-Service`.  
Not nice and very difficult to discover because WSL2 is running just fine, except for this.

### external disk obsolete content

Sometimes the content of an external disk is completely wrong when looked at from the WSL2. It is obsolete, something that is a remnant of other external disks. I think I unmounted the `mnt/d` in Linux and then mounted it back to solve the problem.  

### git repository corruption

My git repository inside WSL2 got corrupted. It looks like this happens to many people on WSL2.  
The cure is:  

```batch
# backup the repo first!
find .git/objects/ -type f -empty | xargs rm
git fetch -p
git fsck --full
```

## Open-source and free as a beer

My open-source projects are free as a beer (MIT license).  
I just love programming.  
But I need also to drink. If you find my projects and tutorials helpful, please buy me a beer by donating to my [PayPal](https://paypal.me/LucianoBestia).  
You know the price of a beer in your local bar ;-)  
So I can drink a free beer for your health :-)  
[Na zdravje!](https://translate.google.com/?hl=en&sl=sl&tl=en&text=Na%20zdravje&op=translate) [Alla salute!](https://dictionary.cambridge.org/dictionary/italian-english/alla-salute) [Prost!](https://dictionary.cambridge.org/dictionary/german-english/prost) [Nazdravlje!](https://matadornetwork.com/nights/how-to-say-cheers-in-50-languages/) 🍻

[//bestia.dev](https://bestia.dev)  
[//github.com/bestia-dev](https://github.com/bestia-dev)  
[//bestiadev.substack.com](https://bestiadev.substack.com)  
[//youtube.com/@bestia-dev-tutorials](https://youtube.com/@bestia-dev-tutorials)  

[//]: # (auto_md_to_doc_comments segment end A)
