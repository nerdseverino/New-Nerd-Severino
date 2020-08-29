# !/bin/bash
#
# File: hugoServer
#
# Purpose: Run the Hugo container as a local server
#
# This requires Docker 17.06.0-ce or above.
#
# NOTE: The docker image provided by jojomi is not managed or audited by devopsdays
ip=`ip addr show | grep global | grep -oE '((1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])\.){3}(1?[0-9][0-9]?|2[0-4][0-9]|25[0-5])' | sed -n '1p'`


docker stop hugo-server
docker rm   hugo-server
docker stop portainer
docker rm   portainer

#docker run -tip 1313:1313 -v $(pwd):/home/circleci/project:cached -e HUGO_BASEURL="http://localhost:1313" --name hugo-server --entrypoint "" cibuilds/hugo:0.67.0 hugo server --watch --bind ""

#docker run -tip 1313:1313 -v $(pwd):/home/circleci/project:cached -e HUGO_BASEURL="http://localhost:1313" --name hugo-server --entrypoint "" hypriot/rpi-hugo:0.67.0 hugo server --watch --bind ""

#docker run -d -p 1313:1313 -v $(pwd):/www hypriot/rpi-hugo server --bind "" -w -D

docker run -d -p 1313:1313 --name hugo-server -v $(pwd):/www hypriot/rpi-hugo server -b http://$ip/ --bind=0.0.0.0 -w -D --theme=hyde-x

docker run -d -p 9000:9000 --name portainer  -v /var/run/docker.sock:/var/run/docker.sock hypriot/rpi-portainer

