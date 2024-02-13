
view: fact_ventas {
  derived_table: {
    sql: SELECT *
               ,DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) ACTUALIZACION
         FROM `envases-analytics-qa.RPT_ALU.Fact_Ventas` ;;
  }


  parameter: Tipo_moneda {

    type: unquoted

    allowed_value: {
      label: "Moneda Nacional"
      value: "MXN"
    }


    allowed_value: {
      label: "Moneda Extranjera"
      value: "ME"
    }



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

  # dimension: fecha {
  #  type: date
  # datatype: date
  #  sql: ${TABLE}.Fecha ;;
  #}

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
    sql: ${TABLE}.Cantidad/ 1000 ;;
  }

  dimension: moneda_transaccion {
    label: "CURRENCY TYPE"
    type: string
    sql: ${TABLE}.Moneda_Transaccion ;;
  }

  dimension: monto {
    type: number
    sql: ${TABLE}.Monto / 1000 ;;
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
    sql: ${TABLE}.Monto_Conversion / 1000 ;;
  }



################################################################### FILTROS DE TIEMPO ######################################################

  ##################Dias ############################

  dimension: periodo_dia {
    hidden: yes
    type: yesno
    sql:DATE_TRUNC(CAST(${created_date} AS DATE),DAY) =DATE_ADD( DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), DAY),INTERVAL -0 DAY);;
  }

  dimension: periodo_dia_anterior {
    hidden: yes
    type: yesno
    sql:DATE_TRUNC(CAST(${created_date} AS DATE),DAY) =DATE_ADD(DATE_ADD( DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), DAY),INTERVAL -1 year),INTERVAL -0 day);;
  }

  ##################Dias ############################


  ##################Mes ############################
  dimension: is_current_period{
    hidden: yes
    type: yesno
    sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY) >=DATE_ADD(DATE_ADD(LAST_DAY(CAST({% date_start date_filter %} AS DATE)), INTERVAL 1 DAY),INTERVAL -1 MONTH) AND DATE_TRUNC(CAST(${created_date} AS DATE),DAY) <= DATE_ADD((CAST({% date_start date_filter %} AS DATE)),INTERVAL -0 day)  ;;
    #sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY)>=DATE_ADD(DATE_ADD(LAST_DAY(CAST({% date_start date_filter %} AS DATE)), INTERVAL 1 DAY),INTERVAL -1 MONTH)    ;;
    #sql:DATE_TRUNC(CAST(${created_date} AS DATE),YEAR) =  DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), YEAR)  and DATE_TRUNC(CAST(${created_date} AS DATE),MONTH) = DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH) ;;
    #LAST_DAY
  }


  dimension: is_previous_period{
    hidden: yes
    type: yesno
    sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY) >=DATE_ADD(DATE_ADD(LAST_DAY(     DATE_ADD( CAST({% date_start date_filter %} AS DATE) ,INTERVAL -1 YEAR)        ), INTERVAL 1 DAY),INTERVAL -1 MONTH) AND DATE_TRUNC(CAST(${created_date} AS DATE),DAY) <= DATE_ADD(   DATE_ADD( CAST({% date_start date_filter %} AS DATE) ,INTERVAL -1 YEAR)    ,INTERVAL -0 day)  ;;
    # sql:DATE_TRUNC(CAST(${created_date} AS DATE),YEAR) =  DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), YEAR) -1  and   DATE_TRUNC(CAST(${created_date} AS DATE),MONTH) = DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH) ;;

  }
  ##################Mes ############################


  ##################Año ############################


  dimension: is_current_year {
    hidden: yes
    type: yesno
    sql: ${created_date} >= CAST(CONCAT(CAST(EXTRACT(YEAR FROM DATE ({% date_start date_filter %})) AS STRING),"-01-01")  AS DATE) and  ${created_date} <= DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), DAY)   ;;
    #DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), YEAR);;  FECHA         DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH)
  }

  dimension: is_previous_year {
    hidden: yes
    type: yesno
    sql: ${created_date} >= CAST(CONCAT(CAST(EXTRACT(YEAR FROM DATE ({% date_start date_filter %})) -1 AS STRING),"-01-01")  AS DATE) and  ${created_date} <= DATE_ADD(DATE_ADD( DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), DAY),INTERVAL -1 year),INTERVAL -0 day)   ;;
    #DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), YEAR);;  FECHA         DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH)
  }

  ##################Año ############################

################################################################### FILTROS DE TIEMPO ######################################################





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


  dimension: actualizacion {
    type: date
    sql: ${TABLE}.ACTUALIZACION ;;
  }



  measure: ult_act {
    type: date
    label: "Update date"
    sql: MAX(${actualizacion});;
    convert_tz: no
  }




  filter: date_filter {
    label: "Período"
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering"
    type: date
    # default_value: "6 weeks"
    # este es un filtro de fecha

  }

  dimension: fecha {
    label: "Date filter"
    type: string
    sql: CAST({% date_start date_filter %} AS DATE) ;;
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


################################################################### METRICA VACIOS ########################################################

  measure: empty_value1 {
    group_label: "seperador"
    label: "Empty value 1"
    type: string
    sql: '';;
  }

  measure: empty_value2 {
    group_label: "seperador"
    label: "Empty value 2"
    type: string
    sql: '';;
  }





################################################################### CALCULOS DIARIOS ######################################################








  measure: DAILY_SALES {
    group_label: "Daily"
    label: "DAILY SALES"
    type: sum
    sql: ${monto} ;;

    filters: {
      field: periodo_dia
      value: "yes"
    }

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, DAILY_SALES]

   # drill_fields: [ Client,DAILY_SALES]

    #value_format: "#,##0"
    value_format: "$#,##0.00"
  }

  measure: promedio_tipo_cambio {
    group_label: "Daily"
    label: "EXCHANGE RATE"
    type: average
    sql: ${tipo_cambio} ;;

    filters: {
      field: periodo_dia
      value: "yes"
    }



    #value_format: "#,##0"
    value_format: "$#,##0.00"
  }



#################################################################### INICIO CALCULOS MENSUALES ##################################################################


  measure: CURRENT_QTY_MTD {
    group_label: "Monthly"
    label: "QTY MTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, CURRENT_QTY_MTD]


    value_format: "#,##0"
  }

  measure: PREVIOUS_QTY_MTD {
    group_label: "Monthly"
    label: "PREVIOUS_QTY MTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }


    value_format: "#,##0"
  }


  measure: INDEX_QTY_MTD {
    group_label: "Monthly"
      label: "% VS QTY MTD"
    type: number
    sql: (${CURRENT_QTY_MTD} - ${PREVIOUS_QTY_MTD}) / NULLIF(${PREVIOUS_QTY_MTD},0)*100 ;;

    html:
    {% if value > 0 %}
    <span style="color: green;">{{ rendered_value }}</span></p>
    {% elsif  value < 0 %}
    <span style="color: red;">{{ rendered_value }}</span></p>
    {% elsif  value == 0 %}
    {{rendered_value}}
    {% else %}
    {{rendered_value}}
    {% endif %} ;;


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,CURRENT_QTY_MTD,PREVIOUS_QTY_MTD, INDEX_QTY_MTD]

    value_format: "0.00\%"

  }

  measure: CURRENT_AMOUNT_MTD {
    group_label: "Monthly"
    label: "AMOUNT MTD"
    type: sum
    sql:

      {% if Tipo_moneda._parameter_value == 'MXN' %}
        ${monto_conversion}
      {% else  %}
       ${monto}
       {% endif %};;


    filters: {
      field: is_current_period
      value: "yes"
    }

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, CURRENT_AMOUNT_MTD]

    value_format: "#,##0"
  }

  measure: PREVIOUS_AMOUNT_MTD {
    group_label: "Monthly"
    label: "PREVIOUS_AMOUNT MTD"
    type: sum
    sql:  {% if Tipo_moneda._parameter_value == 'MXN' %}
        ${monto_conversion}
      {% else  %}
       ${monto}
       {% endif %};;

    filters: {
      field: is_previous_period
      value: "yes"
    }
    value_format: "#,##0"
  }


  measure: INDEX_AMOUNT_MTD {
    group_label: "Monthly"
    label: "% VS AMOUNT MTD"
    type: number
    sql: (${CURRENT_AMOUNT_MTD} - ${PREVIOUS_AMOUNT_MTD}) / NULLIF(${PREVIOUS_AMOUNT_MTD},0)*100 ;;

    html:
    {% if value > 0 %}
    <span style="color: green;">{{ rendered_value }}</span></p>
    {% elsif  value < 0 %}
    <span style="color: red;">{{ rendered_value }}</span></p>
    {% elsif  value == 0 %}
    {{rendered_value}}
    {% else %}
    {{rendered_value}}
    {% endif %} ;;


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,CURRENT_AMOUNT_MTD,PREVIOUS_AMOUNT_MTD, INDEX_AMOUNT_MTD]

      value_format: "0.00\%"

    }


 #################################################################### FIN CALCULOS MENSUALES ##################################################################



#################################################################### INICIO CALCULOS ANUALES ##################################################################

  measure: CURRENT_QTY_YTD {
     group_label: "Annual"
    label: "QTY YTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_year
      value: "yes"
    }

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, CURRENT_QTY_YTD]

    value_format: "#,##0"
  }

  measure: PREVIOUS_QTY_YTD {
     group_label: "Annual"
    label: "PREVIOUS QTY YTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_previous_year
      value: "yes"
    }
    value_format: "#,##0"
  }


  measure: INDEX_QTY_YTD {
     group_label: "Annual"
    label: "% VS QTY YTD"
    type: number
    sql: (${CURRENT_QTY_YTD} - ${PREVIOUS_QTY_YTD}) / NULLIF(${PREVIOUS_QTY_YTD},0)*100 ;;

    html:
    {% if value > 0 %}
    <span style="color: green;">{{ rendered_value }}</span></p>
    {% elsif  value < 0 %}
    <span style="color: red;">{{ rendered_value }}</span></p>
    {% elsif  value == 0 %}
    {{rendered_value}}
    {% else %}
    {{rendered_value}}
    {% endif %} ;;


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,CURRENT_QTY_YTD,PREVIOUS_QTY_YTD, INDEX_QTY_YTD]

      value_format: "0.00\%"

    }

    measure: CURRENT_AMOUNT_YTD {
     group_label: "Annual"
      label: "AMOUNT YTD"
      type: sum
      sql:
      {% if Tipo_moneda._parameter_value == 'MXN' %}
        ${monto_conversion}
      {% else  %}
       ${monto}
       {% endif %}

      ;;


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, CURRENT_AMOUNT_YTD]

      filters: {
        field: is_current_year
        value: "yes"
      }
      value_format: "#,##0"
    }

    measure: PREVIOUS_AMOUNT_YTD {
      group_label: "Annual"
      label: "PREVIOUS_AMOUNT YTD"
      type: sum
      sql:

      {% if Tipo_moneda._parameter_value == 'MXN' %}
        ${monto_conversion}
      {% else  %}
       ${monto}
       {% endif %} ;;

      filters: {
        field: is_previous_year
        value: "yes"
      }
      value_format: "#,##0"
    }


    measure: INDEX_AMOUNT_YTD {
      group_label: "Annual"
      label: "% VS AMOUNT YTD"
      type: number
      sql: (${CURRENT_AMOUNT_YTD} - ${PREVIOUS_AMOUNT_YTD}) / NULLIF(${PREVIOUS_AMOUNT_YTD},0)*100 ;;

      html:
          {% if value > 0 %}
          <span style="color: green;">{{ rendered_value }}</span></p>
          {% elsif  value < 0 %}
          <span style="color: red;">{{ rendered_value }}</span></p>
          {% elsif  value == 0 %}
          {{rendered_value}}
          {% else %}
          {{rendered_value}}
          {% endif %} ;;


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,CURRENT_AMOUNT_YTD,PREVIOUS_AMOUNT_YTD, INDEX_AMOUNT_YTD]
        value_format: "0.00\%"

      }





#################################################################### FIN CALCULOS ANUALES ##################################################################






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
