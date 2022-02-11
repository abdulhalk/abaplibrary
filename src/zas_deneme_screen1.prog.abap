*&---------------------------------------------------------------------*
*& Report ZAS_DENEME_SCREEN1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_deneme_screen1.

DATA: gv_ad    TYPE c LENGTH 20,
      gv_soyad TYPE c LENGTH 30.

DATA: gv_rd1 TYPE xfeld,
      gv_rd2 TYPE xfeld.

DATA: gv_cbox TYPE xfeld.

DATA: gv_yas TYPE i.

DATA: gv_id     TYPE vrm_id,
      gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value.

DATA: gv_cntr TYPE i.

DATA: gv_dogumt TYPE datum.

*bizim tablomuzun tipinin structurunu tutuyor.
DATA: gs_log TYPE zas_t_screen.

CONTROLS ts-id TYPE TABSTRIP.

START-OF-SELECTION.

  gv_cntr = 18.
  DO 60 TIMES.
    gs_value-key  = gv_cntr.
    gs_value-text = gv_cntr.
    APPEND gs_value TO gt_values.
    gv_cntr = gv_cntr + 1.
  ENDDO.


  CALL SCREEN 0100.
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS 'SCREEN'.
  gv_id = 'gv_yas'.
  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id     = gv_id
      values = gt_values.
*


* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.


  CASE sy-ucomm.
    WHEN '&BCK'.
      LEAVE TO SCREEN 0.
    WHEN '&CLEAR'.
      PERFORM clear_data.
    WHEN '&SAVE'.
      PERFORM save_data.
    WHEN '&TAB1'.
      ts-id-activetab = '&TAB1'.
    WHEN '&TAB2'.
      ts-id-activetab = '&TAB2'.
  ENDCASE.

ENDMODULE.
*&---------------------------------------------------------------------*
*& Form SAVE_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM save_data .
  gs_log-ad = gv_ad.
  gs_log-soyad = gv_soyad.
  gs_log-yas = gv_yas.
  gs_log-zdate = gv_dogumt.
  gs_log-cbox = gv_cbox.
  IF gv_rd1 EQ abap_true.
    gs_log-cinsiyet = 'K'.
  ELSE.
    gs_log-cinsiyet = 'E'.
  ENDIF.
  INSERT zas_t_screen FROM gs_log.
  COMMIT WORK AND WAIT.
  MESSAGE 'verileriniz tabloya kaydedilmistir.' TYPE 'I' DISPLAY LIKE 'S'.
ENDFORM.
*&---------------------------------------------------------------------*
*& Form CLEAR_DATA
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM clear_data .
  CLEAR:       gv_ad,
               gv_soyad,
               gv_yas,
               gv_dogumt,
               gv_cbox,
               gv_rd2.
  gv_rd1 = abap_true.
ENDFORM.
