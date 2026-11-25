-- GarageBuild: criação das tabelas
-- "IF NOT EXISTS" permite rodar este arquivo várias vezes sem erro.

CREATE TABLE IF NOT EXISTS users (
  id            INTEGER PRIMARY KEY AUTOINCREMENT,
  name          TEXT NOT NULL,
  email         TEXT NOT NULL UNIQUE,
  password_hash TEXT NOT NULL,
  role          TEXT NOT NULL DEFAULT 'cliente' CHECK (role IN ('cliente', 'admin')),
  created_at    TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS parts (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  name       TEXT NOT NULL,
  category   TEXT NOT NULL CHECK (category IN ('Motor', 'Turbo', 'Injeção', 'Suspensão', 'Freios')),
  price      REAL NOT NULL CHECK (price > 0),
  stock      INTEGER NOT NULL DEFAULT 0 CHECK (stock >= 0),
  created_at TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS builds (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id    INTEGER NOT NULL,
  car_model  TEXT NOT NULL,
  engine     TEXT NOT NULL,
  goal       TEXT,
  status     TEXT NOT NULL DEFAULT 'planejando' CHECK (status IN ('planejando', 'em_montagem', 'concluido')),
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS build_parts (
  id         INTEGER PRIMARY KEY AUTOINCREMENT,
  build_id   INTEGER NOT NULL,
  part_id    INTEGER NOT NULL,
  quantity   INTEGER NOT NULL CHECK (quantity > 0),
  created_at TEXT NOT NULL DEFAULT (datetime('now')),
  FOREIGN KEY (build_id) REFERENCES builds (id) ON DELETE CASCADE,
  FOREIGN KEY (part_id)  REFERENCES parts (id)  ON DELETE RESTRICT,
  UNIQUE (build_id, part_id)
);