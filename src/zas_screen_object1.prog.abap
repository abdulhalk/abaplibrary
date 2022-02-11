*&---------------------------------------------------------------------*
*& Report ZAS_SCREEN_OBJECT1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_screen_object1.
*DATA: gv_name  TYPE char20,
*      gv_sname TYPE char20,
*      gv_age   TYPE i.


DATA: gv_num   TYPE i,
      gv_text1 TYPE char20,
      gv_text2 TYPE char20,
      gv_text3 TYPE char20,
      gv_text4 TYPE char20.

START-OF-SELECTION.
  CALL SCREEN 0200.
*
*DATA: gv_flag TYPE xfeld.
*
*START-OF-SELECTION.
*
*  CALL SCREEN 0100.
*
**&---------------------------------------------------------------------*
**& Module STATUS_0100 OUTPUT
**&---------------------------------------------------------------------*
**&
**&---------------------------------------------------------------------*
*MODULE status_0100 OUTPUT.
*  SET PF-STATUS '0100'.
*
*  LOOP AT SCREEN.
*    IF gv_flag EQ abap_true.
*      IF screen-group1 EQ 'X'.
*        screen-input = 1.
*        MODIFY SCREEN.
*      ENDIF.
*    ENDIF.
*    IF gv_flag EQ abap_false.
*      IF screen-group1 EQ 'X'.
*        screen-input = 0.
*        MODIFY SCREEN.
*      ENDIF.
*    ENDIF.
*
*
*
*  ENDLOOP.

*  LOOP AT SCREEN.
*    IF screen-group1 EQ 'X'.
*      screen-input = 0.
*      MODIFY SCREEN.
*    ENDIF.
*  ENDLOOP.

*  LOOP AT SCREEN.
*    IF screen-name EQ 'GV_NAME'.
*      screen-active = 0.
*      MODIFY SCREEN.
*    ENDIF.
*
*    IF screen-name EQ 'GV_SNAME'.
*      screen-invisible = 1.
*      MODIFY SCREEN.
*    ENDIF.
*
*       IF screen-name EQ 'GV_AGE'.
*      screen-input = 0.
*      MODIFY SCREEN.
*    ENDIF.
*  ENDLOOP.

*ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
*MODULE user_command_0100 INPUT.
*  CASE sy-ucomm.
*    WHEN '&BACK' .
*      SET SCREEN 0.
*    WHEN '&ENABLE'.
*      gv_flag = abap_true. " X
*    WHEN '&DISABLE'.
*      gv_flag = abap_false. " ''
*
*  ENDCASE.
*
*ENDMODULE.
*&---------------------------------------------------------------------*
*& Module STATUS_0200 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0200 OUTPUT.
  SET PF-STATUS '0200'.

  LOOP AT SCREEN.
    IF screen-group1 EQ 'X'.
      screen-input = 0.
      MODIFY SCREEN.
    ENDIF.
    IF screen-group2 EQ 'X'.
      screen-input = 0.
      MODIFY SCREEN.
    ENDIF.
    IF screen-group3 EQ 'X'.
      screen-input = 0.
      MODIFY SCREEN.
    ENDIF.

    IF screen-group4 EQ 'X'.
      screen-input = 0.
      MODIFY SCREEN.
    ENDIF.

  ENDLOOP.


  LOOP AT SCREEN.
    CASE gv_num.
      WHEN 1.
        IF screen-group1 EQ 'X'.
          screen-input = 1.
          MODIFY SCREEN.
        ENDIF.
      WHEN 2.
        IF screen-group2 EQ 'X'.
          screen-input = 1.
          MODIFY SCREEN.
        ENDIF.
      WHEN 3.
        IF screen-group3 EQ 'X'.
          screen-input = 1.
          MODIFY SCREEN.
        ENDIF.
      WHEN 4.
        IF screen-group4 EQ 'X'.
          screen-input = 1.
          MODIFY SCREEN.
        ENDIF.
    ENDCASE.
  ENDLOOP.

ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0200  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN '&BACK'.
      SET SCREEN 0.
  ENDCASE.

ENDMODULE.
