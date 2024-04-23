--Made by holyjoey.
--Credits to Lance. Used dashmaster to check speed of vehicle.

util.require_natives('3095a')

function spawnBus()
    menu.trigger_commands("godmode off")
    menu.trigger_commands("vehgodmode off")
    menu.trigger_commands("spawngod off")
    menu.trigger_commands("bus")
    util.yield(100) -- yeah idfk it tended to not always to the shit after it correctly so
    menu.trigger_commands("tune")
    menu.trigger_commands("plate 1994")
end

local kaboomSpeed = 50
menu.my_root():slider("Kaboom Speed", {"kaboomspeed"}, "Change at what speed the bus goes boom.", 0, 500, kaboomSpeed, 1, function(tresholdChanger)
    kaboomSpeed = tresholdChanger
end)

menu.toggle_loop(menu.my_root(), "Speed (1994)", {"speed1994"}, "There is a bomb on a bus. Once the bus goes 50 MPH, the bomb is armed. If it drops below 50, it blows up.", function(on)
    if not spawnedBus then
        spawnBus()
        spawnedBus = true
    end
    local speed = math.ceil(ENTITY.GET_ENTITY_SPEED(entities.get_user_vehicle_as_handle(false)) * 2.236936)
    if speed >= kaboomSpeed then
        if not kaboomNotif then
            util.toast("Reached the speed of " .. kaboomSpeed .. " MPH. Bomb has been armed!")
            kaboomNotif = true
        end
        kaboomBelowKaboomSpeed = true
    end
    if kaboomBelowKaboomSpeed then
        if speed < kaboomSpeed then
            menu.trigger_commands("destroyvehicle")
            kaboomBelowKaboomSpeed = false
            kaboomNotif = false
        end
    end
    util.yield()
end)

util.keep_running()
