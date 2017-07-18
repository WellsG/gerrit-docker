* Build images with tag
```
sudo docker build -t wguo/gerrit:0.1 .
```

* Start container (can do it via docker-compse)
```
sudo docker run -it -p 8080:8080 <image_id> /bin/bash
```

* docker-compose
```
sudo docker -compose build
sudo docker-compose run --service-ports gerrit bash
```

[Gerrit Documentaion](https://gerrit-documentation.storage.googleapis.com/Documentation/2.14.1/index.html)
[Gerrit Tutorial](https://www.mediawiki.org/wiki/Gerrit/Tutorial#Setting_up_Git)
