*&---------------------------------------------------------------------*
*& Report ZAS_MODALBOX_SCREEN1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZAS_MODALBOX_SCREEN1.


START-OF-SELECTION.

CALL SCREEN 0100 STARTING AT 10 10
                  ENDING AT  50 20.

*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
MODULE status_0100 OUTPUT.
 SET PF-STATUS '0100  '.
* SET TITLEBAR 'xxx'.
ENDMODULE.
*&---------------------------------------------------------------------*
*&      Module  USER_COMMAND_0100  INPUT
*&---------------------------------------------------------------------*
*       text
*----------------------------------------------------------------------*
MODULE user_command_0100 INPUT.
  CASE sy-ucomm.
    WHEN '&CANCEL'.
      LEAVE TO SCREEN 0.
  ENDCASE.

ENDMODULE.