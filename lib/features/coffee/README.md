# Coffee

Pemilik coffee collection, coffee detail, form/draft manual, favorite, dan
coffee-specific search/filter contracts.

Phase 4 mengimplementasikan domain/application/data/presentation untuk manual CRUD
dan favorite. Adapter in-memory di-wire oleh `app/composition/coffee_providers.dart`;
data hanya hidup selama sesi. Baca `docs/COFFEE_MANUAL_IMPLEMENTATION.md` sebelum
mengganti adapter dengan Drift atau menghubungkan journal/photo lifecycle.
