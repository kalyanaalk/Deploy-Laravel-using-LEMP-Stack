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
