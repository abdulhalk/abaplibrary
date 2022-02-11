*&---------------------------------------------------------------------*
*& Report ZAS_OOALV_CALISMA1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_ooalv_calisma1.

INCLUDE zas_ooalv_calisma1_top.
INCLUDE zas_ooalv_calisma1_pbo.
INCLUDE zas_ooalv_calisma1_pai.
INCLUDE zas_ooalv_calisma1_frm.

START-OF-SELECTION.


PERFORM get_data.
PERFORM set_fieldcat.
PERFORM set_layout.




  CALL SCREEN 0100.
