local sqlitelib = require("sqlitelib")

local db = sqlitelib.Sqlite(":memory:")

db:execute("CREATE TABLE users (id INTEGER PRIMARY KEY, name TEXT, score REAL)")
db:execute("INSERT INTO users VALUES (1, 'Eh', 9.5)")

local names = db:execute_string("SELECT name FROM users")
for i = 0, names:size() - 1 do
	print(names[i])
end
