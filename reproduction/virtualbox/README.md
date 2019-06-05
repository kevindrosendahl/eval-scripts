# Virtual Box Setup (if not using Vagrant)

## Setup

1) Create new virtual machine using VirtualBox running Ubunutu 17.10.

- VirtualBox (https://www.virtualbox.org/wiki/Downloads)

- Ubuntu 17.10 (http://old-releases.ubuntu.com/releases/17.10/)

- Setup tutorial (https://itsfoss.com/install-linux-in-virtualbox/)

2) Replace source-urls to use old 17.10 compatible options:<br />
`sudo sed -i -e 's/us.archive.ubuntu.com\|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list
`<br /><br />
(verify all urls in /etc/apt/sources.list are now set to "old-releases")

3) Verify connected to internet:<br />
`ping google.com`

4) Updates:<br />
`sudo apt-get update`

5) Install primary dependencies:<br />
`sudo apt install git`<br />
`sudo apt install curl`

6) Clone git repo:<br />
`git clone https://github.com/kevindrosendahl/eval-scripts.git`

7) Install dependencies:<br />
`cd eval-scripts && sudo ./ccp-system-setup.sh`<br />
`rm -r rust.install.sh`<br />
`curl https://sh.rustup.rs -sSf > rust.install.sh`<br />
`chmod +x ./rust.install.sh`<br />
`su -c "./rust.install.sh -y -v --default-toolchain nightly" your_username`<br />

8) Build (reload terminal to ensure `cargo` in path):<br />
`make`<br />
`cd ccp-kernel && sudo ./ccp_kernel_load ipc=0`

9) See `reproduction` directory for our testing scripts and results.

Further info here https://ccp-project.github.io/guide/setup/index.html



