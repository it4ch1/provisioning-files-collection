{\rtf1\ansi\ansicpg1252\cocoartf1504\cocoasubrtf830
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
{\*\expandedcolortbl;;}
\paperw11900\paperh16840\margl1440\margr1440\vieww19180\viewh8400\viewkind0
\pard\tx566\tx1133\tx1700\tx2267\tx2834\tx3401\tx3968\tx4535\tx5102\tx5669\tx6236\tx6803\pardirnatural\partightenfactor0

\f0\fs24 \cf0 apt-get -qq purge apache2 -y\
apt-get -qq update && apt-get -qq upgrade -y\
apt-get install -qq -y nginx-full\
\
####\
# SET-UP SSL\
####\
\
mkdir /etc/nginx/ssl\
country=IT\
state=Italy\
locality=Rome\
organization=HackingSquare.net\
organizationalunit=IT\
email=admin@hackingsquare.net\
openssl req -x509 -nodes -days 3650 -newkey rsa:2048 -keyout /etc/nginx/ssl/nginx.key -out /etc/nginx/ssl/nginx.crt -subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"\
\
cat <<EOF > /etc/nginx/sites-available/default\
server \{\
	listen 80 default_server;\
	listen [::]:80 default_server;\
\
	# SSL configuration\
	#\
	 listen 443 ssl default_server;\
	 listen [::]:443 ssl default_server;\
\
	root /var/www/html;\
\
	index index.html index.htm index.nginx-debian.html;\
\
	server_name _;\
	ssl_certificate /etc/nginx/ssl/nginx.crt;\
        ssl_certificate_key /etc/nginx/ssl/nginx.key;\
\
	location / \{\
		# First attempt to serve request as file, then\
		# as directory, then fall back to displaying a 404.\
		try_files $uri $uri/ =404;\
	\}\
\
\}\
service nginx restart}