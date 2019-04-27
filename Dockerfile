FROM nvcr.io/nvidia/tensorflow:19.04-py3

VOLUME /project

WORKDIR /project

# ZDoom dependencies
RUN apt-get update && apt-get install --no-install-recommends -y libhdf5-dev \
build-essential zlib1g-dev libsdl2-dev libjpeg-dev \
nasm tar libbz2-dev libgtk2.0-dev cmake git libfluidsynth-dev libgme-dev \
libopenal-dev timidity libwildmidi-dev unzip
# Boost libraries
RUN apt-get install -y libboost-all-dev

COPY requirements.txt ./

RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python3 get-pip.py --force-reinstall \
    && pip3 install --no-cache-dir -r requirements.txt \
    && sudo apt purge python2.7-minimal

EXPOSE 8888