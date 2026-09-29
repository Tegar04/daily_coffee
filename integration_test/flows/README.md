# Integration flows

`local_persistence_test.dart` menggunakan UI dan database produksi Android untuk
tiga proses terpisah: seed, verify/delete, deleted. Jalankan dengan `--no-uninstall`
agar runner Flutter tidak menghapus data sebelum tahap berikutnya. Perintah
lengkap tersedia di `docs/LOCAL_PERSISTENCE_IMPLEMENTATION.md`.
