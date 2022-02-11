*&---------------------------------------------------------------------*
*& Include          ZAS_ODEV_5_FRM
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
  SELECT

         t001~bukrs,
         t001~butxt,
         t012~hbkid,
         t012~banks,
         t012~bankl,
         bnka~banka,
         t012k~hktid,
         t012k~hkont,
         skat~txt50,
         t012k~waers,
         t012t~text1


     FROM t001
    INNER JOIN t012 ON t012~bukrs EQ t001~bukrs
    INNER JOIN bnka ON bnka~banks EQ t012~banks AND
                       bnka~bankl EQ t012~bankl
    LEFT JOIN t012k ON t012k~bukrs EQ t012~bukrs AND
                       t012k~hbkid EQ t012~hbkid
    INNER JOIN skat ON  skat~spras EQ 'TR' AND
                        skat~ktopl EQ t001~ktopl AND
                        skat~saknr EQ t012k~hkont
    LEFT JOIN t012t ON t012t~bukrs EQ t012k~bukrs  AND
                              t012t~hbkid EQ t012k~hbkid AND
                              t012t~hktid EQ t012k~hktid AND
                              t012t~spras EQ 'TR'
     INTO CORRESPONDING FIELDS OF TABLE @gt_banka1
  WHERE   t001~bukrs EQ @p_bukrs AND
          t012~hbkid IN @s_hbkid AND
          t012k~waers IN @s_waers.




ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_FIELDCAT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_fieldcat .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form SET_LAYOUT
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM set_layout .

ENDFORM.
*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
*& text
*&---------------------------------------------------------------------*
*& -->  p1        text
*& <--  p2        text
*&---------------------------------------------------------------------*
FORM  display_alv .
  CREATE OBJECT go_cust
    EXPORTING
      container_name              = 'CC_ALV'.
*    EXCEPTIONS
*      cntl_error                  = 1                " CNTL_ERROR
*      cntl_system_error           = 2                " CNTL_SYSTEM_ERROR
*      create_error                = 3                " CREATE_ERROR
*      lifetime_error              = 4                " LIFETIME_ERROR
*      lifetime_dynpro_dynpro_link = 5                " LIFETIME_DYNPRO_DYNPRO_LINK
*      OTHERS                      = 6.
*  IF sy-subrc <> 0.
** MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
**   WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
*  ENDIF.

  CREATE OBJECT go_alv
    EXPORTING
      i_parent = go_cust.          " Abstract Container for GUI Controls


  CALL METHOD go_alv->set_table_for_first_display
    EXPORTING
      i_structure_name              = 'ZAS_S_BANKA1'             " Internal Output Table Structure Name
    CHANGING
      it_outtab                     = gt_banka1          " Output Table
    EXCEPTIONS
      invalid_parameter_combination = 1                " Wrong Parameter
      program_error                 = 2                " Program Errors
      too_many_lines                = 3                " Too many Rows in Ready for Input Grid
      OTHERS                        = 4.
  IF sy-subrc <> 0.
*   MESSAGE ID SY-MSGID TYPE SY-MSGTY NUMBER SY-MSGNO
*     WITH SY-MSGV1 SY-MSGV2 SY-MSGV3 SY-MSGV4.
  ENDIF.
ENDFORM.
