# Deploy-Laravel-using-LEMP-Stack
Penugasan 2 oprec camin AJK 2023
| Nama | NRP |
| :---:   | :---: | 
| Gabrielle Immanuel Osvaldo Kurniawan | 5025211135 |
| Kalyana Putri Alkanza | NRP |
| Zakia | NRP |

## Azure sebagai cloud provider
# 1. Mendaftar Azure Studentplan
- Login menggunakan akun email its (@mhs.its.ac.id)
- Akan diarahkan ke web pendaftaran ikuti langkah langkahnya dan isi data dengan benar
- Student plan subscription akan memberikan 100$ kredit pada akun Azure

# 2. Membuat Virtual Machine
- Setelah login pada halaman home Azure maka cari layanan virtual machine pada azure
- Kemudian create VM baru pada server azure menggunakan student plan subscription
- Pada bagian instance detail perhatikan :
    * Virtual Machine name -> Beri nama sesuai kebutuhan
    * Region -> pilih region asia sehingga proses lebih cepat
    * Size -> pilih yang 3,5 Gib
- Pada bagian administration perhatikan :
    * Authentication type -> Pilih password sehingga memungkinkan kita mengakses melalui command promt (cmd)
    * Username & password -> Buat user dan password untuk login VM
- Pada bagian Inbound port rules perhatikan :
    * Select inbound port -> Set semuanya agar bisa diakses menggunakan SSH, HTTP, dan HTTPS
- Kemudian create VM

# 3. Login CMD menggunakan SSH
- Sebelum membuka CMD perhatikan bagian public ip yang ada pada VM yang sudah dibuat
- Copy public ip tersebut dan buka CMD
- Pada CMD ketikkan ssh <user>@<ip>
- Connection dengan VM sudah sukses terbentuk jika pada cmd dapat dilihat aktifitas login terakhir

# 4. Konfigurasi Firewall Menggunakan ufw
- sudo ufw allow 'Nginx HTTP' untuk port 80
- sudo ufw allow 'Nginx HTTPS' untuk port 443
- sudo ufw allow 'OpenSSH' untuk port 22
- sudo ufw active untuk menyalakan firewall
   
# 5. Install mysql server
- sudo apt install mysql-server
- sudo mysql
- CREATE USER 'kelompok5'@'localhost' IDENTIFIED BY 'kelompok5'

# 6. Install php
- sudo apt install php-fpm php-mysql

# 7. Membuat direktori website
- sudo mkdir /var/www/kanza.akunlain.my.id mkdir untuk membuat direktori
- sudo chown -R $USER:$USER /var/www/kanza.akunlain.my.id chown untuk mengubah permission user

# 8. Konfigurasi Nginx
- sudo nano /etc/nginx/sites-available/kanza.akunlain.my.id nano untuk membuat konfigurasi Nginx
- sudo ln -s /etc/nginx/sites-available/kanza.akunlain.my.id /etc/nginx/sites-enabled/ ln untuk menyambungkan file pada sites-available
- sudo unlink /etc.nginx/sites-enabled/default unlink untuk melepaskan konfigurasi default
- sudo nginx -t untuk mengetes konfigurasi nginx
- sudo systemctl reload nginx untuk mereload nginx
   
# 9. Install Aplikasi Laravel
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

# 10. Menambahkan konfigurasi SSL 
- apt install certbot untuk menginstall aplikasi certbot
- sudo certbot certonly --webroot --webroot-path=/var/www/kanza.akunlain.my.id/public -d kanza.akunlain.my.id -d www.kanza.akunlain.my.id untuk menambahkan SSL pada DNS
