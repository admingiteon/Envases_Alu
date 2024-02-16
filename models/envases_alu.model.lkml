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
    sql_on: ${fact_ventas.cliente} = ${dim_cliente.codigo_cliente} and ${fact_ventas.id_fuente} = ${dim_cliente.id_fuente} ;;
    relationship: many_to_one
  }

  join: dim_grupoclientes {
    type: left_outer
    sql_on: ${dim_cliente.grupo_ventas} = ${dim_grupoclientes.codigo_grupo} and ${fact_ventas.id_fuente} = ${dim_grupoclientes.id_fuente} ;;
    relationship: many_to_one
  }


  join: dim_material {
    type: left_outer
    sql_on: ${fact_ventas.material} = ${dim_material.material} and ${fact_ventas.id_fuente} = ${dim_material.id_fuente}  ;;
    relationship: many_to_one
  }

  join: dim_grupomateriales {
    type: left_outer
    sql_on: ${dim_material.grupo_mat} = ${dim_grupomateriales.codigo_grupo} and ${fact_ventas.id_fuente} = ${dim_grupomateriales.id_fuente} ;;
    relationship: many_to_one
  }


  join: dim_planta {
    type: left_outer
    sql_on: ${fact_ventas.planta} = ${dim_planta.id_planta} and  ${fact_ventas.id_fuente} = ${dim_planta.id_fuente} ;;
    relationship: many_to_one
  }

  access_filter: {
    field: id_fuente
    user_attribute: sist_fuente
  }
}
