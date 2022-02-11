*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZAS_T_LIBRARYTUR................................*
DATA:  BEGIN OF STATUS_ZAS_T_LIBRARYTUR              .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAS_T_LIBRARYTUR              .
CONTROLS: TCTRL_ZAS_T_LIBRARYTUR
            TYPE TABLEVIEW USING SCREEN '0001'.
*.........table declarations:.................................*
TABLES: *ZAS_T_LIBRARYTUR              .
TABLES: ZAS_T_LIBRARYTUR               .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
