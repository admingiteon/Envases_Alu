
view: dim_planta {
  derived_table: {
    sql: SELECT * FROM `envases-analytics-qa.RPT_ALU.Dim_Planta` ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_fuente {
    type: string
    sql: ${TABLE}.ID_Fuente ;;
  }

  dimension: id_planta {
    type: string
    sql: ${TABLE}.ID_Planta ;;
  }

  dimension: nombre_planta {
    label: "Planta"
    type: string
    sql: ${TABLE}.Nombre_Planta ;;
  }

  dimension: ciudad {
    type: string
    sql: ${TABLE}.Ciudad ;;
  }

  dimension: pais {
    type: string
    sql: ${TABLE}.Pais ;;
  }

  set: detail {
    fields: [
        id_fuente,
  id_planta,
  nombre_planta,
  ciudad,
  pais
    ]
  }
}
