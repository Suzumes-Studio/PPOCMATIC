import SwiftUI

struct MonthSelectorButtonStyle: ButtonStyle {
    // El color de fondo para estado normal del botón
    let fillColor = Color(red: 152/255, green: 210/255, blue: 192/255)  // #98D2C0
    
    func makeBody(configuration: Configuration) -> some View {
        MonthSelectorButton(configuration: configuration, fillColor: fillColor)
    }
    
    struct MonthSelectorButton: View {
        let configuration: Configuration
        let fillColor: Color
        @State private var isHovered: Bool = false
        
        var body: some View {
            configuration.label
                .font(.headline.bold())
                .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                .padding(8)
                .frame(maxWidth: 250)
                // En estado normal, usamos fillColor; en hover, el fondo se vuelve transparente.
                .background(isHovered ? Color.clear : fillColor)
                .cornerRadius(13)
                // En estado hover, el borde se dibuja usando fillColor; de lo contrario, sin borde.
                .overlay(
                    RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .stroke(isHovered ? fillColor : Color.clear, lineWidth: 1)
                )
                .onHover { hovering in
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isHovered = hovering
                    }
                }
        }
    }
}

