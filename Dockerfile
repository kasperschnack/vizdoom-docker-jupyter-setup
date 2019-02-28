FROM nvcr.io/nvidia/pytorch:19.01-py3

VOLUME /project

WORKDIR /project

# ZDoom dependencies
RUN apt-get update && apt-get install --no-install-recommends -y libhdf5-dev \
build-essential zlib1g-dev libsdl2-dev libjpeg-dev \
nasm tar libbz2-dev libgtk2.0-dev cmake git libfluidsynth-dev libgme-dev \
libopenal-dev timidity libwildmidi-dev unzip \
# Boost libraries
RUN apt-get install -y libboost-all-dev

COPY requirements.txt ./

RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

EXPOSE 8888