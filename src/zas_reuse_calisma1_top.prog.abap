*&---------------------------------------------------------------------*
*& Include          ZAS_REUSE_CALISMA1_TOP
*&---------------------------------------------------------------------*

*DATA: BEGIN OF gt_list OCCURS 0,
*        zzstudentname     LIKE zas_t_librarystd-zzstudentname,
*        zzstudentlastname LIKE zas_t_librarystd-zzstudentlastname,
*        zzdate            LIKE zas_t_librarystd-zzdate,
*        zzbookname        LIKE zas_t_lbrrybook-zzbookname,
*        zzpoint           LIKE zas_t_lbrrybook-zzpoint,
*      END OF gt_list.


TYPES: BEGIN OF gty_list,
         icon              type c,
         selkz             TYPE char1,
         zzstudentno       TYPE zas_de_stdntno,
         zzstudentname     TYPE zas_de_stdntname,
         zzstudentlastname TYPE zas_de_stdntlastname,
         zzbookname        TYPE zas_de_bookname,
         zzauthorname      TYPE zas_de_authorname,
         zzauthorlastname  TYPE zas_de_authorlastname,
         zzadate           TYPE zas_de_adate,
         zzvdate           TYPE zas_de_vdate,
         zzpoint           TYPE zas_de_point,
         line_color        TYPE char4,
       END OF gty_list.



DATA: gt_list TYPE TABLE OF gty_list,
      gs_list TYPE gty_list.

DATA: gt_fieldcatolog TYPE slis_t_fieldcat_alv,
      gs_fieldcatolog TYPE slis_fieldcat_alv.

DATA: gs_layout TYPE slis_layout_alv.

DATA: gt_events TYPE slis_t_event,
      gs_event  TYPE  slis_alv_event.


DATA: gt_exclude TYPE slis_t_extab,
      gs_exclude TYPE slis_extab.

DATA: gt_sort TYPE slis_t_sortinfo_alv,
      gs_sort TYPE slis_sortinfo_alv.

data: gt_filter TYPE slis_t_filter_alv,
      gs_filter TYPE slis_filter_alv.

DATA: gs_variant TYPE DISVARIANT.

DATA: gs_variant_get TYPE DISVARIANT,
      gv_exit        TYPE char1.

PARAMETERS: p_vari TYPE DISVARIANT-variant.
