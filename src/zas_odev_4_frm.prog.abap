*&---------------------------------------------------------------------*
*& Include          ZAS_ODEV_4_FRM
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

  PERFORM get_popup_data.
  SELECT bs~buzei AS belgekalemi bk~bukrs AS sirketno bk~gjahr AS maliyil bk~monat AS donem bk~belnr AS belgeno
         bs~lifnr AS satici ib~isko AS iskonto bs~wrbtr AS ilktutar bs~wrbtr AS tutar
  FROM bkpf AS bk INNER JOIN bseg AS bs ON bk~bukrs EQ bs~bukrs
                  INNER JOIN zas_t_bakim2 AS ib ON ib~satici EQ bs~lifnr AND ib~satici NE ''
                  INTO CORRESPONDING FIELDS OF TABLE gt_list
                  WHERE bk~bukrs EQ srktkod AND bk~gjahr EQ malisene
                  AND bk~monat IN so_donem  AND bs~lifnr IN so_stc.

  LOOP AT gt_list INTO gs_list.
    DATA:lv_indirim TYPE bseg-wrbtr.
    lv_indirim = gs_list-tutar * gs_list-iskonto / 100 .
    gs_list-tutar = gs_list-tutar - lv_indirim.
    MODIFY gt_list FROM gs_list.
  ENDLOOP.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_POPUP_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_popup_data .
  LOOP AT gt_list INTO gs_list WHERE selkz = 'X'.
    SELECT bk~bukrs AS sirketno bk~gjahr AS maliyil bk~belnr AS belgeno bs~buzei AS belgekalemi
           bs~sgtxt AS kalemmetni bs~gsber AS isalani bs~shkzg AS borcalacak bs~wrbtr AS ilktutar bs~wrbtr AS tutar
    FROM bkpf AS bk INNER JOIN bseg AS bs ON bk~bukrs EQ bs~bukrs
                    INTO CORRESPONDING FIELDS OF TABLE gt_list2
      WHERE bs~buzei = gt_list-belgekalemi AND bk~bukrs = gs_list-sirketno
      AND bk~gjahr = gs_list-maliyil AND bk~belnr = gs_list-belgeno
      AND bs~wrbtr = gs_list-ilktutar.
  ENDLOOP.

  LOOP AT gt_list2 INTO gs_list2.
    DATA:lv_indirim TYPE bseg-wrbtr.
    lv_indirim = gs_list2-tutar * gs_list-iskonto / 100 .
    gs_list2-tutar = gs_list2-tutar - lv_indirim.
    MODIFY gt_list2 FROM gs_list2.
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
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name     = sy-repid
      i_internal_tabname = 'GT_LIST'
      i_inclname         = sy-repid
    CHANGING
      ct_fieldcat        = gt_fieldcatalog.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  l_fcat-key = space.
  MODIFY gt_fieldcatalog FROM l_fcat TRANSPORTING key WHERE key NE space.

  gs_layout-box_fieldname = 'SELKZ'.
  gs_layout-zebra = abap_true.

  LOOP AT gt_fieldcatalog INTO gs_fieldcatalog.
    CLEAR d_text.

    CASE gs_fieldcatalog-fieldname .
      WHEN 'BELGEKALEMI'.
        d_text = 'kalem'.
      WHEN 'SIRKETNO'.
        d_text = 'şirket no'.
      WHEN 'MALIYIL'.
        d_text = 'mali yıl'.
      WHEN 'DONEM'.
        d_text = 'donem'.
      WHEN 'BELGENO'.
        gs_fieldcatalog-hotspot = 'X'.
        d_text = 'belge no'.
      WHEN 'SATICI'.
        d_text = 'satıcı'.
      WHEN 'ISKONTO'.
        gs_fieldcatalog-edit  = 'X'.
        d_text = 'iskonto'.
      WHEN 'ILKTUTAR'.
        d_text = 'tutar'.
      WHEN 'TUTAR'.
        d_text = 'indirimli tutar'.
      WHEN 'SELKZ'.
        gs_fieldcatalog-no_out = 'X'.

    ENDCASE.
    IF d_text NE space.
      MOVE d_text TO: gs_fieldcatalog-seltext_l,
                      gs_fieldcatalog-seltext_m,
                      gs_fieldcatalog-seltext_s,
                      gs_fieldcatalog-reptext_ddic.
    ENDIF.
    MODIFY gt_fieldcatalog FROM gs_fieldcatalog.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form SET_POPUP_FC
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_popup_fc .
  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_program_name     = sy-repid
      i_internal_tabname = 'GT_LIST2'
      i_inclname         = sy-repid
    CHANGING
      ct_fieldcat        = gt_fieldcatalog2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

  l_fcat2-key = space.
  MODIFY gt_fieldcatalog2 FROM l_fcat2 TRANSPORTING key WHERE key NE space.

  gs_layout2-colwidth_optimize = 'X'.
  LOOP AT gt_fieldcatalog2 INTO gs_fieldcatalog2.
    CLEAR d_text2.

    CASE gs_fieldcatalog2-fieldname .
      WHEN 'SIRKETNO'.
        d_text2 = 'şirket no'.
      WHEN 'MALIYIL'.
        d_text2 = 'mali yıl'.
      WHEN 'BELGENO'.
        gs_fieldcatalog-hotspot = 'X'.
        d_text2 = 'belge no'.
      WHEN 'BELGEKALEMI'.
        d_text2 = 'belge kalemi'.
      WHEN 'KALEMMETNI'.
        gs_fieldcatalog-edit  = 'X'.
        d_text2 = 'kalem metni'.
      WHEN 'ISALANI'.
        d_text2 = 'is alanı'.
      WHEN 'BORCALACAK'.
        d_text2 = 'borc alacak'.
      WHEN 'ILKTUTAR'.
        d_text2 = 'tutar'.
      WHEN 'TUTAR'.
        d_text2 = 'indirimli tutar'.
    ENDCASE.

    IF d_text2 NE space.
      MOVE d_text2 TO: gs_fieldcatalog2-seltext_l,
                      gs_fieldcatalog2-seltext_m,
                      gs_fieldcatalog2-seltext_s,
                      gs_fieldcatalog2-reptext_ddic.
    ENDIF.
    MODIFY gt_fieldcatalog2 FROM gs_fieldcatalog2.
  ENDLOOP.
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

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_SET'
      i_callback_user_command  = 'USER_COMMAND'
      is_layout                = gs_layout
      it_fieldcat              = gt_fieldcatalog
    TABLES
      t_outtab                 = gt_list.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.

*&---------------------------------------------------------------------*
*& Form DISPLAY_POPUP_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM display_popup_alv .
  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'SUB_PF_STATUS'
      i_callback_user_command  = 'USER_COMMAND'
      is_layout                = gs_layout2
      it_fieldcat              = gt_fieldcatalog2
      i_screen_start_column    = 10
      i_screen_start_line      = 1
      i_screen_end_column      = 100
      i_screen_end_line        = 10
    TABLES
      t_outtab                 = gt_list2.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form USER_COMMAND
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM user_command USING p_ucomm       TYPE sy-ucomm
                        ps_selfield   TYPE slis_selfield.


  CASE ps_selfield-fieldname.
    WHEN 'BELGENO'.
      SET PARAMETER ID 'BLN' FIELD ps_selfield-value.
      SET PARAMETER ID 'BUK' FIELD srktkod.
      SET PARAMETER ID 'GJR' FIELD malisene.
      CALL TRANSACTION 'FB03' AND SKIP FIRST SCREEN.
  ENDCASE.

  DATA:lv_ind TYPE numc2.

  IF p_ucomm EQ '&MSG'.
    LOOP AT gt_list INTO gs_list WHERE selkz EQ 'X'.
      lv_ind = lv_ind + 1.
    ENDLOOP.
    IF lv_ind EQ 0.
      MESSAGE 'Satır seçilmemiş lütfen satır seçiniz' TYPE 'STRING' DISPLAY LIKE 'E'.
    ELSEIF lv_ind EQ 1.
      PERFORM get_popup_data.
      PERFORM set_popup_fc.
      PERFORM display_popup_alv.
    ELSEIF lv_ind > 1.
      MESSAGE 'birden fazla satır secemezsiniz' TYPE 'STRING' DISPLAY LIKE 'E'.

    ELSE.
      MESSAGE 'Satır seçme hatası' TYPE 'STRING' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.

  IF p_ucomm EQ '&FTR'.
    LOOP AT gt_list INTO gs_list WHERE selkz EQ 'X'.
      lv_ind = lv_ind + 1.
    ENDLOOP.
    IF lv_ind EQ 0.
      MESSAGE 'Satır seçilmemiş lütfen satır seçiniz' TYPE 'STRING' DISPLAY LIKE 'E'.
    ELSEIF lv_ind EQ 1.
      PERFORM get_faturabaslik_data.
      PERFORM get_fatura_data.
      PERFORM get_fatura_iskonto.
      PERFORM call_smartform.
    ENDIF.
  ENDIF.









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

FORM sub_pf_status USING rt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STANDARD'.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_FATURABASLIK_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_faturabaslik_data .
  LOOP AT gt_list INTO gs_list WHERE selkz = 'X'.
    SELECT  bk~belnr AS belgeno
            bk~bldat AS belgetarih
            bk~gjahr AS maliyil
            bs~lifnr AS satici
            bk~xblnr AS refalani
            bs~wrbtr AS ilktutar
            bs~wrbtr AS tutar
    FROM bkpf AS bk INNER JOIN bseg AS bs ON bk~bukrs EQ bs~bukrs
      INTO CORRESPONDING FIELDS OF TABLE gt_baslik
      WHERE bk~belnr = gs_list-belgeno AND
            bk~gjahr = gs_list-maliyil AND
            bs~lifnr = gs_list-satici AND
            bs~wrbtr = gs_list-ilktutar.

  ENDLOOP.
  READ TABLE gt_baslik INTO gs_baslik WITH KEY belgeno = gt_list-belgeno.

  LOOP AT gt_baslik INTO gs_baslik.
    DATA:lv_indirim TYPE bseg-wrbtr.
    lv_indirim = gs_baslik-ilktutar * gs_list-iskonto / 100 .
    gs_baslik-iskontolu = gs_baslik-ilktutar - lv_indirim.
    MODIFY gt_baslik FROM gs_baslik.
  ENDLOOP.

ENDFORM.


*&---------------------------------------------------------------------*
*& Form GET_FATURA_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_fatura_data.

  LOOP AT gt_list INTO gs_list WHERE selkz = 'X'.
    SELECT bk~bukrs AS sirketno
           bk~gjahr AS maliyil
           bk~belnr AS belgeno
           bs~buzei AS belgekalemi
           bs~sgtxt AS kalemmetni
           bs~gsber AS isalani
           bs~shkzg AS borcalacak
           bs~wrbtr AS ilktutar
           bs~wrbtr AS tutar
    FROM bkpf AS bk INNER JOIN bseg AS bs ON bk~bukrs EQ bs~bukrs
                    INTO CORRESPONDING FIELDS OF TABLE gt_kalem
       WHERE bs~buzei = gt_list-belgekalemi AND bk~bukrs = gs_list-sirketno
      AND bk~gjahr = gs_list-maliyil AND bk~belnr = gs_list-belgeno
      AND bs~wrbtr = gs_list-ilktutar.

  ENDLOOP.



ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_FATURA_ISKONTO
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM get_fatura_iskonto .
  LOOP AT gt_list INTO gs_list WHERE selkz = 'X'.
    SELECT bs~buzei AS belgekalemi bk~bukrs AS sirketno bk~gjahr AS maliyil bk~monat AS donem bk~belnr AS belgeno
            bs~lifnr AS satici ib~isko AS isko bs~wrbtr AS ilktutar bs~wrbtr AS tutar
     FROM bkpf AS bk INNER JOIN bseg AS bs ON bk~bukrs EQ bs~bukrs
                     INNER JOIN zas_t_bakim2 AS ib ON ib~satici EQ bs~lifnr AND ib~satici NE ''
                     INTO CORRESPONDING FIELDS OF TABLE gt_iskonto
      WHERE bs~buzei = gt_list-belgekalemi AND
            bk~bukrs = gs_list-sirketno AND
            bk~gjahr = gs_list-maliyil AND
            bk~belnr = gs_list-belgeno AND
            bs~wrbtr = gs_list-ilktutar.
  ENDLOOP.
  READ TABLE gt_iskonto INTO gs_iskonto WITH KEY isko = gt_list-iskonto.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form CALL_SMARTFORM
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM call_smartform .
  DATA: lv_fm_name TYPE rs38l_fnam.



  CALL FUNCTION 'SSF_FUNCTION_MODULE_NAME'
    EXPORTING
      formname           = 'ZAS_FS_FATURA'
    IMPORTING
      fm_name            = lv_fm_name
    EXCEPTIONS
      no_form            = 1
      no_function_module = 2
      OTHERS             = 3.
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.
  CALL FUNCTION '/1BCDWB/SF00000056'
    EXPORTING
*     ARCHIVE_INDEX              =
*     ARCHIVE_INDEX_TAB          =
*     ARCHIVE_PARAMETERS         =
*     CONTROL_PARAMETERS         =
*     MAIL_APPL_OBJ              =
*     MAIL_RECIPIENT             =
*     MAIL_SENDER                =
*     OUTPUT_OPTIONS             =
*     USER_SETTINGS              = 'X'
      is_baslik  = gs_baslik
      it_kalem   = gt_kalem
      is_iskonto = gs_iskonto
* IMPORTING
*     DOCUMENT_OUTPUT_INFO       =
*     JOB_OUTPUT_INFO            =
*     JOB_OUTPUT_OPTIONS         =
* EXCEPTIONS
*     FORMATTING_ERROR           = 1
*     INTERNAL_ERROR             = 2
*     SEND_ERROR = 3
*     USER_CANCELED              = 4
*     OTHERS     = 5
    .
  IF sy-subrc <> 0.
* Implement suitable error handling here
  ENDIF.


*  CALL FUNCTION lv_fm_name
*    EXPORTING
**     ARCHIVE_INDEX    =
**     ARCHIVE_INDEX_TAB          =
**     ARCHIVE_PARAMETERS         =
**     CONTROL_PARAMETERS         =
**     MAIL_APPL_OBJ    =
**     MAIL_RECIPIENT   =
**     MAIL_SENDER      =
**     OUTPUT_OPTIONS   =
**     USER_SETTINGS    = 'X'
*      is_baslik        = gs_baslik
*      it_kalem         = gt_kalem
** IMPORTING
**     DOCUMENT_OUTPUT_INFO       =
**     JOB_OUTPUT_INFO  =
**     JOB_OUTPUT_OPTIONS         =
*    EXCEPTIONS
*      formatting_error = 1
*      internal_error   = 2
*      send_error       = 3
*      user_canceled    = 4
*      OTHERS           = 5.
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.


ENDFORM.
