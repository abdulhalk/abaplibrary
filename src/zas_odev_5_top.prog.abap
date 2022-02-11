*&---------------------------------------------------------------------*
*& Include          ZAS_ODEV_5_TOP
*&---------------------------------------------------------------------*

TABLES: t012, t012k, t001, bnka, t012t, skat, faglflext .

DATA: go_alv  TYPE REF TO cl_gui_custom_alv_grid,
      go_cust TYPE REF TO cl_gui_custom_container, "layoutta olusturdugum containerın objesi"
      go_cont1  TYPE REF TO cl_gui_container,
      go_cont2  TYPE REF TO cl_gui_container.


TYPES: BEGIN OF gty_banka1,

*         bukrs TYPE bukrs,
*         butxt TYPE butxt,
*         ktopl TYPE ktopl,
*         banks TYPE banks,
*         bankl TYPE bankl,
*         banka TYPE banka,
*         hbkid TYPE hbkid,
*         hktid TYPE hktid,
*         text1 TYPE t012t-text1,
*         waers TYPE waers,
*         spras TYPE spras,
*         saknr TYPE saknr,
*         hkont TYPE hkont,
*         txt50 TYPE skat-txt50,
*         tslxx TYPE tslxx,
*         hslxx TYPE hslxx,

         bukrs TYPE t001-bukrs,
         butxt TYPE t001-butxt,
         hbkid TYPE t012-hbkid,
         hktid TYPE t012k-hktid,
         banks TYPE t012-banks,
         bankl TYPE t012-bankl,
         banka TYPE bnka-banka,
         hkont TYPE t012k-hkont,
         waers TYPE t012k-waers,
         txt50 TYPE skat-txt50,
         text1 TYPE t012t-text1,
         tslvt TYPE faglflext-tslvt,
         hslvt TYPE faglflext-hslvt,

       END OF gty_banka1.

DATA: gt_banka1 TYPE TABLE OF gty_banka1,
      gs_banka1 TYPE gty_banka1.

DATA: gt_fieldcatalog TYPE lvc_t_fcat,
      gs_fieldcatalog TYPE lvc_s_fcat,
      d_text(40)      TYPE c.

FIELD-SYMBOLS: <gfs_banka1> TYPE gty_banka1.


DATA: x_period LIKE t009b-poper,
      x_year   LIKE t009b-bdatj.
