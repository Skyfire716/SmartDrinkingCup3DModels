import sys
import math
from scipy import signal
import numpy as np

modes = ["wave", "triangle", "dots"]
if "width=" not in str(sys.argv) or "height=" not in str(sys.argv):
    sys.exit("You need to supply an width=w and height=h")

if "mode=" not in str(sys.argv):
    sys.exit("You need to supply a mode")
    
width = 0
height = 0
mode = 0
amplitude = 0
frequency = 0
for x in sys.argv:
    if "width=" in x:
        width = int(x.replace("width=", ""))
    if "height=" in x:
        height = int(x.replace("height=", ""))
    if "mode=" in x:
        mode = int(x.replace("mode=", ""))

for x in sys.argv:
    if "amplitude=" in x:
        amplitude = int(x.replace("amplitude=", ""))
    if "frequency=" in x:
        frequency = float(x.replace("frequency=", ""))

if amplitude <= 0 or frequency == 0:
    sys.exit("The amplitude must be > 0 and frequency must be != 0")

f = open(modes[mode] + ".dat", "w")
f.write("#" + modes[mode] + ".dat\n")
for y in range(height):
    for x in range(width):
        if mode == 0:
            f.write(str(amplitude + amplitude * math.sin(y * frequency)) + " ")
        elif mode == 1:
            f.write(str(amplitude + amplitude * signal.sawtooth(2 * np.pi * frequency * y)) + " ")
        elif mode == 2:
            f.write(str(amplitude + (amplitude * math.sin(y * frequency) + amplitude * math.sin(x * frequency)) / 2) + " ")
        
    f.write("\n")
f.close()

print("Wrote " + modes[mode] + ".dat");
