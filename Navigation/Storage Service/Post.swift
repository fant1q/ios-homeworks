//
//  Post.swift
//  Navigation
//
//  Created by Денис Штоколов on 14.04.2022.
//

import Foundation
import UIKit
import iOSIntPackage

public struct Post {
    
    public let author: String
    public let description: String
    public var image: String
    public var likes: Int
    public let views: Int
    public var isLiked: Bool
    
    init(author: String, description: String, image: String, likes: Int, views: Int, isLiked: Bool) {
        self.author = author
        self.description = description
        self.image = image
        self.likes = likes
        self.views = views
        self.isLiked = isLiked
    }
}

let post1 = Post(author: "Mercedes - Benz",
                 description: "Mercedes-Benz 1 июня представил компактный кроссовер GLC-Class нового, второго по счету поколения (код — X254). Модель построена на шасси MRA2, которое также использовано на C-Class последней генерации W206. Длина, ширина и высота составляют 4716, 1890 и 1640 мм соответственно, колесная база — 2888 мм. То есть относительно предшественника X253 длина возросла на 60 мм, высота — на 2 мм, колесная база — на 15 мм. Утверждается, что увеличен объем полезного пространства в салоне. Объем багажника новинки — 600 или, при сложенных задних сиденьях, 1640 литров. В качестве опции для нового GLC предложены подруливающие задние колеса (максимальный угол поворота — до 4,5 градуса) — с этой системой уменьшается радиус разворота на низких скоростях и улучшается прохождение поворотов на высоких. В Евросоюзе предложат шесть моторных версий новинки, причем три из них — подзаряжаемые гибриды. Базовая версия — GLC 200 4Matic, мотор — бензиновый 2,0-литровый турбо мощностью 204 л.с. и крутящим моментом 320 Нм. На ступень выше — GLC 300 4Matic, он имеет двигатель того же объема — 2,0 л, но отдача выше — 258 л.с. и 400 Нм. Любителям дизелей — GLC220d 4Matic с 2,0-литровым двигателем, 197 л.с. и 440 Нм. Все указанные модификации имеют 48-вольтовый стартер-генератор, 9-ступенчатый «автомат» и полный привод. Подзаряжаемые гибриды с бензиновыми моторами в составе — это GLC 300e 4Matic и GLC 400e 4Matic, оба подразумевают 2,0-литровый ДВС и электродвигатель, но в первом случае суммарные характеристики — 313 л.с. и 550 Нм, во втором — 381 л.с. и 650 Нм. Особняком стоит подзаряжаемый гибрид GLC 220d 4Matic, поскольку у него в составе — турбодизель. На пару с электромотором он выдает 197 л.с. мощности и 440 Нм крутящего момента. Все гибриды — полноприводные, варианты с бензиновыми моторами могут на чистой электротяге проехать до 120 км. Среди интересных опций новинки — фары Digital Light, которые могут проецировать на дорожное полотно подсказки для водителя в виде стрелок и других символов. В ЕС продажи GLC-Class X254 стартуют в конце июня.",
                 image: "glc",
                 likes: 13,
                 views: 27,
                 isLiked: false)

let post2 = Post(author: "BMW",
                 description: "BMW представил новый X1. 1 июня дебютировал компактный кроссовер BMW X1 нового, третьего по счету поколения (код — U11). Напомним, в гамме вседорожников баварского бренда X1 является начальной моделью. Новинка построена на платформе FAAR с переднеприводной архитектурой  — она дебютировала в 2019-м на семействе 1 Series и 2 Series последних поколений. Дизайн X1 U11 выполнен в последней итерации фирменного стиля BMW — привлекают внимание «чистая» пластика кузовных панелей, резкие грани, светодиодные фары и фонари, «ностальгические» дверные ручки подъемного типа. Габаритные длина, ширина и высота нового X1 — 4500, 1845 и 1642 мм соответственно, колесная база — 2692 мм. То есть относительно кроссовера уходящей генерации F48 длина увеличена на 53 мм, ширина — на 24 мм, высота — на 44 мм, колесная база — на 22 мм. Объем багажника в зависимости от модификации варьируется от 490 до 540 литров, при сложенных задних сиденьях — от 1545 до 1600 литров. В салоне в едином блоке выполнены цифровой щиток приборов (10,25 дюйма) и экран медиасистемы (10,7 дюйма). В Германии (и Евросоюзе) гамма нового X1 включает два бензиновых, два дизельных, два гибридных и один чисто электрический варианты.",
                 image: "x1",
                 likes: 107,
                 views: 281,
                 isLiked: false)

let post3 = Post(author: "Mercedes - Benz",
                 description: "Mercedes-Benz представил серийную версию центральномоторного суперкара AMG One — внешне он повторяет одноименный концепт-кар 2017 года. В этой машине применен двигатель от болида Formula 1 команды Mercedes-AMG. AMG One укомплектован силовой установкой типа параллельный гибрид, суммарная мощность — 1049 л.с. В нее входят 1,6-литровый бензиновый V6 с электрической турбиной, два электромотора на передней оси (по одному на колесо), один — на коленвале и еще один — внутри турбонагнетателя (итого — четыре электродвигателя). У ДВС — четыре распредвала и непосредственный впрыск, он отдельно развивает 566 л.с. и может раскручиваться до 11 000 об/мин. Передние электромоторы в сумме выдают 322 л.с., агрегат на коленвале добавляет еще 161 л.с., а внутри турбонагнетателя — 121 л.с. На задней оси установлена 7-ступенчатая механическая коробка передач с блокировкой дифференциала, а передняя ось приводится исключительно электродвигателями. Система рекуперации отличается высокой эффективностью — восполняет до 80% энергии. Емкость литий-ионной батареи — 8,4 кВт*ч. На чистой электротяге суперкар способен проехать до 18,1 км. Аккумуляторы можно подзаряжать и от внешней сети. Снаряженная масса Mercedes-Benz AMG One — 1695 кг, максимальная скорость — 350 км/ч, разгон с места до 100 км/ч занимает 2,9 секунды, до 200 км/ч — 7 секунд. Несущей структурой кузова является углепластиковый монокок, к которому крепятся передний и задний подрамники из алюминия. Внешние панели также отформованы из углепластика. Амортизаторные стойки на обеих осях установлены под углом, близким к горизонтали, поперек движения (это позволило отказаться от стабилизаторов поперечной устойчивости). В подвесках применены пять алюминиевых рычагов. Жесткость подвески можно регулировать — предустановлены режимы «комфорт», «спорт» и «спорт+». Также следует отметить магниевые кованые колесные диски и углерод-керамические тормоза. Огромные усилия инженеры немецкой компании приложили к тому, чтобы адаптировать агрегаты от F-1 для повседневного использования, в том числе повысив их надежность.Mercedes-AMG планирует построить 275 таких суперкаров по цене $2,72 млн каждый. Утверждается, что все они проданы заранее.",
                 image: "amgone",
                 likes: 73,
                 views: 307,
                 isLiked: false)

let post4 = Post(author: "Lexus",
                 description: "Lexus, премиум-бренд Тойоты, провел мировую премьеру среднеразмерного кроссовера RX очередного, пятого поколения (код — AL30). Новинка построена на модифицированной версии модульной платформы TNGA GA-K и имеет спроектированный с чистого листа кузов. Специально для кроссовера создали новую многорычажную заднюю подвеску с особо прочными креплениями к подрамнику. Габаритные длина, ширина и высота Lexus RX AL30 составляют 4890, 1920 и 1695 мм соответственно, колесная база — 2850 мм. По сравнению с моделью уходящей генерации AL20 длина не изменилась, но ширина возросла на 25 мм, а высота — на 10 мм. Расстояние между осями стало больше на 60 мм — таким образом, удалось увеличить пространство в салоне для пассажиров. Экстерьер выполнен в новом фирменном стиле бренда Lexus — в пресс-службе компании подчеркивают, что дизайнеры стремились наделить машину легким и изящным обликом. На это ощущение работают приземистая двухобъемная форма, стремительный профиль с ниспадающей крышей, «минималистичные» боковины и необычная решетка радиатора с фальшсотами в верхней части. Кузов тщательно проработан с точки зрения обтекаемости. В салоне цифровой щиток приборов, экран медиасистемы и левый дефлектор вентиляции выполнены единым визуальным блоком, который выступает относительно передней панели. Диагональ экрана мультимедиа — 14 дюймов. Внутренняя длина багажного отделения возросла относительно предшественника на 50 мм — этого достигли за счет менее толстой обивки дверцы багажника. Погрузочная высота уменьшена на 30 мм. В отсеке можно перевозить четыре чемодана объемом 77 л каждый или четыре 9,5-дюймовые  сумки для гольфа, подчеркивается в пресс-релизе. Кузов относительно предыдущего RX стал прочнее и при этом легче на 90 кг. В центральной стойке впервые в мире применили стальной лист класса 2 ГПа, элементы из него штампуются горячим методом. Капот и передние крылья сделали из алюминиевого проката. В узловании элементов несущего каркаса использованы лазерная винтовая сварка, конструкционные клеи и традиционная точечная сварка. Машину будут выпускать в четырех модификациях: RX350, RX350h, RX450h+ и RX500h. Лишь первая из них является чисто бензиновой, остальные — гибридные, причем RX450h+ — с возможностью подзарядки от сети. RX350 оснащен 2,4-литровым бензиновым турбо мощностью 275 л.с. и крутящим моментом 430 Нм. Он сочетается с 8-ступенчатым «автоматом», передним или полным приводом. RX350h укомплектован системой типа «параллельный гибрид» — 2,5-литровый бензиновый мотор в нем совмещен с вариатором и электродвигателем, совокупная мощность — 249 л.с., крутящий момент — 316 Нм. Привод — передний или полный, во втором случае применен электромотор на задней оси (система E-Four). RX500h — это параллельный гибрид с системой Direct4, у него 2,4-литровый бензиновый двигатель, 6-ступенчатая АКП и отдельный электромотор на задней оси. Суммарные характеристики — 372 л.с. и 550 Нм, привод полный. Это исполнение будет предлагаться только со спортивным пакетом F Sport Performance, подразумевающим оригинальный обвес кузова и специальные настройки шасси. Direct4 автоматически распределяет крутящий момент между передней и задней осями в пропорции от 100:0 до 20:80. «Пятисотый» сочетает в себе динамику спорткара (разгон с места до 100 км/ч за 6 секунд) и расход топлива на уровне семейного седана (9,0 л/100 км). Характеристики подзаряжаемого RX450h+ не раскрываются. Продажи нового Lexus RX стартуют в конце 2022 года. Насчет возможности появления модели в России информации пока нет. Напомним, RX уходящей генерации AL20 выпускали с 2015 года.",
                 image: "lexus",
                 likes: 50,
                 views: 129,
                 isLiked: false)

public let posts = [post1, post2, post3, post4]
