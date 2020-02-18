# OneLedger Nano S/X app

## Overview
This app is an implementation for retrieving public keys / Addresses and signing transactions on the OneLedger network using the Nano S/X.

## Building and installing
To build and install the app on your Ledger Nano S you must set up the Ledger Nano S build environments. Please follow the Getting Started instructions at [here](https://ledger.readthedocs.io/en/latest/userspace/getting_started.html).

### Notes on Environment Setup:

.bashrc file must export the following paths (Make sure the path ends with a slash):
```bash
export BOLOS_ENV=~/dev/bolos-dev/
export BOLOS_SDK=~/dev/bolos-dev/nanos-secure-sdk/
export GCCPATH=~/dev/bolos-dev/gcc-arm-none-eabi-5_3-2016q1/bin/
export CLANGPATH=~/dev/bolos-dev/clang-arm-fropi/bin/
```

Update your Nano S device with the firmware version 1.6. You can do this using the ledger live app. 

Compile and load the app onto the device:
```bash
make load
```

Refresh the repo (required after Makefile edits):
```bash
make clean
```

Remove the app from the device:
```bash
make delete
```


## Example of Ledger wallet functionality

### Test functionality:
Get Address
```bash
python test_getAddress.py --account_number 12345
```

Sign Transaction Data (One Ledger Network must be running one node here: http://127.0.0.1:26602)
```bash
python test_signRawTx.py
```
