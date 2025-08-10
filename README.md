# 🪄 Background Remover (Ruby + Sinatra + MiniMagick)

Bu proje, Ruby ve Sinatra kullanarak görseller üzerinde çeşitli işlemler yapmanıza olanak tanır.  
Özellikle **Remove.bg API** kullanarak arka plan kaldırma özelliğine sahiptir. Ayrıca görselleri farklı formatlara dönüştürme ve yeniden boyutlandırma seçenekleri içerir.

![Background Remover](https://via.placeholder.com/800x350?text=Background+Remover)

---

## 🚀 Özellikler
- 🪄 **Arka Plan Kaldırma** – Remove.bg API kullanarak görsellerin arka planını otomatik siler.
- 🖼 **Format Dönüştürme** – PNG ↔ JPG dönüşümü (yakında boyutlandırma seçeneği de eklenebilir).
- 🔍 **Önizleme** – Yüklenen görsel işlemden önce önizlenebilir.
- 📥 **İndirme Desteği** – İşlenmiş görselleri tek tıkla indirebilirsiniz.
- 🎨 **Bootstrap ile Modern Arayüz** – Kullanıcı dostu, mobil uyumlu tasarım.

---

## 📂 Proje Yapısı
```
.
├── app.rb               # Sinatra ana uygulaması
├── views/
│   ├── index.erb         # Ana sayfa (yükleme ve işlem seçme)
│   └── upload.erb        # İşlem tamamlandı sayfası
├── public/
│   ├── css/              # Stil dosyaları
│   ├── data/             # İşlenmiş görsellerin kaydedildiği klasör
│   └── tmp/              # Geçici dosyalar
└── Gemfile               # Gerekli Ruby gem listesi
```

---

## ⚙️ Kurulum

1. **Ruby ve Bundler kurulu olduğundan emin olun**
   ```bash
   ruby -v
   bundler -v
   ```

2. **Depoyu klonlayın**
   ```bash
   git clone https://github.com/kullanici/background-remover.git
   cd background-remover
   ```

3. **Bağımlılıkları yükleyin**
   ```bash
   bundle install
   ```

4. **Remove.bg API anahtarını ayarlayın**
   - [Remove.bg API](https://www.remove.bg/api) adresinden API anahtarınızı alın.
   - `app.rb` dosyasında `REMOVE_BG_API_KEY` değişkenini kendi anahtarınızla değiştirin.
   - Alternatif olarak `.env` dosyasında tutabilirsiniz.

5. **Uygulamayı çalıştırın**
   ```bash
   ruby app.rb -p 4567
   ```

6. **Tarayıcıdan açın**
   ```
   http://localhost:4567
   ```

---

## 🖼 Kullanım
1. Ana sayfada **görselinizi seçin**.
2. İşlem türünü seçin:
   - 🪄 Arka plan kaldır
   - 🖼 JPG formatına çevir
   - 🖼 PNG formatına çevir
3. **🚀 Yükle ve İşle** butonuna basın.
4. İşlenmiş görseli indirin.

---

## 📦 Kullanılan Teknolojiler
- [Ruby](https://www.ruby-lang.org/)
- [Sinatra](https://sinatrarb.com/)
- [MiniMagick](https://github.com/minimagick/minimagick)
- [remove.bg API](https://www.remove.bg/api)
- [Bootstrap](https://getbootstrap.com/)

---

## 📜 Lisans
Bu proje MIT lisansı ile lisanslanmıştır. İstediğiniz gibi kullanabilir ve geliştirebilirsiniz.

---

💡 **Not:** Arka plan kaldırma işlemi için Remove.bg API anahtarı zorunludur. Ücretsiz kullanım limiti dolduğunda API yanıt vermeyecektir.
