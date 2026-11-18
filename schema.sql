create table public.routes (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  name text not null check (char_length(name) between 1 and 80),
  submitter text not null check (char_length(submitter) between 1 and 40),
  terrain text not null check (terrain in ('Road','Trail','Gravel','Track','Mixed')),
  pts jsonb not null check (jsonb_typeof(pts) = 'array' and jsonb_array_length(pts) between 2 and 1000),
  created_at timestamptz not null default now()
);
alter table public.routes enable row level security;
grant select on public.routes to anon, authenticated;
grant insert, delete on public.routes to authenticated;
create policy "anyone can view" on public.routes for select using (true);
create policy "signed-in users add their own" on public.routes for insert to authenticated with check (auth.uid() = user_id);
create policy "owners delete their own" on public.routes for delete to authenticated using (auth.uid() = user_id);
