Config.destroy_all
Season.destroy_all
Plan.destroy_all

Plan.create!({
  id: 1,
  name: "Formule 2024",
  class_price: 320,
  kids_class_price: 280,
  workshop_price: 108,
  obc_markup: 10,
  outbounds_markup: 20,
  early_learning_price: 90,
  kid_discovery_price: 135,
  first_step_discount: 5,
  first_step: 580,
  second_step_discount: 10,
  second_step: 870,
  third_step_discount: 20,
  third_step: 1200,
  pathway_price: 320
})
Season.create!({ start_year: 2024, plan_id: 1, id: 1 })
Config.create!({ season_id: 1 })
