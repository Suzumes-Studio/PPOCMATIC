import SwiftUI

enum Genero {
    case varon
    case mujer
}

struct DiaTurno: Hashable, Equatable {
    var dia: String
    var ubicacion: String
    var weekday: Int

    static func == (lhs: DiaTurno, rhs: DiaTurno) -> Bool {
        return lhs.dia == rhs.dia && lhs.ubicacion == rhs.ubicacion && lhs.weekday == rhs.weekday
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(dia)
        hasher.combine(ubicacion)
        hasher.combine(weekday)
    }
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
