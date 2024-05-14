
view: dim_divisas {
  derived_table: {
    sql: SELECT * FROM `envases-analytics-qa.RPT_ALU.Dim_Divisas`  ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_fuente {
    type: string
    sql: ${TABLE}.ID_Fuente ;;
  }

  dimension: fecha {
    type: date
    datatype: date
    sql: ${TABLE}.Fecha ;;
  }

  dimension: moneda_origen {
    type: string
    sql: ${TABLE}.Moneda_Origen ;;
  }

  dimension: moneda_conversion {
    type: string
    sql: ${TABLE}.Moneda_Conversion ;;
  }

  dimension: tipo_cambio {
    type: number
    sql: ${TABLE}.Tipo_Cambio ;;
  }

  set: detail {
    fields: [
        id_fuente,
  fecha,
  moneda_origen,
  moneda_conversion,
  tipo_cambio
    ]
  }
}
