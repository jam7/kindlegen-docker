# kindlegen-docker
A docker container to run kindlegen as a host user.

## Prerequisite

Need to install docker.

## Install

Download container and run it to generate kindlegen script.

```
$ docker pull jam7/kindlegen
$ docker run --rm jam7/kindlegen > kindlegen
$ chmod a+x kindlegen
```

Don't add `-ti` to `docker run`.  Otherwise, you may create a kindlegen
script with crlf.

## How to use it

Use a generated kindlegen script.  An epub file must be at somewhere
under the current working directory.

```
$ ./kindlegen test.epub
```

## Build

In order to build image by yourself, perform `make`

```
$ make
```

## License

@ 2021 Kazushi (Jam) Marukawa, All rights reserved.

This project including all of its source files is released under the terms of [GNU General Public License (version 3 or later)](http://www.gnu.org/licenses/gpl.txt)

## Related projects

narou.rb is in https://github.com/whiteleaf7/narou.
