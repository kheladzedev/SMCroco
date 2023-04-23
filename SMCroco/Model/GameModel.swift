//
//  GameModel.swift
//  SMCroco
//
//  Created by Alexander Altman on 22.04.2023.
//

import UIKit

let animalsArray = ["Обезьяна", "Носорог", "Капибара", "Петух", "Жираф", "Скунс", "Крокодил", "Свинья", "Страус", "Енот", "Червяк", "Медведь", "Индюк", "Опоссум", "Кенгуру", "Черепаха", "Кит", "Змея", "Орел", "Игуана"]

let foodArray = ["Пицца", "Суп", "Холодец", "Шаверма", "Пюре с гуляшом", "Роллы", "Торт Наполеон", "Плов", "Салат", "Селедка под шубой", "Борщ", "Свекла", "Капуста", "Подлива", "Сырники", "Бутерброд", "Яичница", "Стейк rare", "Арбуз", "Хлеб"]

let peopleArray = ["Сократ", "Иосиф Сталин", "Адольф Гитлер", "Морзе", "Наполеон", "Илон Маск", "Курт Кобейн", "Хеопс", "Леонид Брежнев", "Чарли Чаплин", "Кличко", "Леонид Агутин", "Джеймс Хэтфилд", "Алла Пугачева", "Филипп Киркоров", "Аркадий Укупник", "Антон Лапенко", "Арнольд Шварцнеггер", "Сильвестр Сталоне", "Том Круз"]

let hobbyArray = ["Дайвинг", "Коллекционирование", "Пчеловодство", "Аквариумистика", "Рыбалка", "Рисование", "Флористика", "Пение", "Скалолазание", "Шоппинг", "Аудиофильство", "Кулинария", "Спортивное ориентирование", "Садоводство", "Гадание на картах", "Музыка", "Сноубординг", "Живопись", "Вязание", "Вышивание крестиком"]

let howToExplainArray = ["Объясни с помощью слов", "Объясни с помощью жестов", "Объясни с помощью рисунка", "Объясняй со злостью", "Объясняй с помощью мимики", "Объясняй вульгарно", "Объясняй сексуально"]

let teamLogos = [UIImage(named: "food"), UIImage(named: "frog"), UIImage(named: "hobby"), UIImage(named: "people")]
var teamName = ["Ковбои", "Красотки", "Челики", "Кодировщики", "Киборги", "Роботы"]
let shuffledTeamNames = teamName.shuffled()
let shuffledTeamLogos = teamLogos.shuffled()

struct Team {
    var name: String
    var points: Int
    var avatarName: UIImage?
}

var teams = [Team(name: shuffledTeamNames[0], points: 0, avatarName: shuffledTeamLogos[0]),
             Team(name: shuffledTeamNames[1], points: 0, avatarName: shuffledTeamLogos[1])]

class DataManager {
    static let shared = DataManager()
    var currentTeam = 0
    var numberOfTeams = teams.count
    var totalRounds = 0
}
