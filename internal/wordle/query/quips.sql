-- name: GetQuipByScore :one
SELECT *
FROM quips
where score_value = $1
  and (not inside_joke or (inside_joke and inside_joke_server_id = $2))
ORDER BY random()
LIMIT 1;

-- name: GetQuipsByCreatedByAccount :many
SELECT *
FROM quips
where created_by_account = $1;

-- name: CreateQuipForScore :one
insert into quips (score_value, quip, inside_joke, inside_joke_server_id, created_by_account)
VALUES ($1, $2, $3, $4, $5) returning *;