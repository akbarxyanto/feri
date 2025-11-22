
#!/bin/bash

REMOTE_PATH="/var/www/pterodactyl/app/Http/Controllers/Api/Client/Servers/FileUploadController.php"

echo "🚀 Menghapus proteksi Anti Upload File Besar..."

mkdir -p "$(dirname "$REMOTE_PATH")"
chmod 755 "$(dirname "$REMOTE_PATH")"

cat > "$REMOTE_PATH" << 'EOF'
<?php

namespace Pterodactyl\Http\Controllers\Api\Client\Servers;

use Pterodactyl\Models\Server;
use Pterodactyl\Repositories\Wings\DaemonFileRepository;
use Pterodactyl\Http\Requests\Api\Client\Servers\ServerUploadRequest;

class FileUploadController
{
    public function __construct(private DaemonFileRepository $fileRepository)
    {
    }

    public function __invoke(ServerUploadRequest $request, Server $server)
    {
        // Upload file normal, tanpa batasan ukuran
        return $this->fileRepository
            ->setServer($server)
            ->setRequest($request)
            ->upload($request->all());
    }
}
EOF

chmod 644 "$REMOTE_PATH"

echo "✅ Proteksi Anti Upload File Besar berhasil dihapus!"
echo "📂 Lokasi file: $REMOTE_PATH"
echo "🔓 Upload file sekarang tidak dibatasi ukuran."