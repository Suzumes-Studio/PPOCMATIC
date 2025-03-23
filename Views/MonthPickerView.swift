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
    
    // Ancho de la ventana
    @State private var windowWidth: CGFloat = 300 // Puedes ajustar este valor

    // Fondo global de la app: #F9F8F3
    var backgroundColor: Color {
        return Color(red: 246/255, green: 170/255, blue: 121/255)
    }

    // Color de fondo del botón
    var buttonBackgroundColor: Color {
        return Color(red: 246/255, green: 248/255, blue: 243/255)
    }
    
    // Estado para el efecto hover
    @State private var isHovering: Bool = false
    
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
            .buttonStyle(PlainButtonStyle())
            .padding()
            .background(isHovering ? Color.clear : buttonBackgroundColor) // Color de fondo del botón
            .foregroundColor(.black) // Color del texto del botón
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(isHovering ? buttonBackgroundColor : Color.clear, lineWidth: 2) // Borde del botón en hover
            )
            .onHover { hovering in
                isHovering = hovering
            }
        }
        .frame(width: windowWidth) // Ajusta el ancho de la ventana aquí
        .frame(maxHeight: .infinity)
        .background(backgroundColor) // Color de fondo para toda la vista
        .cornerRadius(15) // Esquinas redondeadas para toda la vista
        .padding()
    }
}
