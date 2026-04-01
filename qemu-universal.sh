#!/bin/bash
sudo apt-get install desktop-file-utils debootstrap schroot perl git wget xz-utils bubblewrap autoconf coreutils
wget -q "https://github.com/VHSgunzo/uruntime/releases/download/v0.5.7/uruntime-appimage-dwarfs-x86_64" -O uruntime && chmod a+x uruntime
wget -c "https://archive.archlinux.org/iso/"
cat index.html | tail -n 3 | awk '{print $2}' | cut -d "/" -f 1 | cut -d "\"" -f 2 | xargs -i -t -exec wget -r --no-parent -np -l 1 -A "*.zst" -erobots=off -P . "https://archive.archlinux.org/iso/{}/archlinux-bootstrap-x86_64.tar.zst"
find ${GITHUB_WORKSPACE} -name '*.zst' | xargs -i -t -exec mv {} ${GITHUB_WORKSPACE}
mkdir arch
tar xf archlinux-bootstrap-x86_64.tar.zst -C ./arch/
# criar no github uma nova pasta parao AppRun e demais arquivos.
cp /etc/resolv.conf -t ${GITHUB_WORKSPACE}/arch/root.x86_64/etc/ && cp ${GITHUB_WORKSPACE}/files/mirrorlist -t ${GITHUB_WORKSPACE}/arch/root.x86_64/etc/pacman.d/ && cp ${GITHUB_WORKSPACE}/files/pacman.conf -t ${GITHUB_WORKSPACE}/arch/root.x86_64/etc/
cd ${GITHUB_WORKSPACE}
sudo chroot ./arch/root.x86_64/ /bin/bash -c "pacman -Syyu --noconfirm && pacman -S qemu-full jack2 --noconfirm && pacman -Scc --noconfirm && rm -rf /var/cache/pacman/pkg/* && exit"
cp ${GITHUB_WORKSPACE}/files/AppRun ${GITHUB_WORKSPACE}/arch/ && chmod a+x ${GITHUB_WORKSPACE}/arch/AppRun && cp ${GITHUB_WORKSPACE}/files/qemu.svg -t ${GITHUB_WORKSPACE}/arch/ && cp ${GITHUB_WORKSPACE}/files/qemu.desktop -t ${GITHUB_WORKSPACE}/arch/
mv ${GITHUB_WORKSPACE}/arch/root.x86_64/ ${GITHUB_WORKSPACE}/arch/root/
find ${GITHUB_WORKSPACE}/arch/root/usr/bin/ -type f -exec strip {} +
find ${GITHUB_WORKSPACE}/arch/root/usr/lib/ -type f -exec strip {} \;
./uruntime --appimage-mkdwarfs -f \
    --set-owner 0 --set-group 0 \
    --no-history --no-create-timestamp \
    --compression zstd:level=15 -S22 -B20 \
    --header uruntime \
    -i "./arch" -o "QEMU-x86_64.AppImage"
