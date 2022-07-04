*&---------------------------------------------------------------------*
*&  Include           ZBFI_MUHTASAR_BEYANNAMESI_CLS
*&---------------------------------------------------------------------*
****************************************************************
* LOCAL CLASSES: Definition
****************************************************************
* Definition:
  CLASS lcl_102_event DEFINITION.

    PUBLIC SECTION.

      METHODS:
        handle_data_changed
                      FOR EVENT data_changed OF cl_gui_alv_grid
          IMPORTING er_data_changed,

*        handle_toolbar
*                      FOR EVENT toolbar OF cl_gui_alv_grid
*          IMPORTING e_object e_interactive, "#EC NEEDED

        handle_user_command
                      FOR EVENT user_command OF cl_gui_alv_grid
          IMPORTING e_ucomm.

    PRIVATE SECTION.

  ENDCLASS.                    "lcl_po_event_receiver DEFINITION

****************************************************************
* LOCAL CLASSES: Implementation
****************************************************************
* Implementation
  CLASS lcl_102_event IMPLEMENTATION.

    METHOD handle_data_changed.

      DATA: ls_good   TYPE lvc_s_modi,
            ls_matrah LIKE gt_matrah,
            lv_id     TYPE sy-tabix.

      FIELD-SYMBOLS: <table>   TYPE ANY TABLE.
      "bu kod ile imleç in bulunduğu satır yakalanıyor.
      ASSIGN er_data_changed->mp_mod_rows->* TO <table>.
      LOOP AT <table> INTO ls_matrah.
        CLEAR: gt_matrah.
        READ TABLE gt_matrah INTO gt_matrah WITH KEY istur = ls_matrah-istur.
        IF sy-subrc = 0.
          gt_matrah-vergi_ksnt_tutar = ls_matrah-vergi_ksnt_tutar.
          MODIFY gt_matrah FROM gt_matrah
          INDEX sy-tabix TRANSPORTING vergi_ksnt_tutar.
        ENDIF.
      ENDLOOP.
      CLEAR: gs_toplamlar-terkin_tutar.
      LOOP AT gt_matrah INTO gt_matrah WHERE istur NE '301'
                    AND istur NE '302'
                    AND istur NE '303'.
        gs_toplamlar-terkin_tutar = gs_toplamlar-terkin_tutar +
                                    gt_matrah-vergi_ksnt_tutar.

        gs_toplamlar-matrah = gs_toplamlar-matrah +
                              gt_matrah-odeme_tutar.
      ENDLOOP.

      PERFORM refresh_table_display CHANGING gr_grid102.
      CALL METHOD cl_gui_cfw=>flush.
      CALL METHOD cl_gui_control=>set_focus
        EXPORTING
          control = gr_grid102.

      CALL METHOD cl_gui_cfw=>set_new_ok_code
        EXPORTING
          new_code = 'XYZ'.

    ENDMETHOD.
*    METHOD handle_toolbar.
*      DATA: ls_toolbar  TYPE stb_button.
*
** append a separator to normal toolbar
*      CLEAR ls_toolbar.
*      MOVE 3 TO ls_toolbar-butn_type.
*      APPEND ls_toolbar TO e_object->mt_toolbar.
** append an icon to show booking table
*      CLEAR ls_toolbar.
*      MOVE 'FC_NEW'     TO ls_toolbar-function.
*      MOVE icon_create  TO ls_toolbar-icon.
*      MOVE 'Satır ekle'(030) TO ls_toolbar-quickinfo.
*      MOVE 'Satır ekle'(030) TO ls_toolbar-text.
*      MOVE ' '          TO ls_toolbar-disabled.
*      APPEND ls_toolbar TO e_object->mt_toolbar.
**
*      CLEAR ls_toolbar.
*      MOVE 'FC_DEL'      TO ls_toolbar-function.
*      MOVE  icon_delete  TO ls_toolbar-icon.
*      MOVE 'Satır sil'(029) TO ls_toolbar-quickinfo.
*      MOVE 'Satır sil'(029) TO ls_toolbar-text.
*      MOVE ' '           TO ls_toolbar-disabled.
*      APPEND ls_toolbar  TO e_object->mt_toolbar.
*
*    ENDMETHOD.                    "handle_toolbar
*-------------------------------------------------------------------
    METHOD handle_user_command.

      CASE e_ucomm.
        WHEN 'FC_NEW'.
*          PERFORM add_row_102.
        WHEN 'FC_DEL'.
*          PERFORM del_row_102.
      ENDCASE.

    ENDMETHOD.                           "handle_user_command

  ENDCLASS.
****************************************************************
* LOCAL CLASSES: Definition
****************************************************************
* Definition:
  CLASS lcl_103_event DEFINITION.

    PUBLIC SECTION.

      METHODS:
        handle_data_changed
                      FOR EVENT data_changed OF cl_gui_alv_grid
          IMPORTING er_data_changed,

*        handle_toolbar
*                      FOR EVENT toolbar OF cl_gui_alv_grid
*          IMPORTING e_object e_interactive, "#EC NEEDED

        handle_user_command
                      FOR EVENT user_command OF cl_gui_alv_grid
          IMPORTING e_ucomm,

        handle_double_click
                      FOR EVENT double_click OF cl_gui_alv_grid
          IMPORTING e_row e_column.                         "#EC NEEDED

    PRIVATE SECTION.

  ENDCLASS.                    "lcl_po_event_receiver DEFINITION

****************************************************************
* LOCAL CLASSES: Implementation
****************************************************************
* Implementation
  CLASS lcl_103_event IMPLEMENTATION.

    METHOD handle_data_changed.

      DATA: ls_good   TYPE lvc_s_modi.
*      FIELD-SYMBOLS: <table>   TYPE ANY TABLE.

      LOOP AT er_data_changed->mt_mod_cells INTO ls_good.
        CASE ls_good-fieldname.
          WHEN ''.
        ENDCASE.
      ENDLOOP.

      PERFORM refresh_table_display CHANGING gr_grid103.
      CALL METHOD cl_gui_cfw=>flush.
      CALL METHOD cl_gui_control=>set_focus
        EXPORTING
          control = gr_grid103.

    ENDMETHOD.
*    METHOD handle_toolbar.
*      DATA: ls_toolbar  TYPE stb_button.
*
** append a separator to normal toolbar
*      CLEAR ls_toolbar.
*      MOVE 3 TO ls_toolbar-butn_type.
*      APPEND ls_toolbar TO e_object->mt_toolbar.
** append an icon to show booking table
*      CLEAR ls_toolbar.
*      MOVE 'FC_NEW'     TO ls_toolbar-function.
*      MOVE icon_create  TO ls_toolbar-icon.
*      MOVE 'Satır ekle'(030) TO ls_toolbar-quickinfo.
*      MOVE 'Satır ekle'(030) TO ls_toolbar-text.
*      MOVE ' '          TO ls_toolbar-disabled.
*      APPEND ls_toolbar TO e_object->mt_toolbar.
**
*      CLEAR ls_toolbar.
*      MOVE 'FC_DEL'      TO ls_toolbar-function.
*      MOVE  icon_delete  TO ls_toolbar-icon.
*      MOVE 'Satır sil'(029) TO ls_toolbar-quickinfo.
*      MOVE 'Satır sil'(029) TO ls_toolbar-text.
*      MOVE ' '           TO ls_toolbar-disabled.
*      APPEND ls_toolbar  TO e_object->mt_toolbar.
*
*    ENDMETHOD.                    "handle_toolbar
*-------------------------------------------------------------------
    METHOD handle_user_command.

      CASE e_ucomm.
        WHEN 'FC_NEW'.
*          PERFORM add_row_102.
        WHEN 'FC_DEL'.
*          PERFORM del_row_102.
      ENDCASE.

    ENDMETHOD.                           "handle_user_command

    METHOD handle_double_click.
      READ TABLE gt_odeme INTO gt_odeme INDEX e_row-index.
      CHECK sy-subrc EQ 0.

      SET PARAMETER ID 'BLN' FIELD gt_odeme-belnr.
      SET PARAMETER ID 'BUK' FIELD gt_odeme-bukrs2.
      SET PARAMETER ID 'GJR' FIELD gt_odeme-gjahr2.
*      SET PARAMETER ID 'BUZ' FIELD gt_odeme-buzei.
*      CALL TRANSACTION 'FB09D' AND SKIP FIRST SCREEN.
      CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.

    ENDMETHOD.                           "handle_double_click

  ENDCLASS.
****************************************************************
* LOCAL CLASSES: Definition
****************************************************************
* Definition:
  CLASS lcl_106_event DEFINITION.

    PUBLIC SECTION.

      METHODS:
        handle_data_changed
                      FOR EVENT data_changed OF cl_gui_alv_grid
          IMPORTING er_data_changed,

*        handle_toolbar
*                      FOR EVENT toolbar OF cl_gui_alv_grid
*          IMPORTING e_object e_interactive, "#EC NEEDED

        handle_user_command
                      FOR EVENT user_command OF cl_gui_alv_grid
          IMPORTING e_ucomm.

    PRIVATE SECTION.

  ENDCLASS.                    "lcl_po_event_receiver DEFINITION

****************************************************************
* LOCAL CLASSES: Implementation
****************************************************************
* Implementation
  CLASS lcl_106_event IMPLEMENTATION.

    METHOD handle_data_changed.

      DATA: ls_good   TYPE lvc_s_modi.
*      FIELD-SYMBOLS: <table>   TYPE ANY TABLE.

      LOOP AT er_data_changed->mt_mod_cells INTO ls_good.
        CASE ls_good-fieldname.
          WHEN ''.
        ENDCASE.
      ENDLOOP.

      PERFORM refresh_table_display CHANGING gr_grid106.
      CALL METHOD cl_gui_cfw=>flush.
      CALL METHOD cl_gui_control=>set_focus
        EXPORTING
          control = gr_grid106.

    ENDMETHOD.
*    METHOD handle_toolbar.
*      DATA: ls_toolbar  TYPE stb_button.
*
** append a separator to normal toolbar
*      CLEAR ls_toolbar.
*      MOVE 3 TO ls_toolbar-butn_type.
*      APPEND ls_toolbar TO e_object->mt_toolbar.
** append an icon to show booking table
*      CLEAR ls_toolbar.
*      MOVE 'FC_NEW'     TO ls_toolbar-function.
*      MOVE icon_create  TO ls_toolbar-icon.
*      MOVE 'Satır ekle'(030) TO ls_toolbar-quickinfo.
*      MOVE 'Satır ekle'(030) TO ls_toolbar-text.
*      MOVE ' '          TO ls_toolbar-disabled.
*      APPEND ls_toolbar TO e_object->mt_toolbar.
**
*      CLEAR ls_toolbar.
*      MOVE 'FC_DEL'      TO ls_toolbar-function.
*      MOVE  icon_delete  TO ls_toolbar-icon.
*      MOVE 'Satır sil'(029) TO ls_toolbar-quickinfo.
*      MOVE 'Satır sil'(029) TO ls_toolbar-text.
*      MOVE ' '           TO ls_toolbar-disabled.
*      APPEND ls_toolbar  TO e_object->mt_toolbar.
*
*    ENDMETHOD.                    "handle_toolbar
*-------------------------------------------------------------------
    METHOD handle_user_command.

      CASE e_ucomm.
        WHEN 'FC_NEW'.
*          PERFORM add_row_102.
        WHEN 'FC_DEL'.
*          PERFORM del_row_102.
      ENDCASE.

    ENDMETHOD.                           "handle_user_command

  ENDCLASS.
