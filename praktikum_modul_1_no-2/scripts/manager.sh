#!/bin/bash
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

CORE_MONITOR="$BASE_DIR/core_monitor.sh"
FRAG_MONITOR="$BASE_DIR/frag_monitor.sh"

LOG_DIR="$(dirname "$BASE_DIR")/logs"
CORE_LOG="$LOG_DIR/core.log"
FRAG_LOG="$LOG_DIR/fragment.log"


show_menu() {
    clear
    printf "  __    ____   ___    __    ____    __                           \n"
printf " /__\  (  _ \ / __)  /__\  ( ___)  /__\                         \n"
printf "/(__)\  )   /( (__  /(__)\  )__)  /(__)\                        \n"
printf "(__)(__)(_)\_) \___)(__)(__)(____)(__)(__)                      \n"
printf "\n"
printf "      ╔══════════════════════════════╗\n"
printf "      ║        ARCAEA TERMINAL        ║\n"
printf "      ╚══════════════════════════════╝\n"
printf "┌──────────────────────────────────────┐\n"
printf "│ %-2s | %-30s │\n" "ID" "OPTION"
printf "├──────────────────────────────────────┤\n"
printf "│ %-2s | %-30s │\n" "1" "Add CPU Usage Monitoring"
printf "│ %-2s | %-30s │\n" "2" "Add RAM (Fragments) Usage Monitoring"
printf "│ %-2s | %-30s │\n" "3" "Remove CPU Usage Monitoring"
printf "│ %-2s | %-30s │\n" "4" "Remove RAM (Fragments) Usage Monitoring"
printf "│ %-2s | %-30s │\n" "5" "View Active Jobs"
printf "│ %-2s | %-30s │\n" "6" "Exit"
printf "└──────────────────────────────────────┘\n"
}

add_core_monitor() {
    read -rp "Masukkan jadwal cron untuk CPU Monitoring (misal: */5 * * * *): " schedule
    (crontab -l 2>/dev/null | grep -v "$CORE_MONITOR" ; echo "$schedule cd $BASE_DIR && /bin/bash $CORE_MONITOR >> $CORE_LOG 2>&1") | crontab -
    echo "Cronjob CPU Monitoring ditambahkan dengan jadwal: $schedule"
}

add_frag_monitor() {
    read -rp "Masukkan jadwal cron untuk RAM Monitoring (misal: */10 * * * *): " schedule
    (crontab -l 2>/dev/null | grep -v "$FRAG_MONITOR" ; echo "$schedule cd $BASE_DIR && /bin/bash $FRAG_MONITOR >> $FRAG_LOG 2>&1") | crontab -
    echo "Cronjob RAM Monitoring ditambahkan dengan jadwal: $schedule"
}

remove_core_monitor() {
    (crontab -l 2>/dev/null | grep -v "$CORE_MONITOR") | crontab -
    echo "Cronjob CPU Monitoring telah dihapus."
}

remove_frag_monitor() {
    (crontab -l 2>/dev/null | grep -v "$FRAG_MONITOR") | crontab -
    echo "Cronjob RAM Monitoring telah dihapus."
}

view_active_jobs() {
    echo "Cron Jobs Aktif:"
    echo "-----------------"
    crontab -l 2>/dev/null || echo "Tidak ada cron job aktif."
}

while true; do
    show_menu
    read -rp "Pilih opsi (1-6): " choice
    case $choice in
        1) add_core_monitor ;;
        2) add_frag_monitor;;
        3) remove_core_monitor ;;
        4) remove_frag_monitor ;;
        5) view_active_jobs ;;
        6) echo "Keluar dari Crontab Manager..."; exit 0 ;;
        *) echo "Pilihan tidak valid! Silakan pilih angka 1-6." ;;
    esac
    read -rp "Press Enter to continue..."
done

