import os
import sys

def gpioExport(gpio):

    gpio = str(gpio)

    fileDescriptor = os.open("/sys/class/gpio/export", os.O_WRONLY)

    if (fileDescriptor < 0):
        print("gpioExport error, unable to open gpio " + gpio)
        return fileDescriptor

    temp = gpio.encode()

    if (os.write(fileDescriptor, temp) != len(gpio)):
        print("Not able to write in gpioExport to gpio " + gpio)
        return fileDescriptor

    os.close(fileDescriptor)

    return 0


def gpioUnexport(gpio):

    gpio = str(gpio)

    fileDescriptor = os.open("/sys/class/gpio/unexport", os.O_WRONLY)

    if (fileDescriptor < 0):
        print("gpioUnexport error, unable to open gpio " + gpio)
        return fileDescriptor

    temp = gpio.encode()

    if (os.write(fileDescriptor, temp) != len(gpio)):
        print("Not able to write in gpioUnexport to gpio " + gpio)
        return fileDescriptor

    os.close(fileDescriptor)

    return 0


def gpioSetDirection(gpio, out_flag):

    gpio = str(gpio)

    fileDescriptor = os.open("/sys/class/gpio/gpio" + gpio + "/direction", os.O_WRONLY)

    if (fileDescriptor < 0):
        print("gpioSetDirection unable to open gpio " + gpio)
        return fileDescriptor


    if (out_flag):
        temp = "out".encode()
        if (os.write(fileDescriptor, temp) != 3):
            print("Not able to write out to gpio " + gpio)
            return fileDescriptor
    else:
        temp = "in".encode()
        if (os.write(fileDescriptor, temp) != 2):
            print("Not able to write in to gpio " + gpio)
            return fileDescriptor

    os.close(fileDescriptor)

    return 0

def gpioSetValue(gpio, value):

    gpio = str(gpio)

    fileDescriptor = os.open("/sys/class/gpio/gpio" + gpio + "/value", os.O_WRONLY)


    if (fileDescriptor < 0):
        print("gpioSetValue unable to open gpio " + gpio)
        return fileDescriptor

    if (value):
        temp = "1".encode()
        if (os.write(fileDescriptor, temp) != 1):
            print("Not able to set value 1 to gpio " + gpio)
            return fileDescriptor
    else:
        temp = "0".encode()
        if (os.write(fileDescriptor, temp) != 1):
            print("Not able to set value 0 to gpio " + gpio)
            return fileDescriptor

    os.close(fileDescriptor)

    return 0


def gpioGetValue(gpio):

    gpio = str(gpio)

    fileDescriptor = os.open("/sys/class/gpio/gpio" + gpio + "/value", os.O_RDONLY)


    if (fileDescriptor < 0):
        print("gpioSetValue unable to open gpio " + gpio)
        return fileDescriptor

    value = os.read(fileDescriptor, 1)

    value = value.decode()

    if (value != "0"):
        value = "1"

    value = int(value)

    os.close(fileDescriptor)

    return 0, value


def gpioActiveLow(gpio, value):

    gpio = str(gpio)

    fileDescriptor = os.open("/sys/class/gpio/gpio" + gpio + "/active_low", os.O_WRONLY)


    if (fileDescriptor < 0):
        print("gpioActiveLow unable to open gpio " + gpio)
        return fileDescriptor

    if (value):
        temp = "1".encode()
        if (os.write(fileDescriptor, temp) != 1):
            print("Not able to set value 1 to gpio " + gpio)
            return fileDescriptor
    else:
        temp = "0".encode()
        if (os.write(fileDescriptor, temp) != 1):
            print("Not able to set value 0 to gpio " + gpio)
            return fileDescriptor

    os.close(fileDescriptor)

    return 0

