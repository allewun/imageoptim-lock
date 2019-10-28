# imageoptim-lock

This script runs [ImageOptim](https://imageoptim.com/mac) on a directory to recursively compress all .png files found within.

After optimization and compression is complete, an `imageoptim.lock` file will be generated, containing a manifest of the optimized files.

The next time `imageoptim-lock` is run, only new and modified .png files will be optimized.

## Installation

```
$ cp imageoptim-lock.sh /usr/local/bin/imageoptim-lock
```

## Usage

Run `imageoptim-lock` from the directory of interest.

```
$ imageoptim-lock
```

<img src="/docs/demo.gif" width="960" alt="imageoptim-lock demo" />

## Why?

It's easy enough to run ImageOptim or some other image compression tool on all the images in your project. However, when working with a team, images may be modified and optimiztions may be reverted, thus requiring another optimization pass.

Running ImageOptim continuously (e.g. on every commit) is computationally-expensive and time-consuming, since the tool doesn't have any way to determine whether or not an image has been previously optimized.

Using `imageoptim-lock` provides the cache needed for ImageOptim to skip files that don't need optimizing.

While the initial optimization pass on a mature project with many images can take minutes to complete, future invocations of `imageoptim-lock` can be orders of magnitude faster, often finishing in seconds.
