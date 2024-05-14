
view: dim_grupoclientes {
  derived_table: {
    sql: SELECT * FROM `envases-analytics-qa.RPT_ALU.Dim_GrupoClientes` ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_fuente {
    type: string
    sql: ${TABLE}.ID_Fuente ;;
  }

  dimension: codigo_grupo {
    type: string
    sql: ${TABLE}.Codigo_Grupo ;;
  }

  dimension: descripcion {
    label: "Cliente"
    type: string
    sql: ${TABLE}.Descripcion ;;
  }

  set: detail {
    fields: [
        id_fuente,
  codigo_grupo,
  descripcion
    ]
  }
}
