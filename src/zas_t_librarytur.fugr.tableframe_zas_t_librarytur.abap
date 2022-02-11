*---------------------------------------------------------------------*
*    program for:   TABLEFRAME_ZAS_T_LIBRARYTUR
*   generation date: 14.01.2022 at 10:14:12
*   view maintenance generator version: #001407#
*---------------------------------------------------------------------*
FUNCTION TABLEFRAME_ZAS_T_LIBRARYTUR   .

  PERFORM TABLEFRAME TABLES X_HEADER X_NAMTAB DBA_SELLIST DPL_SELLIST
                            EXCL_CUA_FUNCT
                     USING  CORR_NUMBER VIEW_ACTION VIEW_NAME.

ENDFUNCTION.
