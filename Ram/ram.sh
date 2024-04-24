#!/bin/bash

cleanup() {
    rm -rf ram.sh
    rm -rf TestRepo
    echo " Cleaning up temporary files"
    echo ""
    echo ""
    echo -e " To try again this script,\n you can copy the command from github"
    echo ""
    echo ""
}

trap cleanup EXIT

clear

# Memulai sesi tmux dengan nama "Monitoring"
tmux new-session -d -s Monitoring
tmux 'htop'

# Memecah layar menjadi dua panel secara vertikal
tmux split-window -v

# Menjalankan perintah watch dalam panel baru di bawah panel utama
tmux send-keys -t Monitoring:1 'watch -n1 -tc "free -w"' C-m

# Menjalankan skrip shell lainnya jika ada di bawah ini

# Menampilkan pesan dan menunggu input dari pengguna
read -p " Press any key to continue"

# Keluar dari sesi tmux
tmux kill-session -t Monitoring
