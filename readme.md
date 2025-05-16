# A local development environment template for Wordpress using Docker & Traefik

This is my template to host Wordpress sites in a local development environment.

## It uses:

- Docker with Compose; I use Docker Desktop installed on Windows/WSLinux
- Traefik, as a router / virtual host / reverse proxy
- Worpress (of course)
- MySQL/Mariadb, for databases
- PhpMyAdmin, for database administration
- OpenSSL, for generating self-signed SSL certificates

# How to deploy

## 1. Domains

Have Docker & Docker Compose installed on your system & point your domains to your local IP in your system's hosts file:

- localhost, for traefik dashboard
- mysite.com, for wp site
- db.mysite.com; for phpmyadmin dashboard

## 2. SSLs

Whilst inside the 'vhost' directory, use this command to generate your self-signed cert:

```
./ssl/cert.sh
```

you may be required to apply permissions to use this file as an executable; if so, use this before trying the above command again:

```
chmod +x ./ssl/cert.sh
```

Now install the newly generated certificate into the usual Trusted Root Certification Authorities directory on your system (windows)

## 3. Launch

While youre still inside the 'vhost' directory, launch the vhost container with:

```
docker compose up -d
```

Now, navigate to the site directory (sites/mysite.com) & launch the wp site container with:

```
docker compose up -d
```

Coffee time! Allow a few minutes for the db to create itself...

## 5. Install & configure wordpress

Finally, connect to https://mysite.com & follow Wordpress installation steps.










# Starting a new site

To start afresh, unzip the _mysite.com.zip folder in 'sites' directory & rename how you like, e.g: 'example.com'.

You will need to do a search & replace in this new folder, changing 'mysite' & 'mysite.com' to 'example' & 'example.com' etc.

## 1. Create new SSL

Naviagte back to 'vhost' directory.

In cert.conf & cert.sh, will need to do a search & replace, changing 'mysite' & 'mysite.com' to 'example' & 'example.com' etc.

Now you can generate your new SSL using:

```
./ssl/cert.sh
```

Install the certificate on your system & add your new cert to the bottom of tls.certificates array in dynamic.yml (same format)

## 2. Launch

Naviagte back to the 'example.com' directory you unzipped before & Launch it as a new wp container using:

```
docker compose up -d
```

Coffee time! Allow a few minutes for the db to create itself...

## 3. Install & configure wordpress

Finally, connect to https://example.com & follow Wordpress installation steps again!



















# Resetting a container

## Reset wp site container

If you want to reset a wp site container back to it's original state & delete any associated data, naviagte to its directory & use this:

```
docker-compose down
sudo rm -r db
sudo rm -r wp/core
sudo rm -r wp/content
```

## Reset vhost container

To reset the vhost container, navigate to 'vhost' directory & use:

```
docker-compose down
sudo rm -r ssl/certs
```

## Rebuild container

You can rebuild a container again inside it's directory with the 'docker compose up -d' command









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