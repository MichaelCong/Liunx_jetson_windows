import sys
from gpio import *
import time

print("Testing GPIO pins")

pir = 397
led = 398

#gpioUnexport(pir)
gpioExport(pir)
gpioExport(led)

gpioSetDirection(pir, 0)
gpioSetDirection(led, 1)
#gpioActiveLow(led, 1)

ledValue = 0
gpioSetValue(led, 1)


while (True):

    ret, value = gpioGetValue(pir)

    print("Button " + str(value))

    time.sleep(5)

