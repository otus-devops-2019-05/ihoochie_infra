!#/bin/bash
set -e

git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install

cat > /etc/systemd/system/puma.service <<EOF
[Unit]
Description=OTUS_puma_app
After=network.target

[Service]
Type=simple
PIDFile=/home/appuser/reddit/pids/service.pid
WorkingDirectory=/home/appuser/reddit
ExecStart=/usr/local/bin/puma
Restart=always

[Install]
WantedBy=multi-user.target
EOF

systemctl enable puma
systemctl start puma

