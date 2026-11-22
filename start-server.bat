@echo off
echo ========================================================
echo   CHILLA'S SPICORA - Starting Production Server & Tunnel
echo ========================================================
echo.
echo Starting Next.js Production Server on port 3000...
start "Spicora Next.js Server" cmd /k "cd /d C:\Users\chill\.gemini\antigravity\scratch\chillas-spicora && npx next start -H 0.0.0.0 -p 3000"

timeout /t 3 /nobreak > nul

echo Starting Cloudflare Public Internet Tunnel...
start "Spicora Cloudflare Tunnel" cmd /k "C:\Users\chill\.gemini\antigravity\scratch\cloudflared.exe tunnel --url http://127.0.0.1:3000"

echo.
echo ========================================================
echo   Server is running!
echo   Local:      http://localhost:3000
echo   Admin:      http://localhost:3000/admin (Passcode: spicora2026)
echo   Public URL: See the Cloudflare Tunnel window for your active URL.
echo ========================================================
pause
