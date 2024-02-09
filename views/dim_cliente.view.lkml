
view: dim_cliente {
  derived_table: {
    sql: SELECT * FROM `envases-analytics-qa.RPT_ALU.Dim_Cliente` LIMIT 10 ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: id_fuente {
    type: string
    sql: ${TABLE}.ID_Fuente ;;
  }

  dimension: codigo_cliente {
    type: string
    sql: ${TABLE}.Codigo_Cliente ;;
  }

  dimension: organizacion_ventas {
    type: string
    sql: ${TABLE}.Organizacion_Ventas ;;
  }

  dimension: canal_distribucion {
    type: string
    sql: ${TABLE}.Canal_Distribucion ;;
  }

  dimension: division {
    type: string
    sql: ${TABLE}.Division ;;
  }

  dimension: nombre {
    type: string
    sql: ${TABLE}.Nombre ;;
  }

  dimension: pais {
    type: string
    sql: ${TABLE}.Pais ;;
  }

  dimension: ciudad {
    type: string
    sql: ${TABLE}.Ciudad ;;
  }

  dimension: grupo_ventas {
    type: string
    sql: ${TABLE}.Grupo_Ventas ;;
  }

  set: detail {
    fields: [
        id_fuente,
	codigo_cliente,
	organizacion_ventas,
	canal_distribucion,
	division,
	nombre,
	pais,
	ciudad,
	grupo_ventas
    ]
  }
}
