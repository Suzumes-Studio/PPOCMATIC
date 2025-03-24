import SwiftUI

struct VolunteerRow: View {
    var voluntario: Voluntario
    @Binding var voluntarioAEditar: Voluntario?
    var deleteVoluntario: (Voluntario) -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(voluntario.nombre)
                    .font(.headline)
                Text(voluntario.turnoAsignado?.diaTurno.dia ?? "Sin turno asignado")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            Button(action: {
                voluntarioAEditar = voluntario
            }) {
                Image(systemName: "pencil")
                    .foregroundColor(.blue)
            }
            Button(action: {
                deleteVoluntario(voluntario)
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
        }
        .padding(.vertical, 4)
    }
}

struct VolunteerRow_Previews: PreviewProvider {
    static var previews: some View {
        VolunteerRow(
            voluntario: Voluntario(
                id: UUID(),
                nombre: "Juan Perez",
                genero: .varon,
                disponibilidad: [],
                turnoAsignado: nil,
                numAssignments: 0
            ),
            voluntarioAEditar: .constant(nil),
            deleteVoluntario: { _ in }
        )
        .previewLayout(.sizeThatFits)
    }
}
