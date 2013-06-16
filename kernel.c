#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>
#include <system.h>

#if defined(__linux__)
#error "Need a crosscompiler. probably should get one. Unless you love errors!"
#endif

size_t strlen(const char* str)
{
        size_t ret = 0;
        while ( str[ret] != 0 )
                ret++;
        return ret;
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

void kernel_main()
{
        init_video();
        puts("Welcome to XitoxOS. \n");
        puts("> ");
}
