# Linux Cosmic Desktop inside Windows WSL2 with WSLg (2026-01)

## WSL2

Windows Subsystem for Linux (WSL) 2 is a full Linux kernel built by Microsoft, which lets Linux distributions run without managing virtual machines. WSL2 can be easily installed from `windows git-bash`:

```bash
# always update to the last version
wsl --update
# Install wsl just by typing wsl:
wsl
# version information
wsl -v
  WSL version: 2.6.3.0
  Kernel version: 6.6.87.2-1
  WSLg version: 1.0.71
  MSRDC version: 1.2.6353
  Direct3D version: 1.611.1-81528511
  DXCore version: 10.0.26100.1-240331-1435.ge-release
  Windows version: 10.0.26200.7462

# List installed distros
wsl --list -v
# List distros prepared for installation inside WSL:
wsl --list --online

# Shutdown all distros inside WSL.
wsl --shutdown

# To remove a WSL distro type:
wsl --unregister Debian

# To uninstall WSL altogether:
wsl --uninstall
```

## WSLg

WSLg is short for Windows Subsystem for Linux GUI and the purpose of the project is to enable support for running Linux GUI applications (X11 and Wayland) on Windows in a fully integrated Windows desktop experience.

Linux graphic applications GUI work normally in WSLg. Just install and run. The window will show up in the Windows Desktop.

```bash
sudo apt install -y ltris
```

## FedoraLinux-43 and Cosmic desktop

In `Windows git-bash` install distro:

```bash
wsl --install -d FedoraLinux-43
# enter the distro bash
wsl -d FedoraLinux-43
```

In `Fedora bash terminal`:

```bash
sudo dnf check-update
sudo dnf upgrade
```

Cosmic desktop is now officially on Fedora. The COSMIC (Computer Operating System Main Interface Components) Desktop Environment is a customized graphical user interface developed by System76 for their Pop!_OS Linux distribution.

```bash
sudo dnf install @cosmic-desktop-environment
```

It takes a lot of time to download and install.

Start the Cosmic desktop with:

```bash
cosmic-session
```

It works like a charm.

The GUI Desktop must be correctly shut down every time to avoid data loss.

## Ubuntu 24.04 and cosmic desktop

In `Windows git-bash` install distro:

```bash
wsl --install -d Ubuntu
# enter the distro bash
wsl -d Ubuntu
```

In `Ubuntu bash terminal` always first update and upgrade to newest packages:

```bash
sudo apt update
sudo apt upgrade -y
```

Ubuntu does not have an official Cosmic package. We must use for now an unofficial package.  
How to Install COSMIC Desktop on Ubuntu 24.04 [PPA]  
<https://www.omgubuntu.co.uk/2025/12/install-cosmic-desktop-ubuntu-24-04-ppa>

```bash
sudo add-apt-repository ppa:hepp3n/cosmic-epoch
sudo apt install cosmic-session
# choose Cosmic greeter
```

It takes a lot of time to download and install.

Start the Cosmic desktop with:

```bash
cosmic-session
```

It works like a charm.

The GUI Desktop must be correctly shut down every time to avoid data loss.

## Debian

Debian is so stable that there is no point to experiment new Desktops on it. Just wait for novelties to make it to the stable Debian.
