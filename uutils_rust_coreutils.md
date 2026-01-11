# uutils rust coreutils

<https://uutils.github.io/>

The uutils project reimplements ubiquitous command line utilities in Rust.  
Our goal is to modernize the utils, while retaining full compatibility with the existing utilities.

There is an older version of uutils as official Debian Trixie package: [rust-coreutils (0.0.30-2)](https://packages.debian.org/trixie/rust-coreutils)

But the newer versions are on GitHub:

<https://github.com/uutils/coreutils/releases>
<https://github.com/uutils/coreutils/releases/download/0.5.0/coreutils-0.5.0-x86_64-unknown-linux-musl.tar.gz>

cd usr/bin
- move the file `coreutils` here
chmod +x coreutils
./coreutils

https://luana.dev.br/2023/10/01/uutils-rules.html

uutils-installer.sh:

```bash
commandsuu="[ arch b2sum b3sum base32 base64 basename basenc cat chgrp chmod chown chroot cksum comm cp csplit cut date dd df dir dircolors dirname du echo env expand expr factor false fmt fold groups hashsum head hostid hostname id install join kill link ln logname ls md5sum mkdir mkfifo mknod mktemp more mv nice nl nohup nproc numfmt od paste pathchk pinky pr printenv printf ptx pwd readlink realpath relpath rm rmdir seq sha1sum sha224sum sha256sum sha3-224sum sha3-256sum sha3-384sum sha3-512sum sha384sum sha3sum sha512sum shake128sum shake256sum shred shuf sleep sort split stat stdbuf stty sum sync tac tail tee test timeout touch tr true truncate tsort tty uname unexpand uniq unlink uptime users vdir wc who whoami yes"

for i in $commandsuu; do
    coreutils rm -f /usr/bin/$i
    coreutils ln -s /usr/bin/coreutils /usr/bin/$i
done

echo done
```

zsh-completions.sh:

```bash
commandsuu="coreutils base32 base64 basename basenc cat cksum comm cp csplit cut date dd df dir dircolors dirname du echo env expand expr factor false fmt fold hashsum md5sum sha1sum sha224sum sha256sum sha384sum sha512sum sha3sum sha3-224sum sha3-256sum sha3-384sum sha3-512sum shake128sum shake256sum b2sum b3sum head join link ln ls mkdir mktemp more mv nl numfmt od paste pr printenv printf ptx pwd readlink realpath relpath rm rmdir seq shred shuf sleep sort split sum tac tail tee touch tr true truncate tsort unexpand uniq unlink test vdir wc yes"

for i in $commandsuu; do
    cargo run completion $i bash > /usr/share/bash-completion/completions/$i
    cargo run completion $i zsh > /usr/share/zsh/site-functions/_$i
done
```

manpage.sh:

```bash
commandsuu="coreutils base32 base64 basename basenc cat cksum comm cp csplit cut date dd df dir dircolors dirname du echo env expand expr factor false fmt fold hashsum md5sum sha1sum sha224sum sha256sum sha384sum sha512sum sha3sum sha3-224sum sha3-256sum sha3-384sum sha3-512sum shake128sum shake256sum b2sum b3sum head join link ln ls mkdir mktemp more mv nl numfmt od paste pr printenv printf ptx pwd readlink realpath relpath rm rmdir seq shred shuf sleep sort split sum tac tail tee touch tr true truncate tsort unexpand uniq unlink test [ vdir wc yes"

for i in $commandsuu; do
    cargo run manpage $i > /usr/local/man/man1/$i.1
done
```



