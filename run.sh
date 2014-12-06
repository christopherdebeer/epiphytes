docker rm -f wired200
docker build -t wired200 .
docker run -d --name wired200 -t wired200

