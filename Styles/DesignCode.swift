import SwiftUI

struct DesignCode {
    // Estilo de botón original de AestheticButtonStyle
    struct AestheticButtonStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            AestheticButton(configuration: configuration)
        }
        
        struct AestheticButton: View {
            let configuration: Configuration
            @State private var isHovered: Bool = false
            
            var body: some View {
                configuration.label
                    .frame(width: 150, height: 18) // Dimensiones fijas para el botón
                    .font(.headline.bold())
                    .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255)) // Ajusta el color del texto si lo deseas
                    .padding(8)
                    .background(isHovered ? Color.clear : Color(red: 198/255, green: 208/255, blue: 199/255))
                    .cornerRadius(13)
                    .overlay(
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .stroke(isHovered ? Color(red: 198/255, green: 208/255, blue: 199/255) : Color.clear, lineWidth: 1)
                    )
                    .scaleEffect(1.0) // Sin efecto de escala al presionar
                    .onHover { hovering in
                        isHovered = hovering
                    }
            }
        }
    }
    
    // Estilo de botón para MonthSelectorSection
    struct MonthSelectorButtonStyle: ButtonStyle {
        // El color de fondo para estado normal del botón
        let staticColor = Color(red: 246/255, green: 170/255, blue: 121/255)  // #F6AA79
        let hoverColor = Color(red: 246/255, green: 248/255, blue: 243/255)  // #F6F8F3
        let borderColor = Color(red: 246/255, green: 170/255, blue: 121/255)  // #F6AA79
        var width: CGFloat = 250 // Ancho por defecto
        var height: CGFloat = 50 // Alto por defecto
        
        func makeBody(configuration: Configuration) -> some View {
            MonthSelectorButton(configuration: configuration, staticColor: staticColor, hoverColor: hoverColor, borderColor: borderColor, width: width, height: height)
        }
        
        struct MonthSelectorButton: View {
            let configuration: Configuration
            let staticColor: Color
            let hoverColor: Color
            let borderColor: Color
            let width: CGFloat
            let height: CGFloat
            @State private var isHovered: Bool = false
            
            var body: some View {
                configuration.label
                    .font(.headline.bold())
                    .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                    .padding(8)
                    .frame(width: width, height: height)
                    // En estado normal, usamos staticColor; en hover, el fondo se vuelve hoverColor.
                    .background(isHovered ? hoverColor : staticColor)
                    .cornerRadius(13)
                    // En estado hover, el borde se dibuja usando borderColor; de lo contrario, sin borde.
                    .overlay(
                        RoundedRectangle(cornerRadius: 13, style: .continuous)
                            .stroke(isHovered ? borderColor : Color.clear, lineWidth: 1)
                    )
                    .onHover { hovering in
                        withAnimation(.easeInOut(duration: 0.2)) {
                            isHovered = hovering
                        }
                    }
            }
        }
    }
    
    // Otros estilos y colores globales
    static let backgroundColor: Color = Color(red: 246/255, green: 248/255, blue: 243/255)
    static let textColor: Color = Color(red: 123/255, green: 114/255, blue: 105/255)
}
