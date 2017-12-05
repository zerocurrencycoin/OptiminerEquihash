# Optiminer/Equihash

GPU miner for Equihash supporting many coins. A (probably incomplete) list:
- **Zcash** (-a equihash200_9)
- **Bitcoin Gold** (-a equihash200_9)
- **Hush** (-a equihash200_9)
- **Zero** (-a equihash192_7)
- **Minexcoin** (-a equihash96_5)
- **Kommodo** (-a equihash200_9)
- **BitcoinZ** (-a equihash200_9)

This is a replacement for the previous versions of separate miners for Zcash and Zero.
Unifying all three variants of Equihash used by different coins ([N,K]=[200,9] / [192,7] / [96,6])
into a single binary simplifies further development on all variants. 

Note that depending on the Equihash parameters the amount of GPU memory needed varies a lot:
- equihash200_9: >512MB
- equihash192_7: >6GB
- equihash96_5: >32MB

Due to the high solution rates achieved with equihash96_5 the CPU demans are higher. Take this into account when putting 5 
or more cards into a rig!

## v2.1.0
[Download Linux 64bit](https://github.com/Optiminer/OptiminerEquihash/raw/master/optiminer-equihash-2.0.0.tar.gz)

`optiminer-equihash-2.1.0.tar.gz sha256sum 

<!--
[Download Windows 64bit](https://github.com/Optiminer/OptiminerZcash/raw/master/optiminer-zcash-1.7.0.zip)
-->



### Recommended Drivers

#### Linux
- fgrlx 15.30.3 for all GCN 1st-3rd gen cards
- amdgpu-pro 16.40.5 for GCN 4th gen cards (RX4\*0)

<!--
#### Windows
- Full speed can only be achieved under Catalyst 15.12 drivers! See
  [below](#installing-catalyst-1512-on-windows) for how to install the older
  driver version.
- RX4\*0 cards are not supported by Catalyst 15.12, **I strongly recommend
  to use linux for mining on them!**
-->

**There is currently no support for AMD Vega cards!**

### Features

Supports:
- <!--Windows and -->Linux 64bit only.
- AMD GCN cards.
- NVidia (equihash192_7 and equihash96_5 only).

### Mining Speed (stock card, net rates)

The miner contains a 1.0% fee for supporting the developer. All shown hash rates 
are net rate, i.e., with fee deducted. What you see is what YOU get!

#### AMD R9 Nano
- Equihash200_9: 450 S/s (with powertune +50)
- Equihash96_5: 10200 S/s

#### AMD R9 290X
- Equihash200_9: 311 S/s

#### AMD RX 480
- Equihash200_9: 290 S/s
- Equihash192_7: 9 S/s
- Equihash96_5: 7700 S/s

#### NVidia GTX 1080
- Equihash192_7: 8 S/s
- Equihash96_5: 7400 S/s


## Usage:
Run from the archive root directory:
```
$ ./optiminer-equihash -s eu1-zcash.flypool.org:3333 -a equihash200_9 \
                       -u t1Yszagk1jBjdyPfs2GxXx1GWcfn6fdTuFJ.example -p password 
```

For a list of all options run with `-h`:
```
$ ./optiminer-equihash -h
```

There are also 'mine_zcash.sh', 'mine_zero.sh' and 'mine_mnx.sh' <!--and 'start.bat'--> scripts for running it under <!--Windows and --> Unix. Just edit the pool and user settings before running!

### Secure connection
Since version 1.0.0, the miner supports ZStratum protocol over TLS to
encrypt the connection to the mining pool. Currently, this is only supported
with some pools, e.g., flypool and supernova.

Use `zstratum+tls://` as prefix to the pool address, e.g.,
```
$ ./optiminer-equihash -s zstratum+tls://eu1-zcash.flypool.org:3443 -a equihash200_9 \
                       -u t1Yszagk1jBjdyPfs2GxXx1GWcfn6fdTuFJ.example -p password 
```

## Troubleshooting

### Intensity
There is the intensity option (-i). Higher intensity generally means faster hashing. 
But if it is too high, the miner might crash or have very poor performance. 
The miner tries to auto-detect the best intensity for your card but you can
experiment with different values.

E.g., adding `-i 2` to command line sets intensity to 2 for all cards. If
you have multiple card you can specify one `-i` for each card, e.g., if you
have four cards `-i 3 -i 4 -i 4 -i 3` (same order as `-d`). An intensity value
of 0 means auto-detect.

As the memory requirements differ a lot depending on the equihash parameters
the optimal value for intensity differs a lot too.


### `GLIBCXX_3.4.20' not found on Ubuntu 14.04
Install the required libstc++:
```shell
sudo add-apt-repository ppa:ubuntu-toolchain-r/test 
sudo apt-get update
sudo apt-get install libstdc++6
```

### Failed to read bin/XXX.bin
You need to run the miner from the directroy where optiminer-equihash is in
otherwise it will not find the opencl kernel.

### libOpenCL.so.1 cannot open object
There is a problem with your OpenCL installation. Make sure that there is a
symlink /usr/lib/libOpenCL.so.1 that points to the OpenCL library on your
system.

### [error] OpenCL error: cl::Context::Context() (CL_DEVICE_NOT_FOUND)
Either you have specified a wrong device / platform combination or there is
a problem with your OpenCL setup.

By default platform id 0 is used. You can specify a different platform by
adding '-c N' to the command line where N is a small number (try 0,1,2).

Restarting X might help to re-initialize the graphic driver under Linux.

### Internal error: Link failed
This can happen if you use an unsupported version of the graphic driver.
Try updating to the newest driver or use `--force-generic-kernel` to get a
slower implementation that also runs on older drivers.

### Installing catalyst 15.12 on Windows
- Download and run the [AMD driver
  cleanup](http://support.amd.com/en-us/kb-articles/Pages/AMD-Clean-Uninstall-Utility.aspx)
- Download and install "Download Windows 10 64-bit (Desktop)" from
  [here](http://www.guru3d.com/files-details/amd-radeon-software-crimson-15-12-driver-download.html).
  You need to scroll down to find the download links.
- Reboot. 

## Changelog
- [2.1.0] Remove --pci-mode flag.
- [2.1.0] Add flag to specify CA certificate.
- [2.1.0] Lower CPU utilization for solution processing.
- [2.1.0] Allow to run on older Nvidia cards (>=SM target 32).
- [2.1.0] Allow to run on older AMD cards.
- [2.1.0] Fix problems when CPU is not fast enough.
- [2.0.0] Dev fee lowered to 1%.
- [2.0.0] Added equihash96_5 for Minexcoin.
- [2.0.0] Unified miner for Zero and Zcash.
