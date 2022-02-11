*&---------------------------------------------------------------------*
*& Report ZAS_SALV_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_salv_01.

*DATA: gt_sbook type TABLE OF sbook,
*      go_salv TYPE REF TO cl_salv_table.
*
*START-OF-SELECTION.
*
*select * UP TO 20 ROWS FROM sbook
*  INTO TABLE gt_sbook.
*
*cl_salv_table=>factory(
*
*  IMPORTING
*    r_salv_table   = go_salv                           " Basis Class Simple ALV Tables
*  CHANGING
*    t_table        = gt_sbook
*).
*
*go_salv->display( ).



DATA: gt_sbook TYPE TABLE OF sbook,
      go_salv  TYPE REF TO cl_salv_table.

START-OF-SELECTION.

  SELECT * UP TO 20 ROWS FROM sbook
    INTO TABLE gt_sbook.

  cl_salv_table=>factory(

    IMPORTING
      r_salv_table   = go_salv                           " Basis Class Simple ALV Tables
    CHANGING
      t_table        = gt_sbook
  ).


  DATA: lo_display TYPE REF TO cl_salv_display_settings.

  lo_display = go_salv->get_display_settings( ).
  lo_display->set_list_header( value = 'SALV CALISMASI' ).
  lo_display->set_striped_pattern( value = 'X' ).

  DATA: lo_cols TYPE REF TO cl_salv_columns.

  lo_cols = go_salv->get_columns( ).
  lo_cols->set_optimize('X').


  DATA: lo_col TYPE REF TO cl_salv_column.

  TRY .
      lo_col = lo_cols->get_column( columnname = 'INVOICE' ).
      lo_col->set_long_text( value = 'yeni fatura düzenlemesi' ).
      lo_col->set_medium_text( value = 'yeni fatura D.' ).
      lo_col->set_short_text( value = 'yeni fat' ).
    CATCH cx_salv_not_found.
  ENDTRY.


  TRY .
      lo_col = lo_cols->get_column( columnname = 'MANDT' ).
      lo_col->set_visible(
          value = if_salv_c_bool_sap=>false
      ).
    CATCH cx_salv_not_found.
  ENDTRY.

  DATA: lo_func TYPE REF TO cl_salv_functions.

  lo_func = go_salv->get_functions( ).
  lo_func->set_all(
      value = if_salv_c_bool_sap=>true
  ).


DATA: lo_header TYPE REF TO cl_salv_form_layout_grid,
      lo_h_label TYPE REF TO cl_salv_form_label,
      lo_h_flow TYPE REF TO cl_salv_form_layout_flow.

CREATE OBJECT lo_header.

lo_h_label = lo_header->create_label(
               row         = 1
               column      = 1
             ).
lo_h_label->set_text( value = 'ilk satır baslik' ).
lo_h_flow = lo_header->create_flow(
              row     = 2
              column  = 1
              ).
lo_h_flow->create_text(
  EXPORTING
    text  = 'ilk satir baslik').
go_salv->set_top_of_list( value = lo_header ).


go_salv->set_screen_popup(
  EXPORTING
    start_column = 10
    end_column   = 75
    start_line   = 5
    end_line     = 25
).


  go_salv->display( ).
