#include <syscall.h>
#include <isr.h>
#include <monitor.h>

static void syscall_handler(registers_t *regs);

DEFN_SYSCALL1(kprintf, 0, const char*);
DEFN_SYSCALL1(kprintf_hex, 1, const char*);
DEFN_SYSCALL1(kprintf_dec, 2, const char*);
DEFN_SYSCALL1(kclear, 3, const char*);
DEFN_SYSCALL1(kput, 4, char);

static void *syscalls[4] =
{
    &monitor_write,
    &monitor_write_hex,
    &monitor_write_dec,
    &monitor_clear,
    &monitor_put,
};
u32int num_syscalls = 4;

void initialise_syscalls()
{
    // Register our syscall handler.
    register_interrupt_handler (0x80, &syscall_handler);
}

void syscall_handler(registers_t *regs)
{
    // Firstly, check if the requested syscall number is valid.
    // The syscall number is found in EAX.
    if (regs->eax >= num_syscalls)
        return;

    // Get the required syscall location.
    void *location = syscalls[regs->eax];

    // We don't know how many parameters the function wants, so we just
    // push them all onto the stack in the correct order. The function will
    // use all the parameters it wants, and we can pop them all back off afterwards.
    int ret;
    asm volatile (" \
      push %1; \
      push %2; \
      push %3; \
      push %4; \
      push %5; \
      call *%6; \
      pop %%ebx; \
      pop %%ebx; \
      pop %%ebx; \
      pop %%ebx; \
      pop %%ebx; \
    " : "=a" (ret) : "r" (regs->edi), "r" (regs->esi), "r" (regs->edx), "r" (regs->ecx), "r" (regs->ebx), "r" (location));
    regs->eax = ret;
}
