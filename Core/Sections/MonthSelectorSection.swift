import SwiftUI

struct MonthSelectorSection: View {
    @Binding var selectedMonth: Date
    @Binding var showingMonthPicker: Bool
    @State private var isHovering: Bool = false
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            HStack(spacing: 10) {
                Text("Selecciona el Mes")
                    .font(.system(size: 18).bold())
                    .foregroundColor(DesignCode.textColor)
                    .padding(8)
                    .background(Color.clear)
                    .cornerRadius(13)
                
                Button(action: {
                    showingMonthPicker = true
                }) {
                    Text(formattedMonth(selectedMonth))
                        .font(.headline.bold())
                        .foregroundColor(DesignCode.textColor)
                        .padding(8)
                }
                .buttonStyle(DesignCode.MonthSelectorButtonStyle(width: 150, height: 40)) // Ajusta el ancho y el alto según sea necesario
                .sheet(isPresented: $showingMonthPicker) {
                    MonthPickerView(selectedMonth: $selectedMonth)
                }
            }
            .padding(.vertical, 8)
        }
    }
    
    func formattedMonth(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
}
