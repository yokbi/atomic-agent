# Yapılacaklar — yokbi/atomic-agent

## Kod işi: **YOK**

Bu, `AtomicBot-ai/atomic-agent` projesinin değiştirilmemiş bir fork'udur. Size
ait tek satır kod olmadığı için düzeltilecek hata, yazılacak test veya
kapatılacak açık da yoktur.

Aşağıdakiler **deponun kendisiyle** ilgilidir.

---

## A1 🟢 Fork'un ne işe yaradığına karar verin

**Sorun:** Fork alınmış, hiç kullanılmamış. Depo listenizde kendi
projelerinizin arasında duruyor.

**Seçenek A — Silin (önerilen).**
Kaybolacak hiçbir şey yok — kendi commit'iniz yok. Atomic Agent'ı **kullanmak**
için fork gerekmiyor; upstream'in kendi kurulum yolu var. İleride katkı vermek
isterseniz yeniden fork'lamak birkaç saniye sürer.

> GitHub → **Settings** → *Danger Zone* → **Delete this repository**

**Seçenek B — Bırakın.** Zararı yok. Bu turda eklenen `DEPO-DURUMU.md`
sayesinde deponun ne olduğu artık ilk bakışta anlaşılıyor.

**Seçenek C — Gerçekten katkı verin veya kendi sürümünüzü yapın.**
Fork'un asıl anlamı bu. O durumda upstream'i uzak olarak ekleyin:

```bash
git remote add upstream https://github.com/AtomicBot-ai/atomic-agent
git fetch upstream && git merge upstream/main    # önce güncelleyin
git checkout -b feature/konu
```

---

## A2 🟡 Kaynaktan çalıştıracaksanız: Node ≥ 25.7.0

**Sorun:** `package.json` → `"engines": { "node": ">=25.7.0" }`

Bu çok yeni bir sürüm ve **LTS değil** (tek sayılı Node sürümleri "Current"
hattıdır). Diğer depolarınız Node 18/20/22 istiyor; sisteminizdeki sürüm
büyük olasılıkla yetmeyecek.

**Yapılacak:**
```bash
# nvm ile (önerilen — diğer projelerinizin Node sürümünü bozmaz)
nvm install 25
nvm use 25
node -v        # v25.x

# nvm yoksa: https://github.com/nvm-sh/nvm
```

> **Uyarı:** Sistem genelinde Node 25'e geçmeyin. Diğer depolarınız (Next.js,
> Expo, coursera-test…) Node 20/22 üzerinde test edilmiş. `nvm` ile proje
> bazında geçiş yapın.

Bu turda eklenen `run-mac-intel.sh` betiği sürümü **en başta kontrol ediyor** ve
yetersizse anlaşılır bir mesajla duruyor — `npm install`'ın anlaşılmaz
hatalarıyla uğraşmayasınız diye.

---

## A3 🟡 Güvenlik: bu ajan kabuk komutu çalıştırır

**Bu bir hata bildirimi değil, bilinçli karar gerektiren bir not.**

Atomic Agent tasarımı gereği:
- Dosyalarınızı okur ve **düzenler**
- Tarayıcınızı sürer
- **Onaylanmış kabuk komutlarını çalıştırır**
- Oturumlar arası bağlam saklar (yani konuşmalarınız diske yazılır)

Ayrıca upstream'in önerdiği kurulum yolu:
```bash
curl -fsSL https://api.atomicbot.ai/agent-install | sh
```
Bu, **indirilen betiği okumadan çalıştırmak** demektir.

**Yapılacak (kullanmadan önce):**

- [ ] Kurulum betiğini önce **indirip okuyun**, sonra çalıştırın:
      ```bash
      curl -fsSL https://api.atomicbot.ai/agent-install -o install.sh
      less install.sh        # okuyun
      sh install.sh
      ```
- [ ] "Onaylanmış komut" mekanizmasının nasıl çalıştığını öğrenin — neyi
      onaylıyorsunuz, onay kalıcı mı?
- [ ] Bulut modeli kullanılacaksa: hangi verinin sağlayıcıya gittiğini
      kontrol edin. Yerel `llama.cpp` yolunda bu sorun yok.
- [ ] Hassas dosyaların bulunduğu bir dizinde çalıştırmayın; önce ayrı bir
      klasörde deneyin.

> Bu maddeler upstream projeye yönelik bir suçlama değil — yerel ajanların
> doğası bu. Ama makinenizde çalıştıracağınız bir yazılım için bir kez
> düşünmeye değer.

---

## Not: upstream kodu denetlenmedi

Bu denetim **sizin işinizi** kapsıyor. Atomic Agent'ın kendi kaynak kodundaki
olası hatalar veya açıklar incelenmedi — o, upstream projenin sorumluluğunda.
