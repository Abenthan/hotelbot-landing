# Contexto del Proyecto — HotelBot

> Pega este archivo completo al inicio de una sesión de Claude Code para que tenga todo el contexto sin explicar nada.

---

## 🎯 Qué es este proyecto

**HotelBot** es un SaaS de atención automática vía WhatsApp para hoteles pequeños y anfitriones Airbnb en Colombia.

- Responde mensajes 24/7 con IA (Claude de Anthropic)
- Detecta idioma automáticamente (ES / EN)
- Hace handoff al humano cuando es necesario
- Soporta múltiples hoteles desde una sola instancia
- Stack: Node.js + Express + Anthropic API + Caddy + Docker

---

## 💻 Stack técnico

| Capa | Tecnología |
|---|---|
| Frontend | HTML + CSS + JS vanilla (una sola página) |
| Backend | Node.js + Express |
| IA | Anthropic API (`claude-haiku-4-5-20251001`) |
| Web server | Caddy (SSL automático) |
| Infra | Ubuntu VPS + Docker |
| Deploy | GitHub + git pull manual |
| Máquina local | Windows + Claude Code |

---

## 📁 Estructura del repositorio

```
hotelbot-landing/
├── index.html         ← landing page + chatbot demo integrado
├── server.js          ← proxy backend (guarda API key segura)
├── package.json
├── .env               ← NO en GitHub (solo en servidor)
├── .gitignore         ← ignora .env
├── CONTEXT.md         ← este archivo
└── SERVER.md          ← config del servidor
```

---

## 🌐 URLs

- **Landing pública:** https://hotelbot.maxansistemas.com
- **Repo GitHub:** https://github.com/[usuario]/hotelbot-landing
- **API proxy:** `POST /api/chat` (mismo servidor, puerto 3000)

---

## 🔑 Variables de entorno (.env — solo en servidor)

```
ANTHROPIC_API_KEY=sk-ant-...
PORT=3000
NODE_ENV=production
```

---

## 🤖 Cómo funciona el chatbot

1. `index.html` contiene la landing page y el chatbot (interfaz WhatsApp)
2. El chat llama a `POST /api/chat` en el backend local
3. `server.js` recibe la llamada, agrega la API key y llama a Anthropic
4. La respuesta vuelve al frontend y se muestra en el chat
5. La API key **nunca se expone** en el frontend ni en GitHub

---

## 🏨 Cliente piloto actual

**Hospedaje San Diego** — Medellín, Colombia
- 14 habitaciones (dobles, cuádruples, quíntuples)
- Check-in 2PM / Check-out 12PM
- WiFi gratis · Cocina compartida · Sin parqueadero · Sin mascotas
- Metro Industriales a 600m · Centro Comercial Premium Plaza a 150m
- Calificación Booking: 8.3/10 (65 reseñas)
- La dueña maneja todo desde WhatsApp y Excel — cliente piloto ideal

---

## 🚀 Deploy

```bash
# Desde Windows (local)
git add . && git commit -m "mensaje" && git push origin master

# En el servidor
bash /var/www/hotelbot/deploy.sh
```

`deploy.sh` en `/var/www/hotelbot/deploy.sh`:
```bash
#!/bin/bash
cd /var/www/hotelbot/hotelbot-landing
git pull origin master
npm install --production
pm2 restart hotelbot
echo "✅ HotelBot actualizado: $(date)"
```

---

## 📋 Tareas pendientes

- [ ] Implementar `server.js` como proxy Node.js
- [ ] Configurar PM2 en el servidor
- [ ] Actualizar Caddyfile para apuntar al puerto 3000
- [ ] Probar flujo completo con API key en servidor
- [ ] Demo con cliente piloto (Hospedaje San Diego)
- [ ] Panel básico de configuración de FAQs

---

## 💡 Instrucciones para Claude Code

1. El archivo principal es `index.html` — landing + chatbot en un solo archivo HTML
2. El backend es `server.js` — proxy simple hacia Anthropic API
3. **Nunca hardcodees la API key** en archivos que vayan a GitHub
4. La rama principal es `master` (no `main`)
5. Servidor: Ubuntu, usuario `ubuntu`, Caddy como web server
6. Puerto del backend: `3000`
7. Modelo de IA: `claude-haiku-4-5-20251001` (rápido y económico para demos)
8. Para referencias al servidor, ver `SERVER.md`
