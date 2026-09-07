# Depo Durumu — yokbi/atomic-agent

> **Kök `README.md`'ye dokunulmadı.** O dosya upstream projesinin
> (`AtomicBot-ai/atomic-agent`) resmî README'sidir. Bu dosya, **bu fork'un
> durumunu** anlatır.

**Denetim tarihi:** 2026-09-07 · **Varsayılan dal:** `main`

---

## 1. Tek cümleyle

Bu, [`AtomicBot-ai/atomic-agent`](https://github.com/AtomicBot-ai/atomic-agent)
projesinin **değiştirilmemiş bir fork'udur.** İçinde size ait tek satır kod yoktur.

---

## 2. Ölçüm — "değiştirilmemiş" iddiasının kanıtı

```
$ git log --all --format='%an|%ae|%s' | grep -icE 'yokbi|ozkaya|claude'
0

$ git ls-remote --heads origin
refs/heads/main          ← tek dal
```

Depodaki **hiçbir commit** size ait değil; **tek dal** var. En son commit
upstream'in kendi commit'i (`Update Discord invite link in README`),
sürüm `v0.1.66`.

**Başka dalda saklı iş bulunması mümkün değil** — kontrol edilecek ikinci bir
dal yok.

---

## 3. Atomic Agent nedir (upstream projesi)

Kendi makinenizde çalışan, **yerel öncelikli (local-first)** bir AI ajanı.
Kontrol döngüsünü ve tüm durumu sizin bilgisayarınızda tutar:

- Tarayıcınızı sürer, dosya okur/düzenler
- **Onaylanmış kabuk komutlarını çalıştırır**
- Oturumlar arası bağlam hatırlar (MEMORY_FABRIC belgeleri)
- MCP üzerinden dış araç çağırır
- `llama.cpp` öncelikli — küçük nicelenmiş (quantized) modeller tüketici
  donanımında uzun, çok adımlı işlerde kullanılabilir kalsın diye

| | |
|---|---|
| Dil | TypeScript 5 |
| Çalışma ortamı | **Node.js ≥ 25.7.0** (⚠️ çok yeni — §5) |
| Dağıtım | CLI (`atomic-agent`) + Tauri sidecar |
| Model | `llama.cpp` (yerel) veya bulut sağlayıcıları |
| Sürüm | v0.1.66 |

---

## 4. Çalıştırma

**Bu fork'a ihtiyacınız yok.** Atomic Agent'ı kullanmak istiyorsanız upstream'in
kendi kurulum yolu var (README §Quick Install). Fork yalnızca **kaynak koda
bakmak veya katkı vermek** için anlamlı.

Kaynaktan derlemek isterseniz:

```bash
./run-mac-intel.sh          # Node sürümünü kontrol eder, kurar, derler, test eder
./run-mac-apple-silicon.sh
run-windows.bat
```

Betik `npm install` → `npm run lint` (tsc) → `npm run build` → `npm test`
sırasını izler.

---

## 5. ⚠️ Node.js ≥ 25.7.0 — yarın için en önemli engel

`package.json`:
```json
"engines": { "node": ">=25.7.0" }
```

Bu **çok yeni** bir Node sürümü. Karşılaştırma: diğer depolarınızın çoğu
Node 18/20/22 istiyor. Node 25 **LTS değildir** — tek sayılı Node sürümleri
"Current" hattıdır ve altı ay sonra desteklenmeyi bırakır.

**Sonucu:** Sisteminizdeki Node muhtemelen yetmez. `nvm` ile ayrı bir sürüm
kurmanız gerekir:

```bash
nvm install 25
nvm use 25
node -v      # v25.x görmelisiniz
```

`nvm` yoksa: https://github.com/nvm-sh/nvm

> Bu bir sorun değil, sadece bir gereksinim — ama fark etmeden `npm install`
> çalıştırırsanız anlaşılması zor hatalar alırsınız. Eklenen betikler bunu
> **en başta kontrol edip** açık bir mesajla söylüyor.

---

## 6. Bu ortamda ne doğrulandı, ne doğrulanmadı

### ✅ Yapılanlar
- Dal envanteri ve commit sahipliği `git` ile ölçüldü
- `package.json` okundu: sürüm, engines, scriptler, bin girdileri
- Depo yapısı incelendi

### ❌ Doğrulanamayanlar
- `npm install` **yapılmadı** — bu ortamda Node v22.22.2 var, proje ≥25.7 istiyor
- Derlenmedi, testler çalıştırılmadı
- Ajan **hiç çalıştırılmadı**; hiçbir model yüklenmedi
- Benchmark (GAIA L1 %69.8 iddiası) doğrulanmadı

---

## 7. Bulgular

### 🟢 A1 — Boş fork
Fork alınmış, üzerinde hiç çalışılmamış. → `YAPILACAKLAR-DEPO.md` A1

### 🟡 A2 — Node ≥ 25.7 gereksinimi
Kaynaktan çalıştırmayı deneyecekseniz ayrı Node sürümü gerekir (§5). → A2

### 🟡 A3 — Güvenlik: bu, kabuk komutu çalıştıran bir ajandır
Bu bir **bilgi notu**, bu depodaki bir hata değil. Atomic Agent tasarımı gereği
dosya düzenliyor, tarayıcı sürüyor ve **kabuk komutu çalıştırıyor.** Kurulum
yolu da `curl -fsSL … | sh` — yani indirilen betiği okumadan çalıştırıyorsunuz.
Kendi makinenizde denemeden önce bilinçli bir karar olmalı. → A3

**Kod hatası veya açık bulgusu yoktur** — burada size ait kod yok. Upstream'in
kendi kodunu denetlemek bu turun kapsamı dışındadır.

---

## 8. Yarınki test için

**Burada test edilecek kendi işiniz yok.** Kaynaktan derlemeyi denemek
isterseniz önce Node 25 kurun (§5), sonra `./run-mac-intel.sh`.

Vaktinizi kendi projelerinize ayırmanız daha verimli olur.

---

Kalan işler: [`YAPILACAKLAR-DEPO.md`](YAPILACAKLAR-DEPO.md)
