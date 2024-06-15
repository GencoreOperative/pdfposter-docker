Overview
===

This project is a simple Docker wrapper around the 
[pdfposter](https://gitlab.com/pdftools/pdfposter) project. This project will take a source PDF
page and scale it up to span across multiple pages.

From the [documentation](https://pdfposter.readthedocs.io/en/stable/) of pdfposter:

```
pdfposter can be used to create a large poster by building it from multiple pages and/or printing it on large media. It expects as input a PDF file, normally printing on a single page. The output is again a PDF file, maybe containing multiple pages together building the poster. The input page will be scaled to obtain the desired size.
```

Building
===

To build this project you will need `docker` and `make`.

```
make build
```

Running
===

*Create an PDF containing the image*

We will start with an image that we want to turn into a tiled poster. This is best scaled to an A4 page.
Then use GIMP to export this image as a PDF called `input.pdf`.

*Run pdfposter*

The Docker image runs as root. On Linux, any files created on the file system by this 
container will be owned by root. As such, we will `touch` the output file first to ensure
it is owned by the current user.

In this command we are tiling the image over two A4 pages.

```
touch output.pdf; docker run -v $(pwd):/data --rm -ti gencore/pdfposter:latest -m2x1a4 /data/input.pdf /data/output.pdf
```

Usage
===

The `pdfposter` utility outputs the following help infomation:

```
usage: pdfposter [-h] [--help-media-names] [--help-box-definitions] [--version] [-v] [-n] [-f INTEGER] [-l INTEGER] [-A] [-m BOX] [-p BOX] [-s SCALE] InputFile OutputFile

positional arguments:
  InputFile
  OutputFile

options:
  -h, --help            show this help message and exit
  --help-media-names    List available media and distance names
  --help-box-definitions
                        Show help about specifying BOX for `--media-size` and `--poster-size` and exit
  --version             show program's version number and exit
  -v, --verbose         Be verbose. Tell about scaling, rotation and number of pages. Can be used more than once to increase the verbosity
  -n, --dry-run         Show what would have been done, but do not generate files

Define Input:
  -f INTEGER, --first INTEGER
                        First page to convert (default: first page)
  -l INTEGER, --last INTEGER
                        Last page to convert (default: last page)
  -A, --art-box         Use the content area defined by the ArtBox (default: use the area defined by the TrimBox)

Define Target:
  -m BOX, --media-size BOX
                        Specify the page size of the output media (default: a4)
  -p BOX, --poster-size BOX
                        Specify the poster size (defaults to media size)
  -s SCALE, --scale SCALE
                        Specify a linear scaling factor to produce the poster. The scaling factor is applied to the width and height of the input image size. Thus, a scaling
                        factor of 2 results in a poster 4 times the area compared to the original
```