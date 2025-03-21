import Foundation

struct Voluntario: Identifiable, Equatable {
    let id: UUID
    var nombre: String
    var genero: Genero
    var disponibilidad: [DiaTurno]
    var numAssignments: Int = 0         // Contador para repartir voluntarios de forma equitativa
    var turnoAsignado: TurnoMensual? = nil   // Turno mensual asignado (cuando se genere)
}

struct DiaTurno: Hashable, Equatable {
    let dia: String         // Ejemplo: "Lunes (10:30 - 12:30)"
    let ubicacion: String   // Ejemplo: "Dr. Fedriani"
    let weekday: Int        // Según Calendar (Domingo=1, Lunes=2, etc.)
}

enum Genero: String, Equatable {
    case varon = "Varón"
    case mujer = "Mujer"
}

struct TurnoMensual: Identifiable, Equatable, Hashable {
    let id = UUID()
    let fecha: Date         // Fecha específica del turno del mes
    let diaTurno: DiaTurno  // Datos fijos: día, horario y ubicación
}

