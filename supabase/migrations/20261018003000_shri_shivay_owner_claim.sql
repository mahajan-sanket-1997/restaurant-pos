create schema if not exists private;
create table if not exists private.restaurant_setup_claims (
  restaurant_id uuid primary key references public.restaurants(id) on delete cascade,
  code_hash text not null,
  used_at timestamptz
);
revoke all on schema private from public, anon, authenticated;
revoke all on private.restaurant_setup_claims from public, anon, authenticated;

-- The production claim hash is provisioned separately for the initial Shri Shivay setup.
create or replace function public.claim_restaurant_owner(claim_code text, owner_name text)
returns uuid
language plpgsql
security definer
set search_path = ''
as $$
declare
  actor_id uuid := (select auth.uid());
  target_restaurant uuid;
begin
  if actor_id is null then raise exception 'Sign in before claiming the restaurant'; end if;
  if exists (select 1 from public.profiles p where p.id = actor_id) then raise exception 'This account already has a restaurant profile'; end if;
  select c.restaurant_id into target_restaurant
  from private.restaurant_setup_claims c
  where c.code_hash = encode(extensions.digest(claim_code, 'sha256'), 'hex') and c.used_at is null
  for update;
  if target_restaurant is null then raise exception 'Setup code is invalid or already used'; end if;
  if exists (select 1 from public.profiles p where p.restaurant_id = target_restaurant and p.role = 'owner') then raise exception 'This restaurant already has an owner'; end if;
  insert into public.profiles (id, restaurant_id, full_name, role)
  values (actor_id, target_restaurant, coalesce(nullif(trim(owner_name), ''), 'Owner'), 'owner');
  update private.restaurant_setup_claims set used_at = now() where restaurant_id = target_restaurant;
  return target_restaurant;
end;
$$;
revoke all on function public.claim_restaurant_owner(text, text) from public, anon;
grant execute on function public.claim_restaurant_owner(text, text) to authenticated;
