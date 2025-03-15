#!/usr/bin/awk -f

BEGIN {
    FS=",";
    Chris_count = 0;
    Total_Duration = 0;
    Count_Tablet = 0;
    max_rating = 0;
    best_reader = "";
    best_book = "";
    best_rating = 0;
    popular_genre = "";
}

# Menghitung jumlah buku yang dibaca oleh "Chris Hemsworth"
$2 == "Chris Hemsworth" {
    Chris_count++;
}

# Menghitung rata-rata durasi membaca dengan "Tablet"
$5 == "Tablet" {
    Total_Duration += $6;
    Count_Tablet++;
}

# Mencari pembaca dengan rating tertinggi
$7 > best_rating {
    best_rating = $7;
    best_reader = $1;
    best_book = $3;
    best_location = $8;
}

# Menganalisis genre paling populer di Asia setelah 31 Desember 2023
$4 > "2023-12-31" && ($8 == "Asia") {
    genre_count[$9]++;
}

END {
    # Output jumlah buku yang dibaca oleh Chris Hemsworth
    print "Chris Hemsworth membaca " Chris_count " buku.";
    
    # Output rata-rata durasi membaca dengan Tablet
    if (Count_Tablet > 0) {
        avg_duration = Total_Duration / Count_Tablet;
    } else {
        avg_duration = 0;
    }
    print "Rata-rata durasi membaca dengan Tablet adalah " avg_duration " menit.";
    
    # Output pembaca dengan rating tertinggi
    print "Pembaca dengan rating tertinggi: " best_reader " - " best_book " " best_location;
    
    # Mencari genre paling populer di Asia setelah 2023
    max_genre_count = 0;
    for (genre in genre_count) {
        if (genre_count[genre] > max_genre_count) {
            max_genre_count = genre_count[genre];
            popular_genre = genre;
        }
    }
    
    if (popular_genre != "") {
        print "Genre paling populer di Asia setelah 2023 adalah " popular_genre " dengan " max_genre_count " buku.";
    } else {
        print "Tidak ada data untuk Asia setelah 2023.";
    }
}
