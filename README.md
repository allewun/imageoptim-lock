# imageoptim-lock

This script runs [ImageOptim](https://imageoptim.com/mac) on a directory to recursively compress all .png files found within.

After optimization and compression is complete, an `imageoptim.lock` file will be generated, containing a manifest of the optimized files.

The next time `imageoptim-lock` is run, only new and modified .png files will be optimized.

## Usage

Run `imageoptim-lock` from the directory of interest.

```
$ imageoptim-lock
```

### Installation

```
$ cp imageoptim-lock.sh /usr/local/bin/imageoptim-lock
```
