UnrealIRCD with Anope Services
======

Container
------

```
docker-compose up --force-recreate --build --remove-orphans
```


Host
------

```
/opt/letsencrypt/letsencrypt-auto certonly

cp /etc/letsencrypt/live/irc.hellface.com/fullchain.pem /opt/docker/unrealircd/ssl/server.cert.pem
cp /etc/letsencrypt/live/irc.hellface.com/privkey.pem /opt/docker/unrealircd/ssl/server.key.pem
docker exec -d unrealircd chown -R ircd:ircd /home/ircd/unrealircd/conf/ssl
docker exec -d unrealircd bash -c 'kill -USR1 $(/usr/bin/supervisorctl pid irc:unreal)'
```
