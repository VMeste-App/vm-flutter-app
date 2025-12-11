CREATE SCHEMA IF NOT EXISTS core;

CREATE TABLE
    IF NOT EXISTS core.activities (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(100) NOT NULL UNIQUE,
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        deleted_at TIMESTAMPTZ NULL
    );

INSERT INTO core.activities (name) VALUES
    ('Бег'),
    ('Плавание'),
    ('Велоспорт'),
    ('Йога'),
    ('Тяжелая атлетика'),
    ('Пеший туризм'),
    ('Баскетбол'),
    ('Танцы'),
    ('Медитация'),
    ('Скалолазание'),
    ('Теннис'),
    ('Футбол');

select * from core.activities;

CREATE TABLE
    IF NOT EXISTS core.skills (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        name VARCHAR(100) NOT NULL UNIQUE,
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        deleted_at TIMESTAMPTZ NULL
    );

INSERT INTO core.skills (name) VALUES
    ('Начинающий'),
    ('Средний'),
    ('Продвинутый'),
    ('Профессионал');

-- select * from core.skills;

CREATE TABLE
    IF NOT EXISTS core.profiles (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        user_id UUID REFERENCES auth.users(id) NOT NULL,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        birth_date DATE NULL,
        height INTEGER NULL,
        weight INTEGER NULL,
        sex INTEGER NULL, -- 0 = male, 1 = female
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        deleted_at TIMESTAMPTZ NULL
    );

INSERT INTO core.profiles 
    (user_id, first_name, last_name, birth_date, height, weight, sex) 
VALUES 
    ('ad25279b-b41b-41eb-a6a8-7c502a1df940', 'Григорий', 'Данилов', '2001-01-08', 180, 78, 0);

-- select * from core.profiles;

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
        deleted_at TIMESTAMPTZ NULL
    );

INSERT INTO core.events 
    (name, activity_id, skill_id, creator_id, 
     min_players, max_players, price, date, duration, description)
VALUES
    -- Событие 1: Баскетбол для начинающих
    (
        'Вечерний баскетбол в парке Горького',
        7,
        1,
        1,
        6,
        12,
        500, -- 500 рублей
        CURRENT_TIMESTAMP + INTERVAL '2 days 19:00:00', -- Послезавтра в 19:00
        120, -- 2 часа
        'Собираемся для неспешной игры в баскетбол. Приносите свою воду и хорошее настроение!'
    ),
    
    -- Событие 2: Футбол для среднего уровня
    (
        'Футбольный матч на стадионе "Локомотив"',
        12,
        2,
        1, 
        10,
        22,
        1000, 
        CURRENT_TIMESTAMP + INTERVAL '5 days 18:30:00', -- Через 5 дней в 18:30
        90, -- 1.5 часа
        'Организованный матч 5х5. Форма любого цвета. Аренда поля включена в стоимость.'
    ),
    
    -- Событие 3: Теннис для продвинутых
    (
        'Теннисный турнир среди любителей',
        11,
        3,
        1, -- creator_id
        2,
        8,
        1500, -- 1500 рублей
        CURRENT_TIMESTAMP + INTERVAL '7 days 10:00:00', -- Через неделю в 10:00
        180, -- 3 часа
        'Мини-турнир по теннису. Призы для победителей. С собой ракетки и мячи.'
    )

select * from core.events;

CREATE TABLE
    IF NOT EXISTS core.event_participants (
        id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
        event_id INTEGER NOT NULL REFERENCES core.events (id) ON DELETE CASCADE,
        profile_id INTEGER NOT NULL REFERENCES core.profiles (id) ON DELETE CASCADE,
        created_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        updated_at TIMESTAMPTZ DEFAULT CURRENT_TIMESTAMP NOT NULL,
        deleted_at TIMESTAMPTZ NULL,
        UNIQUE (event_id, profile_id)
    );

INSERT INTO core.event_participants (event_id, profile_id)
VALUES
    (4, 1)
    (5, 1),
    (6, 1);

select * from core.event_participants 
    where event_id = 4;

GRANT USAGE ON SCHEMA core TO anon;
GRANT USAGE ON SCHEMA core TO authenticated;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA core TO authenticated;

SELECT 
    nspname AS schema_name,
    nspowner::regrole AS owner,
    nspacl AS privileges
FROM pg_namespace 
WHERE nspname = 'core';