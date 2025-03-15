#!/bin/bash
ASCII_ART="
────────▄███████████▄────────
─────▄███▓▓▓▓▓▓▓▓▓▓▓███▄─────
────███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███────
───██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██───
──██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██──
─██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██─
██▓▓▓▓▓▓▓▓▓███████▓▓▓▓▓▓▓▓▓██
██▓▓▓▓▓▓▓▓██░░░░░██▓▓▓▓▓▓▓▓██
██▓▓▓▓▓▓▓██░░███░░██▓▓▓▓▓▓▓██
███████████░░███░░███████████
██░░░░░░░██░░███░░██░░░░░░░██
██░░░░░░░░██░░░░░██░░░░░░░░██
██░░░░░░░░░███████░░░░░░░░░██
─██░░░░░░░░░░░░░░░░░░░░░░░██─
──██░░░░░░░░░░░░░░░░░░░░░██──
───██░░░░░░░░░░░░░░░░░░░██───
────███░░░░░░░░░░░░░░░███────
─────▀███░░░░░░░░░░░███▀─────
────────▀███████████▀────────

P O K E M O N   A N A L Y S I S
"

show_help_menu() {
    echo "$ASCII_ART"
    echo "Usage: $0 <filename.csv> [options]"
    echo
    echo "Options:" 
    echo "  --filter <type>      Filter Pokémon by type (e.g., Water, Fire, Grass)"
    echo "  --stats              Show Pokémon usage statistics"
    echo "  -h, --help           Show this help screen"
    echo "Menu ini masih sementara(Karena pembagian jobdesk pengerjaan yang berbeda, jadi belum sepenuhnya berfungsi)"
}

#filter(){}

#stats(){}

if [ $# -eq 0 ]; then
    show_help_menu
    exit 1
fi

if [ "$1" == "-h" ] || [ "$1" == "--help" ]; then
    show_help_menu
    exit 0
fi

VALIDASI_CSV_FILE="$1"
if [ ! -f "$VALIDASI_CSV_FILE" ]; then
    echo "Error: File '$VALIDASI_CSV_FILE' not found."
    echo "Use -h or --help for more information."
    exit 1
fi

shift

while [ $# -gt 0 ]; do
    case "$1" in
        --filter)
            if [ -z "$2" ]; then
                echo "Error: No filter option provided"
                echo "Use -h or --help for more information."
                exit 1
            fi
            FILTER_TYPE="$2"
            echo "Filtering Pokémon by type: $FILTER_TYPE"
            shift 2
            ;;
        --stats)
            echo "Displaying Pokémon usage statistics..."
            shift
            ;;
        *)
            echo "Error: Unknown option '$1'"
            echo "Use -h or --help for more information."
            exit 1
            ;;
    esac
done

