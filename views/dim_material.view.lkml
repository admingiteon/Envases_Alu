
view: dim_material {
  derived_table: {
    sql: SELECT * FROM `envases-analytics-qa.RPT_ALU.Dim_Material` LIMIT 10 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_fuente {
    type: string
    sql: ${TABLE}.ID_Fuente ;;
  }

  dimension: material {
    type: string
    sql: ${TABLE}.Material ;;
  }

  dimension: descripcion {
    type: string
    sql: ${TABLE}.Descripcion ;;
  }

  dimension: grupo_mat {
    type: string
    sql: ${TABLE}.Grupo_Mat ;;
  }

  dimension: dimensiones {
    type: string
    sql: ${TABLE}.Dimensiones ;;
  }

  dimension: jerarquia {
    type: string
    sql: ${TABLE}.Jerarquia ;;
  }

  set: detail {
    fields: [
        id_fuente,
	material,
	descripcion,
	grupo_mat,
	dimensiones,
	jerarquia
    ]
  }
}
