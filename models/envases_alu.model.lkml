connection: "envases_analytics_qa"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: envases_alu_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: envases_alu_default_datagroup

explore: fact_ventas {

  join: dim_cliente {
    type: left_outer
    sql_on: ${fact_ventas.cliente} = ${dim_cliente.codigo_cliente} ;;
    relationship: many_to_one
  }


  join: dim_material {
    type: left_outer
    sql_on: ${fact_ventas.material} = ${dim_material.material} ;;
    relationship: many_to_one
  }





}




explore: dim_cliente {}
explore: dim_divisas {}
explore: dim_grupoclientes {}
explore: dim_material {}
explore: dim_planta {}
