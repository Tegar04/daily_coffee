# Scan

Pemilik OCR, structured extraction, persistent scan draft, dan promotion yang
selalu membutuhkan review pengguna.

Phase 7 mengimplementasikan `domain/` untuk kontrak teks netral provider,
`data/` untuk ML Kit dan persistence draft, `application/` untuk state machine,
serta `presentation/` untuk scan dan daftar draft. Phase 8 menambahkan parser
deterministik, domain CoffeeDraft/ScanExtractedField, repository review, autosave
berurutan, form konfirmasi, dan promotion atomik ke Coffee. Lihat
[panduan OCR](../../../docs/OCR_SCANNING_IMPLEMENTATION.md) dan
[panduan review](../../../docs/SCAN_REVIEW_IMPLEMENTATION.md).
