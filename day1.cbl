IDENTIFICATION DIVISION.
PROGRAM-ID. DAY1.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT DAY1DATA ASSIGN TO INPUT
    ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD DAY1DATA.
    01 ELF.
        02 CALORIES PIC 9(9).

WORKING-STORAGE SECTION.
01 WS-ELF.
    02 WS-CALORIES PIC 9(9).
77 WS-EOF PIC A(1).
77 WS-SUM PIC 9(9).
77 WS-BIGGEST PIC 9(9).


PROCEDURE DIVISION.
    SET WS-SUM TO 0
    OPEN INPUT DAY1DATA.
        PERFORM UNTIL WS-EOF='Y'
            READ DAY1DATA INTO WS-ELF
                AT END MOVE 'Y' TO WS-EOF
                NOT AT END
                    IF (WS-CALORIES EQUAL TO SPACE)
                        IF (WS-SUM > WS-BIGGEST)
                            MOVE WS-SUM TO WS-BIGGEST
                        END-IF
                        SET WS-SUM TO 0
                    ELSE
                        COMPUTE WS-SUM = WS-SUM + FUNCTION NUMVAL(WS-CALORIES)
                    END-IF
            END-READ
        END-PERFORM.

        IF (WS-SUM > WS-BIGGEST)
            MOVE WS-SUM TO WS-BIGGEST
        END-IF

        DISPLAY WS-BIGGEST
    CLOSE DAY1DATA.
    STOP RUN.

