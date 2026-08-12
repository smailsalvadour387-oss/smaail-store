-- SMAAIL STORE: Supabase database
create extension if not exists pgcrypto;

create table if not exists public.products (
  id uuid primary key default gen_random_uuid(),
  name_ar text not null,
  name_fr text not null,
  price numeric(10,2) not null check (price >= 0),
  image_url text,
  description text default '',
  active boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists public.orders (
  id uuid primary key default gen_random_uuid(),
  customer_name text not null,
  phone text not null,
  city text not null,
  address text not null,
  note text default '',
  items jsonb not null,
  total numeric(10,2) not null check (total >= 0),
  status text not null default 'new' check (status in ('new','confirmed','shipped','delivered','cancelled')),
  created_at timestamptz not null default now()
);

create table if not exists public.admin_users (
  user_id uuid primary key references auth.users(id) on delete cascade
);

alter table public.products enable row level security;
alter table public.orders enable row level security;
alter table public.admin_users enable row level security;

drop policy if exists "public read active products" on public.products;
create policy "public read active products" on public.products for select to anon, authenticated using (active = true or exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

drop policy if exists "admins insert products" on public.products;
create policy "admins insert products" on public.products for insert to authenticated with check (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

drop policy if exists "admins update products" on public.products;
create policy "admins update products" on public.products for update to authenticated using (exists (select 1 from public.admin_users a where a.user_id = auth.uid())) with check (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

drop policy if exists "admins delete products" on public.products;
create policy "admins delete products" on public.products for delete to authenticated using (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

drop policy if exists "public create orders" on public.orders;
create policy "public create orders" on public.orders for insert to anon, authenticated with check (true);

drop policy if exists "admins read orders" on public.orders;
create policy "admins read orders" on public.orders for select to authenticated using (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

drop policy if exists "admins update orders" on public.orders;
create policy "admins update orders" on public.orders for update to authenticated using (exists (select 1 from public.admin_users a where a.user_id = auth.uid())) with check (exists (select 1 from public.admin_users a where a.user_id = auth.uid()));

drop policy if exists "admins read admin users" on public.admin_users;
create policy "admins read admin users" on public.admin_users for select to authenticated using (user_id = auth.uid());
