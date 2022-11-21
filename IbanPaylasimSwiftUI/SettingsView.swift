//
//  SettingsView.swift
//  IbanRehberim
//
//  Created by Çağatay Çürük on 20.11.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var isFaceIdActive = true
    @State private var isFingerPrintActive = false
    @State private var isPasswordActive = false


    var body: some View {
        List {
            Section(header: Text("Tema")) {
                Toggle("Açık / Karanlık", isOn: $isFaceIdActive).font(.system(size: 14))

            }
            
            Section(header: Text("Güvenlik")) {
                HStack {
                    Image(systemName: "faceid")
                    Toggle("Şifre İle Giriş", isOn: $isFaceIdActive).font(.system(size: 14))

                }
                HStack {
                    Image(systemName: "touchid")
                    Toggle("Parmak izi ile Giriş", isOn: $isFingerPrintActive).font(.system(size: 14))

                }
                HStack {
                    Image(systemName: "lock.fill")
                    Toggle("Şifre İle Giriş", isOn: $isPasswordActive).font(.system(size: 14))

                }
            }
            
            Section(header: Text("Geri Bildirim")) {
                HStack {
                    Image(systemName: "message")
                    Text("Görüşlerinizi Gönderin").font(.system(size: 14))
                }
                HStack {
                    Image(systemName: "star")
                    Text("Uygulamayı Puanla").font(.system(size: 14))
                }
            }
            
            Section(header: Text("Kullanım Koşulları")) {
                HStack {
                    Image(systemName: "message")
                    Text("Kullanıcı Sözleşmesi").font(.system(size: 14))
                }
                HStack {
                    Image(systemName: "message")
                    Text("Verileri Sil").font(.system(size: 14))
                }
            }
        }
        .navigationTitle("Ayarlar")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
