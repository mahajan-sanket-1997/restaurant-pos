revoke all on function public.is_restaurant_member(uuid) from public, anon;
grant execute on function public.is_restaurant_member(uuid) to authenticated;
revoke all on function public.current_restaurant_role() from public, anon;
grant execute on function public.current_restaurant_role() to authenticated;
