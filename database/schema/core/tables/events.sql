CREATE TABLE
    IF NOT EXISTS core.events (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        activity_id INTEGER REFERENCES core.activities (id) NOT NULL,
        skill_id INTEGER REFERENCES core.skills (id) NOT NULL,
        creator_id INTEGER REFERENCES core.profiles (id) NOT NULL,
        min_players INTEGER NULL CHECK (
            min_players IS NULL
            OR min_players >= 1
        ),
        max_players INTEGER NULL CHECK (
            max_players IS NULL
            OR max_players >= COALESCE(min_players, 1)
        ),
        price INTEGER NULL CHECK (
            price IS NULL
            OR price >= 0
        ),
        date TIMESTAMPTZ NOT NULL CHECK (date > CURRENT_TIMESTAMP),
        duration INTEGER NOT NULL CHECK (
            duration > 0
            AND duration <= 1440
        ),
        description TEXT NULL,
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        deleted_at TIMESTAMPTZ NULL,
        -- Локация (временно закомментирована)
        -- location_id INTEGER REFERENCES core.locations(id),
        -- address TEXT,
        -- latitude DECIMAL(10, 8),
        -- longitude DECIMAL(11, 8)
    );