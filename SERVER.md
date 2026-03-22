# Configuración del Servidor — Maxan Sistemas

> Copia este contexto al inicio de cualquier conversación con Claude Code cuando trabajes con el servidor.

---

## 🖥️ Servidor

- **OS:** Ubuntu Linux (VPS)
- **Hostname:** `instance-20250828-1958`
- **Usuario SSH:** `ubuntu`
- **Web server:** Caddy (SSL automático vía Let's Encrypt)
- **Contenedores:** Docker + Docker Compose
- **Process manager:** PM2 (para apps Node.js)
- **Máquina local:** Windows con Claude Code

---

## 🌐 Subdominios activos

| Subdominio | Servicio | Puerto |
|---|---|---|
| `maxansistemas.com` | Frontend + API | 4000 / 5000 |
| `n8n.maxansistemas.com` | n8n automatización | 5678 |
| `soporte.maxansistemas.com` | Sistema de soporte | 8080 |
| `auth.maxansistemas.com` | Autenticación | 8081 |
| `evolution.maxansistemas.com` | Evolution API WhatsApp | 8083 |
| `hotelbot.maxansistemas.com` | HotelBot | 3000 |

---

## 📁 Estructura de directorios

```
/var/www/
└── hotelbot/
    ├── deploy.sh
    └── hotelbot-landing/
        ├── index.html
        ├── server.js
        ├── package.json
        ├── .env              ← NO en GitHub
        └── .gitignore
```

---

## 🔧 Caddy

Config: `/etc/caddy/Caddyfile`

Recargar después de cambios:
```bash
sudo caddy reload --config /etc/caddy/Caddyfile
```

Agregar nuevo subdominio con app Node:
```caddy
nuevo.maxansistemas.com {
    reverse_proxy localhost:PUERTO
}
```

Agregar nuevo subdominio con archivos estáticos:
```caddy
nuevo.maxansistemas.com {
    root * /var/www/proyecto
    file_server
}
```

---

## 🐳 Docker

```bash
# Ver contenedores activos
docker ps

# Reiniciar servicio
docker compose restart nombre-servicio

# Ver logs en tiempo real
docker compose logs -f nombre-servicio
```

---

## 🚀 Flujo de deploy estándar

```bash
# Desde Windows (local)
git add . && git commit -m "mensaje" && git push origin master

# En el servidor
bash /var/www/PROYECTO/deploy.sh
```

Plantilla `deploy.sh`:
```bash
#!/bin/bash
cd /var/www/PROYECTO/repo
git pull origin master
npm install --production
pm2 restart app-name
echo "✅ Actualizado: $(date)"
```

---

## ⚠️ Reglas importantes

- Scripts: siempre `bash script.sh` o `./script.sh`, nunca solo `script.sh`
- Permisos ejecución: `chmod +x script.sh`
- Permisos carpeta: `sudo chown -R ubuntu:ubuntu /var/www/PROYECTO`
- Git safe directory: `git config --global --add safe.directory /ruta`
- `.env` **nunca** va a GitHub — siempre en `.gitignore`
- Variables de entorno se crean manualmente en el servidor
- La rama principal es `master` (no `main`)
