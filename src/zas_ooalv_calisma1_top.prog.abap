*&---------------------------------------------------------------------*
*& Include          ZAS_OOALV_CALISMA1_TOP
*&---------------------------------------------------------------------*

TYPE-POOLS icon.

TABLES: scarr.

DATA: go_alv  TYPE REF TO cl_gui_alv_grid,
      go_cont TYPE REF TO cl_gui_custom_container. "olusturdugum container ait obje tanımladık"

TYPES: BEGIN OF gty_scarr,
         icon     TYPE icon_d,
         carrid   TYPE s_carr_id,
         carrname TYPE s_carrname,
         currcode TYPE s_currcode,
         url      TYPE s_carrurl,
         cost     TYPE int4,
         location TYPE zas_de_location,
         seatl    TYPE zaz_de_seat,

*         mess        TYPE char200,
*         line_color  TYPE char4,
*         cell_color  TYPE lvc_t_scol,
       END OF gty_scarr.

DATA: gs_cell_color TYPE lvc_s_scol.
*DATA: gt_scarr TYPE TABLE OF scarr.
DATA : gt_scarr TYPE TABLE OF gty_scarr,
       gs_scarr TYPE gty_scarr.

DATA: gt_fieldcatalog TYPE lvc_t_fcat,
      gs_fieldcatalog TYPE lvc_s_fcat,
      d_text(40)      TYPE c.

DATA: gs_layout TYPE lvc_s_layo.

FIELD-SYMBOLS: <gfs_scarr> TYPE gty_scarr.
