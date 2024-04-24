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

# Menjalankan perintah watch dalam sesi tmux
tmux send-keys -t Monitoring 'watch -n1 -tc "
free -h

"' C-m

# Menjalankan skrip shell lainnya jika ada di bawah ini

# Menampilkan pesan dan menunggu input dari pengguna
read -p " Press any key to continue"

# Keluar dari sesi tmux
tmux kill-session -t Monitoring
