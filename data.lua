
local coinFarm = util.table.deepcopy(data.raw.furnace['electric-furnace'])
coinFarm.name = "coin-farm"
coinFarm.minable = {mining_time = 0.1, result = "coin-farm"}
coinFarm.energy_usage = "1000kW"
coinFarm.energy_source.drain = "10kW"
coinFarm.crafting_categories = {"sciencecoin"}

local coinFarmEnergy = util.table.deepcopy(data.raw.radar['radar'])
coinFarmEnergy.name = "coin-farm-energy"
coinFarmEnergy.minable = {mining_time = 0.1, result = "coin-farm-energy"}
coinFarmEnergy.energy_usage = "2000kW"


data:extend({
  {
    type = "recipe-category",
    name = "sciencecoin"
  },

  {
    type = "recipe",
    name = "RedScienceCoin",
    category = "sciencecoin",
    enabled = true,
    hidden = true,
    energy_required = 80,
    ingredients =
    {
      {"automation-science-pack", 1} 
    },
    results = { },
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 32,
    subgroup = "fluid-recipes",      
  },
  {
    type = "recipe",
    name = "GreenScienceCoin",
    category = "sciencecoin",
    enabled = true,
    hidden = true,
    energy_required = 70,
    ingredients =
    {
      {"logistic-science-pack", 1} --
    },
    results = { },
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 32,
    subgroup = "fluid-recipes",      
  },
  {
    type = "recipe",
    name = "BlackScienceCoin",
    category = "sciencecoin",
    enabled = true,
    hidden = true,
    energy_required = 60,
    ingredients =
    {
      {"military-science-pack", 1} --
    },
    results = { },
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 32,
    subgroup = "fluid-recipes",    
  },
  {
    type = "recipe",
    name = "BlueScienceCoin",
    category = "sciencecoin",
    enabled = true,
    hidden = true,
    energy_required = 50,
    ingredients =
    {
      {"chemical-science-pack", 1} --
    },
    results = { },
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 32,
    subgroup = "fluid-recipes",      
  },
	{
    type = "recipe",
    name = "YellowScienceCoin",
    category = "sciencecoin",
    enabled = true,
    hidden = true,
    energy_required = 40,
    ingredients =
    {
      {"utility-science-pack", 1} --
    },
    results = { },
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 32,
    subgroup = "fluid-recipes",	        
  },
  {
    type = "recipe",
    name = "PurpleScienceCoin",
    category = "sciencecoin",
    enabled = true,
    hidden = true,
    energy_required = 30,
    ingredients =
    {
      {"production-science-pack", 1} 
    },
    results = { },
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 32,
    subgroup = "fluid-recipes",      
  },
  {
    type = "recipe",
    name = "WhiteScienceCoin",
    category = "sciencecoin",
    enabled = true,
    hidden = true,
    energy_required = 20,
    ingredients =
    {
      {"space-science-pack", 1} --
    },
    results = { },
    icon = "__base__/graphics/icons/coin.png",
    icon_size = 32,
    subgroup = "fluid-recipes",	 
  },  
})

data:extend{   
    coinFarm,    
    {
        type = "recipe",
        name = "coin-farm",
        ingredients = {{"electronic-circuit", 50}, {"iron-gear-wheel", 50}},
        energy_required = 30,
        results = {{"coin-farm", 1}},     
        module_specification =
        {
          module_slots = 0,
        }
    },

    coinFarmEnergy,    
    {
        type = "recipe",
        name = "coin-farm-energy",
        ingredients = {{"advanced-circuit", 20}, {"iron-gear-wheel", 50}},
        energy_required = 30,
        results = {{"coin-farm-energy", 1}}
    },
    
    {
        type = "item",
        name = "coin-farm",
        place_result = "coin-farm",		
        subgroup = "extraction-machine",
        stack_size = 10,
        icon = "__base__/graphics/icons/coin.png",
        icon_size = 32
    },

    {
      type = "item",
      name = "coin-farm-energy",
      place_result = "coin-farm-energy",		
      subgroup = "extraction-machine",
      stack_size = 10,
      icon = "__base__/graphics/icons/coin.png",
      icon_size = 32
  },
}