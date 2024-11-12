//
//  HomePageView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/6/24.
//

import SwiftUI
import CoreLocationUI

struct HomePageView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var location: String = ""
    @State private var showLocation: Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Air Quality Control")
                    .font(
                        .custom("Times New Roman", size: 36)
                    )
                    .padding(.top)
                Text("This app, takes your location or allows you to enter your location, and then displays the air quality index for that location.")
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .padding([.top, .leading, .trailing])
                    .font(
                        .custom("Times New Roman", size: 20)
                    )
                HStack {
                    Spacer()
                    NavigationLink(destination: InformationView()) {
                        HStack {
                            Text("More Information")
                            Image(systemName: "arrow.right")
                        }
                    }
                    .padding([.top, .trailing])
                    .buttonStyle(PurpleButton())
                }
                Spacer()
                Text("Find out the air quality index by:")
                    .font(
                        .custom("Times New Roman", size: 20)
                    )
                    .padding(.bottom)
                VStack(alignment: .center) {
                    LocationButton(.currentLocation) {
                        print("Clicked")
                        showLocation = true
                        locationManager.requestLocation()
                    }
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .tint(.purple)
                    
                    Text("OR")
                    .font(
                        .custom("Times New Roman", size: 20)
                    )
                    NavigationLink(destination: SearchView()) {
                        HStack {
                            Text("Search")
                        }
                    }
                    .buttonStyle(PurpleButton())
                }
                .padding(.bottom)
                if showLocation, let location = locationManager.location {
                    Text("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
                        .font(.custom("Times New Roman", size: 16))
                        .padding()
                }
                NavigationLink(destination: FavoritesListView()) {
                    Image(systemName: "star.fill")
                        .font(.largeTitle)
                        .foregroundColor(.yellow)
                        .padding()
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    HomePageView()
}
