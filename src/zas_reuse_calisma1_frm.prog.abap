*&---------------------------------------------------------------------*
*& Include          ZAS_REUSE_CALISMA1_FRM
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_data .
  DATA:lv_today_date TYPE zas_de_vdate.
  DATA:lv_check_date TYPE i.

  lv_today_date = sy-datum.
  lv_check_date = lv_today_date - gs_list-zzvdate.



  SELECT

   zas_t_librarystd~zzstudentno
   zas_t_librarystd~zzstudentname
   zas_t_librarystd~zzstudentlastname
   zas_t_lbrrybook~zzbookname
   zas_t_lbrryauthr~zzauthorname
   zas_t_lbrryauthr~zzauthorlastname
   zas_t_lbrryprcs~zzadate
   zas_t_lbrryprcs~zzvdate
   zas_t_lbrrybook~zzpoint
   INTO CORRESPONDING FIELDS OF TABLE gt_list
   FROM zas_t_lbrrybook
   INNER JOIN zas_t_librarystd ON zas_t_librarystd~zzpoint EQ zas_t_lbrrybook~zzpoint
   INNER JOIN zas_t_lbrryauthr ON zas_t_lbrryauthr~zzauthorno EQ zas_t_lbrrybook~zzauthorno
   INNER JOIN zas_t_lbrryprcs  ON zas_t_lbrryprcs~zzbookno EQ zas_t_lbrrybook~zzbookno.

*   FROM zas_t_lbrrybook
*   INNER JOIN zas_t_librarystd ON zas_t_librarystd~zzpoint EQ zas_t_lbrrybook~zzpoint
*   INTO CORRESPONDING FIELDS OF TABLE gt_list.

  LOOP AT gt_list INTO gs_list.
    IF gs_list-zzpoint > 65.
      gs_list-icon = 3.
    ELSEIF gs_list-zzpoint <= 65 AND gs_list-zzpoint => 55.
      gs_list-icon = 2.
    ELSE.
      gs_list-icon = 1.
    ENDIF.
    MODIFY gt_list FROM gs_list TRANSPORTING icon.
    CLEAR gs_list.
  ENDLOOP.



  LOOP AT gt_list INTO gs_list.
    IF lv_today_date - gs_list-zzvdate = 0.
      gs_list-line_color = 'C311'.
    ELSEIF lv_today_date - gs_list-zzvdate = -3.
      gs_list-line_color = 'C411'.
    ELSEIF lv_today_date - gs_list-zzvdate > 0.
      gs_list-line_color = 'C611'.
    ELSEIF lv_today_date - gs_list-zzvdate < -3.
      gs_list-line_color = 'C511'.
    ENDIF.
    MODIFY gt_list FROM gs_list.

  ENDLOOP.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fc .

*  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
*    EXPORTING
*      i_program_name     = sy-repid
*      i_internal_tabname = 'GT_LIST'
**     I_STRUCTURE_NAME   =
*      i_inclname         = sy-repid
*    CHANGING
*      ct_fieldcat        = gt_fieldcatolog.


  PERFORM: set_fc_sub USING 'zzstudentno' 'st no' 'student no' 'student no' abap_true ,
           set_fc_sub USING 'zzstudentname' 'st name' 'student name' 'student name' abap_true ,
           set_fc_sub USING 'zzstudentlastname' 'st lname' 'student lastname' 'student lastname' abap_true ,
           set_fc_sub USING 'zzbookname' 'book name' 'book name' 'book name' abap_false ,
           set_fc_sub USING 'zzauthorname' 'auth name' 'author name' 'author name' abap_false ,
           set_fc_sub USING 'zzauthorlastname' 'auth lname' 'author lastname' 'author lastname' abap_false ,
           set_fc_sub USING 'zzadate' 'receive dt' 'received date' 'received date' abap_false ,
           set_fc_sub USING 'zzvdate' 'delvry dt' 'delivery date' 'delivery date' abap_false ,
           set_fc_sub USING 'zzpoint' 'score' 'score' 'score' abap_false .
ENDFORM.

*  CLEAR: gs_fieldcatolog.
*  gs_fieldcatolog-fieldname = 'zzstudentname '.
*  gs_fieldcatolog-seltext_s = 'st name'.
*  gs_fieldcatolog-seltext_m = 'student name'.
*  gs_fieldcatolog-seltext_l = 'student name'.
*  gs_fieldcatolog-key = abap_true.
*  gs_fieldcatolog-col_pos = 0.
*  APPEND gs_fieldcatolog TO gt_fieldcatolog.

*  CLEAR: gs_fieldcatolog.
*  gs_fieldcatolog-fieldname = 'zzstudentlastname '.
*  gs_fieldcatolog-seltext_s =  'st lname'.
*  gs_fieldcatolog-seltext_m =  'student lastname'.
*  gs_fieldcatolog-seltext_l =  'student lastname'.
*  gs_fieldcatolog-key = abap_true.
*  gs_fieldcatolog-col_pos = 1.
*  APPEND gs_fieldcatolog TO gt_fieldcatolog.
*
*  CLEAR: gs_fieldcatolog.
*  gs_fieldcatolog-fieldname = 'zzdate '.
*  gs_fieldcatolog-seltext_s =  'date'.
*  gs_fieldcatolog-seltext_m =  'date'.
*  gs_fieldcatolog-seltext_l =  'date'.
*  gs_fieldcatolog-col_pos = 4.
*  APPEND gs_fieldcatolog TO gt_fieldcatolog.
*
*  CLEAR: gs_fieldcatolog.
*  gs_fieldcatolog-fieldname = 'zzbookname '.
*  gs_fieldcatolog-seltext_s =  'bk name'.
*  gs_fieldcatolog-seltext_m =  'book name'.
*  gs_fieldcatolog-seltext_l =  'book name'.
*  gs_fieldcatolog-col_pos = 3.
*  APPEND gs_fieldcatolog TO gt_fieldcatolog.
*
*  CLEAR: gs_fieldcatolog.
*  gs_fieldcatolog-fieldname = 'zzpoint '.
*  gs_fieldcatolog-seltext_s =  'score'.
*  gs_fieldcatolog-seltext_m =  'score'.
*  gs_fieldcatolog-seltext_l =  'score'.
*  gs_fieldcatolog-col_pos = 2.
*  APPEND gs_fieldcatolog TO gt_fieldcatolog.
*




*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .
  gs_layout-window_titlebar = ' RESUE ALV CALISMASI LAYOUT TITLEBAR'.
  gs_layout-zebra = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname = 'SELKZ'.
  gs_layout-info_fieldname = 'LINE_COLOR'.
  gs_layout-lights_fieldname = 'ICON'.
  gs_layout-hotspot_fieldname = 'zzstudentno'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_alv .
  gs_event-name = slis_ev_top_of_page.
  gs_event-form = 'TOP_OF_PAGE '.
  APPEND gs_event TO gt_events.

  gs_event-name = slis_ev_end_of_list.
  gs_event-form = 'END_OF_LIST '.
  APPEND gs_event TO gt_events.

*  gs_event-name = slis_ev_pf_status_set.
*  gs_event-form = 'PF_STATUS_SET '.
*  APPEND gs_event TO gt_events.

  gs_exclude-fcode = '&UMC'.
  APPEND gs_exclude TO gt_exclude.

*gs_sort-spos = 1.
*gs_sort-tabname = 'GT_LIST'.
*gs_sort-fieldname = 'ZZSTUDENTNO'.
*gs_sort-down = abap_true.
*APPEND gs_sort to gt_sort.

*gs_sort-spos = 2.
*gs_sort-tabname = 'GT_LIST'.
*gs_sort-fieldname = 'ZZADATE'.
*gs_sort-up = abap_true.
*APPEND gs_sort to gt_sort.

*gs_filter-tabname   = 'GT_LIST'.
*gs_filter-fieldname = 'zzpoint'.
*gs_filter-sign0     = 'I'.
*gs_filter-optio     = 'EQ'.
*gs_filter-valuf_int =  75.
*APPEND gs_filter TO gt_filter.

  gs_variant-variant = p_vari.



  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
*     I_INTERFACE_CHECK     = ' '
*     I_BYPASSING_BUFFER    = ' '
*     I_BUFFER_ACTIVE       = ' '
      i_callback_program    = sy-repid
*     i_callback_pf_status_set       = 'PF_STATUS_SET '
*     i_callback_user_command = 'USER_COMMAND '
*     I_CALLBACK_TOP_OF_PAGE  = 'TOP_OF_PAGE '
*     I_CALLBACK_HTML_TOP_OF_PAGE    = ' '
*     I_CALLBACK_HTML_END_OF_LIST    = ' '
*     I_STRUCTURE_NAME      =
*     I_BACKGROUND_ID       = ' '
*     I_GRID_TITLE          =
*     I_GRID_SETTINGS       =
      is_layout             = gs_layout
      it_fieldcat           = gt_fieldcatolog
      it_excluding          = gt_exclude
*     IT_SPECIAL_GROUPS     =
      it_sort               = gt_sort
      it_filter             = gt_filter
*     IS_SEL_HIDE           =
*     I_DEFAULT             = 'X'
      i_save                = 'X'
      is_variant            = gs_variant
      it_events             = gt_events
*     IT_EVENT_EXIT         =
*     IS_PRINT              =
*     IS_REPREP_ID          =
*      i_screen_start_column = 40
*      i_screen_start_line   = 5
*      i_screen_end_column   = 100
*      i_screen_end_line     = 20
*     I_HTML_HEIGHT_TOP     = 0
*     I_HTML_HEIGHT_END     = 0
*     IT_ALV_GRAPHICS       =
*     IT_HYPERLINK          =
*     IT_ADD_FIELDCAT       =
*     IT_EXCEPT_QINFO       =
*     IR_SALV_FULLSCREEN_ADAPTER     =
*     O_PREVIOUS_SRAL_HANDLER =
* IMPORTING
*     E_EXIT_CAUSED_BY_CALLER =
*     ES_EXIT_CAUSED_BY_USER  =
    TABLES
      t_outtab              = gt_list
* EXCEPTIONS
*     PROGRAM_ERROR         = 1
*     OTHERS                = 2
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here

  ENDIF.
ENDFORM.

FORM set_fc_sub USING p_fieldname
                      p_seltext_s
                      p_seltext_m
                      p_seltext_l
                      p_key.
*                      p_col_pos.
  CLEAR: gs_fieldcatolog.
  gs_fieldcatolog-fieldname = p_fieldname.
  gs_fieldcatolog-seltext_s =  p_seltext_s.
  gs_fieldcatolog-seltext_m =  p_seltext_m.
  gs_fieldcatolog-seltext_l =  p_seltext_l.
  gs_fieldcatolog-key = p_key.
*  gs_fieldcatolog-col_pos = p_col_pos.
  APPEND gs_fieldcatolog TO gt_fieldcatolog.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form TOP_OF_PAGE
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM top_of_page .
  DATA: lt_header TYPE slis_t_listheader,
        ls_header TYPE slis_listheader.

  DATA: lv_date TYPE char10.
*  DATA: lv_lines   TYPE i,
*        lv_lines_c TYPE char4.


  CLEAR: ls_header.
  ls_header-typ = 'H'.
  ls_header-info = 'kutuphane tablosundan ogrenci ve kitap bilgilerini cekiyoruz.'.
  APPEND ls_header TO lt_header.

  CLEAR: ls_header.
  ls_header-typ = 'S'.
  ls_header-key = 'Tarih:'.
  CONCATENATE sy-datum+6(2)
              '.'
              sy-datum+4(2)
              '.'
              sy-datum+0(4)
              INTO lv_date.
  ls_header-info = lv_date.
*  ls_header-info = '26.01.2022'.
  APPEND ls_header TO lt_header.

*  CLEAR: ls_header.
*  ls_header-typ = 'A'.
**  ls_header-info = 'Raporda 50 adet kalem vardir.'.
*  CONCATENATE 'Raporda'
*              lv_lines_c
*              'adet kalem vardir.'
*              INTO ls_header-info
*                SEPARATED BY space.
*  APPEND ls_header TO lt_header.

*  DESCRIBE TABLE gt_list LINES lv_lines.
*  lv_lines_c = lv_lines.


  CALL FUNCTION 'REUSE_ALV_COMMENTARY_WRITE'
    EXPORTING
      it_list_commentary = lt_header.
*     I_LOGO                   =
*     I_END_OF_LIST_GRID       =
*     I_ALV_FORM               =
  .


ENDFORM.

*&---------------------------------------------------------------------*
*& Form END_OF_LIST
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM end_of_list   .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form PF_STATUS_SET
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM pf_status_set USING p_extab TYPE slis_t_extab .
  SET PF-STATUS 'STANDARD'.

ENDFORM.
*&---------------------------------------------------------------------*
*& Form USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
*FORM user_command USING p_ucomm TYPE sy-ucomm
*                        ps_selfield TYPE slis_selfield.
*
*ENDFORM.
