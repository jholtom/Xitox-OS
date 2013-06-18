#include <monitor.h>
#include <descriptor_tables.h>
#include <timer.h>
#include <paging.h>
#include <multiboot.h>
#include <fs.h>
#include <initrd.h>
#include <kb.h>

extern u32int placement_address;

int main(struct multiboot *mboot_ptr)
{
    init_descriptor_tables();
    // Initialise the screen (by clearing it)
    monitor_clear();
    monitor_write("Welcome to XitoxOS.\n\n");
    monitor_write("*     Bootup in progress......\n");
    // Find the location of our initial ramdisk.
    ASSERT(mboot_ptr->mods_count > 0);
    u32int initrd_location = *((u32int*)mboot_ptr->mods_addr);
    u32int initrd_end = *(u32int*)(mboot_ptr->mods_addr+4);
    // Don't trample our module with placement accesses, please!
    placement_address = initrd_end;
    __asm__ __volatile__("sti");
    // Start paging.
    monitor_write("*     Initializing paging\n");
    initialise_paging();
    monitor_write("*     Loading initial ramdisk\n");
    // Initialise the initial ramdisk, and set it as the filesystem root.
    fs_root = initialise_initrd(initrd_location);
    // list the contents of / - Disable for now while fixing keyboard - TODO: move into seperate method to be called by kernel shell
    /*monitor_write("*     Listing contents of initial ramdisk\n\n");
    int i = 0;
    struct dirent *node = 0;
    while ( (node = readdir_fs(fs_root, i)) != 0)
    {
        monitor_write("Found file ");
        monitor_write(node->name);
        fs_node_t *fsnode = finddir_fs(fs_root, node->name);

        if ((fsnode->flags&0x7) == FS_DIRECTORY)
        {
            monitor_write("\n\t(directory)\n");
        }
        else
        {
            monitor_write("\n\t contents: \"\n");
            char buf[256];
            u32int sz = read_fs(fsnode, 0, 256, buf);
            int j;
            for (j = 0; j < sz; j++)
                monitor_put(buf[j]);
            
            monitor_write("\"\n");
        }
        i++;
    }*/
    monitor_write("*     Initializing Timer\n");
    timer_install();
    //init_timer(50);
    monitor_write("*     Activating keyboard\n");
    init_keyboard_driver();
  for(;;)
  {
      char c = keyboard_getchar();
      if (c)
          monitor_put(c);
  }       
    return 0;
}
