local PLUGIN = PLUGIN

ITEM.name = "Droid Gonk"
ITEM.model = "models/battleground/droids/gonk_droid.mdl"
ITEM.description = "Um Droid Gonk, para alguns uma bateria com pernas, mas para outros uma caixa de munição com pernas!"
ITEM.category = "Tools"

ITEM.width = 2
ITEM.height = 3
ITEM.iconCam = {
    pos = Vector(0, 200, 0),
    ang = Angle(-8.35, 270.6, 0),
    fov = 14.1,
}

ITEM.functions.Deploy = {
    icon = "icon16/wrench.png",
    OnRun = function(itemTable)
        local ply = itemTable.player
        local char = ply:GetCharacter()
        local trace = ply:GetEyeTraceNoCursor()
        if ( trace.HitPos:Distance(ply:GetShootPos()) <= 192 ) then
            local deployable = ents.Create("gnk_supply_droid")
            deployable:SetPos(trace.HitPos)
            deployable:SetMaxHealth(5)
            deployable:SetHealth(5)
            deployable:Spawn()

            local physicsObject = deployable:GetPhysicsObject()
            if ( IsValid(physicsObject) ) then
                physicsObject:Wake()
                physicsObject:EnableMotion(false)
                timer.Simple(0.1, function() physicsObject:EnableMotion(true) end)
            end
            if ( IsValid(deployable) ) then
                deployable:SetAngles(Angle(0, ply:EyeAngles().yaw + 360, 0))
            end
        else
            ply:Notify("Você não pode colocar uma torre tão longe!")
            return false
        end
    end
}
