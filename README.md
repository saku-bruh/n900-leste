# Nokia N900 Maeme 7 (Leste) Optimizations

Some of this repo will follow the guide at:

https://leste.maemo.org/Nokia_N900

You MUST have a SDXC U3 microSD Card. (Because the system is very slow with Class 10 U1 cards, and this guide will make you use ZRAM)

On a first boot I recommend leaving the device for 3-5 minutes, then rebooting and connecting to a wireless network.

## Prerequisites
Run this command
```sudo nano /etc/apt/sources.list```

Add the following entry at the bottom

```deb https://maedevu.maemo.org/leste chimaera-devel main contrib non-free  n900```

And do NOT remove any other entries

Afterwards run

```sudo apt update && sudo apt upgrade && sudo apt dist-upgrade```

```sudo apt install cpufrequtils zram-tools```

## RAM optimizations

The N900 tends to OOM on more RAM heavy apps

```sudo nano /etc/default/zramswap```

(From here on you can use the text editor of your choice since we dist-upgraded, but this guide will assume you use nano as the default)

Change the following

```ALGO``` to ```zstd```

```SIZE``` to ```3072```

```PRIORITY``` to ```-3```

Then edit ```/etc/fstab``` and remove the comment (AKA the #) from /dev/mmcblk1p3
Change the /swap to /dev/zram0

Then reboot, the ZRAM will be activated, you can check if you have 3.75GB of swap via ```htop``` or with ```sudo swapon --show```. (3GB of swap from the microSD Card, 765MB of swap from the eMMC storage)

## CPU optimizations

Out of the box, Leste runs pretty choppy and this section will focus on fixing that (mostly, can't do much about the single-core chip from 2009 being slow)

```git clone https://github.com/saku-bruh/n900-leste```

```cd n900-leste```

Now, here's where it gets interesting as some units can't run at 805MHz (https://leste.maemo.org/Nokia_N900#Overclocking_.28optional.29) so run the n900-init.sh manually with the following commands:

```chmod +x n900-init.sh```

```sudo su```

```sh n900-init.sh```

If you notice no issues then you can do the following

```cp n900-init.sh /home/user```

```chmod +x /home/user/n900-init.sh```

However, if the device reboots or anything ususual happens (I don't know what happens exactly because my unit can run @ 805MHz just fine and can OC to 1.1GHz on Fremantle) do the following instead

```cp n900-init-binned.sh /home/user/n900-init.sh```

```chmod +x /home/user/n900-init.sh```

After you have done all of the steps above run

```crontab -e```

Press 1 and then press enter

and then add the following at the bottom of the list

```@reboot /home/user/n900-init.sh```

then press Ctrl + X and then press Y and enter

# Power Management optimizations

```sudo nano /etc/modprobe.d/blacklist-pm.conf```

Change

```#blacklist omap_hdq```

to

```blacklist omap_hdq```

and then run these commands

```sudo cp scripts/openrc/n900-pm /etc/init.d```

```sudo chmod +x /etc/init.d/n900-pm```

Then reboot!

## UI optimizations

Blur slows down Maemo quite a bit but we can change all of the following values to the ones below for quite a good speed boost (Also you can use Ctrl + W on nano to search for the entries and just change the values)

```sudo nano /usr/share/hildon-desktop/transitions.ini```

Values

```radius = 0.1```

```radius_more = 0.1```

```brightness = 0.2```

```taskswitcher = 2``` (If you want, not needed but I prefer this)

Credits

https://leste.maemo.org/Nokia_N900

https://github.com/maemo-leste/n900-pm (For the power management script)
