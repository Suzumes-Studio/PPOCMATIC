import SwiftUI

struct ContentView: View {
    @State private var mostrandoFormulario: Bool = false
    @State private var showingMonthPicker: Bool = false
    @State private var voluntarios: [Voluntario] = []
    @State private var asignaciones: [DiaTurno: [Voluntario]] = [:]
    @State private var selectedMonth: Date = Date()
    @State private var monthlyTurnos: [TurnoMensual] = []
    @State private var monthlyAsignaciones: [TurnoMensual: [Voluntario]] = [:]
    @State private var voluntarioAEditar: Voluntario? = nil
    
    let turnosDisponibles: [DiaTurno] = [
        DiaTurno(dia: "Lunes (10:30 - 12:30)", ubicacion: "Dr. Fedriani", weekday: 2),
        DiaTurno(dia: "Martes (10:30 - 12:30)", ubicacion: "Avd. Cruz Roja", weekday: 3),
        DiaTurno(dia: "Miércoles (10:30 - 12:30)", ubicacion: "José Laguillo", weekday: 4),
        DiaTurno(dia: "Miércoles (17:30 - 19:30)", ubicacion: "José Laguillo", weekday: 4),
        DiaTurno(dia: "Jueves (10:30 - 12:30)", ubicacion: "Jardines de Murillo", weekday: 5),
        DiaTurno(dia: "Viernes (17:30 - 19:30)", ubicacion: "Jardines de Murillo", weekday: 6)
    ]
    
    var backgroundColor: Color {
        return DesignCode.backgroundColor
    }
    
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }

    var body: some View {
        ZStack {
            backgroundColor
                .ignoresSafeArea()
            
            VStack {
                MonthSelectorSection(selectedMonth: $selectedMonth, showingMonthPicker: $showingMonthPicker)
                MainButtonsSection(mostrandoFormulario: $mostrandoFormulario, assignVolunteers: assignVolunteersToMonthlyShifts)
                HStack(alignment: .top) {
                    VolunteerListSection(voluntarios: $voluntarios, voluntarioAEditar: $voluntarioAEditar, deleteVoluntario: deleteVoluntario)
                    MonthlyShiftListSection(monthlyTurnos: $monthlyTurnos, monthlyAsignaciones: $monthlyAsignaciones, formattedDate: formattedDate)
                }
                .frame(maxHeight: .infinity)
            }
            .padding(.top, 20)
        }
        .sheet(isPresented: $mostrandoFormulario) {
            FormularioVoluntario(voluntarios: $voluntarios, turnosDisponibles: turnosDisponibles)
        }
        .sheet(item: $voluntarioAEditar) { editableVolunteer in
            let bindingVolunteer = Binding<Voluntario>(
                get: {
                    if let idx = voluntarios.firstIndex(where: { $0.id == editableVolunteer.id }) {
                        return voluntarios[idx]
                    }
                    return editableVolunteer
                },
                set: { newValue in
                    if let idx = voluntarios.firstIndex(where: { $0.id == editableVolunteer.id }) {
                        voluntarios[idx] = newValue
                    }
                }
            )
            FormularioVoluntario(voluntarios: $voluntarios,
                                 turnosDisponibles: turnosDisponibles,
                                 editingVolunteer: bindingVolunteer)
        }
    }
    
    func generateMonthlyTurnos(for month: Date) -> [TurnoMensual] {
        var monthlyShifts: [TurnoMensual] = []
        let calendar = Calendar.current

        guard let startOfMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: month)),
              let range = calendar.range(of: .day, in: .month, for: startOfMonth) else {
            return []
        }

        for day in range {
            if let date = calendar.date(byAdding: .day, value: day - 1, to: startOfMonth) {
                let weekday = calendar.component(.weekday, from: date)
                for fixedTurno in turnosDisponibles where fixedTurno.weekday == weekday {
                    let shift = TurnoMensual(fecha: date, diaTurno: fixedTurno)
                    monthlyShifts.append(shift)
                }
            }
        }
        
        return monthlyShifts.sorted { $0.fecha < $1.fecha }
    }
    
    func assignVolunteersToMonthlyShifts() {
        monthlyTurnos = generateMonthlyTurnos(for: selectedMonth)
        var newAssignments: [TurnoMensual: [Voluntario]] = [:]
        var mutableVoluntarios = voluntarios
        
        resetVolunteerAssignments(&mutableVoluntarios)
        
        for monthlyShift in monthlyTurnos {
            let selectedVolunteers = selectVolunteers(for: monthlyShift, from: mutableVoluntarios)
            newAssignments[monthlyShift] = selectedVolunteers
            updateVolunteerAssignments(selectedVolunteers, for: monthlyShift, in: &mutableVoluntarios)
        }
        
        monthlyAsignaciones = newAssignments
        voluntarios = mutableVoluntarios
    }
    
    func resetVolunteerAssignments(_ voluntarios: inout [Voluntario]) {
        for index in voluntarios.indices {
            voluntarios[index].turnoAsignado = nil
        }
    }
    
    func selectVolunteers(for monthlyShift: TurnoMensual, from volunteers: [Voluntario]) -> [Voluntario] {
        let available = volunteers.filter { $0.disponibilidad.contains { $0 == monthlyShift.diaTurno } }
        let sortedAvailable = available.sorted { $0.numAssignments < $1.numAssignments }
        if sortedAvailable.isEmpty { return [] }
        
        let capacity = min(sortedAvailable.count, 4)
        var selected = Array(sortedAvailable.prefix(capacity))
        
        if !selected.contains(where: { $0.genero == .varon }),
           let maleCandidate = sortedAvailable.first(where: { $0.genero == .varon }) {
            if let idx = selected.lastIndex(where: { $0.genero != .varon }) {
                selected[idx] = maleCandidate
            }
        }
        
        return selected
    }
    
    func updateVolunteerAssignments(_ volunteers: [Voluntario], for monthlyShift: TurnoMensual, in mutableVoluntarios: inout [Voluntario]) {
        for volunteer in volunteers {
            if let idx = mutableVoluntarios.firstIndex(where: { $0.id == volunteer.id }) {
                mutableVoluntarios[idx].turnoAsignado = monthlyShift
                mutableVoluntarios[idx].numAssignments += 1
            }
        }
    }
    
    private func deleteVoluntario(_ voluntario: Voluntario) {
        voluntarios.removeAll { $0.id == voluntario.id }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
