# Shared core boundaries

`core` berisi infrastructure dan utility yang benar-benar digunakan lintas
feature. Saat dibutuhkan, module baru ditempatkan pada `database/`, `files/`,
`images/`, `platform/`, `validation/`, atau `utils/`. `core` tidak boleh
bergantung pada feature dan tidak boleh menjadi tempat membuang business logic.
