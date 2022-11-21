//
//  ContentView.swift
//  IbanPaylasimSwiftUI
//
//  Created by Çağatay Çürük on 20.11.2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var searchText = ""
    
    @State private var isFavouriteFilter = 0


    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Item.entity(), sortDescriptors: [])
    private var ibanData: FetchedResults<Item>

    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                
  

                Picker("What is your favorite color?", selection: $isFavouriteFilter) {
                      Text("Tümü").tag(0)
                      Text("Favoriler").tag(1)
                  }
                  .pickerStyle(.segmented)
                  .padding(.horizontal,20)
                
                /*
                ScrollView {
                    IbanCard().padding(.top,20)
                    IbanCard().padding(.top,20)
                }
                 */
                

                List {
                    ForEach(ibanData.filter { $0.isFavourite==Bool(isFavouriteFilter as NSNumber) }) { item in
                        if (item.isFavourite==true) {
                            Text(item.nameSurname ?? "")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                

                    
                    
                if (ibanData.count==0) {
                        VStack(alignment: .center) {
                            Image(systemName: "creditcard.circle.fill")
                              .resizable()
                              .frame(width: 40, height: 40)
                                  .foregroundColor(.gray)
                            Text("Kayıtlı İban Adresi Bulunamadı")
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.gray)
                                .padding(.top, 10)
                        }.frame(alignment: .center)
                    }


                
                Spacer()
                HStack(alignment: .bottom) {
                    Spacer()
                    NavigationLink(destination: AddIbanView()) {
                        Text("+")
                            .frame(width: 55, height: 55)
                            .foregroundColor(Color.white)
                            .background(Color.indigo)
                            .clipShape(Circle())
                    }.padding()
                    .padding(.bottom,30)
                }
            }
                .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .automatic))
                .navigationTitle("İban Listesi")
                .background(Color(UIColor.systemGray6))
                .navigationBarItems(leading:
                                        HStack {
                    
                    NavigationLink(destination: SettingsView()) {
                        Image(systemName: "gear")
                            .foregroundColor(.indigo)
                    }
                })

            }
        }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { ibanData[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
