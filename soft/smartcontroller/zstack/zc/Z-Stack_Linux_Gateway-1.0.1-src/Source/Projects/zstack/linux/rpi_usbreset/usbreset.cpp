#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include <errno.h>
#include <sys/ioctl.h>

#include <libusb/libusb.h>
#include <linux/usbdevice_fs.h>

char *USB_PATH = "/dev/bus/usb/%03d/%03d";
//char *USB_PATH = "/dev/bus/usb/001/01%d";

int resetUSB(int bus, int dev)
{
    char filename[255];;
    int fd;
    int rc=1;

    sprintf(filename, USB_PATH, bus, dev);
    //sprintf(filename, USB_PATH, dev);

    fprintf(stderr, "Resetting USB device %s\n", filename);
    fd = open(filename, O_WRONLY);
    if (fd < 0) {
        perror("resetUSB::Error opening output file");
        return -1;
    }

    rc = ioctl(fd, USBDEVFS_RESET, 0);

    if (rc < 0) {
        perror("resetUSB::Error in ioctl");
        return -1;
    }


    close(fd);

    return rc;
}


int get_dev(libusb_device **devs, unsigned int vendorId, unsigned int productId)
{
       libusb_device *dev;
       int i = 0;

       while ((dev = devs[i++]) != NULL) {
              struct libusb_device_descriptor desc;
              int r = libusb_get_device_descriptor(dev, &desc);
              if (r < 0) {
                     fprintf(stderr, "failed to get device descriptor");
                     return -1;
              }

              if(desc.idVendor == vendorId && desc.idProduct == productId) {
                 return libusb_get_device_address(dev);
              }
       }

       return -1;
}

int get_dev(unsigned int vendorId, unsigned int productId)
{
       libusb_device **devs;
       int r;
       ssize_t cnt;

       r = libusb_init(NULL);
       if (r < 0) return r;

       cnt = libusb_get_device_list(NULL, &devs);
       if (cnt < 0)
              return (int) cnt;

       //print_devs(devs);
       int dev = get_dev(devs, 0x0451, 0x16a8);
       if(dev < 0) {
          dev = get_dev(devs, 0x0451, 0x16a0);
       }
       libusb_free_device_list(devs, 1);
       libusb_exit(NULL);

       return dev;
}
void printUsage(char *cmd)
{
   fprintf(stderr, "%s\n", cmd);
}


int main(int argc, char *argv[])
{
   if(argc != 1) {
      printUsage(argv[0]);
      return -1;
   }

  int dev = get_dev(0x0451, 0x16a8); 

   resetUSB(1, dev);
}
