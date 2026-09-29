# Shared core boundaries

`core` berisi infrastructure dan utility yang benar-benar digunakan lintas
feature. Saat dibutuhkan, module baru ditempatkan pada `database/`, `files/`,
`images/`, `platform/`, `validation/`, atau `utils/`. `core` tidak boleh
bergantung pada feature dan tidak boleh menjadi tempat membuang business logic.

Schema database saat ini v3: migrasi additive dari v1/v2 menambahkan raw OCR,
baris/confidence, revisi operasi, serta snapshot/revisi review pada CoffeeDraft. Adapter ML Kit berada
di `features/scan/data`, bukan core. Normalisasi gambar tetap memakai
`core/images`. Lihat [implementasi OCR](../../docs/OCR_SCANNING_IMPLEMENTATION.md).
Review dan promotion: [Phase 8](../../docs/SCAN_REVIEW_IMPLEMENTATION.md).
