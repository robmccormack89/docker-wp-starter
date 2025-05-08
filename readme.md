# A local development environment template for Wordpress using Docker & Traefik

This is my template to host Wordpress sites in a local development environment.

It uses:
- Docker with Compose; I use Docker Desktop installed on Windows/WSLinux
- Traefik, as a router / virtual host / reverse proxy
- Worpress (of course)
- MySQL/Mariadb, for databases
- PhpMyAdmin, for database administration
- OpenSSL, for generating self-signed SSL certificates




## How to deploy

### 1. System & Domains

Have Docker & Docker Compose installed on your system & point your domains to your local IP in your system's hosts file:

- mysite.com
- sql.mysite.com; for phpmyadmin dashboard
- traefik.mysite.com; for traefik dashboard

### 2. Rename sample.env

Rename 'sample.env' to '.env' & fill in your own details.

### 3. Generate self-signed SSLs

Whilst inside the project directory, hit this to generate your self-signed cert:

```
./ssl/cert.sh
```

if you need to apply permissions to use this file as an executable, use this:

```
chmod +x ./ssl/cert.sh
```

Now install the certificate into the usual Trusted Root Certification Authorities directory on your system (windows)

### 4. Launch the container!

Whilst inside the project directory, launch it:

```
docker compose up -d
```

Coffee time! Allow a few minutes for the db to create itself...

### 5. Install & configure wordpress

Finally, connect to https://mysite.com & follow Wordpress installation steps.




## Starting again

To start afresh, clone this repo again & rename it.

Don't forget to search & replace mysite/mysite.com where necessary.

### Run the starting procedure

Create the networks & compose the container:

```
docker compose up -d
```

### Resetting a container

If you want to reset a container back to it's original state & delete any associated data, use this:

```
docker-compose down
sudo rm -r db
sudo rm -r wp/core
sudo rm -r wp/content
sudo rm -r ssl/cert
```

You can rebuild the container again inside it's directory with the 'docker compose up -d' command






# Useful commands

A collection of useful commands / variations of the ones above




## Startups & Creation

### Rebuild & start the container from existing caches (also use for code changes)

```
docker compose up -d
```

### Rebuild & start the container, but with fresh volumes

```
docker compose up -d --force-recreate
```

### A full & fresh rebuild, all uncached

```
docker compose build --no-cache
docker compose up -d --force-recreate --renew-anon-volumes
```

- build = builds the images, does not start the containers
- --no-cache = disables the build cache in the image creation process
- up -d = detatched mode (close after finish)
- --renew-anon-volumes = Recreate anonymous volumes instead of retrieving data from the previous containers
- --force-recreate = force all layers to be pulled fresh

### Create network/s

```
docker network create mysite-net
```




## Shutdown & Deletion

### Shutdown & delete containers, images & volumes

```
docker-compose down
```

### Delete excess files relating to wp, db & ssl

```
sudo rm -r db
sudo rm -r wp/core
sudo rm -r wp/content
sudo rm -r ssl/cert
```

### Delete network/s

```
docker network rm mysite-net
```

### Clear the system of ALL containers, images & volumes (be careful with this!)

```
docker system prune --volumes --force --all
```

- --volumes = Prune anonymous volumes
- --force = Do not prompt for confirmation
- --all = Remove all unused images not just dangling ones




## Watch commands

```
docker compose watch
```

```
docker compose up --watch
```




## Generating self-signed SSLs

Whilst inside the project directory, hit this to generate your self-signed cert:

```
./ssl/cert.sh
```

if you need to apply permissions to use this file as an executable, use this:

```
chmod +x ./ssl/cert.sh
```