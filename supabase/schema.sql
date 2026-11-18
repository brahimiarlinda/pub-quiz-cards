-- Pub Quiz Cards: one row of saved data per signed-in user.
-- Run once in Supabase: SQL Editor → New query → paste → Run.

create table if not exists public.user_data (
  user_id    uuid primary key references auth.users (id) on delete cascade,
  progress   jsonb not null default '{}'::jsonb,   -- {"music-12":"got","sport-3":"missed", ...}
  quiz       jsonb,                                -- last generated quiz (rounds of question ids)
  teams      jsonb not null default '[]'::jsonb,   -- [{"n":"Team name","s":3}, ...]
  used       jsonb not null default '[]'::jsonb,   -- question ids used in earlier quizzes
  updated_at timestamptz not null default now()
);

-- Row-level security: every user can only see and change their own row.
alter table public.user_data enable row level security;

drop policy if exists "Own row: read"   on public.user_data;
drop policy if exists "Own row: insert" on public.user_data;
drop policy if exists "Own row: update" on public.user_data;
drop policy if exists "Own row: delete" on public.user_data;

create policy "Own row: read"   on public.user_data for select using ((select auth.uid()) = user_id);
create policy "Own row: insert" on public.user_data for insert with check ((select auth.uid()) = user_id);
create policy "Own row: update" on public.user_data for update using ((select auth.uid()) = user_id) with check ((select auth.uid()) = user_id);
create policy "Own row: delete" on public.user_data for delete using ((select auth.uid()) = user_id);
