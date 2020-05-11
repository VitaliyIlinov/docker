# Docker

## Getting Started

### Clone repository to the common place

```bash
git clone git@github.com:VitaliyIlinov/docker.git ~/workspace/docker
```

# Install Docker
https://docs.docker.com/install/linux/docker-ce/ubuntu

### Build application image:

You can build app with different php version and web servers/
Default: 7.2 php version && nginx
```bash
make build
```
For custom config:
```bash
make build  PHP_VERSION=7.2 WEB_SERVER=apache
```

### Start application

Start project using command as follows:

```bash
make up
```
Now it is ready to use (check http://localhost/ ).

### For more info see
```bash
make help
```

### Docker folder include
```bash
Setting for apache && nginx
```