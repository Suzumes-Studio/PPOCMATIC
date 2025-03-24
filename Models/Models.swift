import SwiftUI

enum Genero {
    case varon
    case mujer
}

struct DiaTurno: Hashable {
    var dia: String
    var ubicacion: String
    var weekday: Int
}

struct TurnoMensual: Hashable, Equatable {
    var fecha: Date
    var diaTurno: DiaTurno
}

struct Voluntario: Identifiable, Equatable {
    var id: UUID
    var nombre: String
    var genero: Genero
    var disponibilidad: [DiaTurno]
    var turnoAsignado: TurnoMensual?
    var numAssignments: Int

    static func == (lhs: Voluntario, rhs: Voluntario) -> Bool {
        return lhs.id == rhs.id
    }
}
