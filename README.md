# win10_wsl2_debian11

**Linux everywhere**  
***version: 1.0  date: 2022-03-01 author: [bestia.dev](https://bestia.dev) repository: [GitHub](https://github.com/bestia-dev/win10_wsl2_debian11)***  

For 30 years of my professional life I programmed in Windows. It was good.  
I am on a long vacation now and is time to learn something new.  

Watch the tutorial video on youtube: <https://bestia.dev/youtube/win10_wsl2_debian11.html>  

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
I explicitly didn't say Javascript, let call it by its true name **ECMAScript**, because it is an abomination.  
Fortunately we have now [WebAssembly](https://developer.mozilla.org/en-US/docs/WebAssembly) abbreviated as [WASM](https://webassembly.org/) to save the day.  
We can finally make client programs for the browser in some "normal" programming language like Rust and many others.

## Win10

Win10 is so ubiquitous that I have nothing interesting to say. It works just fine with all the drivers and peripherals and it comes preinstalled on most of the notebooks. We can say it is a winner OS in the desktop/notebook segment. In the enterprize world Microsoft still has a firm grip with their Office suite. Blue collar workers are just hooked to it like drug addicts even when there are good alternatives.  
But Windows lost completely in the server segment and shamefully in the smartphone segment.  
We "must" use it on notebooks because of the drivers, but it is slowly dying.  
I don't have any opinion of Win11. Microsoft "promised" that Win10 was the last version of Windows and the number will last forever and be free. In the background there will be minor and major updates. They broke their promise. I think nobody really loves Win11.  
It looks more like they are trying to push people away from Windows on purpose.  

## Installing WSL2  
  
WSL2 is a revolution. With it I have a lightweight virtual machine with a true Linux kernel. On my Lenovo notebook I have Win10 and it works fine with all the drivers and peripherals, but now I have also Linux, so I can do some serious programming for the Linux cloud servers. Not just one Linux, I can have multiple Linux OS simultaneously on the same machine because they run in a VM.  
Let install/enable it on Win10:  
<https://docs.microsoft.com/en-us/windows/wsl/install-win10#update-to-wsl-2>  
Open `PowerShell Run as Administrator`:  

```powershell
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
# restart and update to WSL2
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
# restart your machine. Set WSL2 as default
wsl --set-default-version 2
```

I get the error: WSL 2 requires an update to its kernel component.  
Visit <https://aka.ms/wsl2kernel> and do the update.  

## Debian11 - Bullseye

Debian is considered the grandfather of Linux based operating systems. The Linux OSes are called "distribution" or "distro". All of them have in common the Linux Kernel developed firstly by Linux Torvald, but they differ in other components that make an Operating system.  
Debian is conservative in its release cycle to ensure high stability. Some say that it is boringly stable ;-) I am old and I like stable.  
Some distros are derived from Debian and share a lot with it. Everybody have heard for Ubuntu, a big Linux popularity success for desktops.  
The new version of Debian is 11. Every version has its unique name, the version 11 is called Bullseye. Nice name.  
Use the Microsoft Store to install Debian inside WSL2:  

<https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6>  

Now we can open the Debian bash terminal using the provided icon or we can type `wsl` or `debian` in the start menu, command prompt or powershell terminal. This Debian is without the GUI desktop. We could additionally install it, but we will rarely need it. A lot of Linux programs for programmers work just fine in the non-GUI mode inside a bash terminal.  
The windows User is automatically also a Debian user.  

In the bash terminal we can type these commands to update/upgrade Debian packages:  

```bash
sudo apt update
sudo apt -y full-upgrade
cat /etc/debian_version
# 11.3
```

WSL2 works very fast with its own filesystem.  
From Linux we can access the win10 filesystem mounted on `/mnt/c/`, but this is very slow.  
From Windows we can access the linux files on `\\wsl$\Debian\`.  But sometimes we got an additional annoying file "*.attr" for attributes that differ on the 2 filesystems. I always delete it.  

## Removing Debian

If you want a fresh new installation of Debian it is easy to remove the existing one in `cmd prompt`:

```bash
# get the exact distro name
wsl -l -v
wsl --unregister Debian
```

## Removing WSL2

If you need to remove WSL2 open `PowerShell Run as Administrator`:

```powershell
Disable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
```

## Quirks

### network connection after sleep

After putting the laptop to sleep, sometimes the WSL2 does not work right. When I need to use `localhost` or `127.0.0.1` connection from Win10 to a Linux program, the connection is broken. I have to restart the WSL in `PowerShell Run as administrator` with  
`Get-Service LxssManager | Restart-Service`.  
Not nice and very difficult to discover because WSL2 is running just fine, except this.  

### external disk obsolete content

Sometimes the content of an external disk is completely wrong when looked from the WSL2. It is obsolete, something that is a remnant from other external disks. I think I unmounted the `mnt/d` in Linux and then mount it back to solve the problem.  

### git repository corruption

My git repository inside WSL2 got corrupted. It looks that this happens to many people on WSL2.  
The cure is:  

```batch
# backup the repo first!
find .git/objects/ -type f -empty | xargs rm
git fetch -p
git fsck --full
```
