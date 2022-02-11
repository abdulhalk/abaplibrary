*&---------------------------------------------------------------------*
*& Report ZAS_ODEV_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_odev_4.

TABLES:bkpf, bseg, zas_t_bakim, sscrfields.

INCLUDE zas_odev_4_top.
INCLUDE zas_odev_4_ss.
INCLUDE zas_odev_4_frm.


START-OF-SELECTION.
PERFORM get_data.
PERFORM set_fc.
PERFORM display_alv.
*PERFORM call_smartform.
*PERFORM get_fatura_data.
