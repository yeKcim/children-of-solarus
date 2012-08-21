local map = ...
-- Cave of the hole near the flower

function map:on_started(destination_point_name)

  if destination_point_name ~= "main_entrance" then
    map:set_doors_open("door", true)
  end
end

function map:on_hero_on_sensor(sensor_name)

  if sensor_name == "close_door_sensor"
      and map:door_is_open("door") then
    map:close_doors("door")
  end
end

