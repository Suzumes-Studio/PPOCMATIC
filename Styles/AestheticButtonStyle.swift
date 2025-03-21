import SwiftUI

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

