//
//  RestaurantListView.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/26/22.
//

import SwiftUI

struct RestaurantListView: View {

    var restaurantList: [RestaurantViewModel]

    var body: some View {
        ScrollView {
            ForEach(restaurantList) { restaurant in
                RestaurantView(variant:.list, viewModel: restaurant)
                    .frame(height: 150)
            }
        }
        .frame(maxWidth: .infinity)
        .padding([.top, .horizontal], 16)
        .background(Color.appColor(.background))
    }
}

struct RestaurantListView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantListView(
            restaurantList: .make()
        )
        .preview()
    }
}
