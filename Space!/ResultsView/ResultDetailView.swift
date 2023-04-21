//
//  ResultDetailView.swift
//  Space!
//
//  Created by Dave Piernick on 4/19/23.
//

import SwiftUI

struct ResultDetailView: View {
    var item: Item
    var imageURL: URL { return URL(string: item.links?.first?.href ?? "https://example.com/icon.png")! }
    var dateString: String? { return Date.dateFromString(item.data?.first?.date_created ?? "")?.formatted(date: .abbreviated, time: .omitted) }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                AsyncImage(url: imageURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ZStack {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                            .padding()
                        ProgressView()
                            .scaleEffect(4)
                    }
                }
                
                Text(item.data?.first?.description ?? "")
                    .padding()
                    .font(.system(size: 24, weight: .medium, design: .rounded))
                    .foregroundColor(.white)
                
                if let dateString = dateString {
                    Text("Date created: \(dateString)")
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
        .preferredColorScheme(.dark)
    }
}

struct ResultDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ResultDetailView(item: Item(data: [], links: []))
    }
}
