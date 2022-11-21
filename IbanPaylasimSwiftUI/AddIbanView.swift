//
//  AddIbanView.swift
//  IbanPaylasimSwiftUI
//
//  Created by Çağatay Çürük on 20.11.2022.
//

import SwiftUI
import CoreData
import PhotosUI

struct AddIbanView: View {

    @State private var ibanTextField: String = ""
    @State private var nameSurnameTextField: String = ""
    @State private var currencyTextField: String = ""
    @State private var bankNameTextField: String = ""
    @State private var descripitonTextField: String = ""
    @State private var isFavourite: Bool = true
    @State private var imageField: String = ""

    @Environment(\.presentationMode) var presentationMode

    @State private var showingCredits = false
    var banksName = ["Akbank", "Garanti Bankası", "İş Bankası", "QNB", "Ing", "Yapı Kredi"]
    @State private var selectedColor = "Red"
    
    @State private var showingAlert = false
    @State private var alertMessage = ""

    @State private var selectedItem: PhotosPickerItem?

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
    private var ibanData: FetchedResults<Item>
    
    var body: some View {
        VStack {
            
            IbanCard()
                .padding(.top,20)
            
            /*
            Button("Show Credits") {
                showingCredits.toggle()
            }
            
            .sheet(isPresented: $showingCredits) {
                List {
                    ForEach(banksName, id: \.self) { color in
                        Text(color.description.capitalized)
                    }
                }
            }
             */
            
                TextField("", text: $ibanTextField)
                    .placeholder(when: ibanTextField.isEmpty) {
                          Text("İban Numarası")
                  }
                .padding()
                .keyboardType(.numberPad)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(UIColor.systemFill), lineWidth: 2)
                )
                .cornerRadius(15)
                .padding()
                .font(Font.body.weight(.medium))

            TextField("", text: $nameSurnameTextField)
                    .placeholder(when: nameSurnameTextField.isEmpty) {
                          Text("İsim Soyisim")
                  }
                .padding()
                .keyboardType(.numberPad)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(UIColor.systemFill), lineWidth: 2)
                )
                .cornerRadius(15)
                .padding()
                .font(Font.body.weight(.medium))

            
            HStack {
                TextField("", text: $currencyTextField)
                    .placeholder(when: currencyTextField.isEmpty) {
                          Text("Döviz")
                  }
                    .padding()
                    .keyboardType(.numberPad)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(UIColor.systemFill), lineWidth: 2)
                    )
                    .cornerRadius(15)
                    .padding()
                    .font(Font.body.weight(.medium))

                TextField("", text: $bankNameTextField)
                    .placeholder(when: bankNameTextField.isEmpty) {
                          Text("Banka")
                  }
                    .padding()
                    .keyboardType(.numberPad)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(UIColor.systemFill), lineWidth: 2)
                    )
                    .cornerRadius(15)
                    .padding()
                    .font(Font.body.weight(.medium))
            }
            
            TextField("", text: $descripitonTextField)
                .placeholder(when: descripitonTextField.isEmpty) {
                      Text("Açıklama")
              }
                .frame(height:50)
                .padding()
                .keyboardType(.numberPad)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color(UIColor.systemFill), lineWidth: 2)
                )
                .cornerRadius(15)
                .padding()
                .font(Font.body.weight(.medium))
            
                HStack {
                    PhotosPicker(
                           selection: $selectedItem,
                           matching: .images,
                           photoLibrary: .shared()) {
                               Image(systemName: "photo")
                                   .frame(width: 300, height: 40)
                           }
                }.padding(30)
                .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 14)
                            .stroke(Color(UIColor.systemFill), lineWidth: 2)
                    )
                    .cornerRadius(10)
            Spacer()
                .alert(alertMessage, isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
                }
        }
        .navigationTitle("İban Ekle")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing:
                       HStack {
                           Image(systemName: "photo")
                           Button("Ekle") {
                               addItem()
                           }
        })
        .background(Color(UIColor.systemGray6))
    }
    
    private func addItem() {
        if (ibanTextField.isEmpty) {
            alertMessage = "İban Bilgisi Boş Olamaz"
            showingAlert = true
        }else if (ibanTextField.isEmpty) {
            alertMessage = "İsim Soyisim Bilgisi Boş Olamaz"
            showingAlert = true
        }
        
        else {
            withAnimation {
                let newItem = Item(context: viewContext)
                newItem.ibanValue = ibanTextField
                newItem.nameSurname = nameSurnameTextField
                newItem.currency = currencyTextField
                newItem.bankName = bankNameTextField
                newItem.descriptionValue = descripitonTextField
                newItem.isFavourite = isFavourite
                newItem.timestamp = Date()
                
                do {
                    try viewContext.save()
                    presentationMode.wrappedValue.dismiss()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }
        }
    }
}


struct AddIbanView_Previews: PreviewProvider {
    static var previews: some View {
        AddIbanView()
    }
}


extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
                .foregroundColor(Color(UIColor.systemGray2))
            self
        }
    }
}
