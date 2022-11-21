//
//  IbanCard.swift
//  IbanPaylasimSwiftUI
//
//  Created by Çağatay Çürük on 20.11.2022.
//

import SwiftUI

struct IbanCard: View {
    
    @State private var isFavourite = false

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "gear")
                        .foregroundColor(.white)
                    Text("Garanti Bankası")
                        .foregroundColor(.white)
                    Spacer()
                    
                    Button {
                        isFavourite = !isFavourite
                    } label: {
                        Image(systemName: "heart.fill")
                            .foregroundColor(isFavourite ? .red : Color(UIColor.systemGray4))
                    }
                }.frame(maxWidth: .infinity)
                    .padding(.horizontal,20)
                
                Text("Çağatay Çürük")
                    .font(.body)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .padding(.top,40)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal,20)

                
                HStack {
                    Text("TR XXXX XXXX XXXX XXXXX XXXX")
                        .font(.body)
                        .foregroundColor(.white)
                    Text("TL")
                        .font(.body)
                        .foregroundColor(.white)
                }.padding(.top,5)
            }
         }
         .frame(width: 350, height: 170)
         .background(Color.indigo)
         .cornerRadius(10)
     }
}

struct IbanCard_Previews: PreviewProvider {
    static var previews: some View {
        IbanCard()
    }
}
