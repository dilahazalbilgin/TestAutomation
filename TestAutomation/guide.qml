import QtQuick
import QtQuick.Controls // Window, Button, ScrollView ve modal özelliği için GEREKLİDİR
import QtQuick.Layouts  // ColumnLayout ve Layout özellikleri için GEREKLİDİR

Window {
    id: guideWindow
    width: 600
    height: 500
    // Ana pencerenin önünde açılması ve etkileşim gerektirmesi için
    modality: Qt.WindowModal
    title: "Kullanma Kılavuzu"

    // Ana layout
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 10
        spacing: 10

        // Kaydırılabilir metin alanı
        ScrollView {
            Layout.fillWidth: true
            Layout.fillHeight: true
            clip: true // Kenarlardan taşan içeriği gizler

            Text {
                // Not: Bu metnin genişliği ScrollView'a bağlanmalıdır ki satır sonlarında alta geçebilsin.
                width: availableWidth
                wrapMode: Text.WordWrap // Uzun metinleri otomatik olarak alt satıra indir
                font.pixelSize: 14

                // =========================================================
                // BURAYA KENDİ UZUN KULLANMA KILAVUZU METNİNİZİ YAPIŞTIRIN
                // =========================================================
                text: "Dinamik Test Paneli Kullanım Kılavuzu\n\n" +
                      "1. Genel Bakış\n" +
                      "Dinamik Test Paneli, çeşitli test prosedürlerini yönetmek, izlemek ve raporlamak için tasarlanmış kapsamlı bir uygulamadır. Bu kılavuz, uygulamanın temel özelliklerini ve nasıl kullanılacağını açıklar.\n\n" +
                      "2. Ana Menü Özellikleri\n\n" +
                      "2.1 Ana Sayfa\n" +
                      "Tüm Sekmeleri Kapat: Açık olan tüm test sekmelerini kapatır\n" +
                      "Yeni Sekme Aç: Yeni test başlatma diyalog penceresini açar\n" +
                      "Ayarlar: Sistem ayarlarına erişim sağlar (geliştirme aşamasında)\n\n" +
                      "2.2 Test Başlat\n" +
                      "Yeni bir test prosedürü başlatmak için kullanılır\n" +
                      "Test parametrelerini ve dosyalarını yapılandırma imkanı sunar\n\n" +
                      "2.3 Canlı Test İzleme\n" +
                      "Devam eden testleri gerçek zamanlı olarak izleme\n" +
                      "Test durumlarını ve ilerlemeyi görüntüleme\n\n" +
                      "2.4 Test Raporları\n" +
                      "Tamamlanan testlerin raporlarını görüntüleme\n" +
                      "Geçmiş test verilerini analiz etme\n\n" +
                      "2.5 Ayarlar\n" +
                      "Uygulama ayarlarını düzenleme\n" +
                      "Kullanıcı tercihlerini yapılandırma\n\n" +
                      "3. Test Başlatma İşlemi\n" +
                      "Ana menüden \"Test Başlat\" butonuna tıklayın\n\n" +
                      "Test Seçimi:\n" +
                      "Açılır menüden test türünü seçin (PBİT, CBİT, KONFİGÜRASYON vb.)\n\n" +
                      "Test Tipi Seçimi:\n" +
                      "BlackBox, WhiteBox, Regression vb. test metodlarını seçin\n\n" +
                      "Test Parametreleri:\n" +
                      "JSON formatında veya form şeklinde test parametrelerini girin\n" +
                      "Örnek: { \"param1\": \"deger1\", \"param2\": 123 }\n\n" +
                      "Dosya Yükleme:\n" +
                      "\"Dosya Yükle\" butonu ile test scriptini seçin\n" +
                      "Dosya adı otomatik olarak oluşturulacaktır\n\n" +
                      "Başlatma:\n" +
                      "\"Başlat\" butonu ile testi başlatın\n" +
                      "\"İptal Et\" butonu ile işlemi sonlandırın\n\n" +
                      "4. Test İzleme ve Yönetme\n\n" +
                      "4.1 Devam Eden Testler\n" +
                      "Ana sayfada devam eden testler listelenir\n" +
                      "Her test için:\n" +
                      "Test adı ve durumu görüntülenir\n" +
                      "Testi kapatmak için \"✕\" butonunu kullanın\n" +
                      "Detayları görüntülemek için testin üzerine tıklayın\n\n" +
                      "4.2 Test Detayları\n" +
                      "Seçili testin başarı oranı dairesel grafikle gösterilir\n" +
                      "Test case sayıları ve geçme oranları listelenir\n" +
                      "Son yapılan testler kronolojik sırayla görüntülenir\n\n" +
                      "4.3 Genel İstatistikler\n" +
                      "Tüm testlerin toplam başarı oranı\n" +
                      "Toplam test case sayıları\n" +
                      "Genel performans metrikleri\n\n" +
                      "5. Sekme Yönetimi\n" +
                      "Her yeni test otomatik olarak yeni bir sekmede açılır\n" +
                      "Sekmeler arasında geçiş yapmak için üst menüyü kullanın\n" +
                      "Sekmeyi kapatmak için sekme üzerindeki \"✕\" butonunu kullanın\n\n" +
                      "6. Sık Kullanılan Kısayollar\n" +
                      "Ctrl+N: Yeni test başlat\n" +
                      "Ctrl+W: Aktif sekmeyi kapat\n" +
                      "Ctrl+Tab: Sonraki sekmeye geç\n" +
                      "Ctrl+Shift+Tab: Önceki sekmeye geç\n\n" +
                      "7. Sorun Giderme\n\n" +
                      "7.1 Test Başlatılamıyor\n" +
                      "Test seçimi yapıldığından emin olun\n" +
                      "Gerekli dosyanın yüklendiğini kontrol edin\n" +
                      "Parametrelerin doğru formatta olduğunu doğrulayın\n\n" +
                      "7.2 Alt Menü Görünmüyor\n" +
                      "\"Ana Sayfa\" butonunun üzerine gelin\n" +
                      "Mouse'un menü dışına çıkmadığından emin olun\n\n" +
                      "7.3 Performans Sorunları\n" +
                      "Çok sayıda sekme açıksa gereksiz olanları kapatın\n" +
                      "Uygulamayı yeniden başlatmayı deneyin\n\n" +
                      "8. İletişim\n" +
                      "Teknik destek veya sorularınız için:\n\n" +
                      "Email: destek@tei.com.tr\n" +
                      "Telefon: 0 222 211 21 00\n"

            }
        }

        // Kapatma butonu
        Button {
            text: "Kapat"
            Layout.alignment: Qt.AlignRight
            onClicked: guideWindow.close() // Bu pencereyi kapatır
        }
    }
}
