#!/bin/bash

echo "🚀 Menghapus proteksi Anti Intip Application API..."

REMOTE_PATH="/var/www/pterodactyl/app/Http/Controllers/Admin/Application/ApiController.php"
TIMESTAMP=$(date -u +"%Y-%m-%d-%H-%M-%S")
BACKUP_PATH="${REMOTE_PATH}.restore_${TIMESTAMP}"

# Backup versi proteksi
if [ -f "$REMOTE_PATH" ]; then
  mv "$REMOTE_PATH" "$BACKUP_PATH"
  echo "📦 Backup versi proteksi: $BACKUP_PATH"
fi

mkdir -p "$(dirname "$REMOTE_PATH")"
chmod 755 "$(dirname "$REMOTE_PATH")"

# Kembalikan file ke versi default (tanpa proteksi ID 1)
cat > "$REMOTE_PATH" << 'EOF'
<?php

namespace Pterodactyl\Http\Controllers\Admin\Application;

use Pterodactyl\Http\Controllers\Controller;

class ApiController extends Controller
{
    /**
     * Halaman utama Application API
     */
    public function index()
    {
        // Akses default, tanpa proteksi ID
        return view('admin.api.index');
    }

    /**
     * Store Application API Key
     */
    public function store()
    {
        // Jalankan controller bawaan panel
        return app(\Pterodactyl\Http\Controllers\Admin\Application\Api\StoreApplicationApiKeyController::class)
            ->__invoke();
    }

    /**
     * Delete Application API Key
     */
    public function delete($keyId)
    {
        // Jalankan controller bawaan panel
        return app(\Pterodactyl\Http\Controllers\Admin\Application\Api\DeleteApplicationApiKeyController::class)
            ->__invoke($keyId);
    }
}
EOF

chmod 644 "$REMOTE_PATH"

echo "🎯 UNINSTALL SELESAI!"
echo "🔓 Proteksi Application API telah dihapus."
echo "📂 File dikembalikan: $REMOTE_PATH"
echo "🗂 Backup versi proteksi: $BACKUP_PATH"