CREATE TABLE
    IF NOT EXISTS core.profiles (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        user_id UUID REFERENCES auth.users (id) NOT NULL,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        birth_date DATE NULL,
        height INTEGER NULL,
        weight INTEGER NULL,
        sex INTEGER NULL,
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        deleted_at TIMESTAMPTZ NULL
    );