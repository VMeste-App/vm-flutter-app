CREATE TABLE
    IF NOT EXISTS core.event_participants (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        event_id INTEGER NOT NULL REFERENCES core.events (id) ON DELETE CASCADE,
        profile_id INTEGER NOT NULL REFERENCES core.profiles (id) ON DELETE CASCADE,
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        deleted_at TIMESTAMPTZ NULL,
        -- Уникальность: один пользователь может быть в событии только один раз
        UNIQUE (event_id, user_id)
    );