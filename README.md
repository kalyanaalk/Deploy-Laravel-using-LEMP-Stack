# Deploy-Laravel-using-LEMP-Stack
Penugasan 2 oprec camin AJK 2023
| Nama | NRP |
| :---:   | :---: | 
| Gabrielle Immanuel Osvaldo Kurniawan | 5025211135 |
| Kalyana Putri Al Kanza | 5025211137|
| Zakia Kolbi | 5025211049 |

## Digitalocean sebagai cloud provider

# 1. Membuat instance baru di digitalocean
- Sebelum membuka CMD perhatikan bagian public ip yang ada pada VM yang sudah dibuat
- Copy public ip tersebut dan buka CMD

# 2. Login CMD menggunakan SSH
- Pada CMD ketikkan ssh <user>@<ip>
- Connection dengan VM sudah sukses terbentuk jika pada cmd dapat dilihat aktifitas login terakhir

# 3. Konfigurasi Firewall Menggunakan ufw
- sudo ufw allow 'Nginx HTTP' untuk port 80
- sudo ufw allow 'Nginx HTTPS' untuk port 443
- sudo ufw allow 'OpenSSH' untuk port 22
- sudo ufw active untuk menyalakan firewall
   
# 4. Install mysql server
- sudo apt install mysql-server
- sudo mysql
- CREATE USER 'kelompok5'@'localhost' IDENTIFIED BY 'kelompok5'

# 5. Install php
- sudo apt install php-fpm php-mysql

# 6. Membuat direktori website
- sudo mkdir /var/www/kanza.akunlain.my.id mkdir untuk membuat direktori
- sudo chown -R $USER:$USER /var/www/kanza.akunlain.my.id chown untuk mengubah permission user

# 7. Konfigurasi Nginx
- sudo nano /etc/nginx/sites-available/kanza.akunlain.my.id nano untuk membuat konfigurasi Nginx
- sudo ln -s /etc/nginx/sites-available/kanza.akunlain.my.id /etc/nginx/sites-enabled/ ln untuk menyambungkan file pada sites-available
- sudo unlink /etc.nginx/sites-enabled/default unlink untuk melepaskan konfigurasi default
- sudo nginx -t untuk mengetes konfigurasi nginx
- sudo systemctl reload nginx untuk mereload nginx
   
# 8. Install Aplikasi Laravel
- cd /var/www/kanza.akunlain.my.id/ cd untuk membuka direktori website 
- git clone https://gitlab.com/kuuhaku86/web-penugasan-individu.git . untuk mengunduh repo penugasan
- apt install composer untuk menginstall composer
- composer update untuk mengupdate paket-paket yang dibutuhkan
- cp .env.example .env untuk mengkopi .env.example menjadi .env
- nano .env untuk menambahkan username dan password mysql
- php artisan key:generate perintah laravek pokoknya
- php artisan migrate untuk menggenerate database
- sudo chgrp -R www-data storage bootstrap/cache untuk mengubah permission folder
- sudo chmod -R ug+rwx storage bootstrap/cache untuk mengubah permission folder

# 9. Menambahkan konfigurasi SSL 
- apt install certbot untuk menginstall aplikasi certbot
- sudo certbot certonly --webroot --webroot-path=/var/www/kanza.akunlain.my.id/public -d kanza.akunlain.my.id -d www.kanza.akunlain.my.id untuk menambahkan SSL pada DNS

# 10. Melakukan otomasi backup access log pada NGINX setiap 1 jam dan menguploadnya ke Google Drive
