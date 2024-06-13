# EPIC RPS

Распечатать все шрифты:
```
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print(family, names)
        }
```
