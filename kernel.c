#if !defined(__cplusplus)
#include <stdbool.h> /* C doesn't have booleans by default. */
#endif
#include <stddef.h>
#include <stdint.h>
<<<<<<< HEAD
#include < system.h >

=======
 
>>>>>>> parent of 74ac261... Update kernel.c
#if defined(__linux__)
#error "Need a crosscompiler. probably should get one. Unless you love errors!"
#endif

void *memcpy(void *dest, const void *src, size_t count)
{
        const char *sp = (const char *)src;
        char *dp = (char *)dest;
        for(; count != 0; count--) *dp++ = *sp++;
        return dest;
}

void *memset(void *dest, char val, size_t count)
{
        char *temp = (char *)dest;
        for( ; count != 0; count--) *temp++ = val;
        return dest;
}

unsigned short *memsetw(unsigned short *dest, unsigned short val, size_t count)
{
        unsigned short *temp = (unsigned short *)dest;
        for( ; count != 0; count--) *temp++ = val;
        return dest;
}

size_t strlen(const char *str)
{
        size_t retval;
        for(retval = 0; *str != '\0'; str++) retval++;
        return retval;
}

unsigned char inportb (unsigned short _port)
{
        unsigned char rv;
        __asm__ __volatile__ ("inb %1, %0" : "=a" (rv) : "dN" (_port));
        return rv;
}

void outportb (unsigned short _port, unsigned char _data)
{
        __asm__ __volatile__ ("outb %1, %0" : : "dN" (_port), "a" (_data));
}

#if defined(__cplusplus)
extern "C" /* Use C linkage for kernel_main. */
#endif
void kernel_main()
{
        gdt_install();
        idt_install();
        isrs_install();
        irq_install();
        init_video();
        timer_install();
        keyboard_install();

        __asm__ __volatile__ ("sti");

        puts("XitoxOS Loaded\n");

        for(;;);
}












