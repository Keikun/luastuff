function PLUGIN:CanPlayerEquipItem(client, item)
    if client:GetCharacter():GetAttribute("str", 10) > 0
            else
                client:Notify("Voce n tem forca seu bobo")
                return false
end

  ITEM.functions.Equip = {
    name = "Equipar",
    icon = "icon16/arrow_up.png",
    onCanRun = function(item)
        local client = item.player
        if client:GetCharacter() then
            local character = client:GetCharacter()
            local armorEquipped = character:GetData("armorEquipped")

            if armorEquipped then
                return false, "Você já está usando uma armadura!"
            end

            return true
        end

        return false, "Você precisa ter um personagem válido para equipar a armadura."
    end,
    onRun = function(item)
        local client = item.player
        local character = client:GetCharacter()

        character:GetInventory():Add(item.uniqueID)
        character:UpdateInventory()
        character:Save()

        item:OnEquip(character, character:GetInventory())

        item.player:Notify("Você equipou a armadura com sucesso!")
        return true
    end
}

ITEM.functions.Holster = {
    name = "Remover",
    icon = "icon16/arrow_down.png",
    onCanRun = function(item)
        local client = item.player
        if client:GetCharacter() then
            local character = client:GetCharacter()
            local armorEquipped = character:GetData("armorEquipped")

            if not armorEquipped then
                return false, "Você não está usando uma armadura!"
            end

            return true
        end

        return false, "Você precisa ter um personagem válido para remover a armadura."
    end
