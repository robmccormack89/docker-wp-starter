# Wordpress template with Docker and Traefik

This is my template to host Wordpress sites on a server.

It uses:
- Docker with Compose (I use Docker Desktop installed on Windows/WSLinux)
- Traefik, as a virtual host / reverse proxy
- Worpress (of course)
- MySQL/Maridb
- PhPMyAdmin, for database administration
- OpenSSL, for generating self-signed SSL certificates




## How to deploy

### Server and domains

Have a server with Docker installed & point your domains to your local IP in your system's hosts file:

- mysite.com
- sql.mysite.com; for phpmyadmin dashboard
- traefik.mysite.com; for traefik dashboard

### 1. Rename sample.env

Rename 'sample.env' to '.env' & fill in your own details.

### 2. Generate self-signed SSLs

Whilst inside the project directory, hit this to generate your self-signed cert:

```
./ssl/cert.sh
```

if you need to apply permissions to use this file as an executable, use this:

```
chmod +x ./ssl/cert.sh
```

Now install the certificate into the usual Trusted Root Certification Authorities directory on your system (windows)

### 3. Launch the container!

Whilst inside the project directory, launch it:

```
docker compose up -d
```

Coffee time! Allow a few minutes for the db to create itself...

### Install and configure wordpress

Finally, connect to https://mysite.com and follow Wordpress installation steps!




## Starting again!

### Resetting a container

First delete the current active containers/images/volumes/networks for your given active directory

Then, delete the excess leftover files from wp & db

```
docker-compose down
sudo rm -r db
sudo rm -r wp/core
sudo rm -r wp/content
sudo rm -r ssl/cert
```

### Or, Starting afresh

To start again, clone this repo again & rename it! Dont forget to search & replace mysite/mysite.com where necessary.

Now, you can run the starting procedure!

Create the networks & compose the container:

```
docker compose up -d
```

For a more complete composition using fresh volumes, try instead:

```
docker compose up -d --force-recreate
```

Or for a fully fresh build ignoring all caches, try instead:

```
docker compose build --no-cache
docker compose up -d --force-recreate --renew-anon-volumes
```

And after a container has been started up & is running, use this to refresh the containers with your latest code:

```
docker compose up -d
```








# Useful commands

A collection of useful commands / variations of the ones above




## Startups & Creation

### recreate & start containers from existing caches. good for code changes!

```
docker compose up -d
```

### compose & start new containers but with fresh volumes

```
docker compose up -d --force-recreate
```

### full & fresh build with compose & start, all uncached

```
docker compose build --no-cache
docker compose up -d --force-recreate --renew-anon-volumes
```

- build = builds the images, does not start the containers
- --no-cache = disables the build cache in the image creation process
- up -d = detatched mode (close after finish)
- --renew-anon-volumes = Recreate anonymous volumes instead of retrieving data from the previous containers
- --force-recreate = force all layers to be pulled fresh

### create network/s

```
docker network create mysite-net
```




## Shutdown & Deletion

### shutdown & delete containers, but not images/valumes

```
docker-compose down
```

### delete excess files relating to wp, db & ssl

```
sudo rm -r db
sudo rm -r wp/core
sudo rm -r wp/content
sudo rm -r ssl/cert
```

### prune delete the whole system of ALL containers, volumes & images (be careful with this!)

```
docker system prune --volumes --force --all
```

- --volumes = Prune anonymous volumes
- --force = Do not prompt for confirmation
- --all = Remove all unused images not just dangling ones

### delete network/s

```
docker network rm mysite-net
```




## Watching

```
docker compose watch
```

```
docker compose up --watch
```




## Generating self-signed SSLs

```
./ssl/cert.sh
```

```
chmod +x ./ssl/cert.sh
```