#!python
import subprocess
import os, random
a = random.choice(os.listdir("/home/horhik/Pictures/Lain")) #change dir name to whatever
path = "~/Pictures/Lain/" + str(a)
print(path)
