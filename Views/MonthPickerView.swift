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
    
    // Tamaño del botón (ajusta estos valores según tus necesidades)
    var buttonWidth: CGFloat = 120
    var buttonHeight: CGFloat = 30
    
    // Colores del botón según los estados
    var normalColor: Color = Color(red: 246/255, green: 248/255, blue: 243/255) // F6F8F3
    var pressedOrHoverColor: Color = Color(red: 242/255, green: 178/255, blue: 140/255) // F2B28C
    var borderColor: Color = Color(red: 246/255, green: 248/255, blue: 243/255) // F6F8F3

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
            .buttonStyle(MonthPickerButtonStyle(buttonWidth: buttonWidth, buttonHeight: buttonHeight, normalColor: normalColor, pressedOrHoverColor: pressedOrHoverColor, borderColor: borderColor))
            .padding()
        }
        .frame(width: windowWidth)
        .frame(maxHeight: .infinity)
        .background(backgroundColor)
        .cornerRadius(15)
        .padding()
    }
}

struct MonthPickerButtonStyle: ButtonStyle {
    var buttonWidth: CGFloat
    var buttonHeight: CGFloat
    var normalColor: Color
    var pressedOrHoverColor: Color
    var borderColor: Color
    
    @State private var isHovering = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .frame(width: buttonWidth, height: buttonHeight)
            .background(configuration.isPressed || isHovering ? pressedOrHoverColor : normalColor)
            .foregroundColor(.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(configuration.isPressed || isHovering ? borderColor : Color.clear, lineWidth: 2)
            )
            .onHover { hovering in
                isHovering = hovering
            }
    }
}
