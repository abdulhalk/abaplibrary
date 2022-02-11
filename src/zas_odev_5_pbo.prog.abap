*&---------------------------------------------------------------------*
*& Include          ZAS_ODEV_5_PBO
*&---------------------------------------------------------------------*
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
  SET PF-STATUS '0100'.
  SET TITLEBAR '0100'.

  SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.

  PARAMETERS: p_bukrs TYPE bkpf-bukrs OBLIGATORY,
              p_gjahr TYPE bseg-gjahr,
              p_monat TYPE bkpf-monat.
  SELECT-OPTIONS: s_hbkid FOR t012-hbkid ,
                  s_waers FOR t012k-waers.
  SELECTION-SCREEN END OF BLOCK b1.
ENDMODULE.
