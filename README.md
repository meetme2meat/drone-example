# drone-example

**Note**: For Testing purpose on non public machine please used ngrok.

- STEP 1: Setup repo Oauth by click -> Setting -> Developer Settings -> Oauth Application.
- STEP 2: create the .env file with following env

All the below env value should be in there general form i.e **without quotes** and **without http scheme like http:// or https://**

```
DRONE_RPC_HOST                        ## the host provided in oauth settings.
DRONE_GITHUB_CLIENT_ID                ## the client_id provided in oauth settings.
DRONE_GITHUB_CLIENT_SECRET            ## the client_secret provied in oauth settings.
DRONE_SERVER_HOST                     ## the host provided in oauth settings.
DRONE_USER_CREATE                     ## the username and privileges (not entirely sure we need it).
DRONE_SERVER_PROTO                    ## http or https (for https there are other settings that need to set see drone configuration).
DRONE_RPC_SECRET                      ## RPC secret that is used between Drone server and Runner (can be any secret).
DRONE_LOG_FILE                        ## Log file for drone.
DRONE_UI_USERNAME                     ## Drone runner username (not server as server use oauth).
DRONE_UI_PASSWORD                     ## Drone runner password.
DRONE_DEBUG=true                      ## Drone debug.  
DRONE_RPC_DUMP_HTTP=true              ## Drone dump RPC HTTP.
DRONE_RPC_DUMP_HTTP_BODY=true         ## Drone dump RPC HTTP BODY.
DRONE_HTTP_HOST='localhost:3000'      ## Drone HTTP Host.
```

For other configuration, kindly check the individual runner and server configuration. 

**NOTE**: In the sample project there is one .env file for server and two runner (docker and exec) this because most of the environment variable used were not conflicting if they conflict it make sense to use different env for each one of them.



## Start drone server.

```
docker run \
  --volume=/Users/admin/Documents/drone-ui/new-app:/data \
  --publish=8080:80 \
  --publish=443:443 \
  --restart=always \
  --name=drolling \
  --env-file .env \
drone/drone:latest
```

## Start drone runner.
- Exec Runner

Download [link](https://docs.drone.io/runner/exec/installation/)

```
./drone-runner-exec daemon .env
```
- Docker Runner

```
docker run  \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --env-file .env \
  -p 3001:3000 \
  --restart always \
  --name runner \
  drone/drone-runner-docker:latest
```

Use `DRONE_UI_USERNAME` and `DRONE_UI_PASSWORD` to login to individual interface of the runners.



## Drone Server (cont.)

Navigate to drone server UI with the URL provided in the oauth settings (on development you should be using [ngrok](https://ngrok.com/), if you don't have public facing server to run drone server e.g when running personal computer or laptop)

Authorize using Oauth and activate your repository(on drone server) under individual repository setting section. (Verify the repository settings on drone server)

Make sure the configuration file(on drone server repository setting page) name match with the drone file you would be creating on your repository.

Last, create the relevant drone configuration file inside your repository with desired pipeline (also check individual [configuration](https://docs.drone.io/pipeline/overview/) for each of the pipeline like exec, ssh, docker etc)


## Drone Template

To work with drone template, create the template settings page of the project activated on drone-ci. Template name should contain extension.
A sample template is added in [templates](https://github.com/meetme2meat/drone-example/tree/main/templates) directory
