//
//  RestaurantMapView.swift
//  AllRestaurants
//
//  Created by Carl Brenneisen on 4/3/22.
//

import MapKit
import SwiftUI

struct RestaurantMapView: View {

    @Binding var restaurantList: [RestaurantViewModel]
    @Binding var region: MKCoordinateRegion
    @State var calloutActiveId: String?

    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: restaurantList
        ) { annotation in
            MapAnnotation(coordinate: annotation.coordinate, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                PlaceAnnotationView(calloutActiveId: $calloutActiveId, viewModel: annotation)
            }
        }
        .frame(maxHeight: .infinity)
        .ignoresSafeArea()
    }
}

struct PlaceAnnotationView: View {

    @Binding var calloutActiveId: String?

    let viewModel: RestaurantViewModel

    var body: some View {
      VStack(spacing: 0) {
          VStack {
              RestaurantView(variant: .callout, viewModel: viewModel)
          }
          .frame(maxWidth: 300)
          .opacity(calloutActiveId == viewModel.id ? 1.0 : 0)

          VStack {
            Image(systemName: "mappin.circle.fill")
              .font(.title)
              .foregroundColor(.red)

            Image(systemName: "arrowtriangle.down.fill")
              .font(.caption)
              .foregroundColor(.red)
              .offset(x: 0, y: -5)
          }
          .frame(minWidth: 40, minHeight: 40)
          .contentShape(Rectangle())
          .padding()
          .onAnyTouch {
            withAnimation(.easeInOut) {
                if calloutActiveId == viewModel.id {
                    calloutActiveId = nil
                } else {
                    calloutActiveId = viewModel.id
                }
            }
          }
      }
    }
}
