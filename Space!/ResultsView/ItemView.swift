//
//  ItemView.swift
//  Space!
//
//  Created by Dave Piernick on 4/18/23.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    var imageURL: URL {
        let urlString = item.links?.first?.href ?? "https://example.com/icon.png"
        return URL(string: urlString)!
    }
    
    @State var showingDetail = false
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            HStack {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ZStack {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 75, height: 75)
                            .foregroundColor(.gray)
                        .padding()
                        ProgressView()
                    }
                }
                .frame(width: 50, height: 50)
                .padding()

                Text(item.data?.first?.title ?? "--")
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .onTapGesture {
            showingDetail.toggle()
        }
        .sheet(isPresented: $showingDetail) {
            ResultDetailView(item: item)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(item: Item(data: [], links: []))
    }
}
