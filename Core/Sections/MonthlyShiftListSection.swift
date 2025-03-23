import SwiftUI

struct MonthlyShiftListSection: View {
    @Binding var monthlyTurnos: [TurnoMensual]
    @Binding var monthlyAsignaciones: [TurnoMensual: [Voluntario]]
    var formattedDate: (Date) -> String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Turnos del Mes")
                .font(.title2)
                .bold()
                .foregroundColor(DesignCode.textColor)
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
