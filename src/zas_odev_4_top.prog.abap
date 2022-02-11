*&---------------------------------------------------------------------*
*& Include          ZAS_ODEV_4_TOP
*&---------------------------------------------------------------------*


DATA: BEGIN OF gt_list OCCURS 0,

        selkz       TYPE char1,
        belgekalemi LIKE bseg-buzei,
        sirketno    LIKE bkpf-bukrs,
        maliyil     LIKE bkpf-gjahr,
        donem       LIKE bkpf-monat,
        belgeno     LIKE bkpf-belnr,
        satici      LIKE bseg-lifnr,
        iskonto     LIKE zas_t_bakim2-isko,
        ilktutar    LIKE bseg-wrbtr,
        tutar       LIKE bseg-wrbtr,

      END OF gt_list.


DATA: BEGIN OF gt_list2 OCCURS 0,

        sirketno    LIKE bkpf-bukrs,
        maliyil     LIKE bkpf-gjahr,
        belgeno     LIKE bkpf-belnr,
        belgekalemi LIKE bseg-buzei,
        kalemmetni  LIKE bseg-sgtxt,
        isalani     LIKE bseg-gsber,
        borcalacak  LIKE bseg-shkzg,
        ilktutar    LIKE bseg-wrbtr,
        tutar       LIKE bseg-wrbtr,
      END OF gt_list2.


DATA:gs_list LIKE LINE OF gt_list.

DATA: gs_list2 LIKE LINE OF gt_list2.

DATA: gt_baslik type standard table of zas_s_baslik,
      gs_baslik TYPE  zas_s_baslik.

DATA: gt_kalem TYPE  zas_tt_kalem,
      gs_kalem TYPE  zas_s_kalem.

DATA: gt_iskonto TYPE TABLE OF zas_t_bakim2,
      gs_iskonto LIKE LINE OF gt_iskonto.


DATA: gt_fieldcatalog TYPE slis_t_fieldcat_alv,
      l_fcat          TYPE LINE OF slis_t_fieldcat_alv,
      gs_fieldcatalog TYPE slis_fieldcat_alv,
      d_text(40)      TYPE c.

DATA: gt_fieldcatalog2 TYPE slis_t_fieldcat_alv,
      l_fcat2          TYPE LINE OF slis_t_fieldcat_alv,
      gs_fieldcatalog2 TYPE slis_fieldcat_alv,
      d_text2(40)      TYPE c.



DATA: gs_layout TYPE  slis_layout_alv.
DATA: gs_layout2 TYPE  slis_layout_alv.
