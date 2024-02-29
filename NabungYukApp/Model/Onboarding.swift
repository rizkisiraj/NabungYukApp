//
//  Onboarding.swift
//  NabungYukApp
//
//  Created by Rizki Siraj on 27/02/24.
//

import Foundation

struct Onboarding: Identifiable {
    var id: Int
    var title: String
    var description: String
    var image: String
}

extension Onboarding {
    static let datas: [Onboarding] = [
        Onboarding(id: 0, title: "Tetapkan Tujuan Anda", description: "Apa impian Anda? Liburan? Gadget baru? Kami di sini untuk membantu Anda mewujudkannya. Mulai dengan menetapkan tujuan menabung Anda.", image: "onboarding1"),
        Onboarding(id: 1, title: "Atur Rencana", description: "Tentukan berapa banyak yang ingin Anda tabung dan kami akan membantu Anda merencanakan dengan mudah.", image: "onboarding2"),
        Onboarding(id: 2, title: "Lacak Kemajuan", description: "Dengan fitur pelacakan kami, Anda bisa melihat seberapa dekat Anda dengan tujuan Anda setiap hari.", image: "onboarding3")
    ]
}
