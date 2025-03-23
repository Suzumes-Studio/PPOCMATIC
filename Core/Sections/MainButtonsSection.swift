import SwiftUI

struct MainButtonsSection: View {
    @Binding var mostrandoFormulario: Bool
    var assignVolunteers: () -> Void
    
    var body: some View {
        HStack {
            Button(action: { mostrandoFormulario = true }) {
                Text("Añadir Voluntario")
            }
            .buttonStyle(DesignCode.AestheticButtonStyle())
            .frame(width: 150, height: 40)
            .padding(.horizontal, 16)
            
            Button(action: { assignVolunteers() }) {
                Text("Generar Turnos")
            }
            .buttonStyle(DesignCode.AestheticButtonStyle())
            .frame(width: 150, height: 40)
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
    }
}
