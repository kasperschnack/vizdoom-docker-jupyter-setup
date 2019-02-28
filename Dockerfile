FROM nvcr.io/nvidia/pytorch:19.01-py3

VOLUME /project

WORKDIR /project

COPY requirements.txt ./
RUN apt-get update && apt-get install --no-install-recommends -y libhdf5-dev
RUN pip install --upgrade pip && pip install --no-cache-dir -r requirements.txt

EXPOSE 8888