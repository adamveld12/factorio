# Headless Factorio Docker 

A headless Factorio setup. 


## Getting started

Crash course:
```sh
# See help
docker run -it  adamveld12/factorio --help

# Create a new map
docker run -it -v $PWD/save/:/opt/factorio/saves adamveld12/factorio --create factorio_save.zip

# Run server after previous step
docker run -it -p 3000:3000 -v $PWD/save/:/opt/factorio/saves adamveld12/factorio

# Run server but set up RCON with the password 'factorio123'
docker run -it -p 3000:3000 -p 3001:3001 -e RCON_PASSWORD=factorio123 -v $PWD/save/:/opt/factorio/saves adamveld12/factorio
```

Environment Variables:


`RCON_PASSWORD`: The password for RCON access. Defaults to factorio - to disable RCON just don't export the port

Ports:


`3000`: The game server port

`3001`: The RCON port


Volumes:

`/opt/factorio/data`: The data folder

`/opt/factorio/mods`: Mods

`/opt/factorio/saves`: Game saves

`/opt/factorio/settings`: The server.json and map.json are here.


