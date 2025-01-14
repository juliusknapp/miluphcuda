#! /bin/sh

# Some checks and system-dependent config for Makefile.

# last updated: 29/Apr/2022

# Christoph Burger
# christoph.burger@uni-tuebingen.de


MAKEFILE=Makefile
if [ ! -f $MAKEFILE ]; then
    echo "Error: didn't find Makefile '$MAKEFILE'..."
    exit 1
fi

echo "Configuring Makefile..."
echo ""
ISSUES=0


# check C compiler
if [ ! -f /usr/bin/g++ ]; then
    echo "Warning: /usr/bin/g++ not found, set C compiler manually in Makefile."
    ISSUES=1
fi

# check CUDA path
if [ ! -d /usr/local/cuda ]; then
    echo "Warning: /usr/local/cuda not found, set CUDA path manually in Makefile."
    ISSUES=1
fi


# try to find compute capability from lookup list
GPU_ARCH_FOUND=0
GPU=`nvidia-smi -q -i 0 2>/dev/null | grep "Product Name" | cut -d: -f 2 | cut -d\  -f 2-`
if [ -z "$GPU" ]; then
    echo "Warning: couldn't extract GPU model, set compute capability (GPU_ARCH) manually in Makefile."
    ISSUES=1
else
    case $GPU in
        *"GeForce GTX 570" | *"Quadro 4000" )
            GPU_ARCH="-arch=sm_20"
            GPU_ARCH_FOUND=1 ;;
        *"GeForce GTX 680" | *"GeForce GTX 770" )
            GPU_ARCH="-arch=sm_30"
            GPU_ARCH_FOUND=1 ;;
        *"GeForce GTX Titan" | *"Tesla K40" )
            GPU_ARCH="-arch=sm_35"
            GPU_ARCH_FOUND=1 ;;
        *"Tesla K80" )
            GPU_ARCH="-arch=sm_37"
            GPU_ARCH_FOUND=1 ;;
        *"GeForce GTX 750 Ti" )
            GPU_ARCH="-arch=sm_50"
            GPU_ARCH_FOUND=1 ;;
        *"GeForce GTX 970" | *"GeForce GTX Titan X" )
            GPU_ARCH="-arch=sm_52"
            GPU_ARCH_FOUND=1 ;;
        *"GeForce GTX 1080" | *"GeForce GTX 1080 Ti" )
            GPU_ARCH="-arch=sm_61"
            GPU_ARCH_FOUND=1 ;;
        *)
            echo "Warning: didn't find GPU model '$GPU' in lookup list, set compute capability (GPU_ARCH) manually in Makefile, and/or drop the developers a line to add it..."
            ISSUES=1
            ;;
    esac
fi

# set compute capability (GPU_ARCH) in Makefile
if [ $GPU_ARCH_FOUND -eq 1 ]; then
    grep "^GPU_ARCH" $MAKEFILE >/dev/null
    if [ $? -ne 0 ]; then
        echo "Error: couldn't find setting for compute capability (GPU_ARCH) in Makefile."
        exit 1
    else
        sed -i "/^GPU_ARCH*/c\GPU_ARCH = $GPU_ARCH" $MAKEFILE
        echo "Found GPU model '$GPU' and set compute capability (GPU_ARCH) to '$GPU_ARCH'."
    fi
fi

# warning if more than one GPU
NO_GPUS=`nvidia-smi -q 2>/dev/null | grep "Attached GPUs" | cut -d: -f 2 | cut -d\  -f 2`
if [ $GPU_ARCH_FOUND -eq 1 ] && [ $NO_GPUS -gt 1 ]; then
    echo "Warning: more than one GPU on host (found $NO_GPUS), used device with ID 0 to set compute capability."
fi


# the bottom line
if [ $ISSUES -eq 1 ]; then
    echo ""
    echo "Resolve these issues manually, then compile."
else
    echo ""
    echo "You're all set, compile via the Makefile and enjoy."
fi

