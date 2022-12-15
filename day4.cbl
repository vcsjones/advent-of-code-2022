IDENTIFICATION DIVISION. *> Compile and run with cobc -std=cobol2014 --free -x day4.cbl && ./day4
PROGRAM-ID. DAY4.

ENVIRONMENT DIVISION.
INPUT-OUTPUT SECTION.
FILE-CONTROL.
    SELECT DAY4DATA ASSIGN TO INPUT
    ORGANIZATION IS LINE SEQUENTIAL.

DATA DIVISION.
FILE SECTION.
FD DAY4DATA.
    01 PAIRS PIC X(20).

WORKING-STORAGE SECTION.
77 WS-EOF PIC A(1).
01 WS-SECTION-PAIR1-1 PIC 9(2).
01 WS-SECTION-PAIR1-2 PIC 9(2).
01 WS-SECTION-PAIR2-1 PIC 9(2).
01 WS-SECTION-PAIR2-2 PIC 9(2).
01 WS-PART1 PIC 9(4).
01 WS-PART2 PIC 9(4).
01 WS-PAIRS PIC X(20).

PROCEDURE DIVISION.
MAIN-PARA.
    OPEN INPUT DAY4DATA.
        PERFORM UNTIL WS-EOF='Y'
            READ DAY4DATA INTO WS-PAIRS
                AT END MOVE 'Y' TO WS-EOF
                NOT AT END

                UNSTRING WS-PAIRS DELIMITED BY ',' OR '-' INTO WS-SECTION-PAIR1-1 WS-SECTION-PAIR1-2 WS-SECTION-PAIR2-1 WS-SECTION-PAIR2-2

                IF (WS-SECTION-PAIR1-1 <= WS-SECTION-PAIR2-1 AND WS-SECTION-PAIR1-2 >= WS-SECTION-PAIR2-2)
                OR (WS-SECTION-PAIR2-1 <= WS-SECTION-PAIR1-1 AND WS-SECTION-PAIR2-2 >= WS-SECTION-PAIR1-2)
                    ADD 1 TO WS-PART1
                END-IF

                IF (WS-SECTION-PAIR1-1 >= WS-SECTION-PAIR2-1 AND WS-SECTION-PAIR1-1 <= WS-SECTION-PAIR2-2)
                OR (WS-SECTION-PAIR1-2 >= WS-SECTION-PAIR2-1 AND WS-SECTION-PAIR1-1 <= WS-SECTION-PAIR2-2)
                    ADD 1 TO WS-PART2
                END-IF
            END-READ
        END-PERFORM.
    CLOSE DAY4DATA.

    DISPLAY 'PART 1: ' WS-PART1
    DISPLAY 'PART 2: ' WS-PART2
    STOP RUN.
