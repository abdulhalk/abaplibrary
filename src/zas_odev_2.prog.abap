*&---------------------------------------------------------------------*
*& Report ZAS_ODEV_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zas_odev_2.

TABLES: zas_t_librarystd, zas_t_lbrrybook.

DATA: gt_stdnt TYPE TABLE OF zas_t_librarystd,
      gt_book  TYPE TABLE OF zas_t_lbrrybook,
      gt_authr TYPE TABLE OF zas_t_lbrryauthr,
      gt_proc  TYPE TABLE OF zas_t_lbrryprcs,

      gs_stdnt LIKE LINE OF gt_stdnt,
      gs_book  LIKE LINE OF gt_book,
      gs_authr LIKE LINE OF gt_authr,
      gs_proc  LIKE LINE OF gt_proc.


SELECTION-SCREEN BEGIN OF BLOCK chk_block WITH FRAME TITLE TEXT-000.

PARAMETERS: p_chk1 AS CHECKBOX USER-COMMAND c1,
            p_chk2 AS CHECKBOX USER-COMMAND c1,
            p_chk3 AS CHECKBOX USER-COMMAND c1,
            p_chk4 AS CHECKBOX USER-COMMAND c1.
SELECTION-SCREEN END OF BLOCK chk_block.


SELECTION-SCREEN BEGIN OF BLOCK student WITH FRAME TITLE TEXT-001.
PARAMETERS: p_stno   TYPE zas_t_librarystd-zzstudentno    MATCHCODE OBJECT zas_sh_stdno MODIF ID 000,
            p_stnm   TYPE zas_t_librarystd-zzstudentname                                MODIF ID 000,
            p_stlnm  TYPE zas_t_librarystd-zzstudentlastname                            MODIF ID 000,
            p_gender TYPE zas_t_librarystd-zzgender                                     MODIF ID 000,
            p_date   TYPE zas_t_librarystd-zzdate                                       MODIF ID 000,
            p_class  TYPE zas_t_librarystd-zzclass                                      MODIF ID 000,
            p_point  TYPE zas_t_librarystd-zzpoint                                      MODIF ID 000.

SELECTION-SCREEN END OF BLOCK student.


SELECTION-SCREEN BEGIN OF BLOCK book WITH FRAME TITLE TEXT-002.
PARAMETERS:
  p_bkno   TYPE zas_t_lbrrybook-zzbookno MATCHCODE OBJECT zas_sh_bookno MODIF ID 001,
  p_isbno  TYPE zas_t_lbrrybook-zzisbno                                 MODIF ID 001,
  p_booknm TYPE zas_t_lbrrybook-zzbookname                              MODIF ID 001,
  p_fautno TYPE zas_t_lbrrybook-zzauthorno                              MODIF ID 001,
  p_turno  TYPE zas_t_lbrrybook-zzturno  MATCHCODE OBJECT zas_sh_tur    MODIF ID 001,
  p_pgnmb  TYPE zas_t_lbrrybook-zzpagesnumber                           MODIF ID 001,
  p_bpoint TYPE zas_t_lbrrybook-zzpoint                                 MODIF ID 001.
SELECTION-SCREEN END OF BLOCK book.


SELECTION-SCREEN BEGIN OF BLOCK process WITH FRAME TITLE TEXT-003.
PARAMETERS: p_prcno TYPE zas_t_lbrryprcs-zzprocessno                                   MODIF ID 002,
            p_fstno TYPE zas_t_lbrryprcs-zzstudentno MATCHCODE OBJECT zas_sh_stdno     MODIF ID 002,
            p_fbkno TYPE zas_t_lbrryprcs-zzbookno    MATCHCODE OBJECT zas_sh_bookno    MODIF ID 002,
            p_adate TYPE zas_t_lbrryprcs-zzadate     MATCHCODE OBJECT zas_sh_date      MODIF ID 002,
            p_vdate TYPE zas_t_lbrryprcs-zzvdate     MATCHCODE OBJECT zas_sh_date      MODIF ID 002.
SELECTION-SCREEN END OF BLOCK process.


SELECTION-SCREEN BEGIN OF BLOCK author WITH FRAME TITLE TEXT-004.
PARAMETERS: p_autno  TYPE zas_t_lbrryauthr-zzauthorno     MATCHCODE OBJECT zas_sh_author MODIF ID 003,
            p_autnm  TYPE zas_t_lbrryauthr-zzauthorname                                  MODIF ID 003,
            p_autlnm TYPE zas_t_lbrryauthr-zzauthorlastname                              MODIF ID 003.
SELECTION-SCREEN END OF BLOCK author.


AT SELECTION-SCREEN OUTPUT.
  LOOP AT SCREEN.
    IF screen-group1 EQ '000'.
      IF p_chk1 EQ 'X'.
        screen-active = 1.
      ELSE.
        CLEAR: p_stno, p_stnm, p_stlnm, p_gender, p_date, p_class, p_point.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
    IF screen-group1 EQ '001'.
      IF p_chk2 EQ 'X'.
        screen-active = 1.
      ELSE.
        CLEAR: p_bkno,p_isbno, p_booknm, p_fautno, p_turno, p_pgnmb, p_bpoint.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
    IF screen-group1 EQ '002'.
      IF p_chk3 EQ 'X'.
        screen-active = 1.
      ELSE.
        CLEAR: p_prcno, p_fstno, p_fbkno, p_adate, p_vdate.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.

    ENDIF.
    IF screen-group1 EQ '003'.
      IF p_chk4 EQ 'X'.
        screen-active = 1.
      ELSE.
        CLEAR: p_autno, p_autnm, p_autlnm.
        screen-active = 0.
      ENDIF.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

AT SELECTION-SCREEN.
  PERFORM takestudents.
  PERFORM takebooks.
  PERFORM takeauthors.

START-OF-SELECTION.
  PERFORM studentadd.
  PERFORM process.
  PERFORM bookadd.

END-OF-SELECTION.


*  PERFORM authoradd.


FORM takestudents.
  SELECT SINGLE  * FROM zas_t_librarystd
    INTO CORRESPONDING FIELDS OF gs_stdnt
    WHERE zzstudentno = p_stno.
  IF sy-subrc EQ 0.
    p_stnm   = gs_stdnt-zzstudentname    .
    p_stlnm  = gs_stdnt-zzstudentlastname.
    p_gender = gs_stdnt-zzgender         .
    p_date   = gs_stdnt-zzdate           .
    p_class  = gs_stdnt-zzclass          .
    p_point  = gs_stdnt-zzpoint          .
  ENDIF.
ENDFORM.

FORM studentadd.
*  PERFORM functionstudentno.
  gs_stdnt-zzstudentno       = p_stno.
  gs_stdnt-zzstudentname     = p_stnm.
  gs_stdnt-zzstudentlastname = p_stlnm.
  gs_stdnt-zzgender          = p_gender.
  gs_stdnt-zzdate            = p_date.
  gs_stdnt-zzclass           = p_class.
  gs_stdnt-zzpoint           = p_point.
*  INSERT zas_t_librarystd FROM gs_stdnt.
  MODIFY zas_t_librarystd FROM gs_stdnt.
ENDFORM.

FORM takebooks.
  SELECT SINGLE * FROM zas_t_lbrrybook
     INTO CORRESPONDING FIELDS OF gs_book
    WHERE zzbookno = p_bkno.

*  READ TABLE gt_book INTO gs_book WITH KEY zzbookno = p_bkno.
  IF sy-subrc EQ 0.
    p_isbno = gs_book-zzisbno.
    p_booknm = gs_book-zzbookname.
    p_fautno = gs_book-zzauthorno.
    p_turno = gs_book-zzturno.
    p_pgnmb = gs_book-zzpagesnumber.
    p_bpoint = gs_book-zzpoint.
  ENDIF.
*  LOOP AT gt_book INTO gs_book WHERE zzbookno = p_bkno.
*  p_isbno = gs_book-zzisbno.
*  p_booknm = gs_book-zzbookname.
*  p_fautno = gs_book-zzauthorno.
*  p_turno = gs_book-zzturno.
*  p_pgnmb = gs_book-zzpagesnumber.
*  p_bpoint = gs_book-zzpoint.
*  ENDLOOP.
ENDFORM.

FORM bookadd.
  PERFORM functionbookno.
  gs_book-zzbookno = p_bkno.
  gs_book-zzisbno = p_isbno.
  gs_book-zzbookname = p_booknm.
  gs_book-zzauthorno = p_fautno.
  gs_book-zzturno = p_turno.
  gs_book-zzpagesnumber = p_pgnmb.
  gs_book-zzpoint = p_bpoint.
  INSERT zas_t_lbrrybook FROM gs_book.
ENDFORM.

FORM process.
  PERFORM functionprocessno.
  IF p_point > p_bpoint.
    gs_proc-zzprocessno = p_prcno.
    gs_proc-zzstudentno = p_fstno.
    gs_proc-zzbookno = p_fbkno.
    gs_proc-zzadate = p_adate.
    gs_proc-zzvdate = p_vdate.
*    SELECT COUNT(*) FROM zas_t_lbrryprcs
*      WHERE zzprocessno = p_prcno.
*    IF sy-subrc EQ 0.
*      UPDATE zas_t_lbrryprcs FROM gs_proc.
*    ELSE.
*      INSERT zas_t_lbrryprcs FROM gs_proc.
*    ENDIF.
  ELSEIF p_point < p_bpoint.
    MESSAGE TEXT-005 TYPE 'I'.
  ENDIF.
ENDFORM.

FORM takeauthors.
  SELECT * FROM zas_t_lbrryauthr APPENDING CORRESPONDING FIELDS OF TABLE gt_authr.
  LOOP AT gt_authr INTO gs_authr WHERE zzauthorno = p_autno.
    p_autnm = gs_authr-zzauthorname.
    p_autlnm = gs_authr-zzauthorlastname.
  ENDLOOP.
ENDFORM.

FORM authoradd.
  PERFORM functionauthorno.
  gs_authr-zzauthorno = p_autno.
  gs_authr-zzauthorname = p_autnm.
  gs_authr-zzauthorlastname = p_autlnm.
  INSERT zas_t_lbrryauthr FROM gs_authr.
ENDFORM.

FORM functionstudentno.
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '01'
      object      = 'ZAS_ENTRYR'
    IMPORTING
      number      = p_stno.
ENDFORM.

FORM functionbookno.
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '02'
      object      = 'ZAS_ENTRYR'
    IMPORTING
      number      = p_bkno.
ENDFORM.



FORM functionauthorno.
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '04'
      object      = 'ZAS_ENTRYR'
    IMPORTING
      number      = p_autno.
ENDFORM.

FORM functionprocessno.
  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr = '03'
      object      = 'ZAS_ENTRYR'
    IMPORTING
      number      = p_prcno.
ENDFORM.
