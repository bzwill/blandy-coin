
local coinFarm = util.table.deepcopy(data.raw.furnace['electric-furnace'])
coinFarm.name = "coin-farm"
coinFarm.minable = {mining_time = 0.1, result = "coin-farm"}
coinFarm.energy_usage = "0.1kW"
coinFarm.energy_source.drain = settings.startup["credit-mint-energy-usage"].value
coinFarm.crafting_categories = {"sciencecoin"},

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
    hidden = false,
    energy_required = 70,
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
    hidden = false,
    energy_required = 60,
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
    hidden = false,
    energy_required = 50,
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
    hidden = false,
    energy_required = 40,
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
    hidden = false,
    energy_required = 30,
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
    hidden = false,
    energy_required = 20,
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
    hidden = false,
    energy_required = 10,
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