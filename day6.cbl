 IDENTIFICATION DIVISION. *> Compile and run with cobc -std=cobol2014 --free -x day6.cbl && ./day6
PROGRAM-ID. DAY6.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT DAY6DATA ASSIGN TO INPUT
    ORGANIZATION IS SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD DAY6DATA.
01 MSG PIC X(4096).

WORKING-STORAGE SECTION.
77 WS-EOF PIC A(1).
01 WS-BLOCK PIC X(14).
01 WS-PART-LEN PIC 9(9).
01 WS-POS PIC 9(9).
01 WS-POS-RESULT PIC 9(9).
01 WS-TALLY PIC 9(9).
01 WS-TALLY-POS PIC 9(9).

PROCEDURE DIVISION.
MAIN-PARA.
    OPEN INPUT DAY6DATA.
        READ DAY6DATA.

        MOVE 4 TO WS-PART-LEN
        PERFORM DISTINCT-PARA
        DISPLAY WS-POS-RESULT

        MOVE 14 TO WS-PART-LEN
        PERFORM DISTINCT-PARA
        DISPLAY WS-POS-RESULT
    CLOSE DAY6DATA.

    STOP RUN.
COUNTER-PARA.
DISTINCT-PARA.
    MOVE 1 TO WS-POS
    MOVE ZERO TO WS-POS-RESULT

    PERFORM UNTIL WS-POS > LENGTH OF MSG - WS-PART-LEN + 1 OR WS-POS-RESULT > 0
        MOVE ZERO TO WS-TALLY
        MOVE 1 TO WS-TALLY-POS
        MOVE MSG(WS-POS:WS-PART-LEN) TO WS-BLOCK

        PERFORM UNTIL WS-TALLY-POS > WS-PART-LEN
            INSPECT WS-BLOCK TALLYING WS-TALLY FOR ALL WS-BLOCK(WS-TALLY-POS:1)
            ADD 1 TO WS-TALLY-POS
        END-PERFORM

        IF (WS-TALLY = WS-PART-LEN)
            COMPUTE WS-POS-RESULT = WS-POS + WS-PART-LEN - 1
        END-IF

        ADD 1 TO WS-POS
    END-PERFORM.
