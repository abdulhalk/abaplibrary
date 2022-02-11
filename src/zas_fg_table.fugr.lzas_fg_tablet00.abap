*---------------------------------------------------------------------*
*    view related data declarations
*---------------------------------------------------------------------*
*...processing: ZAS_T_BAKIM.....................................*
DATA:  BEGIN OF STATUS_ZAS_T_BAKIM                   .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAS_T_BAKIM                   .
CONTROLS: TCTRL_ZAS_T_BAKIM
            TYPE TABLEVIEW USING SCREEN '0001'.
*...processing: ZAS_T_BAKIM2....................................*
DATA:  BEGIN OF STATUS_ZAS_T_BAKIM2                  .   "state vector
         INCLUDE STRUCTURE VIMSTATUS.
DATA:  END OF STATUS_ZAS_T_BAKIM2                  .
CONTROLS: TCTRL_ZAS_T_BAKIM2
            TYPE TABLEVIEW USING SCREEN '0002'.
*.........table declarations:.................................*
TABLES: *ZAS_T_BAKIM                   .
TABLES: *ZAS_T_BAKIM2                  .
TABLES: ZAS_T_BAKIM                    .
TABLES: ZAS_T_BAKIM2                   .

* general table data declarations..............
  INCLUDE LSVIMTDT                                .
