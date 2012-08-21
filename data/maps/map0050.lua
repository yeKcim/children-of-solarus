local map = ...
-- Dungeon 8 B3

-- Legend
-- RC: Rupee Chest
-- KC: Key Chest
-- KP: Key Pot
-- LD: Locked Door
-- KD: Key Door
-- DB: Door Button
-- LB: Locked Barrier
-- BB: Barrier Button
-- DS: Door Sensor

function map:on_started(destination_point_name)
  map:set_doors_open("LD12", true)
  if map:get_game():get_boolean(725) then
    map:block_set_enabled("STT5", false)
  end
  if map:get_game():get_boolean(720) then
    map:switch_set_activated("DB1", true)
  end
  if map:get_game():get_boolean(721) then
    map:switch_set_activated("DB2", true)
  end
  if map:get_game():get_boolean(720) and map:get_game():get_boolean(721) then
    map:set_doors_open("LD14", true)
  end
end

function map:on_hero_on_sensor(sensor_name)
  if sensor_name == "DS12" then
    map:close_doors("LD12")
    map:sensor_set_enabled("DS12", false)
  end
end

function map:on_block_moved(block_name)
  x, y = map:block_get_position("STT5")
  if x >= 1096 and x <= 1160
      and y >= 893 and y <= 925 then
    map:block_set_enabled("STT5", false)
    sol.audio.play_sound("jump")
    map:get_game():set_boolean(725, true)
    sol.timer.start(500, function()
      sol.audio.play_sound("bomb")
    end)
  end
end

function map:on_switch_activated(switch_name)
  if switch_name == "DB1" then
    map:get_game():set_boolean(720, true)
    if map:get_game():get_boolean(721) then
      map:open_doors("LD14")
      sol.audio.play_sound("secret")
    end
  elseif switch_name == "DB2" then
    map:get_game():set_boolean(721, true)
    if map:get_game():get_boolean(720) then
      map:open_doors("LD14")
      sol.audio.play_sound("secret")
    end
  elseif switch_name == "DB3" then
    map:open_doors("LD12")
    map:open_doors("LD13")
    sol.audio.play_sound("secret")
  end
  if DB1_status == true and DB2_status == true then
    map:open_doors("LD14")
    sol.audio.play_sound("secret")
  end
end
