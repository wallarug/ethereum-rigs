# The Ultimate Guide to ETH mining on Ubuntu

This guide outlines how to set up a Ubuntu Machine to mine the cryptocurreny Ethereum.  Currently Windows 10 is the most popular OS to run and maintain Ethereum mining rigs, however, Ubuntu is easier once you have it up and running.


## The OS

Choose the latest stable Ubuntu LTS OS.  One without any extra features is the best (like the server edition).  

For this guide, I choose Ubuntu 20.04.2 as that was the latest OS as of writing.


## Installation of Ubuntu

Follow all the default steps for the installation.  There is nothing special that needs to be done during installation.


## Post Install Steps

### Install Software

You will want to get a number of different software packages installed to get up and running.  These are listed below.

```
sudo apt update
sudo apt install gcc make openssh-server openssh-client
```

You need the gcc and make tool so that you can build and install the GPU drivers later.  The OpenSSH Server will allow remote access to your mining rig(s).  The client will allow you to connect to other rigs as well.

It would be worth while to update your Ubuntu as well at this stage to ensure you have the latest software.

```
sudo apt upgrade
```

### Configure Software

At this point, I would recommend turning off the system GUI.  You don't need it from here on and it will create problems later on.

```
sudo systemctl set-default multi-user.target
```

This will turn off the GUI on next boot.  There are additional steps if you want the computer to boot normally into text mode, but they are not necessary as all of the time you will be using SSH instead of the physical monitor attached to the device.  These steps are optional and outlined below.

1. Open terminal and run command to backup the configuration file:

```
sudo cp -n /etc/default/grub /etc/default/grub.backup
```

2. Edit the configuration file via command:

```
sudo gedit /etc/default/grub
```

When the file opens, do:

```
disable GRUB_CMDLINE_LINUX_DEFAULT="quiet splash" by adding # at the beginning.
set GRUB_CMDLINE_LINUX="" to GRUB_CMDLINE_LINUX="text"
remove # from the line GRUB_TERMINAL="console" to disable graphical terminal.
```

3. Save the file and apply changes by running command:

```
sudo update-grub
```


### Set Up SSH

SSH is absolutely key to getting your mining setup operational.  Without SSH you will need to physically be next to the computer.  SSH allows remote access and management of your mining rig(s).

SSH was already installed at the [Install Software](#Install Software) step above.  We just need to configure it.

It will be running automatically after the installation.  However, you probably want to secure your mining rig(s) more than just using a password.  It is well worth while to set up a Private-Public key to secure your rig(s).  These steps are outlined below in more detail.

**Create Private-Public Key**

My personal choice is to create the private key on my own computer and then copy the public key component to the remote host (mining rig).  This ensures that the private key is secure and only located in one place.  I've written these instructions from a Ubuntu and Windows point of view.  There are tonnes of other guides out there for doing this, so this will be brief.

__Ubuntu__

Make sure to not override any existing private key.  Rename the old private key before continuing.

```
ssh-keygen
```

You will be asked for a password.  It is recommended that you use a password.

__Windows__

Using puttygen.exe

- Change the number of bits from 2048 to 4096
- Click "Generate"
- Give a description to the key
- Save the Private Key
- Save the Public Key
- Create a separate text file with the Public Key in the 'Key' field.


**Adding The Public Key to the Server**





## Eth Mining Software Setup

WIP

## TODO

* work out modding GPU speeds

**Pre-req:**

i.  Set up a wallet

ii.  Choose a mining pool


## Install NVIDIA Driver

NOTE:  It appears that Ubuntu 20.04 automatically installs and configures the NVIDIA Driver (460.0) without any need to use the custom installer.  This is enabled when installing by ticking the 'install 3rd party drivers'.

To update the driver:  `sudo apt install nvidia-driver-460`

Option 2: Manual From Run File:

```
sudo apt install gcc make
```


## Install CUDA 11.2+

Option 1: Download the latest CUDA package from the NVIDIA website.  You may need to use a non-linux computer to get the link.  Then you can use wget to download the program.  Make sure to chmod 755 the CUDA run file.

Option 2:  It appears that Ubuntu 20.04 can install the CUDA library from apt using the following command:  `sudo apt install nvidia-cuda-toolkit` without a need for the run file.  Note this will install the older version of CUDA (10.1) which may not be ideal for what is needed.

```
sudo apt install gcc
```

#### Post Install

Add the cuda directory to path and Add the Library LD path to .bashrc

```
## For CUDA
export PATH=$PATH:/usr/local/cuda-11.2/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.2/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.2/lib
```


## Download Eth Miner

* Claymore Duel Miner [here](https://github.com/Claymore-Dual/Claymore-Dual-Miner):  Has a 1% dev fee
* Phoenix Miner [here](https://phoenixminer.org/):  Has a 0.65% dev fee
* Ethminer [here](https://github.com/ethereum-mining/ethminer):  Has no dev fee

Each needs their own configuration file and has their own setups.


## Configure Miner and Mine!

- Testing with RTX 2070 Super (Max)
- Room Temp:  24 degrees (AC on, Window Open)
- gdm service stopped (give about 0.5 MH/s performance boost)

| Claymore Duel | Phoenix Miner | Ethminer |
|--|--|--|
| 36.095 MH/s | 36.103 MH/s | 35.57 MH/s |

## Card Expected Rates

3090 - 105 MH/s (120+ MH/s with mods)
3070 - 50 MH/s (60+ MH/s with mods)


## Set Up SSH

1.  Generate key pair
2.  Put Public Key into ./ssh/authorized_keys
3.  chmod 600 ./ssh/authorized_keys
4.  chown user:user ./ssh/authorized_keys
5.  Edit the file /etc/ssh/sshd_config to contain `PasswordAuthentication no` and `ChallengeResponseAuthentication no`
6.  Restart SSH:  `sudo systemctl restart ssh`


## Leaving a session running

Use TMUX
```
sudo apt install tmux
tmux
Ctrl D then B
```

## Mods for Cards

On Windows:  use MSI afterburner.  Set the Card Frequency to 1200 MHz.  Set the Memory to +250 or higher depending on cooling.  100 degrees is the stable temp.
