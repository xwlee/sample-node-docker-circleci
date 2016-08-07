#!/bin/bash
docker push xwlee/sample-node

ssh deploy@128.199.77.198 << EOF
docker pull xwlee/sample-node:latest
docker stop web || true
docker rm web || true
docker rmi xwlee/sample-node:current || true
docker tag xwlee/sample-node:latest xwlee/sample-node:current
docker run -d --net app --restart always --name web -p 3000:3000 xwlee/sample-node:current
EOF
