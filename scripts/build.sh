echo "Modifying PATH for crosscompiler"
export PATH="/home/jholtom/Projects/buildtools/local/bin:$PATH"
echo "Assembling multiboot header"
#i586-elf-as -o boot.o boot.s
nasm -f elf -o boot.o ../boot/boot.s
nasm -f elf -o gdt.o ../kernel/gdt.s
nasm -f elf -o interrupt.o ../kernel/interrupt.s
echo "Building Kernel"
i586-elf-gcc -c ../kernel/main.c -o main.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/common.c -o common.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/fs.c -o fs.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/descriptor_tables.c -o descriptor_tables.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/initrd.c -o initrd.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/kheap.c -o kheap.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/monitor.c -o monitor.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/ordered_array.c -o ordered_array.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/timer.c -o timer.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/paging.c -o paging.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
i586-elf-gcc -c ../kernel/isr.c -o isr.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I../kernel/include -w
echo "Linking kernel and headers"
i586-elf-gcc -T ../kernel/linker.ld -o ../build/xitox.kern -ffreestanding -O2 -nostdlib boot.o main.o common.o fs.o descriptor_tables.o initrd.o kheap.o ordered_array.o monitor.o timer.o paging.o isr.o gdt.o interrupt.o -lgcc
echo "Moving files around"
cp build/xitox.kern isodir/boot/xitox.kern
echo "Building grub boot image"
grub2-mkrescue -o ../build/XitoxOS.iso isodir >/dev/null 2>/dev/null
echo "Cleaning up..."
rm *.o
echo "Kernel executable is located at build/xitox.kern"
echo "================================================"
echo "ISO is located at build/XitoxOS.iso"
echo "Executing floppy image updater"
./update_image.sh
echo "Floppy image is at build/floppy.img"
