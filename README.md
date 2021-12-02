# drone-example

**Note**: For Testing purposes on non-public machines please use ngrok.

- STEP 1: Setup repo Oauth by click -> Setting -> Developer Settings -> Oauth Application.
- STEP 2: create the .env file with following env

All the below env values should be in their general form i.e **without quotes** and **without http scheme like http:// or https://**

```
DRONE_RPC_HOST                        ## the host provided in OAuth settings.
DRONE_GITHUB_CLIENT_ID                ## the client_id provided in oauth settings.
DRONE_GITHUB_CLIENT_SECRET            ## the client_secret provied in oauth settings.
DRONE_SERVER_HOST                     ## the host provided in OAuth settings.
DRONE_USER_CREATE                     ## the username and privileges (not entirely sure we need it).
DRONE_SERVER_PROTO                    ## http or https (for https other settings need to set see drone configuration).
DRONE_RPC_SECRET                      ## RPC secret that is used between Drone server and Runner (can be any secret).
DRONE_LOG_FILE                        ## Log file for the drone.
DRONE_UI_USERNAME                     ## Drone runner username (not server as server use OAuth).
DRONE_UI_PASSWORD                     ## Drone runner password.
DRONE_DEBUG=true                      ## Drone debug.  
DRONE_RPC_DUMP_HTTP=true              ## Drone dump RPC HTTP.
DRONE_RPC_DUMP_HTTP_BODY=true         ## Drone dump RPC HTTP BODY.
DRONE_HTTP_HOST='localhost:3000'      ## Drone HTTP Host.
```

For other configurations, kindly check the individual runner and server configuration. 

**NOTE**: In the sample project there is one .env file for the server and two runners (docker and exec) this is because most of the environment variables used were not conflicting if they conflict it makes sense to use different env for each one of them.



## Start drone server.

```
docker run \
  --volume=/Users/admin/Documents/drone-ui/new-app:/data \
  --publish=8080:80 \
  --publish=443:443 \
  --restart=always \
  --name=drolling \
  --env-file .env \
drone/drone:2
```

## Start drone runner.
- Exec Runner

Download [link](https://docs.drone.io/runner/exec/installation/)

```
./drone-runner-exec daemon .env
```
- Docker Runner

```
docker run  \
  -v /var/run/docker.sock:/var/run/docker.sock \
  --env-file .env \
  -p 3001:3000 \
  --restart always \
  --name runner \
  drone/drone-runner-docker:1
```

Use `DRONE_UI_USERNAME` and `DRONE_UI_PASSWORD` to log in to the individual interface of the runners.



## Drone Server (cont.)

Navigate to drone server UI with the URL provided in the OAuth settings (on the development you should be using [ngrok](https://ngrok.com/), if you don't have the public-facing server to run drone server e.g when running personal computer or laptop)

Authorize using Oauth and activate your repository(on drone server) under the individual repository setting section. (Verify the repository settings on drone server)

Make sure the configuration file(on drone server repository setting page) name matches the drone file you would be creating on your repository.

Last, create the relevant drone configuration file inside your repository with the desired pipeline (also check individual [configuration](https://docs.drone.io/pipeline/overview/) for each of the pipelines like exec, ssh, docker, etc)


## Drone Template

To work with the drone template, create the template from the settings page of the project activated on drone-server ui. The template name should contain an extension. A sample template is added in [templates](github.com/meetme2meat/drone-example/tree/main/templates) directory