FROM tensorflow/tensorflow:1.13.1-py3

VOLUME /project

WORKDIR /project

# Basic info
RUN cat /etc/*release && python --version

# ZDoom dependencies
RUN apt-get update && apt-get install --no-install-recommends -y libhdf5-dev \
build-essential zlib1g-dev libsdl2-dev libjpeg-dev \
nasm tar libbz2-dev bzip2 g++ libgtk2.0-dev cmake git libfluidsynth-dev libgme-dev \
libgtk-3-dev libmpg123-dev libopenal-dev libsndfile1-dev timidity \
libwildmidi-dev x11-apps unzip curl \
&& python --version

# Default python to python3
RUN which python \
    && which python3 \
    && update-alternatives --install /usr/bin/python python /usr/bin/python3 10 \
    && apt-get install -y python3-dev python3-pip \
    && python --version

# Boost libraries
RUN apt-get install -y libboost-all-dev \
    && python --version

COPY requirements.txt ./
RUN python -m pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt 

## code formatter (https://github.com/ryantam626/jupyterlab_code_formatter)
#RUN apt-get install -y curl python-software-properties \
#    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
#    && apt-get install -y nodejs \
#    && jupyter labextension install @ryantam626/jupyterlab_code_formatter \
#    && pip install jupyterlab_code_formatter \
#    && jupyter serverextension enable --py jupyterlab_code_formatter

EXPOSE 8888