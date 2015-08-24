# Docker-Processwire
This repository is made to run Processwire in Docker, the Dockerfile installs Nginx and all the files needed to run Processwire, this project does not install a MySQL server (this you can add yourself seperately or run independent of the Docker container). Nginx HTTP (80) is in the EXPOSE.

# Running Docker-Processwire

## Build the Docker image
Git clone the repository:

<code>git clone https://github.com/livebytes/docker-processwire.git</code>

Install Docker using the Docker documentation that you can find here: https://www.docker.io/gettingstarted/

Pull the ubuntu Docker:

<code>sudo docker pull ubuntu:12.10</code>

Build the processwire-docker (execute command below in the folder you cloned the repository to):

<code>sudo docker build -t processwire .</code>

Run the processwire-docker:

<code>sudo docker run -d processwire</code>

Find which port your instance is exposed to:

<code>sudo docker port container-id 80</code>

Point your webbrowser to:

<code>http://serverip:port</code>
