//
//  OfficeStatisticsCell.swift
//  Brouipetbrain
//
//  Created by Andrii Momot on 22.11.2024.
//

import SwiftUI

struct OfficeStatisticsCell: View {
    var item: OfficeModel
    
    @State private var image = Asset.placeholder.swiftUIImage
    
    private var bounds: CGRect {
        UIScreen.main.bounds
    }
    
    var body: some View {
        HStack(spacing: 14) {
            HStack(spacing: 10) {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: bounds.width * 0.3,
                           height: bounds.width * 0.3)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Spacer()
                        
                        Text(item.name)
                            .foregroundStyle(.white)
                            .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 15))
                        
                        Spacer()
                        
                        HStack {
                            HStack {
                                Text("Company budget")
                                    .foregroundStyle(.black)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 10))
                                
                                VStack {
                                    Spacer()
                                    Text("\(item.budget)".toNumberFormat())
                                        .foregroundStyle(.black)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                    Spacer()
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(.silver)
                            .cornerRadius(14, corners: [.topLeft, .bottomLeft])
                            
                            Spacer()
                            
                            HStack {
                                Text("Company costs")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 10))
                                
                                VStack {
                                    Spacer()
                                    Text("\(calculateCosts(item))")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                    Spacer()
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(.red)
                            .cornerRadius(14, corners: [.topRight, .bottomRight])
                        }
                        
                        Spacer()
                        
                        HStack {
                            Spacer()
                            
                            HStack(spacing: 8) {
                                Text("Company income")
                                    .foregroundStyle(.white)
                                    .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 10))
                                
                                VStack(alignment: .trailing) {
                                    Text("+25%")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 7))
                                        .lineLimit(1)
                                    
                                    Text("\(calculateIncome(item))")
                                        .foregroundStyle(.white)
                                        .font(Fonts.SFProDisplay.bold.swiftUIFont(size: 14))
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.5)
                                }
                            }
                            .padding(.vertical, 4)
                            .padding(.horizontal, 10)
                            .background(.greenCustom)
                            .cornerRadius(14, corners: [.topLeft, .topRight])
                            
                            Spacer()
                        }
                    }
                    .padding(.trailing, 6)
                    .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
            }
            .background(.darkBlue)
            .cornerRadius(10, corners: .allCorners)
        }
        .frame(height: bounds.width * 0.3)
        .onAppear {
            withAnimation {
                getImage()
            }
        }
    }
}

private extension OfficeStatisticsCell {
    func getImage() {
        ImageStorageManager().fetchImage(with: item.id) { data in
            guard let data,
                    let uiImage = UIImage(data: data)
            else { return }
            image = Image(uiImage: uiImage)
        }
    }
    
    func calculateCosts(_ office: OfficeModel) -> Int {
        Int(ceil((Double(office.budget) * 0.1) * Double(office.employees.count)))
    }
    
    func calculateIncome(_ office: OfficeModel) -> Int {
        let cost = calculateCosts(office)
        let budgetWithoutCosts = office.budget - cost
        let income = ceil(Double(budgetWithoutCosts) * 1.25)
        return Int(income)
    }
}

#Preview {
    ZStack {
        Color.greenCustom
            .opacity(0.5)
        
        VStack {
            OfficeStatisticsCell(item: .init(
                name: "EcoPulse Innovations",
                budget: 10_000,
                numberOfEmployees: 8,
                description: "A green tech company dedicated to developing cutting-edge solutions for sustainable energy, waste management, and eco-friendly products. Their goal is to drive environmental change through innovation and smart technologies."))
            
            OfficeStatisticsCell(item: .init(
                name: "EcoPulse Innovations",
                budget: 10_000,
                numberOfEmployees: 8,
                description: "A green tech company dedicated to developing cutting-edge solutions for sustainable energy, waste management, and eco-friendly products. Their goal is to drive environmental change through innovation and smart technologies. Their goal is to drive environmental change through innovation and smart technologies."))
        }
        .padding(.horizontal, 16)
    }

}
