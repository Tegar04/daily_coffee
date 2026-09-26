# Feature ownership

Setiap feature memiliki ownership sendiri. Layer dibuat saat feature mulai
diimplementasikan: `domain/`, `application/`, `data/`, dan `presentation/`.
Dependency mengikuti arah pada `docs/ARCHITECTURE.md`; tidak ada folder global
`models`, `services`, `controllers`, atau `screens` yang mencampur feature.
