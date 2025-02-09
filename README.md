# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version 3.3.0
* Rails version 8.0.1

* System dependencies
postgresql

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

change path in backup_postgresql.sh

crontab -e

0 2 * * * /path/to/backup_postgresql.sh




sudo nano /etc/hosts


192.168.*.*  astha.local




* sudo nano /etc/nginx/sites-available/patient



**************************
server {
    listen 80;
    server_name astha.clinic;

    location / {
        proxy_pass http://localhost:3000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}

************************

* sudo ln -s /etc/nginx/sites-available/patient /etc/nginx/sites-enabled/
* sudo nginx -t
* sudo systemctl reload nginx



* ...
