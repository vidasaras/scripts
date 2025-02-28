#!/bin/sh

curl -fsSL https://ollama.com/install.sh | sh
sudo systemctl stop ollama
docker run -d -p 3000:8080 -v ollama:/root/.ollama -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:ollama
curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
	| sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
	&& echo "deb https://ngrok-agent.s3.amazonaws.com buster main" \
	| sudo tee /etc/apt/sources.list.d/ngrok.list \
	&& sudo apt update \
	&& sudo apt install ngrok
ngrok config add-authtoken 2sGCDtWQ902N6GDPvyLScDZqQxV_6u87G36UvkSAK8ZDrCXTq
ollama serve &
ngrok http 3000 

#ngrok http 11434 --host-header="localhost:11434"
