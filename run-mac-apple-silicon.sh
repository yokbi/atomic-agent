#!/usr/bin/env bash
#
# run-mac-apple-silicon.sh — atomic-agent fork'unu Apple Silicon Mac'te kaynaktan derler ve
# test eder. Intel Mac: run-mac-intel.sh · Windows: run-windows.bat
#
# DİKKAT: Bu, AtomicBot-ai/atomic-agent'ın DEĞİŞTİRİLMEMİŞ bir fork'udur —
# bu depoda size ait kod yoktur (bkz. DEPO-DURUMU.md). Ajanı sadece KULLANMAK
# istiyorsanız bu depoya ihtiyacınız yok; upstream'in kendi kurulum yolu var.
# Bu betik yalnızca kaynaktan derleyip incelemek/katkı vermek içindir.
#
# Kullanım:
#   ./run-mac-apple-silicon.sh           # kur + lint + derle + test
#   ./run-mac-apple-silicon.sh --check   # yalnızca ortam kontrolü (hiçbir şey kurmaz)

set -euo pipefail
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

BOLD="$(tput bold 2>/dev/null||true)"; RESET="$(tput sgr0 2>/dev/null||true)"
GREEN="$(tput setaf 2 2>/dev/null||true)"; YELLOW="$(tput setaf 3 2>/dev/null||true)"
RED="$(tput setaf 1 2>/dev/null||true)"
info(){ echo "${BOLD}==>${RESET} $*"; }
ok(){ echo "${GREEN}✓${RESET} $*"; }
warn(){ echo "${YELLOW}UYARI:${RESET} $*"; }
fail(){ echo "${RED}${BOLD}HATA:${RESET} $*" >&2; exit 1; }

echo "${BOLD}atomic-agent${RESET} — AtomicBot-ai/atomic-agent fork'u"
echo "${YELLOW}(Bu depoda size ait kod yok — DEPO-DURUMU.md)${RESET}"
echo

# --- Node sürümü: bu projenin en sık takıldığı yer --------------------------
NODE_MIN_MAJOR=25
NODE_MIN_MINOR=7

info "Node.js kontrol ediliyor (package.json: >=25.7.0)..."
command -v node >/dev/null 2>&1 || fail "Node.js bulunamadı.
  Bu proje ${BOLD}Node >= 25.7.0${RESET} istiyor — çok yeni bir sürüm, LTS değil.
  nvm ile kurun (diğer projelerinizin Node sürümünü bozmaz):
      nvm install 25 && nvm use 25
  nvm yoksa: https://github.com/nvm-sh/nvm"

NODE_V="$(node -v)"; NUM="${NODE_V#v}"
MAJOR="${NUM%%.*}"; REST="${NUM#*.}"; MINOR="${REST%%.*}"
if [ "$MAJOR" -lt "$NODE_MIN_MAJOR" ] || { [ "$MAJOR" -eq "$NODE_MIN_MAJOR" ] && [ "$MINOR" -lt "$NODE_MIN_MINOR" ]; }; then
  echo
  fail "Node ${NODE_V} bulundu; bu proje ${BOLD}>= 25.7.0${RESET} istiyor.

  Bu, diğer depolarınızdan (Node 18/20/22) belirgin şekilde daha yeni bir
  gereksinim. Sistem genelinde Node 25'e GEÇMEYİN — diğer projeleriniz bozulur.
  Bunun yerine nvm ile proje bazında geçin:

      nvm install 25
      nvm use 25
      ./run-mac-apple-silicon.sh

  Not: Node 25 tek sayılı, yani 'Current' hattı — LTS değil ve altı ay sonra
  desteklenmeyi bırakır."
fi
ok "Node.js ${NODE_V}"
ok "npm $(npm -v)"

if [[ "${1:-}" == "--check" ]]; then
  echo
  ok "Ortam uygun. Derlemek için argümansız çalıştırın: ./run-mac-apple-silicon.sh"
  exit 0
fi

# --- Kurulum ve derleme ------------------------------------------------------
if [[ -d node_modules ]]; then
  ok "node_modules mevcut — kurulum atlandı."
else
  info "Bağımlılıklar kuruluyor (npm install)... uzun sürebilir."
  npm install
fi

info "Tip kontrolü (npm run lint → tsc --noEmit)..."
npm run lint
ok "Tip kontrolü temiz."

info "Derleme (npm run build)..."
npm run build
ok "Derlendi → dist/"

info "Testler (npm test → vitest run)..."
npm test

echo
ok "${BOLD}Tamam.${RESET} CLI'yi çalıştırmak için: ${BOLD}npm run cli${RESET}"
echo
warn "Çalıştırmadan önce DEPO-DURUMU.md §7 (A3) okuyun:"
warn "bu ajan dosya düzenler, tarayıcı sürer ve kabuk komutu çalıştırır."
