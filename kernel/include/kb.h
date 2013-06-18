#ifndef KB_H
#define KB_H

#include <common.h>
#include <monitor.h>

char* regs;

// Keyboard driver functions
extern void keyboard_install();
extern char* get_stream(char character);

// Keyboard driver variables
volatile char* buffer2;
volatile char* buffer;        //For storing strings
//volatile u32int kb_count = 0; //Position in buffer
//volatile int gets_flag = 0;
#endif
