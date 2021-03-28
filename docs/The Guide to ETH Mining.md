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

Copy the public key string into the file below and then save/close the the file.

```
mkdir -p ~/.ssh
sudo nano ~/.ssh/authorized_keys
```

Then update the permissions of the file to allow SSH to work.

```
sudo chmod 0600 ~/.ssh/authorized_keys
```

**Test it**

At this point, you should be able to authenticate to your server using the private key.  Check it is working.

**Disable Password Authentication**

The final step is to secure your server even further by disabling the text password log in.  This is to ensure that only people with the private key can log into the server.  Password security is good, but certainly not as secure as keys.

```
sudo nano /etc/ssh/sshd_config
```

Locate the following lines and change them to the below:

```
PasswordAuthentication no
ChallengeResponseAuthentication no
```

**Restart SSH**

```
sudo systemctl restart ssh
```


## NVIDIA Software

The next very important step is to configure all the NVIDIA Software.  This includes the driver and CUDA.  Both are vital to the mining operation.

### The Driver

The most reliable way to install the NVIDIA Driver is to download the Linux Run File from the NVIDIA Website.  This ensures you have the latest driver and will not run into any problems in the future.  The pre-built Ubuntu Driver tends to be older and can without reason stop working.

Go to: https://www.nvidia.com/Download/index.aspx to find the driver on your computer (not the server, we disabled the GUI).

Make sure to select the correct operation system and card type.  Click on "Search".  Then click "Download" next to the desired driver.

The trick here is to now copy the link of the second "Download" button that appears.  Then we can use wget to download the file on the server.  

```
wget https://us.download.nvidia.com/XFree86/Linux-x86_64/460.67/NVIDIA-Linux-x86_64-460.67.run
```

After the download completes, change the permissions on it so that it can be executed.

```
sudo chmod 755 NVIDIA-Linux-x86_64-460.67.run
```

And then run the downloaded file.

```
sudo ./NVIDIA-Linux-x86_64-460.67.run
```

You will be presented with a number of prompts throughout the installation process.  A brief outline of these are below.

- Continue
- Continue
- Only 64 Bit (No)

After this, you should be able to check that the driver installed successfully by typing `nvidia-smi` and see all your GPUs listed.


### CUDA

Similarly to the NVIDIA Driver, it is recommended that you install the latest CUDA using the run file instead of the pre-built version through Ubuntu.

Go to: https://developer.nvidia.com/cuda-downloads and select the below options:

- Operating System: Ubuntu
- Architecture: x86_64
- Distribution: Ubuntu
- Version: 20.04 
- Installer Type: runfile(local)

Copy the wget command that appears below the options into the server.

```
wget https://developer.download.nvidia.com/compute/cuda/11.2.2/local_installers/cuda_11.2.2_460.32.03_linux.run
```

Once the Download has completed, change the permissions so that the file can be executed and run it.

```
sudo chmod 755 cuda_11.2.2_460.32.03_linux.run
sudo sh cuda_11.2.2_460.32.03_linux.run
```

There will be some options that come up that can be customised.

- Install Driver: No

The other options can be kept as default.


### CUDA - post install

Add the CUDA directory to path and Add the Library LD path to .bashrc

```
## For CUDA
export PATH=$PATH:/usr/local/cuda-11.2/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.2/lib64
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.2/lib
```


Once complete, you can test the install using `nvcc --version`


That should be all for the NVIDIA Driver and CUDA set up.


## Selecting a Miner!

This is a step where you are open to options.  The miner you choose will depending on your setup and preferences.  The options are outlined below.

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
