data:extend(
{

  {
    type = "recipe-category",
    name = "sciencecoin"
  },
})

local coinFarm = util.table.deepcopy(data.raw.furnace['electric-furnace'])
coinFarm.name = "coin-farm"
coinFarm.minable = {mining_time = 0.1, result = "coin-farm"}
coinFarm.energy_usage = "0.1kW"
coinFarm.energy_source.drain ="500kW"
coinFarm.crafting_categories = {"sciencecoin"},




  data:extend({
    {
      type = "recipe",
      name = "RedScienceCoin",
      category = "sciencecoin",
      enabled = true,
      hidden = false,
      energy_required = 0.01,
      ingredients =
      {
        {"automation-science-pack", 40} --2.5 credits per bottle at default 100 price
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
      energy_required = 1,
      ingredients =
      {
        {"logistic-science-pack", 20} --5 credits per bottle at default 100 price 
      },
      results = { },
      icon = "__base__/graphics/icons/coin.png",
      icon_size = 32,
      subgroup = "fluid-recipes",
	 
      
    },
	{
      type = "recipe",
      name = "BlackScienceCOin",
      category = "sciencecoin",
      enabled = true,
      hidden = false,
      energy_required = 1,
      ingredients =
      
        {"military-science-pack", 10} --10 credits per bottle at default 100 price
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
      energy_required = 1,
      ingredients =
      {
        {"chemical-science-pack", 5} --20 credits per bottle at default 100 price
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
      energy_required = 1,
      ingredients =
      {
        {"utility-science-pack", 2} --50 credits per bottle at default 100 price
      },
      results = { },
      icon = "__base__/graphics/icons/coin.png",
      icon_size = 32,
      subgroup = "fluid-recipes",
	  
      
    }

	},
  	{
      type = "recipe",
      name = "WhiteScienceCoin",
      category = "sciencecoin",
      enabled = true,
      hidden = false,
      energy_required = 1,
      ingredients =
      {
        {"space-science-pack", 1} --100 credits per bottle at default 100 price
      },
      results = { },
      icon = "__base__/graphics/icons/coin.png",
      icon_size = 32,
      subgroup = "fluid-recipes",
	  
      
    }

	},
  	{
      type = "recipe",
      name = "PurpleScienceCoin",
      category = "sciencecoin",
      enabled = true,
      hidden = false,
      energy_required = 1,
      ingredients =
      {
        {"production-science-pack", 3} --333 credits per bottle at default 100 price
      },
      results = { },
      icon = "__base__/graphics/icons/coin.png",
      icon_size = 32,
      subgroup = "fluid-recipes",
	  
      
    }

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


