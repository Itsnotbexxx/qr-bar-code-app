//
//  TabbarButton.swift
//  qr-bar-code-scanner
//
//  Created by Бексултан Нурпейс on 20.11.2025.
//

import SwiftUI

struct TabbarButton: View {
    let imageName: String
    let isSelected: Bool
    let action: Completion
    
    var body: some View {
        Button {
            action()
        } label: {
            VStack(spacing: 4) {
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .foregroundColor(isSelected ? Color.white : Color.black)
                    .frame(width: 24, height: 24)
            }
            .frame(width: 48, height: 48)
            .background(isSelected ? Color.black : Color.white)
            .cornerRadius(4)
        }
    }
}

#Preview {
    TabbarButton(imageName: "scanner", isSelected: true, action: {})
}
