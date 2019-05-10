FROM tensorflow/tensorflow:1.13.1-py3

VOLUME /project

WORKDIR /project

# Basic setup.
RUN cat /etc/*release \
    && python --version \
    && apt-get update && apt-get install -y curl wget \
    && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
    && python get-pip.py --force-reinstall

## Install opencv 4 - from https://www.pyimagesearch.com/2018/08/15/how-to-install-opencv-4-on-ubuntu/.
#RUN apt-get install -y build-essential cmake unzip pkg-config \
#    libjpeg-dev libpng-dev libtiff-dev \
#    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
#    libxvidcore-dev libx264-dev \
#    libgtk-3-dev \
#    libatlas-base-dev gfortran \
#    python3-dev \
#    && wget -O opencv.zip https://github.com/opencv/opencv/archive/4.0.0.zip; \
#    wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.0.0.zip; \
#    unzip -o opencv.zip \
#    && unzip -o opencv_contrib.zip \
#    && mv opencv-4.0.0 opencv \
#    && mv opencv_contrib-4.0.0 opencv_contrib \
#    && cd opencv \
#    && mkdir build \
#    && cd build \
#    && cmake -D CMAKE_BUILD_TYPE=RELEASE \
#	-D CMAKE_INSTALL_PREFIX=/usr/local \
#	-D INSTALL_PYTHON_EXAMPLES=ON \
#	-D INSTALL_C_EXAMPLES=OFF \
#	-D OPENCV_ENABLE_NONFREE=ON \
#	-D OPENCV_EXTRA_MODULES_PATH=/project/opencv_contrib/modules \
#	-D PYTHON_EXECUTABLE=/project/.virtualenvs/cv/bin/python \
#	-D BUILD_EXAMPLES=ON .. \
#    && make -j4 \
#    && make install \
#    && ldconfig

# ZDoom dependencies
RUN apt-get install --no-install-recommends -y libhdf5-dev \
build-essential zlib1g-dev libsdl2-dev libjpeg-dev \
nasm tar libbz2-dev libgtk2.0-dev cmake git libfluidsynth-dev libgme-dev \
libopenal-dev timidity libwildmidi-dev unzip

# Boost libraries
RUN apt-get install -y libboost-all-dev

# Install pip packages
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt 

# code formatter (https://github.com/ryantam626/jupyterlab_code_formatter)
RUN apt-get install -y curl python-software-properties \
    && curl -sL https://deb.nodesource.com/setup_10.x | bash - \
    && apt-get install -y nodejs \
    && jupyter labextension install @ryantam626/jupyterlab_code_formatter \
    && pip install jupyterlab_code_formatter \
    && jupyter serverextension enable --py jupyterlab_code_formatter

EXPOSE 8888
