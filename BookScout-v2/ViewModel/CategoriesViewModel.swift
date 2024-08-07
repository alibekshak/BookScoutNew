//
//  CategoriesViewModel.swift
//  BookScout-v2
//
//  Created by Alibek Shakirov on 20.06.2024.
//

import Foundation

enum CategoryName {
    case fiction
    case nonFiction
}

class CategoriesViewModel: ObservableObject {
    
    var categoryName: CategoryName
    
    var categoriess: [Category] {
        switch categoryName {
        case .fiction:
            return [
                Category(title: "Роман", text: "Ромыны - это длинные истории, с глубокими персонажами и сложным сюжетом", textSend: "Дай рецензию  1 книги в жанре романы, название дай на русском и англиском"),
                Category(title: "Рассказы", text: "Рассказы - это короткие истории, которые рассказывают о событии или о каком то случае", textSend: "Дай рецензию  1 книги в жанре рассказы, название дай на русском и англиском"),
                Category(title: "Повесть", text: "Повесть - это длинная история, которая рассказывает о разных событиях и персонажах", textSend: "Дай рецензию  1 книги в жанре повесть, название дай на русском и англиском"),
                Category(title: "Поэзия", text: "Поэзия - это вид литературы, где используются особые язык и стиль для выражения эмоций", textSend: "Дай рецензию  1 книги в жанре поэзия, название дай на русском и англиском"),
                Category(title: "Новеллы", text: "Новеллы - это длинные рассказы с интересными сюжетами и персонажами", textSend: "Дай рецензию  1 книги в жанре новеллы, название дай на русском и англиском"),
                Category(title: "Детектив", text: "Детективы - это истории, где герои расследуют преступления и разгадывает загадки", textSend: "Дай рецензию  1 книги в жанре детектив, название дай на русском и англиском"),
                Category(title: "Пьесы", text: "Пьесы - это драматические произведения с диалогами и действиями на сцене", textSend: "Дай рецензию  1 книги в жанре пьесы, название дай на русском и англиском"),
                Category(title: "Фантастика", text: "Фантастика - жанр с вымышленными и необычными историями и мирами", textSend: "Дай рецензию  1 книги в жанре фантастика, название дай на русском и англиском"),
                Category(title: "Фэнтези", text: "Фэнтези - жанр с магическими мирами, существами и приключениями", textSend: "Дай рецензию  1 книги в жанре фэнтези, название дай на русском и англиском"),
                Category(title: "Мистика", text: "Мистика - жанр с загадочными и таинственными элементами и необъяснимыми явлениями", textSend: "Дай рецензию  1 книги в жанре мистика, название дай на русском и англиском"),
                Category(title: "Хоррор", text: "Хоррор - жанр, который страшит и вызывает ужас у читателей", textSend: "Дай рецензию  1 книги в жанре хоррор, название дай на русском и англиском"),
            ]
        case .nonFiction:
            return [
                Category(title: "Биография", text: "Биография - это история человека, которая описывает достижения, важные события", textSend: "Дай рецензию 1 книги в жанре биография, название дай на русском и англиском"),
                Category(title: "Финансы", text: "Финансы - управление деньгами и ресурсами для достижения финансовых целей", textSend: "Дай рецензию 1 книги в жанре финансы, название дай на русском и англиском"),
                Category(title: "Философия", text: "Философия - это изучение вопросов о смысле жизни, реальности, ценностях и знании", textSend: "Дай рецензию 1 книги в жанре философия, название дай на русском и англиском"),
                Category(title: "Бизнес", text: "Бизнес - это литературный жанр где внимание уделяется корпоративной среде", textSend: "Дай рецензию 1 книги в жанре бизнес, название дай на русском и англиском"),
                Category(title: "Психология", text: "Книги по психологии - это работы, которые помогают понять себя", textSend: "Дай рецензию 1 книги в жанре психология, название дай на русском и англиском"),
                Category(title: "Искусство", text: "Книги по искусству - это работы, изучающие аспекты искусства, такие как история, стили", textSend: "Дай рецензию 1 книги в жанре искусство, название дай на русском и англиском"),
                Category(title: "Мемуары", text: "Мемуары - это рассказы авторов о своей жизни, впечатлениях и опыте", textSend: "Посоветуй 1 книгу в котором автор рассказывает о тех или иных исторических событиях, свидетелем или участником которых был он сам, название дай на русском и англиском"),
                Category(title: "Спорт", text: "Спорт - спортивная деятельность с заработком и достижением выдающихся результатов", textSend: "Дай рецензию 1 книги про профессиональный спорт, название дай на русском и англиском"),
            ]
        }
    }
    
    init(categoryName: CategoryName) {
        self.categoryName = categoryName
    }
}
