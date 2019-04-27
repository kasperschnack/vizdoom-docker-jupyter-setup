FROM nvcr.io/nvidia/tensorflow:19.04-py3

# currently this docker-image only runs non-visually, which is still useful for training but not for debugging
# we could look more into the possiblities here https://github.com/mwydmuch/ViZDoom/tree/master/docker
# so far though, I haven't gotten it to work.

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

RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

EXPOSE 8888