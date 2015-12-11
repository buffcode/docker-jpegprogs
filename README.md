# docker-jpegprogs
JPG/JPEG image optimization/manipulation via libjpeg-progs within Docker

## Pull image
```bash
$ docker pull buffcode/docker-jpegprogs
```

## Source directory
This image creates a volume at `/source`, so you can mount a local directory to this remote directory and access any
file within.
Please note that `jpegtran` will not overwrite the input file but output the optimized image to STDOUT. As an
alternative you can use the the `-outfile <filename>` argument with the same path to overwrite the input file.

## Contained applications
This image makes use of the `libjpeg-progs` package. As such it also other tools like `exifautotran`, `jpegexiforient`,
`rdjpgcom`, `wrjpgcom`, `cjpeg` and `djpeg`.

## Running jpegtran
```bash
$ docker run buffcode/docker-jpegprogs --help
usage: /usr/bin/jpegtran [switches] [inputfile]
Switches (names may be abbreviated):
  -copy none     Copy no extra markers from source file
  -copy comments Copy only comment markers (default)
  -copy all      Copy all extra markers
  -optimize      Optimize Huffman table (smaller file, but slow compression)
  -progressive   Create progressive JPEG file
Switches for modifying the image:
  -crop WxH+X+Y  Crop to a rectangular subarea
  -grayscale     Reduce to grayscale (omit color data)
  -flip [horizontal|vertical]  Mirror image (left-right or top-bottom)
  -perfect       Fail if there is non-transformable edge blocks
  -rotate [90|180|270]         Rotate image (degrees clockwise)
  -transpose     Transpose image
  -transverse    Transverse transpose image
  -trim          Drop non-transformable edge blocks
Switches for advanced users:
  -arithmetic    Use arithmetic coding
  -restart N     Set restart interval in rows, or in blocks with B
  -maxmemory N   Maximum memory to use (in kbytes)
  -outfile name  Specify name for output file
  -verbose  or  -debug   Emit debug output
Switches for wizards:
  -scans file    Create multi-scan JPEG per script file
```

### Optimize a single image
```bash
# output to new file
$ docker run -v /local-path-to-image:/source buffcode/docker-jpegprogs \
    -optimize -copy none image.jpg >image-optimized.jpg

# overwrite input file
$ docker run -v /local-path-to-image:/source buffcode/docker-jpegprogs \
    -optimize -copy none -outfile image.jpg image.jpg
```

### Recursivley optimize all images
The following command finds all images in the current folder (`find...`), mounts it to the Docker volume (`-v ...`) and
optimizes the image (`-optimize -copy none`).
```bash
$ find . -name "*.jpg" | \
    xargs -I{} docker run -v `pwd`:/source buffcode/docker-jpegprogs \
    -optimize -copy none -outfile {} {}
```

### Run another tool
In case you would like to run another tool than `jpegtran` eg. `exifautotran` use the following command:
```bash
$ docker run --entrypoint '/usr/bin/exifautotran' buffcode/docker-jpegprogs --help
exifautotran [list of files]

Transforms Exif files so that Orientation becomes 1
```