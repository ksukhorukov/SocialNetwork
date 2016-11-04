CREATE TABLE activities_15 (
	CHECK ( created_at >= '2016-11-04 14:00:00' AND created_at <= '2016-11-04 15:00:00' )
) INHERITS (activities);
CREATE TABLE activities_16 (
	CHECK ( created_at >= '2016-11-04 15:00:00' AND created_at <= '2016-11-04 16:00:00' )
) INHERITS (activities);
CREATE TABLE activities_17 (
	CHECK ( created_at >= '2016-11-04 16:00:00' AND created_at <= '2016-11-04 17:00:00' )
) INHERITS (activities);
CREATE TABLE activities_18 (
	CHECK ( created_at >= '2016-11-04 17:00:00' )
) INHERITS (activities);

CREATE TABLE activities_1 (
	CHECK ( id % 5 = 0 )
) INHERITS (activities);
CREATE TABLE activities_2 (
	CHECK ( id % 5 = 1 )
) INHERITS (activities);
CREATE TABLE activities_3 (
	CHECK ( id % 5 = 2 )
) INHERITS (activities);
CREATE TABLE activities_4 (
	CHECK ( id % 5 = 3 )
) INHERITS (activities);
CREATE TABLE activities_5 (
	CHECK ( id % 5 = 4 )
) INHERITS (activities);

CREATE INDEX activities_1_id ON activities_1(id);
CREATE INDEX activities_2_id ON activities_2(id);
CREATE INDEX activities_3_id ON activities_3(id);
CREATE INDEX activities_4_id ON activities_4(id);
CREATE INDEX activities_5_id ON activities_5(id);



CREATE INDEX activities_15_created_at ON activities_15(created_at);
CREATE INDEX activities_16_created_at ON activities_16(created_at);
CREATE INDEX activities_17_created_at ON activities_17(created_at);
CREATE INDEX activities_18_created_at ON activities_18(created_at);

CREATE OR REPLACE FUNCTION my_activities_insert_trigger() RETURNS TRIGGER AS $my_activities$
	BEGIN
		IF ( NEW.created_at >=  TIMESTAMP '2016-11-04 14:00:00' AND  NEW.created_at <  TIMESTAMP '2016-11-04 15:00:00' ) THEN
			INSERT INTO activities_15 VALUES (NEW.*);
		ELSIF ( NEW.created_at >=  TIMESTAMP '2016-11-04 15:00:00' AND NEW.created_at <  TIMESTAMP '2016-11-04 16:00:00') THEN
			INSERT INTO activities_16 VALUES (NEW.*);
		ELSIF ( NEW.created_at >= TIMESTAMP '2016-11-04 16:00:00' AND  NEW.created_at <  TIMESTAMP '2016-11-04 17:00:00') THEN
			INSERT INTO activities_17 VALUES (NEW.*);
		ELSIF ( NEW.created_at >= TIMESTAMP '2016-11-04 17:00:00' ) THEN
			INSERT INTO activities_18 VALUES (NEW.*);
		ELSE
			RAISE EXCEPTION 'Date out of range';
		END IF;
		RETURN NULL;
	END;
$my_activities$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION my_activities_insert_trigger() RETURNS TRIGGER AS $my_activities$
	BEGIN
		IF ( NEW.id % 5 = 0 ) THEN
			INSERT INTO activities_1 VALUES (NEW.*);
		ELSIF ( NEW.id % 5 = 1) THEN
			INSERT INTO activities_2 VALUES (NEW.*);
		ELSIF ( NEW.id % 5 = 2) THEN
			INSERT INTO activities_3 VALUES (NEW.*);
		ELSIF ( NEW.id % 5 = 3 ) THEN
			INSERT INTO activities_4 VALUES (NEW.*);
		ELSIF ( NEW.id % 5 = 4 ) THEN
			INSERT INTO activities_5 VALUES (NEW.*);
		ELSE
			RAISE EXCEPTION 'ID out of range';
		END IF;
		RETURN NULL;
	END;
$my_activities$ LANGUAGE plpgsql;

CREATE TRIGGER insert_my_activities_trigger
	BEFORE INSERT ON activities 
	FOR EACH ROW EXECUTE PROCEDURE
	my_activities_insert_trigger();
