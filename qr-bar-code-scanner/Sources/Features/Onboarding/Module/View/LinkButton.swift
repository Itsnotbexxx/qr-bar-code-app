//
//  LinkButton.swift
//  qr-bar-code-scanner
//
//  Created by Бексултан Нурпейс on 19.11.2025.
//

import SwiftUI

struct LinkButton: View {
    let title: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(Color(hex: "#0D0D0D", opacity: 0.4))
                .font(.system(size: 13, weight: .bold))
                .padding(.vertical, 4)
        }
    }
}

#Preview {
    LinkButton(title: "Terms of Use", action: {})
}
