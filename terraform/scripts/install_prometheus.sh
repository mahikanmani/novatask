#! /bin/bash

sudo apt update -y
sudo apt install wget unzip -y

cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v3.3.1/prometheus-3.3.1.linux-amd64.tar.gz
tar -xvzf prometheus-3.3.1.linux-amd64.tar.gz
sudo mv prometheus-3.3.1.linux-amd64 /usr/local/bin/prometheus
sudo mv prometheus-3.3.1.linux-amd64 /usr/local/bin/promtool

sudo mkdir -p /etc/prometheus /var/lib/prometheus

sudo cp /tmp/prometheus.yml /etc/prometheus/

echo '[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=root
ExecStart=/usr/local/bin/prometheus/prometheus \
  --config.file=/etc/prometheus/prometheus.yml
  -- storage.tsdb.path=/var/lb/prometheus

[Install]
WantedBy=default.target' | sudo tee /etc/systemd/system/prometheus.service

sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
