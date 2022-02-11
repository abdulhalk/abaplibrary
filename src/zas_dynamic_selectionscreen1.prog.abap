*&---------------------------------------------------------------------*
*& Report ZAS_DYNAMIC_SELECTIONSCREEN1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_dynamic_selectionscreen1.

PARAMETERS: p_rad1 RADIOBUTTON GROUP gr1 DEFAULT 'X' USER-COMMAND uc1,
            p_rad2 RADIOBUTTON GROUP gr1.

PARAMETERS: p_lifnr  TYPE lifnr MODIF ID g1,
            p_lifnrn TYPE name1_gp MODIF ID g1,
            p_kunnr  TYPE kunnr MODIF ID g2,
            p_kunnrn TYPE name1_gp MODIF ID g2.

AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF p_rad1 EQ abap_true.
      IF screen-group1 EQ 'G1'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'G2'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

    IF p_rad2 EQ abap_true.
      IF screen-group1 EQ 'G1'.
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
      IF screen-group1 EQ 'G2'.
        screen-active = 1.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.


  ENDLOOP.
