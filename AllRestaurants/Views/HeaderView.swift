//
//  HeaderView.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/1/22.
//

import SwiftUI

struct HeaderView: View {

    @State var text: String = ""
    @Environment(\.contentCoordinator) private var coordinator

    var body: some View {
        VStack(alignment: .center) {
            Image(appImage: .logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 40)
            HStack {
                SearchButton {
                    coordinator.filterRestaurants(using: text)
                }
                SearchBar(text: $text)
            }
            .padding(.horizontal, 25)
        }
    }
}

private struct SearchButton: View {

    var onFilter: () -> Void

    var body: some View {
        Button(LocalizedString.filter.value) {
            onFilter()
        }
        .foregroundColor(.appColor(.detail))
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .roundedBorder(
            color: .appColor(.border),
            radius: 5,
            width: 2
        )
    }
}

private struct SearchBar: View {

    @Binding var text: String
    @State private var isEditing = false
    @Environment(\.contentCoordinator) private var coordinator

    var body: some View {
        HStack {
            ZStack {
                TextField(LocalizedString.search.value, text: $text)
                    .foregroundColor(.appColor(.title))
                    .font(.headline)
                    .multilineTextAlignment(.leading)
                    .padding(8)
                    .background(Color.white)
                    .cornerRadius(8)
                    .padding(.horizontal, 10)
                    .roundedBorder(color: .appColor(.border), radius: 8, width: 2)
                    .onTapGesture {
                        self.isEditing = true
                    }

                HStack {
                    Spacer()
                    Button(action: {
                        self.isEditing.toggle()
                        self.text = ""
                        if !self.isEditing {
                            coordinator.clearFilter()
                        }
                    }) {
                        Image(appIcon: isEditing ? .cancel : .search)
                            .foregroundColor(.appColor(.detail))
                    }
                }.padding(10)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HeaderView()
            Spacer()
        }.preview()
    }
}
