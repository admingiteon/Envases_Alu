
view: fact_ventas {
  derived_table: {
    sql: SELECT * FROM `envases-analytics-qa.RPT_ALU.Fact_Ventas` ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_fuente {
    type: string
    sql: ${TABLE}.ID_Fuente ;;
  }

  dimension: documento {
    type: string
    sql: ${TABLE}.Documento ;;
  }

  dimension: posicion {
    type: string
    sql: ${TABLE}.Posicion ;;
  }

  dimension: tipo_transaccion {
    type: string
    sql: ${TABLE}.Tipo_Transaccion ;;
  }

  dimension: tipo_documento {
    type: string
    sql: ${TABLE}.Tipo_Documento ;;
  }

  dimension: fecha {
    type: date
    datatype: date
    sql: ${TABLE}.Fecha ;;
  }

  dimension: canal_distribucion {
    type: string
    sql: ${TABLE}.Canal_Distribucion ;;
  }

  dimension: material {
    type: string
    sql: ${TABLE}.Material ;;
  }

  dimension: planta {
    type: string
    sql: ${TABLE}.Planta ;;
  }

  dimension: cliente {
    type: string
    sql: ${TABLE}.Cliente ;;
  }

  dimension: destinatario {
    type: string
    sql: ${TABLE}.Destinatario ;;
  }

  dimension: organizacion_ventas {
    type: string
    sql: ${TABLE}.Organizacion_Ventas ;;
  }

  dimension: unidad_base {
    type: string
    sql: ${TABLE}.Unidad_Base ;;
  }

  dimension: cantidad {
    type: number
    sql: ${TABLE}.Cantidad ;;
  }

  dimension: moneda_transaccion {
    type: string
    sql: ${TABLE}.Moneda_Transaccion ;;
  }

  dimension: monto {
    type: number
    sql: ${TABLE}.Monto ;;
  }

  dimension: moneda_conversion {
    type: string
    sql: ${TABLE}.Moneda_Conversion ;;
  }

  dimension: tipo_cambio {
    type: number
    sql: ${TABLE}.Tipo_Cambio ;;
  }

  dimension: monto_conversion {
    type: number
    sql: ${TABLE}.Monto_Conversion ;;
  }




  dimension_group: created {
    label: "Fecha"
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      month_name,
      year
    ]
    sql: CAST(${TABLE}.Fecha AS TIMESTAMP) ;;

  }


  filter: date_filter {
    label: "Período"
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering"
    type: date
    # default_value: "6 weeks"
    # este es un filtro de fecha

  }


  measure: total_cantidad {
    type: sum
    sql: ${TABLE}.Cantidad ;;
  }

  measure: total_monto {
    type: sum
    sql: ${TABLE}.Monto ;;
  }

  measure: total_monto_conversion {
    type: sum
    sql: ${TABLE}.Monto_Conversion ;;
  }


  set: detail {
    fields: [
        id_fuente,
  documento,
  posicion,
  tipo_transaccion,
  tipo_documento,
  fecha,
  canal_distribucion,
  material,
  planta,
  cliente,
  destinatario,
  organizacion_ventas,
  unidad_base,
  cantidad,
  moneda_transaccion,
  monto,
  moneda_conversion,
  tipo_cambio,
  monto_conversion
    ]
  }
}
