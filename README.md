docker build . -t test -f ./dockerfile 
docker run --publish 8888:8888 --volume ~/docker/data:/home/jovyan/data --volume ~/docker/jupyter:/home/jovyan/work test
