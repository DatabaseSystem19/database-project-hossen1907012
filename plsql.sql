-- ()


-- Count number of movies of every publisher - Using ARRAY, WHILE LOOP, FOR LOOP, ROWTYPE and CURSOR

SET serveroutput ON;
DECLARE
    TYPE REFETYPE IS VARRAY(5) OF NUMBER(5); 
    movie_counts REFETYPE := REFETYPE(0,0,0,0,0);

    CURSOR movie_curosr IS SELECT * FROM movie;
    movie_row movie%ROWTYPE;

BEGIN

    OPEN movie_curosr;
    FETCH movie_curosr INTO movie_row;

    WHILE movie_curosr%found LOOP
        movie_counts(movie_row.publisher) := movie_counts(movie_row.publisher) + 1;
        FETCH movie_curosr INTO movie_row;
    END LOOP;


    FOR ind IN 1 .. 5 LOOP
        dbms_output.put_line('Publisher: ' || ind || ' Movie count: ' || movie_counts(ind));
    END LOOP;
    
    CLOSE movie_curosr;
END;
/



-- Publisher with more that 3 movies - WHILE LOOP, CURSOR,  FOR LOOP, ARRAY, ROWTYPE

SET serveroutput ON;
DECLARE
    TYPE REFETYPE IS VARRAY(5) OF NUMBER(5); 
    movie_counts REFETYPE := REFETYPE(0,0,0,0,0);

    CURSOR movie_curosr IS SELECT * FROM movie;
    movie_row movie%ROWTYPE;

BEGIN

    OPEN movie_curosr;
    FETCH movie_curosr INTO movie_row;

    WHILE movie_curosr%found LOOP
        movie_counts(movie_row.publisher) := movie_counts(movie_row.publisher) + 1;
        FETCH movie_curosr INTO movie_row;
    END LOOP;


    FOR ind IN 1 .. 5 LOOP
        IF movie_counts(ind) > 3 THEN
            dbms_output.put_line('Publisher: ' || ind || ' Movie count: ' || movie_counts(ind));
        END IF;
    END LOOP;
    
    CLOSE movie_curosr;
END;
/



-- Top 5 paying users - WHILE, CURSOR

SET serveroutput ON;
DECLARE
    counter NUMBER := 0;
    CURSOR summed_pay_cursor IS WITH temptable(user_id, sum_amount) AS (SELECT user_id, sum(amount) FROM payment GROUP BY user_id) SELECT * FROM temptable ORDER BY sum_amount DESC;
    usr_id NUMBER(10);
    sum_amount NUMBER(10);
    ufname VARCHAR(50);

BEGIN
    dbms_output.put_line('Five Highest paid user: ');
    OPEN summed_pay_cursor;
    FETCH summed_pay_cursor INTO usr_id, sum_amount;
    WHILE summed_pay_cursor%found LOOP
        IF counter > 5 THEN
            EXIT;
        END IF;
        
        SELECT fullname INTO ufname FROM users WHERE id=usr_id;
        dbms_output.put_line(ufname || ' -> USD '||sum_amount);
        FETCH summed_pay_cursor INTO usr_id, sum_amount;
        counter:= counter + 1;        
    END LOOP;
END;
/



-- publisher name to their viewer's name - FUNCTION, WHLE LOOP, CURSOR, 
SET serveroutput ON;

CREATE OR REPLACE FUNCTION publisher_viewer(pubname IN VARCHAR) RETURN NUMBER AS 
    CURSOR movie_cursor IS SELECT * FROM movie WHERE publisher = (SELECT id FROM publisher WHERE fullname = pubname);
    movie_row movie%rowtype;
    watch_row watch_history%rowtype;

    ufname users.username%type;
    user_id users.id%type;

BEGIN

    dbms_output.put_line('Users who watched ' || pubname);

    OPEN movie_cursor;
    FETCH movie_cursor INTO movie_row;

    WHILE movie_cursor%found LOOP
        CURSOR watch_cursor IS SELECT user_id FROM watch_history WHERE mid=movie_row.id;
        OPEN watch_cursor;
        FETCH watch_cursor into watch_row;
            WHILE watch_cursor%found LOOP
                SELECT user_id 
                dbms_output.put_line(ufname);
            END LOOP;


        FETCH movie_cursor INTO movie_row;
    END LOOP;
    
    CLOSE movie_cursor;

    RETURN 0;
END;
/





-- --------------- MAIN



DECLARE
    result NUMBER;
BEGIN
    result := publisher_viewer('Warner Bros.');
END;
/

SHOW ERRORS FUNCTION publisher_viewer;
