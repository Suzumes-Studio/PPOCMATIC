import SwiftUI

struct FormularioVoluntario: View {
    @Binding var voluntarios: [Voluntario]
    let turnosDisponibles: [DiaTurno]
    
    var editingVolunteer: Binding<Voluntario>? = nil
    @Environment(\.presentationMode) var presentationMode
    @State private var editableVolunteer: Voluntario
    @State private var isHoveringSave: Bool = false
    @State private var isHoveringClose: Bool = false
    
    @State private var currentWidth: CGFloat = 500
    @State private var currentHeight: CGFloat = 500
    @State private var textFieldWidth: CGFloat = 400 // Añadido para definir el ancho del campo de texto
    
    init(voluntarios: Binding<[Voluntario]>, turnosDisponibles: [DiaTurno], editingVolunteer: Binding<Voluntario>? = nil) {
        self._voluntarios = voluntarios
        self.turnosDisponibles = turnosDisponibles
        self.editingVolunteer = editingVolunteer
        if let editingVolunteer = editingVolunteer {
            _editableVolunteer = State(initialValue: editingVolunteer.wrappedValue)
        } else {
            _editableVolunteer = State(initialValue: Voluntario(id: UUID(), nombre: "", genero: .varon, disponibilidad: [], numAssignments: 0))
        }
    }
    
    var body: some View {
        VStack(spacing: 25) {
            ZStack(alignment: .top) {
                Color(red: 242/255, green: 178/255, blue: 140/255)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Text(editingVolunteer == nil ? "Añadir Voluntario" : "Editar Voluntario")
                        .font(.headline)
                        .padding()
                    
                    TextField("Nombre", text: $editableVolunteer.nombre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: textFieldWidth) // Definir el ancho del campo de texto
                        .padding()
                    
                    VStack {
                        Text("Género")
                            .font(.system(size: 17))
                            .padding(.bottom, 5)
                        
                        Picker("", selection: $editableVolunteer.genero) {
                            Text("Varón").tag(Genero.varon)
                            Text("Mujer").tag(Genero.mujer)
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding(.horizontal)
                    }
                    
                    Text("Selecciona Disponibilidad")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: 10) {
                            ForEach(turnosDisponibles, id: \.self) { turno in
                                HStack {
                                    Image(systemName: editableVolunteer.disponibilidad.contains(turno) ? "checkmark.square.fill" : "square")
                                        .foregroundColor(editableVolunteer.disponibilidad.contains(turno) ? Color(red: 123/255, green: 114/255, blue: 105/255) : .gray)
                                        .onTapGesture {
                                            if let index = editableVolunteer.disponibilidad.firstIndex(of: turno) {
                                                editableVolunteer.disponibilidad.remove(at: index)
                                            } else {
                                                editableVolunteer.disponibilidad.append(turno)
                                            }
                                        }
                                    Text("\(turno.dia) - \(turno.ubicacion)")
                                        .padding(.vertical, 2)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    .frame(maxHeight: 400)
                    .padding(.vertical, 5)
                    .padding(.horizontal)
                    
                    HStack {
                        Button(action: {
                            guard !editableVolunteer.nombre.trimmingCharacters(in: .whitespaces).isEmpty else { return }
                            if let editingVolunteer = editingVolunteer {
                                editingVolunteer.wrappedValue = editableVolunteer
                            } else {
                                voluntarios.append(editableVolunteer)
                            }
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Guardar")
                                .font(.headline.bold())
                                .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                                .padding(8)
                                .frame(maxWidth: 150)
                                .background(isHoveringSave ? Color.clear : Color(red: 246/255, green: 248/255, blue: 243/255))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(13)
                        .overlay(
                            RoundedRectangle(cornerRadius: 13, style: .continuous)
                                .stroke(isHoveringSave ? Color(red: 246/255, green: 248/255, blue: 243/255) : .clear, lineWidth: 1)
                        )
                        .onHover { hovering in
                            isHoveringSave = hovering
                        }
                        .padding()
                        .disabled(editableVolunteer.nombre.trimmingCharacters(in: .whitespaces).isEmpty)
                        
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("Cerrar")
                                .font(.headline.bold())
                                .foregroundColor(Color(red: 123/255, green: 114/255, blue: 105/255))
                                .padding(8)
                                .frame(maxWidth: 150)
                                .background(isHoveringClose ? Color.clear : Color(red: 246/255, green: 248/255, blue: 243/255))
                        }
                        .buttonStyle(PlainButtonStyle())
                        .cornerRadius(13)
                        .overlay(
                            RoundedRectangle(cornerRadius: 13, style: .continuous)
                                .stroke(isHoveringClose ? Color(red: 246/255, green: 248/255, blue: 243/255) : .clear, lineWidth: 1)
                        )
                        .onHover { hovering in
                            isHoveringClose = hovering
                        }
                        .padding()
                    }
                }
            }
        }
        .padding()
        .frame(minWidth: currentWidth, minHeight: currentHeight)
    }
}
