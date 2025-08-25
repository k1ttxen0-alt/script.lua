локальные Игроки = игра:GetService("Игроки")
локальные запрещенные инструменты = { ["Барьер"] = правда, ["Захватить"] = правда }

локальная функция kickIfBanned(игрок, инструмент)
    если tool:IsA("Tool") и bannedTools[tool.Name] тогда
        player:Kick("Жёлтый Блодмэн кинул тебя за " .. tool.Name)
    конец
конец

локальная функция checkPlayer(player)
    локальная функция onCharacterAdded(char)
        -- Проверка уже имеющихся инструментов
        для _, инструмент в ipairs(player.Backpack:GetChildren()) сделать
            kickIfBanned(игрок, инструмент)
        конец
        -- Проверка инструментов в руках
        для _, инструмент в ipairs(char:GetChildren()) сделать
            kickIfBanned(игрок, инструмент)
        конец

        -- Отслеживание новых инструментов в рюкзаке
        player.Backpack.ChildAdded:Connect(function(tool)
            kickIfBanned(игрок, инструмент)
        конец)

        -- Отслеживание новых инструментов в руках
        char.ChildAdded:Connect(function(tool)
            kickIfBanned(игрок, инструмент)
        конец)
    конец

    -- Если персонаж уже загружен
    если player.Character, то onCharacterAdded(player.Character) конец
    player.CharacterAdded:Connect(onCharacterAdded)
конец

Players.PlayerAdded:Connect(checkPlayer)

