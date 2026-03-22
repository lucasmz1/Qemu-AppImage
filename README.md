# Qemu_Appimage
########################################################################
<br> Thank you for sharing this project across the internet! <br/>
<br> If you like it don't forget to give an star. <br/>
<br> By the way this is an unofficial project. <br/>
<br>There are two versions updated and avaiable here, Universal which is intended to work in every linux distro and Jammy which is intended to run in glibc 2.25 and above<br/>
########################################################################


<br> This is a Prove of the concept that is possible to run a virtual machine from an Appimage. <br/>
<br> What is the goal? <br/>
<br> To run QEMU a virtual machine emulator from this container. <br/>

which architectures are possible to run using this appimage? almost all of then which is supported by QEMU.
In this repository you may find a text file with examples for using This QEMU AppImage, of course it's all in portuguese, but no need worries... those commands are the same for every single use of QEMU.
if you had doubts about the use you can find me in Telegram: @zainotel.

<br> useful commands! <br/>

<br> this one bellow creat an hard drive <br/>

<br> `./QEMU-x86_64.AppImage qemu-img create -f qcow2 windows10.qcow2 30G` <br/>

<br> this other example boot the iso file <br/>

<br> `./QEMU-x86_64.AppImage qemu-system-x86_64 -enable-kvm -cpu host -smp cores=2 -m 4G -name 'Manjaro' -boot d -hda ~/Documentos/Manjaro.qcow2 -cdrom ~/Documentos/manjaro-gnome-21.3.7-220816-linux515.iso` <br/>

<br> attention if you're using the version stable or the one which was build from the source you must use this command <br/>

<br> `./QEMU-x86_64.AppImage qemu-system-x86_64 -enable-kvm -M q35 -vga virtio -display gtk,gl=on -cpu host -smp cores=2 -m 1G -name 'teste' -boot d -hda ~/Downloads/organizar/windows10.qcow2 -cdrom ~/Documentos/AppImage/TinyCorePure64-14.0.iso` <br/>

<br> the option `-vga virtio -display gtk,gl=on` will enable the gtk interface instead of vnc or if you didn't like gtk window you can change to sdl. the network is working normaly. <br/>

<br> the audio is working use this command to get audio outoput in HDMI monitor or TV <br/>

<br> `./QEMU-git.AppImage qemu-system-x86_64 -enable-kvm -M q35 -vga virtio -display gtk,gl=on -cpu host -smp cores=2 -m 1G -name 'teste' -boot d -hda ~/Downloads/organizar/windows10.qcow2 -cdrom ~/Downloads/organizar/bodhi.iso -device ich9-intel-hda,addr=1f.1 -audiodev pa,id=snd0 -device hda-output,audiodev=snd0` <br/>

########################################################################
<br> How to mount the qcow2 image on your system in order to add files or edit the VM <br/>
<br> `sudo modprobe nbd max_part=8`  <br/>
<br> `sudo /home/lucas/Downloads/QEMU-x86_64.AppImage qemu-nbd --connect=/dev/nbd0 /home/lucas/Downloads/windows10.qcow2` <br/>
<br> attention in order to use the appimage to run qemu-nbd you may have to give the full path til the .AppImage file <br/>
<br> `sudo fdisk /dev/nbd0 -l` <br/>
<br> `sudo mount /dev/nbd0p1 /mnt/somepoint/` <br/>
<br> Unmount the .qcow2 image <br/>
<br> `sudo umount /mnt/somepoint/` <br/>
<br> `sudo /home/lucas/Downloads/QEMU-x86_64.AppImage qemu-nbd --disconnect /dev/nbd0` <br/>
<br> now remove de nbd <br/>
<br> `sudo rmmod nbd` <br/>
<br> <h3> How to mount a shared folder between the host and guest </h3> <br/>
<br> With this command below you will able to mount a shared folder betwen the vm (guest OS) and your linux system (host OS) <br/>
<br> `QEMU-x86_64.AppImage qemu-system-x86_64 -M q35 -vga virtio -enable-kvm -cpu host -smp cores=2 -m 4G -name 'VM' -boot c -hda ~/Downloads/Xubuntu.qcow2 -virtfs local,path=/some/path/in/my/machine/hostOS/,mount_tag=host0,security_model=mapped,id=host0` <br/>
<br> the command below must be typed into the the gest os on the terminal <br/>
<br> `sudo mount -t 9p -o trans=virtio,version=9p2000.L host0 /some/folder/into/the/vm/` <br/>
<br> <h1>Telegram Group<h1/> <br/>
<h1>https://t.me/appimagelucasmz1<h1/>
