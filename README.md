# Web3-Project-Building

# Motoko Kullanıcı Kayıt Sistemi

Bu proje, Motoko programlama dilini kullanılarak bir kullanıcı kayıt sistemi uygulamasını içerir. Temel işlevler şunlardır:

- **Kullanıcı kaydı**: Kullanıcılar benzersiz kimlik bilgileriyle hesap oluşturabilir.
- **Kullanıcı girişi**: Kullanıcılar kayıtlı bilgilerini kullanarak kimlik doğrulaması yapabilir.
- **Profil yönetimi**: Kullanıcılar kimlik bilgilerini (örneğin, şifre) güncelleyebilir.
- **Hesap silme**: Kullanıcılar sistemden hesaplarını silebilir.
- **Harici veri çekme**: Sistem, dış API'lere HTTP istekleri yapabilir ve yanıtları JSON formatında işleyebilir.
- **Gelişmiş özellikler**: Proje, veri tipleri, hata yönetimi ve eşzamanlı işlemlerle güvenli ve verimli bir çalışma sağlar.

## Projeyi VS Code'da Çalıştırma

Projeyi kurmak ve yerel olarak çalıştırmak için aşağıdaki adımları takip edebilirsiniz:

### 1. VS Code'u Yükleyin

- Eğer VS Code yüklü değilse, [buradan](https://code.visualstudio.com/) indirip yükleyebilirsiniz.

### 2. DFINITY SDK'yı Yükleyin

- Motoko dilinde geliştirme yapmak için DFINITY SDK'yı yüklemeniz gerekiyor.
- Terminal veya komut satırında şu komutu çalıştırın:
```
sh -ci "$(curl -fsSL https://internetcomputer.org/install.sh)"
```
- Bu komut, DFINITY SDK'yı bilgisayarınıza yükleyecektir.


### 3. VS Code'da Motoko Eklentisi Yükleme

- VS Code'da Motoko dilini destekleyen bir eklenti bulunmaktadır.
- VS Code'u açın ve sol kenardaki **Extensions** (Eklentiler) sekmesine gidin.
- **Motoko** anahtar kelimesini aratın ve **Motoko Language Support** eklentisini yükleyin.
  

### 4. Yeni Proje Oluşturma
- Terminalde çalıştığınız klasöre giderek yeni bir Motoko projesi oluşturun:
```
dfx new my_project
cd my_project
```
- Bu, proje için gerekli yapı dosyalarını ve `src` klasörünü oluşturur. Kendi Motoko dosyanızı `src` klasöründe oluşturup kodunuzu burada yazabilirsiniz.

### 5. Kodunuzu Yazın
- VS Code içinde `src` klasörüne giderek bir `.mo` dosyası oluşturun (örneğin, `main.mo`) ve yukarıda verdiğiniz Motoko kodunu bu dosyaya yapıştırın.

### 6. Canister'ı Çalıştırma ve Dağıtma
- Projeyi çalıştırmadan önce şu komutlarla DFINITY ağı üzerinde canister'ınızı dağıtabilir ve çalıştırabilirsiniz:
 ```
dfx start --background
dfx deploy
```
- Bu komutlar, canister'ınızı yerel ağda çalıştırmanızı sağlar. Canister, Motoko projelerinde dağıtılan ve çalışan yazılım birimidir.

### 7. Test Etme
- Kodunuzu çalıştırdıktan sonra, sonuçları kontrol etmek için `dfx` komutlarını kullanarak test yapabilirsiniz. Örneğin, `dfx canister call` ile belirli fonksiyonları çağırabilirsiniz.

