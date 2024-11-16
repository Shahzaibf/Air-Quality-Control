//
//  InformationView.swift
//  Air Quality Control
//
//  Created by Shahzaib Fareed on 11/7/24.
//

import SwiftUI

struct InformationView: View {
    var body: some View {
        VStack {
            Text("This app gives additional statistics:")
                .font(
                    .custom("Times New Roman", size: 16)
                )
                .multilineTextAlignment(.leading)
                .italic()
                .padding(.bottom)
            VStack(alignment: .leading, spacing: 10) {
                Text("1. (CO, Carbon monoxide): Indicates the level of carbon monoxide in the air, which can be harmful at high concentrations and is typically linked to combustion processes.")
                Text("2. (NO, Nitrogen monoxide): Measures the amount of nitrogen monoxide, a precursor to nitrogen dioxide, often produced by vehicles and industrial emissions.")
                Text("3. (NO2, Nitrogen dioxide): Shows the concentration of nitrogen dioxide, a harmful pollutant contributing to respiratory issues and smog formation.")
                Text("4. (O3, Ozone): Reflects the concentration of ozone, which at ground level is a major component of smog and can cause lung problems.")
                Text("5. (SO2, Sulfur dioxide): Reports the concentration of sulfur dioxide, often resulting from burning fossil fuels, and can lead to acid rain and respiratory issues.")
                Text("6. (PM2.5, Fine particles matter): Indicates the amount of fine particulate matter smaller than 2.5 microns, which can penetrate deep into the lungs and is linked to severe health risks.")
                Text("7. (PM10, Coarse particulate matter): Represents the concentration of coarse particulate matter, particles up to 10 microns in diameter, which can affect respiratory health.")
                Text("8. (NH3, Ammonia): Measures ammonia levels, which is emitted from agricultural sources and can contribute to the formation of harmful particulate matter in the atmosphere.")
            }
            .font(.custom("Times New Roman", size: 14))
            .multilineTextAlignment(.leading)
            .padding(.leading, 10)
            Spacer()
        }
    }
}

#Preview {
    InformationView()
}
