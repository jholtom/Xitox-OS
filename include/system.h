#ifndef __SYSTEM_H
#define __SYSTEM_H

typedef int size_t

/* KERNEL.C */
extern size_t strlen(const char *str);
extern void *memcpy(void *dest, const void *src, size_t count);
extern void *memset(void *dest, char val, size_t count);
extern unsigned short *memsetw(unsigned short *dest, unsigned short val, size_t count);
extern unsigned char inportb (unsigned short _port);
extern void outportb (unsigned short _port, unsigned char _data);

extern void cls();
extern void putch(unsigned char c);
extern void puts(unsigned char *str);
extern void init_video();

#endif
