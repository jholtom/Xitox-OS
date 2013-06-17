echo "Modifying PATH for crosscompiler"
export PATH="/home/jholtom/Projects/buildtools/local/bin:$PATH"
echo "Assembling multiboot header"
i586-elf-as -o boot.o boot.s
echo "Building Kernel"
i586-elf-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c scrn.c -o scrn.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c gdt.c -o gdt.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c idt.c -o idt.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c irq.c -o irq.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c isrs.c -o isrs.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c kb.c -o kb.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
i586-elf-gcc -c timer.c -o timer.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra -I./include -w
echo "Linking kernel and headers"
i586-elf-gcc -T linker.ld -o xitox.kern -ffreestanding -O2 -nostdlib boot.o kernel.o scrn.o gdt.o idt.o irq.o isrs.o kb.o timer.o -lgcc
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
