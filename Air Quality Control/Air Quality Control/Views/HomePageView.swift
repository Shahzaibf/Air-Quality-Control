//
//  HomePageView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/6/24.
//

import SwiftUI



struct HomePageView: View {
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
            }
        }
    }
}

#Preview {
    HomePageView()
}
