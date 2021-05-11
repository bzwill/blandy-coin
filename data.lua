local coinFarm = util.table.deepcopy(data.raw.radar['radar'])
coinFarm.name = "coin-farm"
coinFarm.minable = {mining_time = 0.1, result = "coin-farm"}
coinFarm.energy_usage = "500kW"

data:extend{
    
    coinFarm,
    
    {
        type = "recipe",
        name = "coin-farm",
        ingredients = {{"electronic-circuit", 50}, {"iron-gear-wheel", 50}},
        energy_required = 30,
        results = {{"coin-farm", 1}}
    },

    {
        type = "item",
        name = "coin-farm",
        place_result = "coin-farm",
        subgroup = "extraction-machine",
        stack_size = 1,
        icon = "__base__/graphics/icons/coin.png",
        icon_size = 32
    },
}

