#ifndef __SYSTEM_H
#define __SYSTEM_H

/* KERNEL.C */
extern void *memcpy(unsigned char *dest, const unsigned char *src, int count);
extern void *memset(unsigned char *dest, unsigned char val, int count);
extern unsigned short *memsetw(unsigned short *dest, unsigned short val, int count);
extern size_t strlen(const char *str);
extern unsigned char inportb (unsigned short _port);
extern void outportb (unsigned short _port, unsigned char _data);

extern void cls();
extern void putch(unsigned char c);
extern void puts(unsigned char *str);
extern void init_video();

#endif
