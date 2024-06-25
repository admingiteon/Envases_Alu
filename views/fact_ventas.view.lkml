
view: fact_ventas {
  derived_table: {
    sql: SELECT *
               ,DATE_ADD(CURRENT_DATE(), INTERVAL -1 DAY) ACTUALIZACION
         FROM `envases-analytics-qa.RPT_ALU.Fact_Ventas` ;;
  }

#############FILTROS Y PARAMETROS
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

  filter: date_filter {
    label: "Período"
    description: "Use this date filter in combination with the timeframes dimension for dynamic date filtering"
    type: date
    default_value: "[hoy]"
    # default_value: "6 weeks"
    # este es un filtro de fecha

  }

################DIMENSIONES





  dimension: fecha_ultimo {
    type: date
    sql:  CAST({% date_start date_filter %} AS DATE);;
  }




  dimension: Status_Transferencia_Contable {
    type: string
    sql: ${TABLE}.Status_Transferencia_Contable ;;
  }



  dimension: hoy {
    type: date
    sql: current_date();;
    hidden: yes
  }
  dimension: id_fuente {
    label: "Sistema Fuente"
    type: string
    sql: ${TABLE}.ID_Fuente ;;
  }

  dimension: documento {
    hidden: yes
    type: string
    sql: ${TABLE}.Documento ;;
  }

  dimension: posicion {
    hidden: yes
    type: string
    sql: ${TABLE}.Posicion ;;
  }

  dimension: tipo_transaccion {
    label: "Tipo Transaccion"
    type: string
    sql: ${TABLE}.Tipo_Transaccion ;;
  }

  dimension: tipo_documento {
    #hidden: yes
    type: string
    sql: ${TABLE}.Tipo_Documento ;;
  }

  dimension: canal_distribucion {
    hidden: yes
    label: "Canal Distribución"
    type: string
    sql: ${TABLE}.Canal_Distribucion ;;
  }

  dimension: canal {
    label: "Canal Distribución"
    type: string
    sql:case when ${TABLE}.Canal_Distribucion in ('00','10','50') then 'Nacional' else 'Exportaciòn' end ;;
  }


  dimension: material {
    hidden: yes
    type: string
    sql: ${TABLE}.Material ;;
  }

  dimension: planta {
    hidden: yes
    type: string
    sql: ${TABLE}.Planta ;;
  }

  dimension: cliente {
    #hidden: yes
    type: string
    sql: ${TABLE}.Cliente ;;
  }

  dimension: destinatario {
    hidden: yes
    type: string
    sql: ${TABLE}.Destinatario ;;
  }

  dimension: organizacion_ventas {
    label: "Org. Ventas"
    type: string
    sql: ${TABLE}.Organizacion_Ventas ;;
  }

  dimension: unidad_base {
    label: "Unidad Medida"
    type: string
    sql: ${TABLE}.Unidad_Base ;;
  }

  dimension: cantidad {
    hidden: yes
    type: number
    sql: ${TABLE}.Cantidad/ 1000 ;;
  }

  dimension: moneda_transaccion {
    label: "Moneda Origen"
    type: string
    sql: ${TABLE}.Moneda_Transaccion ;;
  }

  dimension: monto {
    hidden: yes
    type: number
    sql: ${TABLE}.monto_conversion_usd / 1000 ;;
  }

  dimension: division {
    hidden: yes
    type: string
    sql: ${TABLE}.division ;;
  }


  dimension: monto_original {
    hidden: yes
    type: number
    sql: ${TABLE}.Monto / 1000 ;;
  }


  #dimension: moneda_conversion {
  #  hidden: yes
  #  type: string
  #  sql: ${TABLE}.Moneda_Conversion_MXN ;;
  #}

  dimension: tipo_cambio {
    hidden: yes
    type: number
    sql: ${TABLE}.Tipo_Cambio_MXN ;;
  }

  dimension: monto_conversion {
    hidden: yes
    type: number
    sql: ${TABLE}.Monto_Conversion_MXN / 1000 ;;
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


  ################## 3 Mes  ############################
  dimension: is_current_quarter{
    hidden: yes
    type: yesno
    sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY) >=DATE_ADD(DATE_ADD(LAST_DAY(CAST({% date_start date_filter %} AS DATE)), INTERVAL 1 DAY),INTERVAL -3 MONTH) AND DATE_TRUNC(CAST(${created_date} AS DATE),DAY) <= DATE_ADD((CAST({% date_start date_filter %} AS DATE)),INTERVAL -0 day)  ;;
    #sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY)>=DATE_ADD(DATE_ADD(LAST_DAY(CAST({% date_start date_filter %} AS DATE)), INTERVAL 1 DAY),INTERVAL -1 MONTH)    ;;
    #sql:DATE_TRUNC(CAST(${created_date} AS DATE),YEAR) =  DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), YEAR)  and DATE_TRUNC(CAST(${created_date} AS DATE),MONTH) = DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH) ;;
    #LAST_DAY
  }


  dimension: is_previous_quarter{
    hidden: yes
    type: yesno
    sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY) >=DATE_ADD(DATE_ADD(LAST_DAY(     DATE_ADD( CAST({% date_start date_filter %} AS DATE) ,INTERVAL -1 YEAR)        ), INTERVAL 1 DAY),INTERVAL -3 MONTH) AND DATE_TRUNC(CAST(${created_date} AS DATE),DAY) <= DATE_ADD(   DATE_ADD( CAST({% date_start date_filter %} AS DATE) ,INTERVAL -1 YEAR)    ,INTERVAL -0 day)  ;;
    # sql:DATE_TRUNC(CAST(${created_date} AS DATE),YEAR) =  DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), YEAR) -1  and   DATE_TRUNC(CAST(${created_date} AS DATE),MONTH) = DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH) ;;

  }
  ##################Mes ############################



  ################## 6 Mes ############################
  dimension: is_current_semester{
    hidden: yes
    type: yesno
    sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY) >=DATE_ADD(DATE_ADD(LAST_DAY(CAST({% date_start date_filter %} AS DATE)), INTERVAL 1 DAY),INTERVAL -6 MONTH) AND DATE_TRUNC(CAST(${created_date} AS DATE),DAY) <= DATE_ADD((CAST({% date_start date_filter %} AS DATE)),INTERVAL -0 day)  ;;
    #sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY)>=DATE_ADD(DATE_ADD(LAST_DAY(CAST({% date_start date_filter %} AS DATE)), INTERVAL 1 DAY),INTERVAL -1 MONTH)    ;;
    #sql:DATE_TRUNC(CAST(${created_date} AS DATE),YEAR) =  DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), YEAR)  and DATE_TRUNC(CAST(${created_date} AS DATE),MONTH) = DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH) ;;
    #LAST_DAY
  }


  dimension: is_previous_semester{
    hidden: yes
    type: yesno
    sql: DATE_TRUNC(CAST(${created_date} AS DATE),DAY) >=DATE_ADD(DATE_ADD(LAST_DAY(     DATE_ADD( CAST({% date_start date_filter %} AS DATE) ,INTERVAL -6 YEAR)        ), INTERVAL 1 DAY),INTERVAL -1 MONTH) AND DATE_TRUNC(CAST(${created_date} AS DATE),DAY) <= DATE_ADD(   DATE_ADD( CAST({% date_start date_filter %} AS DATE) ,INTERVAL -1 YEAR)    ,INTERVAL -0 day)  ;;
    # sql:DATE_TRUNC(CAST(${created_date} AS DATE),YEAR) =  DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), YEAR) -1  and   DATE_TRUNC(CAST(${created_date} AS DATE),MONTH) = DATE_TRUNC(CAST({% date_start date_filter %} AS DATE), MONTH) ;;

  }
  ##################Mes ############################





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
    label: "Fecha actualización"
    sql: MAX(${actualizacion});;
    convert_tz: no
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


  measure: QTY_diario {
    group_label: "Diario"
    label: "QTY Diario"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: periodo_dia
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_conversion_diario]
    value_format: "$#,##0.00"
  }






  measure: Monto_Diario {
    group_label: "Diario"
    label: "Monto Diario"
    type: sum
    sql: ${monto} ;;

    filters: {
      field: periodo_dia
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_Diario]

    value_format: "$#,##0.00"
  }


  measure: Ptto_Diario {
    group_label: "Ptto Diario"
    label: "Ptto Diario"
    type: sum
    sql: ${monto} ;;

    filters: {
      field: periodo_dia
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_Diario]

    value_format: "$#,##0.00"
  }






  measure: Monto_conversion_diario {
    group_label: "Diario"
    label: "Monto Conversion Diario"
    type: sum
    sql: ${monto_conversion};;

    filters: {
      field: periodo_dia
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_conversion_diario]
    value_format: "$#,##0.00"
  }


  measure: Ptto_conversion_diario {
    group_label: "Ptto Diario"
    label: "Ptto Conversion Diario"
    type: sum
    sql: ${monto_conversion};;

    filters: {
      field: periodo_dia
      value: "yes"
    }

   filters: [tipo_transaccion: "Presupuesto"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_conversion_diario]
    value_format: "$#,##0.00"
  }

  measure: promedio_tipo_cambio {
    group_label: "Diario"
    label: "TIPO DE CAMBIO"
    type: average
    sql: ${tipo_cambio} ;;

    filters: {
      field: periodo_dia
      value: "yes"
    }

    value_format: "$#,##0.00"
  }






#################################################################### INICIO CALCULOS MENSUALES ##################################################################



#### INICIO CANTIDAD ####

  measure: QTY_MTD {
    group_label: "Mensual-QTY"
    label: "QTY_MTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_MTD]
    value_format: "#,##0"
  }



  measure: LY_QTY_MTD {
    group_label: "Mensual-QTY"
    label: "LY QTY MTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    value_format: "#,##0"
  }


  measure: INDEX_QTY_MTD {
    group_label: "Mensual-QTY"
      label: "% VS QTY MTD"
    type: number
    #sql: (${QTY_MTD} - ${LY_QTY_MTD}) / CASE WHEN ${LY_QTY_MTD} = 0,0)*100 ;;
    #sql: CASE WHEN ${LY_QTY_MTD} = 0 THEN 1 ELSE (${QTY_MTD} - ${LY_QTY_MTD}) / COALESCE (${LY_QTY_MTD}, 0)*100 END  ;;
    sql: CASE WHEN ${QTY_MTD} = 0 THEN 1 ELSE (${QTY_MTD} - ${LY_QTY_MTD})/ NULLIF(${LY_QTY_MTD},0) END ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,QTY_MTD,LY_QTY_MTD, INDEX_QTY_MTD]

    value_format: "0.00\%"

  }


  measure: QTY_Ptto_MTD {
    group_label: "Mensual-QTY-Ptto"
    label: "QTY Ptto MTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

   filters: [tipo_transaccion: "Presupuesto"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_Ptto_MTD]
    value_format: "#,##0"
  }

  measure: LY_QTY_Ptto_MTD {
    group_label: "Mensual-QTY-Ptto"
    label: "LY QTY Ptto MTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

   filters: [tipo_transaccion: "Presupuesto"]

    value_format: "#,##0"
  }


  measure: INDEX_QTY_Ptto_MTD {
    group_label: "Mensual-QTY-Ptto"
    label: "% VS QTY Ptto MTD"
    type: number
    #sql: (${QTY_MTD} - ${LY_QTY_MTD}) / CASE WHEN ${LY_QTY_MTD} = 0,0)*100 ;;
    #sql: CASE WHEN ${QTY_Ptto_MTD} = 0 THEN 1 ELSE (${QTY_Ptto_MTD} - ${LY_QTY_Ptto_MTD}) / COALESCE (nullif(${LY_QTY_Ptto_MTD},0), 0)*100 END ;;
    sql: CASE WHEN ${QTY_Ptto_MTD} = 0 THEN 1 ELSE (${QTY_Ptto_MTD} - ${LY_QTY_Ptto_MTD})/ NULLIF(${LY_QTY_Ptto_MTD},0) END ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,QTY_Ptto_MTD,LY_QTY_Ptto_MTD, INDEX_QTY_Ptto_MTD]

    value_format: "0.00\%"

  }





  #### FIN CANTIDAD ####




  measure: QTY_MTD_GTQ {
    group_label: "Mensual-QTY"
    label: "QTY_MTD GTQ"
    type: sum
    sql: case when ${TABLE}.Moneda_Transaccion ="GTQ" then ${monto_original}     else ${monto} end ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_MTD]
    value_format: "$#,##0.00"
  }





  #### INICIO MONTO CONVERSION ####

  measure: Monto_Conversion_MTD {
    group_label: "Mensual-Monto Conversion"
    label: "Monto Conversion MTD"
    type: sum
    sql: ${monto_conversion};;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_Conversion_MTD]

    value_format: "$#,##0.00"
  }


  measure: LY_Monto_Conversion_MTD {
     group_label: "Mensual-Monto Conversion"
    label: "LY Monto Conversion MTD"
    type: sum
    sql:  ${monto_conversion} ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    value_format: "$#,##0.00"
  }


  measure: INDEX_Monto_Conversion_MTD {
     group_label: "Mensual-Monto Conversion"
    label: "% VS Monto Conversion MTD"
    type: number
    sql: (${Monto_Conversion_MTD} - ${LY_Monto_Conversion_MTD} ) / NULLIF(${LY_Monto_Conversion_MTD},0)*100 ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Monto_Conversion_MTD,LY_Monto_Conversion_MTD, INDEX_Monto_Conversion_MTD]

      value_format: "0.00\%"

    }


  measure: Ptto_Conversion_MTD {
    group_label: "Mensual-Ptto Conversion"
    label: "Ptto Conversion MTD"
    type: sum
    sql: ${monto_conversion};;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Ptto_Conversion_MTD]

    value_format: "$#,##0.00"
  }


  measure: LY_Ptto_Conversion_MTD {
    group_label: "Mensual-Ptto Conversion"
    label: "LY Ptto Conversion MTD"
    type: sum
    sql:  ${monto_conversion} ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    value_format: "$#,##0.00"
  }



  measure: INDEX_Ptto_Conversion_MTD {
    group_label: "Mensual-Ptto Conversion"
    label: "% VS Ptto Conversion MTD"
    type: number
    sql: (${Monto_Conversion_MTD} - ${Ptto_Conversion_MTD} ) / NULLIF(${Ptto_Conversion_MTD},0)*100 ;;




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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Ptto_Conversion_MTD,LY_Ptto_Conversion_MTD, INDEX_Ptto_Conversion_MTD]

    value_format: "0.00\%"

  }





  #### FIN  MONTO CONVERSION ####

  #### INICIO  MONTO  ####

  measure: Monto_MTD {
   group_label: "Mensual-Monto"
    label: "Monto MTD"
    type: sum
    sql:${monto} ;;

    filters: {
      field: is_current_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_MTD]

    value_format: "$#,##0.00"
  }

  measure: LY_Monto_MTD {
     group_label: "Mensual-Monto"
    label: "LY Monto MTD"
    type: sum
    sql:  ${monto} ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    value_format: "$#,##0.00"
  }


  measure: INDEX_MONTO_MTD {
     group_label: "Mensual-Monto"
    label: "% VS Monto MTD"
    type: number
    sql: (${Monto_MTD} - ${LY_Monto_MTD}) / NULLIF(${LY_Monto_MTD},0)*100 ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Monto_MTD,LY_Monto_MTD, INDEX_MONTO_MTD]

    value_format: "0.00\%"

  }

  measure: Ptto_MTD {
    group_label: "Mensual-Ptto"
    label: "Ptto MTD"
    type: sum
    sql:${monto} ;;



    filters: [tipo_transaccion: "Presupuesto"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Ptto_MTD]

    value_format: "$#,##0.00"
  }

  measure: LY_Ptto_MTD {
    group_label: "Mensual-Ptto"
    label: "LY Ptto MTD"
    type: sum
    sql:  ${monto} ;;

    filters: {
      field: is_previous_period
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    value_format: "$#,##0.00"
  }


  measure: INDEX_Ptto_MTD {
    group_label: "Mensual-Ptto"
    label: "% VS Ptto MTD"
    type: number
    sql: ( ${Monto_MTD}-${Ptto_MTD} ) / NULLIF(${Ptto_MTD},0)*100 ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Ptto_MTD,LY_Ptto_MTD, INDEX_Ptto_MTD]

    value_format: "0.00\%"

  }








 #################################################################### FIN CALCULOS MENSUALES ##################################################################



#################################################################### INICIO CALCULOS ANUALES ##################################################################

  measure: QTY_YTD {
     group_label: "Anual-QTY"
    label: "QTY YTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_year
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_YTD]

    value_format: "#,##0"
  }

  measure: LY_QTY_YTD {
    group_label: "Anual-QTY"
    label: "LY QTY YTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_previous_year
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    value_format: "#,##0"
  }


  measure: INDEX_QTY_YTD {
    group_label: "Anual-QTY"
    label: "% VS QTY YTD"
    type: number
    sql: (${QTY_YTD} - ${LY_QTY_YTD}) / NULLIF(${LY_QTY_YTD},0)*100 ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,QTY_YTD,LY_QTY_YTD, INDEX_QTY_YTD]

      value_format: "0.00\%"

    }


  measure: QTY_Ptto_YTD {
    group_label: "Anual-QTY-Ptto"
    label: "QTY Ptto YTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_year
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_Ptto_YTD]

    value_format: "#,##0"
  }

  measure: LY_QTY_Ptto_YTD {
    group_label: "Anual-QTY-Ptto"
    label: "LY QTY Ptto YTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_previous_year
      value: "yes"
    }

   filters: [tipo_transaccion: "Presupuesto"]

    value_format: "#,##0"
  }


  measure: INDEX_QTY_Ptto_YTD {
    group_label: "Anual-QTY-Ptto"
    label: "% VS QTY Ptto YTD"
    type: number
    sql: (${QTY_YTD} - ${QTY_Ptto_YTD}) / NULLIF(${QTY_Ptto_YTD},0)*100 ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,QTY_Ptto_YTD,LY_QTY_Ptto_YTD, INDEX_QTY_Ptto_YTD]

    value_format: "0.00\%"

  }




    measure: Monto_Conversion_YTD {
      group_label: "Anual-Monto_Conversion"
      label: "Monto Conversion YTD"
      type: sum
      sql:  ${monto_conversion} ;;


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_Conversion_YTD]

      filters: {
        field: is_current_year
        value: "yes"
      }

      filters: [tipo_transaccion: "Venta"]

      value_format: "#,##0"
    }

    measure: LY_Monto_Conversion_YTD {
      group_label: "Anual-Monto_Conversion"
      label: "LY Monto Conversion YTD"
      type: sum
      sql: ${monto_conversion} ;;

      filters: {
        field: is_previous_year
        value: "yes"
      }

      filters: [tipo_transaccion: "Venta"]

      value_format: "#,##0"
    }


    measure: INDEX_Monto_Conversion_YTD {
       group_label: "Anual-Monto_Conversion"
      label: "% VS Monto Conversion YTD"
      type: number
      sql: (${Monto_Conversion_YTD} - ${LY_Monto_Conversion_YTD}) / NULLIF(${LY_Monto_Conversion_YTD},0)*100 ;;

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


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Monto_Conversion_YTD,LY_Monto_Conversion_YTD, INDEX_Monto_Conversion_YTD]
        value_format: "0.00\%"

      }

  measure: Ptto_Conversion_YTD {
    group_label: "Anual-Ptto_Conversion"
    label: "Ptto Conversion YTD"
    type: sum
    sql:  ${monto_conversion} ;;


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Ptto_Conversion_YTD]

    filters: {
      field: is_current_year
      value: "yes"
    }

   filters: [tipo_transaccion: "Presupuesto"]

    value_format: "#,##0"
  }

  measure: LY_Ptto_Conversion_YTD {
    group_label: "Anual-Ptto_Conversion"
    label: "LY Ptto Conversion YTD"
    type: sum
    sql: ${monto_conversion} ;;

    filters: {
      field: is_previous_year
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    value_format: "#,##0"
  }


  measure: INDEX_Ptto_Conversion_YTD {
    group_label: "Anual-Ptto_Conversion"
    label: "% VS Ptto Conversion YTD"
    type: number
    sql: (${Monto_Conversion_YTD} - ${Ptto_Conversion_YTD}) / NULLIF(${Ptto_Conversion_YTD},0)*100 ;;




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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Ptto_Conversion_YTD,LY_Ptto_Conversion_YTD, INDEX_Ptto_Conversion_YTD]
    value_format: "0.00\%"

  }




   measure: Monto_YTD {
    group_label: "Anual-Monto"
    label: "Monto YTD"
    type: sum
    sql:  ${monto} ;;


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_YTD]

    filters: {
      field: is_current_year
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    value_format: "$#,##0.00"
  }

  measure: LY_Monto_YTD {
    group_label: "Anual-Monto"
    label: "LY Monto YTD"
    type: sum
    sql: ${monto} ;;

    filters: {
      field: is_previous_year
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    value_format: "$#,##0.00"
  }


  measure: INDEX_Monto_YTD {
    group_label: "Anual-Monto"
    label: "% VS Monto  YTD"
    type: number
    sql: (${Monto_YTD} - ${LY_Monto_YTD}) / NULLIF(${LY_Monto_YTD},0)*100 ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Monto_YTD,LY_Monto_YTD, INDEX_Monto_YTD]
    value_format: "0.00\%"

  }


  measure: Ptto_YTD {
    group_label: "Anual-Ptto"
    label: "Ptto YTD"
    type: sum
    sql:  ${monto} ;;


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Ptto_YTD]

    filters: {
      field: is_current_year
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    value_format: "$#,##0.00"
  }

  measure: LY_Ptto_YTD {
    group_label: "Anual-Ptto"
    label: "LY Ptto YTD"
    type: sum
    sql: ${monto} ;;

    filters: {
      field: is_previous_year
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    value_format: "$#,##0.00"
  }


  measure: INDEX_Ptto_YTD {
    group_label: "Anual-Ptto"
    label: "% VS Ptto  YTD"
    type: number
    sql: (${Monto_YTD} - ${Ptto_YTD}) / NULLIF(${Ptto_YTD},0)*100 ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Ptto_YTD,LY_Ptto_YTD, INDEX_Ptto_YTD]
    value_format: "0.00\%"

  }









#################################################################### FIN CALCULOS ANUALES ##################################################################



#################################################################### INICIO CALCULOS TRIMESTRALES ##################################################################



  measure: QTY_QTD {
    group_label: "Trimestral-QTY"
    label: "QTY QTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_quarter
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_QTD]

    value_format: "#,##0"
  }

  measure: LY_QTY_QTD {
     group_label: "Trimestral-QTY"
    label: "LY QTY QTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_previous_quarter
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    value_format: "#,##0"
  }


  measure: INDEX_QTY_QTD {
     group_label: "Trimestral-QTY"
    label: "% VS QTY QTD"
    type: number
    sql: (${QTY_QTD} - ${LY_QTY_QTD}) / NULLIF(${LY_QTY_QTD},0)*100 ;;

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


    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,QTY_QTD,LY_QTY_QTD, INDEX_QTY_QTD]

    value_format: "0.00\%"

  }


  measure: QTY_Ptto_QTD {
    group_label: "Trimestral-QTY-Ptto"
    label: "QTY Ptto QTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_quarter
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_Ptto_QTD]

    value_format: "#,##0"
  }

  measure: LY_QTY_Ptto_QTD {
    group_label: "Trimestral-QTY-Ptto"
    label: "LY QTY Ptto QTD"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field:  is_previous_quarter
      value: "yes"
    }

    filters: [tipo_transaccion: "Presupuesto"]

    value_format: "#,##0"
  }


  measure: INDEX_QTY_Ptto_QTD {
    group_label: "Trimestral-QTY-Ptto"
    label: "% VS QTY Ptto QTD"
    type: number
    sql: (${QTY_QTD} - ${QTY_Ptto_QTD}) / NULLIF(${QTY_Ptto_QTD},0)*100 ;;



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


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,QTY_Ptto_QTD,LY_QTY_Ptto_QTD, INDEX_QTY_Ptto_QTD]

      value_format: "0.00\%"

    }




    measure: Monto_Conversion_QTD {
      group_label: "Trimestral-Monto_Conversion"
      label: "Monto Conversion QTD"
      type: sum
      sql:  ${monto_conversion} ;;


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_Conversion_QTD]

      filters: {
        field: is_current_quarter
        value: "yes"
      }

      filters: [tipo_transaccion: "Venta"]

      value_format: "#,##0"
    }

    measure: LY_Monto_Conversion_QTD {
      group_label: "Trimestral-Monto_Conversion"
      label: "LY Monto Conversion QTD"
      type: sum
      sql: ${monto_conversion} ;;

      filters: {
        field: is_previous_quarter
        value: "yes"
      }

      filters: [tipo_transaccion: "Venta"]

      value_format: "#,##0"
    }


    measure: INDEX_Monto_Conversion_QTD {
      group_label: "Trimestral-Monto_Conversion"
      label: "% VS Monto Conversion QTD"
      type: number
      sql: (${Monto_Conversion_QTD} - ${LY_Monto_Conversion_QTD}) / NULLIF(${LY_Monto_Conversion_QTD},0)*100 ;;

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


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Monto_Conversion_QTD,LY_Monto_Conversion_QTD, INDEX_Monto_Conversion_QTD]
      value_format: "0.00\%"

    }

    measure: Ptto_Conversion_QTD {
      group_label: "Trimestral-Ptto_Conversion"
      label: "Ptto Conversion QTD"
      type: sum
      sql:  ${monto_conversion} ;;


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Ptto_Conversion_QTD]

      filters: {
        field: is_current_quarter
        value: "yes"
      }

      filters: [tipo_transaccion: "Presupuesto"]

      value_format: "#,##0"
    }

    measure: LY_Ptto_Conversion_QTD {
      group_label: "Trimestral-Ptto_Conversion"
      label: "LY Ptto Conversion QTD"
      type: sum
      sql: ${monto_conversion} ;;

      filters: {
        field: is_previous_quarter
        value: "yes"
      }

      filters: [tipo_transaccion: "Presupuesto"]

      value_format: "#,##0"
    }


    measure: INDEX_Ptto_Conversion_QTD {
      group_label: "Trimestral-Ptto_Conversion"
      label: "% VS Ptto Conversion QTD"
      type: number
      sql: (${Monto_Conversion_QTD} - ${Ptto_Conversion_QTD}) / NULLIF(${Ptto_Conversion_QTD},0)*100 ;;




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


        drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Ptto_Conversion_QTD,LY_Ptto_Conversion_QTD, INDEX_Ptto_Conversion_QTD]
        value_format: "0.00\%"

      }




      measure: Monto_QTD {
        group_label: "Trimestral-Monto"
        label: "Monto QTD"
        type: sum
        sql:  ${monto} ;;


        drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_QTD]

        filters: {
          field: is_current_quarter
          value: "yes"
        }

        filters: [tipo_transaccion: "Venta"]

        value_format: "$#,##0.00"
      }

      measure: LY_Monto_QTD {
        group_label: "Trimestral-Monto"
        label: "LY Monto QTD"
        type: sum
        sql: ${monto} ;;

        filters: {
          field: is_previous_quarter
          value: "yes"
        }

        filters: [tipo_transaccion: "Venta"]

        value_format: "$#,##0.00"
      }


      measure: INDEX_Monto_QTD {
        group_label: "Trimestral-Monto"
        label: "% VS Monto  QTD"
        type: number
        sql: (${Monto_QTD} - ${LY_Monto_QTD}) / NULLIF(${LY_Monto_QTD},0)*100 ;;

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


        drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Monto_QTD,LY_Monto_QTD, INDEX_Monto_QTD]
        value_format: "0.00\%"

      }


      measure: Ptto_QTD {
        group_label: "Trimestral-Ptto"
        label: "Ptto QTD"
        type: sum
        sql:  ${monto} ;;


        drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Ptto_QTD]

        filters: {
          field: is_current_quarter
          value: "yes"
        }

        filters: [tipo_transaccion: "Presupuesto"]

        value_format: "$#,##0.00"
      }

      measure: LY_Ptto_QTD {
        group_label: "Trimestral-Ptto"
        label: "LY Ptto QTD"
        type: sum
        sql: ${monto} ;;

        filters: {
          field: is_previous_quarter
          value: "yes"
        }

        filters: [tipo_transaccion: "Presupuesto"]

        value_format: "$#,##0.00"
      }


      measure: INDEX_Ptto_QTD {
        group_label: "Trimestral-Ptto"
        label: "% VS Ptto  QTD"
        type: number
        sql: (${Monto_QTD} - ${Ptto_QTD}) / NULLIF(${Ptto_QTD},0)*100 ;;


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


          drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Ptto_QTD,LY_Ptto_QTD, INDEX_Ptto_QTD]
          value_format: "0.00\%"

        }








  #################################################################### FIN CALCULOS TRIMESTRALES ##################################################################


 #################################################################### INICIO CALCULOS SEMESTRALES ##################################################################

  measure: QTY_SEM {
    group_label: "Semestral-QTY"
    label: "QTY SEM"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_current_semester
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_SEM]

    value_format: "#,##0"
  }

  measure: LY_QTY_SEM {
    group_label: "Semestral-QTY"
    label: "LY QTY SEM"
    type: sum
    sql: ${cantidad} ;;

    filters: {
      field: is_previous_semester
      value: "yes"
    }

    filters: [tipo_transaccion: "Venta"]

    value_format: "#,##0"
  }


  measure: INDEX_QTY_SEM {
    group_label: "Semestral-QTY"
    label: "% VS QTY SEM"
    type: number
    sql: (${QTY_SEM} - ${LY_QTY_SEM}) / NULLIF(${LY_QTY_SEM},0)*100 ;;

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


      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,QTY_SEM,LY_QTY_SEM, INDEX_QTY_SEM]

      value_format: "0.00\%"

    }


    measure: QTY_Ptto_SEM {
      group_label: "Semestral-QTY-Ptto"
      label: "QTY Ptto SEM"
      type: sum
      sql: ${cantidad} ;;

      filters: {
        field: is_current_semester
        value: "yes"
      }

      filters: [tipo_transaccion: "Presupuesto"]

      drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, QTY_Ptto_SEM]

      value_format: "#,##0"
    }

    measure: LY_QTY_Ptto_SEM {
      group_label: "Semestral-QTY-Ptto"
      label: "LY QTY Ptto SEM"
      type: sum
      sql: ${cantidad} ;;

      filters: {
        field:  is_previous_semester
        value: "yes"
      }

      filters: [tipo_transaccion: "Presupuesto"]

      value_format: "#,##0"
    }


    measure: INDEX_QTY_Ptto_SEM {
      group_label: "Trimestral-QTY-Ptto"
      label: "% VS QTY Ptto SEM"
      type: number
      sql: (${QTY_SEM} - ${QTY_Ptto_SEM}) / NULLIF(${QTY_Ptto_SEM},0)*100 ;;

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


        drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,QTY_Ptto_SEM,LY_QTY_Ptto_SEM, INDEX_QTY_Ptto_SEM]

        value_format: "0.00\%"

      }




      measure: Monto_Conversion_SEM {
        group_label: "Semestral-Monto_Conversion"
        label: "Monto Conversion SEM"
        type: sum
        sql:  ${monto_conversion} ;;


        drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_Conversion_SEM]

        filters: {
          field: is_current_semester
          value: "yes"
        }

        filters: [tipo_transaccion: "Venta"]

        value_format: "#,##0"
      }

      measure: LY_Monto_Conversion_SEM {
        group_label: "Semestral-Monto_Conversion"
        label: "LY Monto Conversion SEM"
        type: sum
        sql: ${monto_conversion} ;;

        filters: {
          field: is_previous_semester
          value: "yes"
        }

        filters: [tipo_transaccion: "Venta"]

        value_format: "#,##0"
      }


      measure: INDEX_Monto_Conversion_SEM {
        group_label: "Semestral-Monto_Conversion"
        label: "% VS Monto Conversion SEM"
        type: number
        sql: (${Monto_Conversion_SEM} - ${LY_Monto_Conversion_SEM}) / NULLIF(${LY_Monto_Conversion_SEM},0)*100 ;;

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


          drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Monto_Conversion_SEM,LY_Monto_Conversion_SEM, INDEX_Monto_Conversion_SEM]
          value_format: "0.00\%"

        }

        measure: Ptto_Conversion_SEM {
          group_label: "Semestral-Ptto_Conversion"
          label: "Ptto Conversion SEM"
          type: sum
          sql:  ${monto_conversion} ;;


          drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Ptto_Conversion_SEM]

          filters: {
            field: is_current_semester
            value: "yes"
          }

          filters: [tipo_transaccion: "Presupuesto"]

          value_format: "#,##0"
        }

        measure: LY_Ptto_Conversion_SEM {
          group_label: "Semestral-Ptto_Conversion"
          label: "LY Ptto Conversion SEM"
          type: sum
          sql: ${monto_conversion} ;;

          filters: {
            field: is_previous_semester
            value: "yes"
          }

          filters: [tipo_transaccion: "Presupuesto"]

          value_format: "#,##0"
        }


        measure: INDEX_Ptto_Conversion_SEM {
          group_label: "Semestral-Ptto_Conversion"
          label: "% VS Ptto Conversion SEM"
          type: number
          sql: (${Monto_Conversion_SEM} - ${Ptto_Conversion_SEM}) / NULLIF(${Ptto_Conversion_SEM},0)*100 ;;


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


            drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Ptto_Conversion_SEM,LY_Ptto_Conversion_SEM, INDEX_Ptto_Conversion_SEM]
            value_format: "0.00\%"

          }




          measure: Monto_SEM {
            group_label: "Semestral-Monto"
            label: "Monto SEM"
            type: sum
            sql:  ${monto} ;;


            drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Monto_SEM]

            filters: {
              field: is_current_semester
              value: "yes"
            }

            filters: [tipo_transaccion: "Venta"]

            value_format: "$#,##0.00"
          }

          measure: LY_Monto_SEM {
            group_label: "Semestral-Monto"
            label: "LY Monto SEM"
            type: sum
            sql: ${monto} ;;

            filters: {
              field: is_previous_semester
              value: "yes"
            }

            filters: [tipo_transaccion: "Venta"]

            value_format: "$#,##0.00"
          }


          measure: INDEX_Monto_SEM {
            group_label: "Semestral-Monto"
            label: "% VS Monto  SEM"
            type: number
            sql: (${Monto_SEM} - ${LY_Monto_SEM}) / NULLIF(${LY_Monto_SEM},0)*100 ;;

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


              drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Monto_SEM,LY_Monto_SEM, INDEX_Monto_SEM]
              value_format: "0.00\%"

            }


            measure: Ptto_SEM {
              group_label: "Semestral-Ptto"
              label: "Ptto SEM"
              type: sum
              sql:  ${monto} ;;


              drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion, Ptto_SEM]

              filters: {
                field: is_current_semester
                value: "yes"
              }

              filters: [tipo_transaccion: "Presupuesto"]

              value_format: "$#,##0.00"
            }

            measure: LY_Ptto_SEM {
              group_label: "Semestral-Ptto"
              label: "LY Ptto SEM"
              type: sum
              sql: ${monto} ;;

              filters: {
                field: is_previous_semester
                value: "yes"
              }

              filters: [tipo_transaccion: "Presupuesto"]

              value_format: "$#,##0.00"
            }


            measure: INDEX_Ptto_SEM {
              group_label: "Semestral-Ptto"
              label: "% VS Ptto  SEM"
              type: number
              sql: (${Monto_SEM} - ${Ptto_SEM}) / NULLIF(${Ptto_SEM},0)*100 ;;


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


                drill_fields: [dim_planta.nombre_planta,dim_grupoclientes.descripcion,Ptto_SEM,LY_Ptto_SEM, INDEX_Ptto_SEM]
                value_format: "0.00\%"

              }




 #################################################################### FIN CALCULOS SEMESTRALES ##################################################################








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
  tipo_cambio,
  monto_conversion
    ]
  }
}
