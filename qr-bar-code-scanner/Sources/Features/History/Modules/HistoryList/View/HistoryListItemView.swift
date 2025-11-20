import SwiftUI

struct HistoryListItemView: View {
    let item: HistoryModel
    @Binding var isEditMode: Bool
    let onTapDelete: () -> Void

    var body: some View {
        content
            .animation(.spring(), value: isEditMode)
    }
    
    @ViewBuilder
    private var content: some View {
        HStack(spacing: 8) {
            if isEditMode {
                Image("remove")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .onTapGesture {
                        onTapDelete()
                    }
            }
            
            cell
                .offset(x: isEditMode ? 8 : 0)
        }
        .frame(maxWidth: .infinity)
    }
    
    private var cell: some View {
        HStack(alignment: .center) {
            Image(item.image)
                .resizable()
                .scaledToFit()
                .frame(width: 48, height: 48)
                .cornerRadius(8)
           
            textView
            Spacer()
        }
        .padding(12)
        .background(Color(hex: "#E6E6E6"))
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
    
    private var textView: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(item.title)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.9))
                .lineLimit(1)
            subtitleView
        }
    }
    
    private var subtitleView: some View {
        HStack(spacing: 4) {
            Text(item.type.title)
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.9))
                .padding(.horizontal, 8)
                .background(Color.white)
                .cornerRadius(99)
            
            Text(item.date.formattedAsTodayString())
                .font(.system(size: 12, weight: .medium))
                .foregroundStyle(Color(hex: "0D0D0D", opacity: 0.4))
        }
    }
}

//#Preview {
//    HistoryListItemView(
//        item: .init(
//            title: "linkly.app/item/90731218192434811111",
//            type: .qr,
//            date: Date(),
//            image: "qrCode"
//        )
//    )
//}
