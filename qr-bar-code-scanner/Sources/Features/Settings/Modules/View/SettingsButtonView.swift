//
//  SettingsButtonView.swift
//  qr-bar-code-scanner
//
//  Created by Бексултан Нурпейс on 20.11.2025.
//

import SwiftUI

struct SettingsButtonView: View {
    let title: String
    let imageName: String
    var backgroundColor: Color = .init(hex: "#1A1A1A")
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .padding(12)
                    .background(Color.white)
                
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.init(hex: "##0D0D0D", opacity: 0.9))
                Spacer()
            }
            .padding(4)
            .frame(height: 56)
            .background(Color(hex: "#E6E6E6"))
            .cornerRadius(4)
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    SettingsButtonView(title: "Privacy Policy", imageName: "pp", action: {})
}
