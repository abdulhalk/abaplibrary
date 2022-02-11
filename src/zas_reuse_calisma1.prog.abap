*&---------------------------------------------------------------------*
*& Report ZAS_REUSE_CALISMA1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_reuse_calisma1.

TABLES: zas_t_librarystd, zas_t_lbrrybook.

INCLUDE zas_reuse_calisma1_top.
INCLUDE zas_reuse_calisma1_frm.

INITIALIZATION.

  gs_variant_get-report = sy-repid.
  CALL FUNCTION 'REUSE_ALV_VARIANT_DEFAULT_GET'
    CHANGING
      cs_variant    = gs_variant_get
    EXCEPTIONS
      wrong_input   = 1
      not_found     = 2
      program_error = 3
      OTHERS        = 4.
  IF sy-subrc EQ 0.
    p_vari = gs_variant_get-variant.
  ENDIF.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_vari.
  gs_variant_get-report = sy-repid.
  CALL FUNCTION 'REUSE_ALV_VARIANT_F4'
    EXPORTING
      is_variant    = gs_variant_get
    IMPORTING
      e_exit        = gv_exit
      es_variant    = gs_variant_get
    EXCEPTIONS
      not_found     = 1
      program_error = 2
      OTHERS        = 3.
  IF sy-subrc eq 0.
    IF gv_exit is INITIAL.
      p_vari = gs_variant_get-variant.

    ENDIF.
* Implement suitable error handling here
  ENDIF.




START-OF-SELECTION.

  PERFORM get_data.
  PERFORM set_fc.
  PERFORM set_layout.
  PERFORM display_alv.
