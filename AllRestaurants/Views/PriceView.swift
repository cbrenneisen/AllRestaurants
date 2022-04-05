//
//  PriceView.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/1/22.
//

import SwiftUI

struct PriceView: View {

    let priceLevel: PriceLevel

    var body: some View {
        VStack {
            Text(String(repeating: "$", count: priceLevel.rawValue))
                .foregroundColor(.appColor(.detail))
                .font(.caption)
                .bold()
        }
    }
}

struct PriceView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(alignment: .leading) {
            ForEach(PriceLevel.allCases, id: \.self) { level in
                PriceView(priceLevel: level)
            }
        }
    }
}
