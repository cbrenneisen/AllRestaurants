//
//  RestaurantView.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/26/22.
//

import SwiftUI

struct RestaurantView: View {

    enum Variant {
        case list
        case callout
    }

    let variant: Variant
    let viewModel: RestaurantViewModel
    @Environment(\.contentCoordinator) private var coordinator: ContentCoordinator

    var body: some View {
        HStack(spacing: 0) {
            AsyncImage(url: viewModel.icon) { image in
                Thumbnail(image: image)
            } placeholder: {
                Thumbnail(image: Image("martis-trail"))
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(viewModel.name)
                    .foregroundColor(.appColor(.title))
                    .font(.title3)
                    .bold()
                    //.lineLimit(2)
                    //.minimumScaleFactor(variant.scaleFactor)
                RatingView(rating: viewModel.rating, reviewCount: viewModel.reviewCount)
                    .padding(.leading, -2)
                HStack(alignment: .top, spacing: 4) {
                    PriceView(priceLevel: viewModel.priceLevel)
                    Separator()
                    Text(viewModel.detail)
                        .foregroundColor(.appColor(.detail))
                        .font(.caption)
                        //.lineLimit(nil)
                        //.minimumScaleFactor(variant.scaleFactor)
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 16, leading: 0, bottom: 0, trailing: 0))
            if variant == .list {
                Spacer()
                VStack(spacing: 0) {
                    Button(action: {
                        coordinator.toggleRestaurant(id: viewModel.id)
                    }) {
                        Image(appIcon: .favorite(viewModel.favorited))
                            .foregroundColor(viewModel.favorited ? Color.red : .gray)
                            .imageScale(.large)
                    }
                    Spacer()
                }
            }
        }
        
        .padding(16)
        .background(Color.white)
        .roundedBorder(
            color: .appColor(.border),
            radius: Constants.cornerRadius,
            width: 2
        )
    }
}

private extension RestaurantView.Variant {
    var scaleFactor: CGFloat {
        switch self {
        case .list:
            return 1
        case .callout:
            return 0.5
        }
    }
}

private struct Constants {
    static let height: CGFloat = 100
    static let cornerRadius: CGFloat = 10
}

private struct Thumbnail: View {

    let image: Image

    var body: some View {
        image
            .resizable()
            .frame(width: 80, height: 80)
            .cornerRadius(4)
            .padding(.trailing, 20)
    }
}

private struct Separator: View {

    var body: some View {
        VStack{
            Text("·")
                .foregroundColor(.appColor(.detail))
                .font(.caption)
                .bold()
        }
    }
}

struct RestaurantView_Previews: PreviewProvider {
    static var previews: some View {
        HStack() {
            RestaurantView(
                variant: .list,
                viewModel: .make(
                    name: "Heirloom BBQ",
                    rating: 5,
                    favorited: true
                )
            )
        }
        .frame(maxWidth: .infinity, maxHeight: Constants.height)
        .padding(2)
        .background(Color.appColor(.background))
        .preview()
    }
}
