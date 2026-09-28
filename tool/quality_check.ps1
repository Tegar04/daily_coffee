$ErrorActionPreference = 'Stop'
Set-Location (Resolve-Path (Join-Path $PSScriptRoot '..'))

flutter pub get
if ($LASTEXITCODE -ne 0) { throw 'Dependency resolution failed.' }
dart run build_runner build
if ($LASTEXITCODE -ne 0) { throw 'Code generation failed.' }
dart format --output=none --set-exit-if-changed lib test integration_test
if ($LASTEXITCODE -ne 0) { throw 'Formatting check failed.' }
flutter analyze
if ($LASTEXITCODE -ne 0) { throw 'Static analysis failed.' }
flutter test
if ($LASTEXITCODE -ne 0) { throw 'Tests failed.' }
flutter build apk --debug
if ($LASTEXITCODE -ne 0) { throw 'Debug build failed.' }
