echo "Modifying PATH for crosscompiler"
export PATH="/home/jholtom/Projects/buildtools/local/bin:$PATH"
echo "Assembling multiboot header"
#i586-elf-as -o boot.o boot.s
nasm -f elf -o boot.o boot.s
nasm -f elf -o gdt.o gdt.s
nasm -f elf -o interrupt.o interrupt.s
echo "Building Kernel"
i586-elf-gcc -c main.c -o main.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c common.c -o common.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c fs.c -o fs.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c descriptor_tables.c -o descriptor_tables.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c initrd.c -o initrd.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c kheap.c -o kheap.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c monitor.c -o monitor.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c ordered_array.c -o ordered_array.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c timer.c -o timer.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c paging.c -o paging.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c isr.c -o isr.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
echo "Linking kernel and headers"
i586-elf-gcc -T linker.ld -o xitox.kern -ffreestanding -O2 -nostdlib boot.o main.o common.o fs.o descriptor_tables.o initrd.o kheap.o ordered_array.o monitor.o timer.o paging.o isr.o gdt.o interrupt.o -lgcc
echo "Moving files around"
mv xitox.kern build/xitox.kern
cp build/xitox.kern isodir/boot/xitox.kern
echo "Building grub boot image"
grub2-mkrescue -o build/XitoxOS.iso isodir >/dev/null 2>/dev/null
echo "Cleaning up..."
rm *.o
echo "Kernel executable is located at build/xitox.kern"
echo "================================================"
echo "ISO is located at build/XitoxOS.iso"
echo "Executing floppy image updater"
./update_image.sh
echo "Floppy image is at build/floppy.img"
