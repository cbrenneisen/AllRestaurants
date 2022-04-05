//
//  RatingView.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 3/31/22.
//

import SwiftUI

struct RatingView: View {

    let rating: Int
    let reviewCount: Int

    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                ForEach((0..<rating), id: \.self) { _ in
                    StarView(filled: true)
                }
                ForEach(0...AppConstants.starCount-rating, id: \.self) { index in
                    if index > 0 {
                        StarView(filled: false)
                    }
                }
            }
            Text("(\(reviewCount))")
                .foregroundColor(.appColor(.detail))
                .font(.caption)
        }
    }
}

private struct StarView: View {

    let filled: Bool

    var body: some View {
        Image(appIcon: .star)
            .foregroundColor(.appColor(.star(filled: filled)))
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            ForEach(1...AppConstants.starCount, id: \.self){ rating in
                RatingView(rating: rating, reviewCount: .random(in: 1...1000))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
