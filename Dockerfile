FROM nvcr.io/nvidia/tensorflow:19.04-py2

VOLUME /project

WORKDIR /project

# ZDoom dependencies
RUN apt-get update && apt-get install --no-install-recommends -y libhdf5-dev \
build-essential zlib1g-dev libsdl2-dev libjpeg-dev \
nasm tar libbz2-dev libgtk2.0-dev cmake git libfluidsynth-dev libgme-dev \
libopenal-dev timidity libwildmidi-dev unzip
# Boost libraries
RUN apt-get install -y libboost-all-dev
#SDL
RUN apt-get update && apt-get install -y \
libsdl2-2.0-0 \
libsdl2-dev \
libsdl2-image-2.0-0 \
libsdl2-image-dev \
libsdl2-mixer-2.0-0 \ 
libsdl2-mixer-dev \ 
libsdl2-net-2.0-0 \
libsdl2-net-dev \ 
libsdl2-ttf-2.0-0 \
libsdl2-ttf-dev



COPY requirements.txt ./

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py --force-reinstall \
    && pip install --no-cache-dir -r requirements.txt \
    && pip install --upgrade notebook \
    && pip install lesscpy

EXPOSE 8888
