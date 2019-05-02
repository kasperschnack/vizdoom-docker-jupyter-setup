# VizDoom w. Jupyter setup in Docker 

## Up and running
To get going as fast as possible (without visuals) you can do this. If you're training on servers - this approach might be the only resonable thing to do.

~~~~
docker build --no-cache -t doom .

docker run -d -v $(pwd):/project -p 8888:8888 doom jupyter notebook --no-browser --ip 0.0.0.0 --allow-root --NotebookApp.token='' && open http:localhost:8888
~~~~

## Up and running w. visuals

It is actually possible to see the frame by frame through docker even though it takes a bit of fiddling:

This works with the following versions on a host machine running Mac OS 10.14.3
- XQuartz 2.7.11 (xorg-server 1.18.4)
- Docker engine 18.09.2
- socat 1.7.3.2

0. Install XQuartz and socat
~~~~
$ brew install socat
$ brew cask reinstall xquartz
~~~~

After installation - restart your computer

1. Close any 6000
On a new terminal, verify that nothing is running on port 6000:
~~~~
$ lsof -i TCP:6000
$
~~~~
If there is anything, kill the process

2. Listen on port 6000
Open a socket on that port and keep the terminal open
~~~~
$ socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
~~~~
3. Verify 6000 is open
In a new terminal, verify if it is opened
~~~~
$ lsof -i TCP:6000
COMMAND   PID     USER   FD   TYPE             DEVICE SIZE/OFF NODE NAME
socat   29298 mdesales    5u  IPv4 0xe21e43ca9d99bf1d      0t0  TCP *:6000 (LISTEN)
~~~~

4. Get going w. docker
~~~~
docker build --no-cache -t doom .

docker run -d -v $(pwd):/project -e DISPLAY=docker.for.mac.host.internal:0 -p 8888:8888 doom jupyter notebook --no-browser --ip 0.0.0.0 --allow-root --NotebookApp.token='' && open http:localhost:8888
~~~~

## Up and running with GPU

Doing Deep RL using CPUs is very time consuming  using GPUs is generally preferable. We train using quite a few different algorithms. 
As there are currently no Macbooks with nvidia gpu(the only feasible gpus for deep learning at the time of writing) we we only use mac for the preliminary testing. The actual training is done on ubuntu-machines. Setting up unfortunately isn't trivial. Thankfully, Pyimagesearch has a [guide](https://www.pyimagesearch.com/2019/01/30/ubuntu-18-04-install-tensorflow-and-keras-for-deep-learning/) for doing setup.
