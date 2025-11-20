//
//  TabbarView.swift
//  qr-bar-code-scanner
//
//  Created by Бексултан Нурпейс on 20.11.2025.
//

import SwiftUI

struct TabbarView: View {
    @StateObject var viewModel: TabbarViewModel
    
    var onTapButton: Completion?

    var body: some View {
        content
    }
    
    private var content: some View {
        HStack(spacing: 4) {
            ForEach(TabbarType.allCases, id: \.self) { type in
                TabbarButton(
                    imageName: type.imageName,
                    isSelected: viewModel.selectedType == type
                ) {
                    viewModel.selectedType = type
                    onTapButton?()
                }
                .animation(.easeInOut(duration: 0.25), value: viewModel.selectedType)
            }
        }
        .padding(4)
        .background(Color.white)
        .cornerRadius(8)
    }
}

#Preview {
    TabbarView(viewModel: TabbarViewModel())
}
