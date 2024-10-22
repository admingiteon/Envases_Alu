---
- dashboard: ventas_alu_pet
  title: ventas_alu_pet
  layout: newspaper
  preferred_viewer: dashboards-next
  crossfilter_enabled: true
  description: ''
  preferred_slug: M0wJjqkkBUQ2w2I7Zq15fX
  elements:
  - title: Top 10 Clientes
    name: Top 10 Clientes
    model: envases_alu
    explore: Fact_Alu_Pet
    type: looker_bar
    fields: [dim_cliente.nombre, Fact_Alu_Pet.Monto_Conversion_MTD]
    filters:
      Fact_Alu_Pet.Monto_Conversion_MTD: not 0
    sorts: [Fact_Alu_Pet.Monto_Conversion_MTD desc 0]
    limit: 10
    column_limit: 50
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: circle
    show_value_labels: true
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
    x_axis_zoom: true
    y_axis_zoom: true
    hide_legend: false
    series_colors:
      Fact_Alu_Pet.total_monto_conversion: "#EA4335"
      Fact_Alu_Pet.Monto_conversion_diario: "#EA4335"
      Fact_Alu_Pet.Monto_Conversion_MTD: "#EA4335"
    series_labels:
      Fact_Alu_Pet.total_monto_conversion: Monto MXN
    defaults_version: 1
    hidden_pivots: {}
    listen:
      ID Fuente: Fact_Alu_Pet.id_fuente
      Período: Fact_Alu_Pet.date_filter
      Estatus Transferencia: Fact_Alu_Pet.Status_Transferencia_Contable
      Agrupador: dim_planta.Nombre_Agrupador
    row: 10
    col: 0
    width: 24
    height: 12
  - title: Acumulado Mensual MTD Por Planta
    name: Acumulado Mensual MTD Por Planta
    model: envases_alu
    explore: Fact_Alu_Pet
    type: looker_grid
    fields: [dim_planta.nombre_planta, Fact_Alu_Pet.id_fuente, Fact_Alu_Pet.INDEX_Monto_Conversion_MTD,
      Fact_Alu_Pet.Monto_Conversion_MTD, Fact_Alu_Pet.LY_Monto_Conversion_MTD, Fact_Alu_Pet.QTY_MTD]
    sorts: [Fact_Alu_Pet.Monto_Conversion_MTD desc]
    limit: 500
    column_limit: 50
    total: true
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: ["$$$_row_numbers_$$$", Fact_Alu_Pet.id_fuente, dim_planta.nombre_planta,
      Fact_Alu_Pet.QTY_MTD, Fact_Alu_Pet.Monto_Conversion_MTD, Fact_Alu_Pet.LY_Monto_Conversion_MTD,
      Fact_Alu_Pet.INDEX_Monto_Conversion_MTD]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      Fact_Alu_Pet.LY_Monto_Conversion_MTD: Monto MXN LY
      Fact_Alu_Pet.Monto_Conversion_MTD: Monto MXN
      Fact_Alu_Pet.QTY_MTD: Cantidad (Pzas)
      Fact_Alu_Pet.INDEX_Monto_Conversion_MTD: "% VS Año Anterior"
    series_cell_visualizations:
      Fact_Alu_Pet.Monto_Conversion_MTD:
        is_active: false
      Fact_Alu_Pet.LY_Monto_Conversion_MTD:
        is_active: false
    header_font_color: "#ffe5e8"
    header_background_color: "#b03427"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      ID Fuente: Fact_Alu_Pet.id_fuente
      Período: Fact_Alu_Pet.date_filter
      Estatus Transferencia: Fact_Alu_Pet.Status_Transferencia_Contable
      Agrupador: dim_planta.Nombre_Agrupador
    row: 22
    col: 0
    width: 13
    height: 8
  - title: "% Acumulado por Canal Dist"
    name: "% Acumulado por Canal Dist"
    model: envases_alu
    explore: Fact_Alu_Pet
    type: looker_pie
    fields: [Fact_Alu_Pet.Monto_Conversion_MTD, Fact_Alu_Pet.canal]
    sorts: [Fact_Alu_Pet.Monto_Conversion_MTD desc 0]
    limit: 500
    column_limit: 50
    value_labels: labels
    label_type: labPer
    inner_radius:
    color_application:
      collection_id: 7c56cc21-66e4-41c9-81ce-a60e1c3967b2
      palette_id: 5d189dfc-4f46-46f3-822b-bfb0b61777b1
      options:
        steps: 5
        reverse: false
    series_colors:
      Exportacion: "#EA4335"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_view_names: false
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    limit_displayed_rows: false
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    listen:
      ID Fuente: Fact_Alu_Pet.id_fuente
      Período: Fact_Alu_Pet.date_filter
      Estatus Transferencia: Fact_Alu_Pet.Status_Transferencia_Contable
      Agrupador: dim_planta.Nombre_Agrupador
    row: 22
    col: 13
    width: 11
    height: 8
  - name: ''
    type: text
    title_text: ''
    subtitle_text: ''
    body_text: "<div style=\"border-radius: 5px; padding: 5px 10px; background: #5e2129;\
      \ height: 60px; color: red;\">\n\t<nav style=\"font-size: 18px;\">\n\t\t<img\
      \ style=\"color: #efefef; padding: 5px 15px; float: left; height: 40px;\" src=\"\
      https://wwwstatic.lookercdn.com/logos/looker_all_white.svg\"/>\n\t\t<a style=\"\
      color: #efefef; padding: 5px 15px; float: left; line-height: 40px; font-weight:\
      \ bold;\" href=\"https://envases.cloud.looker.com/dashboards/9\"></a>\n\t\t\
      <a style=\"color: #efefef; padding: 5px 15px; float: left; line-height: 40px;\
      \ font-weight: bold;\" href=\"https://envases.cloud.looker.com/dashboards/11\"\
      ></a>\n\t\t\n\t</nav>\n</div>"
    row: 0
    col: 0
    width: 24
    height: 2
  - title: Ventas Acumulado Mensual MTD Por Grupo de Artículos
    name: Ventas Acumulado Mensual MTD Por Grupo de Artículos
    model: envases_alu
    explore: Fact_Alu_Pet
    type: looker_grid
    fields: [Fact_Alu_Pet.id_fuente, dim_grupomateriales.descripcion, Fact_Alu_Pet.INDEX_Monto_Conversion_MTD,
      Fact_Alu_Pet.Monto_Conversion_MTD, Fact_Alu_Pet.LY_Monto_Conversion_MTD, Fact_Alu_Pet.QTY_MTD,
      Fact_Alu_Pet.Monto_MTD, Fact_Alu_Pet.LY_Monto_MTD, Fact_Alu_Pet.INDEX_MONTO_MTD,
      Fact_Alu_Pet.LY_QTY_MTD, Fact_Alu_Pet.INDEX_Ptto_MTD, Fact_Alu_Pet.INDEX_Ptto_Conversion_MTD,
      dim_material.dimensiones]
    filters: {}
    sorts: [Fact_Alu_Pet.id_fuente, dim_grupomateriales.descripcion]
    subtotals: [Fact_Alu_Pet.id_fuente, dim_grupomateriales.descripcion]
    limit: 500
    column_limit: 50
    show_view_names: false
    show_row_numbers: true
    transpose: false
    truncate_text: true
    hide_totals: false
    hide_row_totals: false
    size_to_fit: true
    table_theme: editable
    limit_displayed_rows: false
    enable_conditional_formatting: false
    header_text_alignment: left
    header_font_size: '12'
    rows_font_size: '12'
    conditional_formatting_include_totals: false
    conditional_formatting_include_nulls: false
    show_sql_query_menu_options: false
    column_order: [Fact_Alu_Pet.id_fuente, dim_grupomateriales.descripcion, dim_material.dimensiones,
      Fact_Alu_Pet.QTY_MTD, Fact_Alu_Pet.LY_QTY_MTD, Fact_Alu_Pet.Monto_Conversion_MTD,
      Fact_Alu_Pet.LY_Monto_Conversion_MTD, Fact_Alu_Pet.INDEX_Monto_Conversion_MTD,
      Fact_Alu_Pet.INDEX_Ptto_MTD, Fact_Alu_Pet.Monto_MTD, Fact_Alu_Pet.LY_Monto_MTD,
      Fact_Alu_Pet.INDEX_MONTO_MTD, Fact_Alu_Pet.INDEX_Ptto_Conversion_MTD]
    show_totals: true
    show_row_totals: true
    truncate_header: false
    minimum_column_width: 75
    series_labels:
      Fact_Alu_Pet.LY_Monto_Conversion_MTD: Monto MXN LY
      Fact_Alu_Pet.Monto_Conversion_MTD: Monto MXN
      Fact_Alu_Pet.QTY_MTD: Cantidad (Pzas)
      Fact_Alu_Pet.INDEX_Monto_Conversion_MTD: "% VS Año Anterior"
      dim_grupomateriales.descripcion: Grupo Artículos
      Fact_Alu_Pet.Monto_MTD: Monto USD
      Fact_Alu_Pet.LY_Monto_MTD: Monto USD LY
      Fact_Alu_Pet.INDEX_MONTO_MTD: "% Vs Año Anterior"
      Fact_Alu_Pet.LY_QTY_MTD: LY Cantidad (Pzas)
      Fact_Alu_Pet.QTY_Ptto_MTD: Cantidad Ptto
      Fact_Alu_Pet.Ptto_MTD: Ptto MO
      Fact_Alu_Pet.Ptto_Conversion_MTD: Ptto
    series_column_widths:
      dim_grupomateriales.descripcion: 122
    series_cell_visualizations:
      Fact_Alu_Pet.Monto_Conversion_MTD:
        is_active: false
      Fact_Alu_Pet.LY_Monto_Conversion_MTD:
        is_active: false
    series_collapsed:
      Fact_Alu_Pet.id_fuente: true
      dim_grupomateriales.descripcion: true
    header_font_color: "#ffe5e8"
    header_background_color: "#b03427"
    x_axis_gridlines: false
    y_axis_gridlines: true
    show_y_axis_labels: true
    show_y_axis_ticks: true
    y_axis_tick_density: default
    y_axis_tick_density_custom: 5
    show_x_axis_label: true
    show_x_axis_ticks: true
    y_axis_scale_mode: linear
    x_axis_reversed: false
    y_axis_reversed: false
    plot_size_by_field: false
    trellis: ''
    stacking: ''
    legend_position: center
    point_style: none
    show_value_labels: false
    label_density: 25
    x_axis_scale: auto
    y_axis_combined: true
    ordering: none
    show_null_labels: false
    show_totals_labels: false
    show_silhouette: false
    totals_color: "#808080"
    defaults_version: 1
    hidden_pivots: {}
    listen:
      ID Fuente: Fact_Alu_Pet.id_fuente
      Período: Fact_Alu_Pet.date_filter
      Estatus Transferencia: Fact_Alu_Pet.Status_Transferencia_Contable
      Agrupador: dim_planta.Nombre_Agrupador
    row: 2
    col: 0
    width: 24
    height: 8
  filters:
  - name: ID Fuente
    title: ID Fuente
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: popover
    model: envases_alu
    explore: Fact_Alu_Pet
    listens_to_filters: []
    field: Fact_Alu_Pet.id_fuente
  - name: Período
    title: Período
    type: field_filter
    default_value: 2024/02/16
    allow_multiple_values: true
    required: false
    ui_config:
      type: day_picker
      display: inline
      options: []
    model: envases_alu
    explore: Fact_Alu_Pet
    listens_to_filters: []
    field: Fact_Alu_Pet.date_filter
  - name: Estatus Transferencia
    title: Estatus Transferencia
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: button_group
      display: popover
    model: envases_alu
    explore: Fact_Alu_Pet
    listens_to_filters: []
    field: Fact_Alu_Pet.Status_Transferencia_Contable
  - name: Agrupador
    title: Agrupador
    type: field_filter
    default_value: ''
    allow_multiple_values: true
    required: false
    ui_config:
      type: tag_list
      display: popover
    model: envases_alu
    explore: Fact_Alu_Pet
    listens_to_filters: []
    field: dim_planta.Nombre_Agrupador
