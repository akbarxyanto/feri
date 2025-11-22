#!/bin/bash

echo "🚀 Menghapus proteksi API Admin ID 1 only..."

# Uninstall Patch 1 – Application API
REMOTE1="/var/www/pterodactyl/app/Http/Controllers/Admin/Application/ApiController.php"
mkdir -p "$(dirname "$REMOTE1")"
chmod 755 "$(dirname "$REMOTE1")"

cat > "$REMOTE1" << 'EOF'
<?php

namespace Pterodactyl\Http\Controllers\Admin\Application;

use Pterodactyl\Http\Controllers\Controller;

class ApiController extends Controller
{
    public function index()
    {
        // Akses Application API tanpa batasan ID
        return view('admin.api.index');
    }
}
EOF
chmod 644 "$REMOTE1"


# Uninstall Patch 2 – API Credentials
REMOTE2="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Account/ApiClientController.php"
mkdir -p "$(dirname "$REMOTE2")"
chmod 755 "$(dirname "$REMOTE2")"

cat > "$REMOTE2" << 'EOF'
<?php

namespace Pterodactyl\Http\Controllers\Api\Client\Account;

use Pterodactyl\Http\Controllers\Api\Client\ClientApiController;
use Illuminate\Http\Request;

class ApiClientController extends ClientApiController
{
    public function index(Request $request)
    {
        return parent::index($request);
    }

    public function store(Request $request)
    {
        return parent::store($request);
    }

    public function delete(Request $request)
    {
        return parent::delete($request);
    }
}
EOF
chmod 644 "$REMOTE2"

echo "✅ Proteksi API Admin ID 1 berhasil dihapus!"
echo "📂 Lokasi file Application API: $REMOTE1"
echo "📂 Lokasi file API Credentials: $REMOTE2"
echo "🔓 Semua admin sekarang bisa mengakses Application API dan API Credentials."