VolumnDir=$(pwd -P)/CodeDir

docker run -it --rm -v $VolumnDir:/home/GC/CodeDir zhuangjw/gc-base /bin/bash
