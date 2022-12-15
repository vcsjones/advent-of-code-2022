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
01 WS-TOP.
   05 WS-BIGGEST PIC 9(9) OCCURS 3 TIMES.


PROCEDURE DIVISION.
    MOVE ZEROES TO WS-TOP
    MOVE 0 TO WS-SUM
    OPEN INPUT DAY1DATA.
        PERFORM UNTIL WS-EOF='Y'
            READ DAY1DATA INTO WS-ELF
                AT END MOVE 'Y' TO WS-EOF
                NOT AT END
                    IF (WS-CALORIES EQUAL TO SPACE)
                        IF (WS-SUM > WS-BIGGEST(1))
                            MOVE WS-BIGGEST(2) TO WS-BIGGEST(3)
                            MOVE WS-BIGGEST(1) TO WS-BIGGEST(2)
                            MOVE WS-SUM TO WS-BIGGEST(1)
                        ELSE
                            IF (WS-SUM > WS-BIGGEST(2))
                                MOVE WS-BIGGEST(2) TO WS-BIGGEST(3)
                                MOVE WS-SUM TO WS-BIGGEST(2)
                            ELSE
                                IF (WS-SUM > WS-BIGGEST(3))
                                    MOVE WS-SUM TO WS-BIGGEST(3)
                                END-IF
                            END-IF
                        END-IF

                        SET WS-SUM TO 0
                    ELSE
                        COMPUTE WS-SUM = WS-SUM + FUNCTION NUMVAL(WS-CALORIES)
                    END-IF
            END-READ
        END-PERFORM.

        IF (WS-SUM > WS-BIGGEST(1))
            MOVE WS-BIGGEST(2) TO WS-BIGGEST(3)
            MOVE WS-BIGGEST(1) TO WS-BIGGEST(2)
            MOVE WS-SUM TO WS-BIGGEST(1)
        ELSE
            IF (WS-SUM > WS-BIGGEST(2))
                MOVE WS-BIGGEST(2) TO WS-BIGGEST(3)
                MOVE WS-SUM TO WS-BIGGEST(2)
            ELSE
                IF (WS-SUM > WS-BIGGEST(3))
                    MOVE WS-SUM TO WS-BIGGEST(3)
                END-IF
            END-IF
        END-IF

        DISPLAY 'PART 1: ' WS-BIGGEST(1)
        DISPLAY 'PART 2: ' FUNCTION SUM (WS-BIGGEST(1) WS-BIGGEST(2) WS-BIGGEST(3))
    CLOSE DAY1DATA.
    STOP RUN.

