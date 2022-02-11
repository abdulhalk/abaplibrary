*&---------------------------------------------------------------------*
*& Report ZAS_ODEV_5
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_odev_5.

INCLUDE zas_odev_5_top.
INCLUDE zas_odev_5_pbo.
INCLUDE zas_odev_5_pai.
INCLUDE zas_odev_5_frm.

INITIALIZATION.

CALL FUNCTION 'DATE_TO_PERIOD_CONVERT'
  EXPORTING
    i_date  = sy-datum
*   I_MONMIT       = 00
    i_periv = 'K4'
  IMPORTING
    e_buper = x_period
    e_gjahr = x_year.

p_gjahr = x_year.
p_monat = x_period.

START-OF-SELECTION.


  PERFORM get_data.
  PERFORM set_fieldcat.
  PERFORM set_layout.
  PERFORM display_alv.

  CALL SCREEN 0100.
