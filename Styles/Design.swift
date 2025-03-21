import SwiftUI

struct MonthSelectorSection: View {
    @Binding var selectedMonth: Date
    @Binding var showingMonthPicker: Bool
    @State private var isHovering: Bool = false // Añadir una propiedad de estado para el efecto de mouseover
    
    var body: some View {
        VStack {
            Spacer().frame(height: 20)
            HStack(spacing: 10) {
                Text("Selecciona el Mes")
                    .font(.system(size: 18).bold()) // Cambia el tamaño de la fuente a 24
                    .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                    .padding(8)
                    .background(Color.clear)
                    .cornerRadius(13)
                
                Button(action: {
                    showingMonthPicker = true
                }) {
                    Text(formattedMonth(selectedMonth))
                        .font(.headline.bold())
                        .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                        .padding(8)
                        .frame(maxWidth: 150)
                        .background(isHovering ? Color.clear : Color(red: 246/255, green: 170/255, blue: 121/255))
                }
                .buttonStyle(PlainButtonStyle())
                .cornerRadius(13)
                .overlay(
                    RoundedRectangle(cornerRadius: 13, style: .continuous)
                        .stroke(isHovering ? Color(red: 246/255, green: 170/255, blue: 121/255) : .clear, lineWidth: 1)
                )
                .onHover { hovering in
                    isHovering = hovering
                }
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

struct MainButtonsSection: View {
    @Binding var mostrandoFormulario: Bool
    var assignVolunteers: () -> Void
    
    var body: some View {
        HStack {
            Button(action: { mostrandoFormulario = true }) {
                Text("Añadir Voluntario")
            }
            .buttonStyle(AestheticButtonStyle())
            .frame(width: 150, height: 40)
            .padding(.horizontal, 16)
            
            Button(action: { assignVolunteers() }) {
                Text("Generar Turnos")
            }
            .buttonStyle(AestheticButtonStyle())
            .frame(width: 150, height: 40)
            .padding(.horizontal, 16)
        }
        .padding(.vertical, 8)
    }
}

struct VolunteerListSection: View {
    @Binding var voluntarios: [Voluntario]
    @Binding var voluntarioAEditar: Voluntario?
    var deleteVoluntario: (Voluntario) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Voluntarios PPOC")
                .font(.title2)
                .bold()
                .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 11)
                .padding(.bottom, 4)
            List {
                ForEach(voluntarios) { voluntario in
                    VolunteerRow(voluntario: voluntario, voluntarioAEditar: $voluntarioAEditar, deleteVoluntario: deleteVoluntario)
                }
            }
            .listStyle(PlainListStyle())
        }
        .frame(minWidth: 250, maxWidth: .infinity)
        .background(Color(red: 198/255, green: 208/255, blue: 199/255))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .stroke(Color(red: 198/255, green: 208/255, blue: 199/255), lineWidth: 1)
        )
        .padding()
    }
}

struct MonthlyShiftListSection: View {
    @Binding var monthlyTurnos: [TurnoMensual]
    @Binding var monthlyAsignaciones: [TurnoMensual: [Voluntario]]
    var formattedDate: (Date) -> String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turnos del Mes")
                .font(.title2)
                .bold()
                .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 11)
                .padding(.bottom, 4)
            List {
                ForEach(monthlyTurnos, id: \.self) { turnoMensual in
                    VStack(alignment: .leading, spacing: 4) {
                        Text("\(formattedDate(turnoMensual.fecha)) - \(turnoMensual.diaTurno.dia) - \(turnoMensual.diaTurno.ubicacion)")
                            .font(.headline)
                        ForEach(monthlyAsignaciones[turnoMensual] ?? [], id: \.id) { voluntario in
                            Text(voluntario.nombre)
                                .font(.subheadline)
                        }
                    }
                    .padding(4)
                }
            }
            .listStyle(PlainListStyle())
        }
        .frame(minWidth: 250, maxWidth: .infinity)
        .background(Color(red: 198/255, green: 208/255, blue: 199/255))
        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 13, style: .continuous)
                .stroke(Color(red: 198/255, green: 208/255, blue: 199/255), lineWidth: 1)
        )
        .padding()
    }
}

struct VolunteerRow: View {
    let voluntario: Voluntario
    @Binding var voluntarioAEditar: Voluntario?
    let deleteVoluntario: (Voluntario) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(voluntario.nombre)
                .font(.headline)
            Text(voluntario.genero.rawValue)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text("Disponibilidad:")
                .font(.caption)
                .foregroundColor(.secondary)
            ForEach(voluntario.disponibilidad, id: \.self) { turno in
                Text("\(turno.dia) - \(turno.ubicacion)")
                    .font(.caption2)
            }
            HStack {
                Button("Editar") {
                    voluntarioAEditar = voluntario
                }
                .buttonStyle(MonthSelectorButtonStyle())
                .frame(maxWidth: 170)
                
                Button("Eliminar") {
                    deleteVoluntario(voluntario)
                }
                .buttonStyle(MonthSelectorButtonStyle())
                .frame(maxWidth: 170)
            }
        }
        .padding(4)
    }
}
