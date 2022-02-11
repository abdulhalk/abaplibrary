*&---------------------------------------------------------------------*
*& Include          ZAS_OOALV_CALISMA1_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .
*
*    CREATE OBJECT go_cont
*    EXPORTING
*      container_name  = 'CC_ALV'.
*
*  CREATE OBJECT go_alv "GO ALV OBJESININ CONTEINIRINI TANIMLAMIS OLDUK"
*    EXPORTING
*      i_parent        = go_cont.           "buraya tanımladıgımız ID'yi direkt veremiyoruz obje tipinde bir sey istiyo"

  IF go_alv IS INITIAL.


    CREATE OBJECT go_alv "GO ALV OBJESININ CONTEINIRINI TANIMLAMIS OLDUK"
      EXPORTING
        i_parent = cl_gui_container=>screen0.          "buraya tanımladıgımız ID'yi direkt veremiyoruz obje tipinde bir sey istiyo"

    PERFORM set_dropdown.

    CALL METHOD go_alv->set_table_for_first_display
      EXPORTING
*       i_buffer_active =
*       i_bypassing_buffer            =
*       i_consistency_check           =
*       i_structure_name               =
*       is_variant      =
*       i_save          =
*       i_default       = 'X'
        is_layout       = gs_layout
*       is_print        =
*       it_special_groups             =
*       it_toolbar_excluding          =
*       it_hyperlink    =
*       it_alv_graphics =
*       it_except_qinfo =
*       ir_salv_adapter =
      CHANGING
        it_outtab       = gt_scarr
        it_fieldcatalog = gt_fieldcatalog
*       it_sort         =
*       it_filter       =
*  EXCEPTIONS
*       invalid_parameter_combination = 1
*       program_error   = 2
*       too_many_lines  = 3
*       others          = 4
      .
*  CALL METHOD go_alv->register_edit_event
*    EXPORTING
*      i_event_id = cl_gui_alv_grid=>mc_evt_enter.


    CALL METHOD go_alv->register_edit_event
      EXPORTING
        i_event_id = cl_gui_alv_grid=>mc_evt_modified.
  ELSE.
    CALL METHOD go_alv->refresh_table_display.
  ENDIF.

  CALL METHOD go_alv->refresh_table_display.

  .
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.
  IF sy-subrc <> 0.
* MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.


ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  SELECT * FROM scarr
    INTO CORRESPONDING FIELDS OF TABLE gt_scarr.

*  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*    <gfs_scarr>-icon = '@OD@'.
*
*  ENDLOOP.

*  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
*    CASE <gfs_scarr>-currcode.
*      WHEN 'USD'.
*        <gfs_scarr>-line_color = 'C710'. "USD OLANLARIN BACKGORUNDUNU TURUNCU YAPTIK"
*      WHEN 'JPY'.
*        <gfs_scarr>-line_color = 'C501'.  "JOY OLANLARIN YAZI FONTUNU YESİL YAPTIK"
*      WHEN 'EUR'.
*        CLEAR:gs_cell_color.
*        gs_cell_color-fname = 'URL'.
*        gs_cell_color-color-col = '5'.
*        gs_cell_color-color-int = '1'.
*        gs_cell_color-color-inv = '0'.
*        APPEND gs_cell_color TO <gfs_scarr>-cell_color.
*
*    ENDCASE.
*
*  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FIELDCAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fieldcat .

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
*     i_structure_name       = 'SCARR'  "s11 den kendimizin oluşturduğu bir structure"
      i_structure_name       = 'zas_s_ooalv'  "s11 den kendimizin oluşturduğu bir structure"
*     I_INTERNAL_TABNAME     =
    CHANGING
      ct_fieldcat            = gt_fieldcatalog
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  LOOP AT gt_fieldcatalog INTO gs_fieldcatalog.
    CLEAR d_text.

    CASE gs_fieldcatalog-fieldname .
      WHEN 'CARRID'.
        d_text = 'sirket kodu'.

      WHEN 'CARRNAME'.
        d_text = 'şirket name'.

      WHEN 'URL'.
        d_text = 'url'.
        gs_fieldcatalog-col_opt = 'X'.

      WHEN 'COST'.
        d_text = 'fiyat'.
        gs_fieldcatalog-col_opt = 'X'.
        gs_fieldcatalog-edit    = abap_true.

      WHEN 'ICON'.
        d_text = 'durum'.
        gs_fieldcatalog-col_opt = 'X'.

      WHEN 'LOCATION'.
        d_text = 'ucus sec'.
        gs_fieldcatalog-col_opt = 'X'.
        gs_fieldcatalog-drdn_hndl = 1.
        gs_fieldcatalog-edit    = abap_true.

      WHEN 'SEATL'.
        d_text = 'koltuk sec'.
*        gs_fieldcatalog-col_opt = 'X'.
        gs_fieldcatalog-drdn_hndl = 2.
        gs_fieldcatalog-edit    = abap_true.


    ENDCASE.
    IF d_text NE space.
      MOVE d_text TO: gs_fieldcatalog-scrtext_l,
                      gs_fieldcatalog-scrtext_m,
                      gs_fieldcatalog-scrtext_s,
                      gs_fieldcatalog-reptext.
    ENDIF.
    MODIFY gt_fieldcatalog FROM gs_fieldcatalog.
  ENDLOOP.



ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  CLEAR: gs_layout.
*  gs_layout-zebra = abap_true.
  gs_layout-col_opt = abap_true.
*  gs_layout-info_fname = 'LINE_COLOR'.
*  gs_layout-ctab_fname = 'CELL_COLOR'.
**gs_layout-edit = abap_true.
*gs_layout-no_toolbar = abap_true.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form GET_TOTAL_SUM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_total_sum .
  DATA: lv_total_sum TYPE int4,
        lv_lines     TYPE int4,
        lv_avarage   TYPE int4.

  LOOP AT gt_scarr INTO gs_scarr.
    lv_total_sum = lv_total_sum + gs_scarr-cost.
  ENDLOOP.

  DESCRIBE TABLE gt_scarr LINES lv_lines.

  lv_avarage = lv_total_sum / lv_lines.

  LOOP AT gt_scarr ASSIGNING <gfs_scarr>.
    IF <gfs_scarr>-cost > lv_avarage.
      <gfs_scarr>-icon = '@0A@'.
    ELSEIF <gfs_scarr>-cost < lv_avarage.
      <gfs_scarr>-icon = '@08@'.
    ELSE.
      <gfs_scarr>-icon = '@09@'.


    ENDIF.

  ENDLOOP.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_DROPSOWN
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_dropdown .

  DATA: lt_dropdown TYPE lvc_t_drop,
        ls_dropdown TYPE lvc_s_drop.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value  = 'yurtici'.
  APPEND ls_dropdown TO lt_dropdown.

  CLEAR: ls_dropdown.
  ls_dropdown-handle = 1.
  ls_dropdown-value  = 'yurtdisi'.
  APPEND ls_dropdown TO lt_dropdown.


  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value  = 'a'.
  APPEND ls_dropdown TO lt_dropdown.


  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value  = 'b'.
  APPEND ls_dropdown TO lt_dropdown.


  CLEAR: ls_dropdown.
  ls_dropdown-handle = 2.
  ls_dropdown-value  = 'c'.
  APPEND ls_dropdown TO lt_dropdown.



  go_alv->set_drop_down_table(
    EXPORTING
      it_drop_down  = lt_dropdown
      ).


ENDFORM.
