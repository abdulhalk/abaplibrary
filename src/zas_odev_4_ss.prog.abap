*&---------------------------------------------------------------------*
*& Include          ZAS_ODEV_4_SS
*&---------------------------------------------------------------------*

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-000.

PARAMETERS: srktkod  TYPE bkpf-bukrs OBLIGATORY DEFAULT 1101,
            malisene TYPE bseg-gjahr OBLIGATORY DEFAULT '2019'.
SELECT-OPTIONS: so_donem FOR bkpf-monat,
                so_stc FOR bseg-lifnr.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN PUSHBUTTON 1(25) p_but1 USER-COMMAND but1.
SELECTION-SCREEN PUSHBUTTON 30(25) p_but2 USER-COMMAND but2.

SELECTION-SCREEN END OF BLOCK b2.


AT SELECTION-SCREEN.
  CASE sscrfields.
    WHEN 'BUT1'.
      CALL FUNCTION 'VIEW_MAINTENANCE_CALL'
        EXPORTING
          action    = 'S'
          view_name = 'ZAS_T_BAKIM2'.
    WHEN 'BUT2'.
      CALL FUNCTION 'VIEW_MAINTENANCE_CALL'
        EXPORTING
          action    = 'U'
          view_name = 'ZAS_T_BAKIM2'.
  ENDCASE.

AT SELECTION-SCREEN OUTPUT.
  CONCATENATE icon_display 'Tabloyu Görüntüle' INTO p_but1 SEPARATED BY space.
  CONCATENATE icon_change 'Tabloyu Değiştir' INTO p_but2 SEPARATED BY space.
