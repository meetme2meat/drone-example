# First stage: build the executable.
FROM golang:alpine AS drone-example

# git is required to fetch go dependencies
RUN apk add --no-cache ca-certificates git

RUN apk update && apk add bash

# Create the user and group files that will be used in the running
# container to run the process as an unprivileged user.
RUN mkdir /user && \
  echo 'nobody:x:65534:65534:nobody:/:' > /user/passwd && \
  echo 'nobody:x:65534:' > /user/group

# Set the working directory outside $GOPATH to enable the support for modules.
RUN mkdir -p /go/src/drone-ci-example
WORKDIR /go/src/drone-ci-example

# Fetch dependencies first; they are less susceptible to change on every build
# and will therefore be cached for speeding up the next build
COPY ./go.mod ./go.sum ./
RUN go mod download && go mod verify

# Import the code from the context.
COPY . .

RUN go build  -o /bin/droner /go/src/drone-ci-example

FROM alpine
RUN apk update && apk add ca-certificates && rm -rf /var/cache/apk/*

RUN update-ca-certificates

COPY --from=drone-example /bin/droner /bin/droner

ENTRYPOINT ["/bin/droner"]