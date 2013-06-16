echo "Modifying PATH for crosscompiler"
export PATH="/home/jholtom/Projects/buildtools/local/bin:$PATH"
echo "Assembling multiboot header"
i586-elf-as -o boot.o boot.s
echo "Building Kernel"
i586-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
echo "Linking kernel and headers"
i586-elf-gcc -T linker.ld -o xitox.kern -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
echo "Moving files around"
mv xitox.kern build/xitox.kern
cp build/xitox.kern isodir/boot/xitox.kern
echo "Building grub boot image"
grub2-mkrescue -o build/XitoxOS.iso isodir
echo "Cleaning up..."
rm *.o
echo "Kernel executable is located at build/xitox.kern"
echo "================================================"
echo "ISO is located at build/XitoxOS.iso"
