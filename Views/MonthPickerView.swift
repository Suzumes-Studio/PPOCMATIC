import SwiftUI

struct MonthPickerView: View {
    @Binding var selectedMonth: Date
    @Environment(\.presentationMode) var presentationMode
    
    // Array de meses en español usando el locale "es_ES"
    let months: [String] = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "es_ES")
        return formatter.monthSymbols ?? []
    }()
    
    // Índice 0-based para el mes (0 = enero, 11 = diciembre)
    @State private var month: Int = Calendar.current.component(.month, from: Date()) - 1
    
    var body: some View {
        VStack {
            Text("Selecciona Mes")
                .font(.headline)
                .padding()
            
            Picker("Mes", selection: $month) {
                ForEach(0..<months.count, id: \.self) { index in
                    Text(months[index]).tag(index)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .frame(maxWidth: .infinity)
            .padding()
            
            Button("Seleccionar") {
                // Usar el año actual para crear la fecha (primer día del mes)
                let currentYear = Calendar.current.component(.year, from: Date())
                let components = DateComponents(year: currentYear, month: month + 1, day: 1)
                if let newDate = Calendar.current.date(from: components) {
                    selectedMonth = newDate
                }
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(AestheticButtonStyle())
            .padding()
        }
        .frame(maxHeight: .infinity)
    }
}

