import SwiftUI

struct VolunteerListSection: View {
    @Binding var voluntarios: [Voluntario]
    @Binding var voluntarioAEditar: Voluntario?
    var deleteVoluntario: (Voluntario) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Voluntarios PPOC")
                .font(.title2)
                .bold()
                .foregroundColor(DesignCode.textColor)
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
