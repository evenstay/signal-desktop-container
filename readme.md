## Signal-Desktop Docker
Docker container for [Signal-Desktop](https://signal.org/download/).

### Prerequisite
For the time-being, allow X11 sharing between the docker container and the local X server with the following; 

Note: This must be done each time the X server is restarted.

`$ xhost local:root` 

### Quickstart
1. Pull the docker image

`$ docker pull evenstay/signal-desktop-container:latest`

2. Create the container 

`$ docker run --name=signal -dt -e DISPLAY=$DISPLAY -v /tmp/.X11-unix/:/tmp/.X11-unix evenstay/signal-desktop-container`

3. Start the docker

`$ docker start signal`

4. Stop the docker (gracefully)

`$ docker stop signal`

### Advanced Features
#### Using Volumes
Mapping a volume to a local folder will allow you to send attachments and save
any media received via signal-desktop docker.

~~~~
$ docker run --name=signal --detach --tty \
--env DISPLAY=$DISPLAY \
--volume /tmp/.X11-unix/:/tmp/.X11-unix/ \
--volume $HOME/.config/signal/share:/opt/Signal/share \
evenstay/signal-desktop-container
~~~~
