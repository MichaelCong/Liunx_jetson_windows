import sys
from gpio import *
import time

print("unexporting gpio pins")

pir = 397
led = 398

gpioUnexport(pir)
gpioUnexport(led)


