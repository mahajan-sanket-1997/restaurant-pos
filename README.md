# Restaurant POS — Shri Shivay

Responsive multi-device restaurant POS built with Next.js, TypeScript, Supabase and Vercel.

## Current state
- Removed fictional menu items, occupied tables, sample orders, and sample sales figures.
- Configured the `Shri Shivay` restaurant record in Supabase (`INR`, `Asia/Kolkata`).
- Added owner sign-in / sign-up and one-time restaurant claim flow.
- Added live table setup and menu-item creation, scoped to the signed-in restaurant.
- Kitchen order submission, real billing/payments, staff attendance, expenses and reporting are not implemented yet.

## Environment
Set `NEXT_PUBLIC_SUPABASE_URL` and `NEXT_PUBLIC_SUPABASE_ANON_KEY` to the Supabase project URL and publishable/anon key. These are public client values; never expose a service-role key in the browser.

## Run locally
```bash
npm install
npm run dev
```

## Database
Initial schema: `supabase/migrations/20261018000000_initial_restaurant_pos_schema.sql`.
Owner claim flow: `supabase/migrations/20261018003000_shri_shivay_owner_claim.sql`.

The owner claim code is a one-time bootstrap secret and must only be used by the restaurant owner. It is stored as a hash in the private schema and becomes invalid after first use. Don't commit the plaintext code to GitHub.

## Next
1. Confirm the Vercel deployment and configure environment variables.
2. Verify owner sign-in and create the initial table layout and menu.
3. Add saved orders and Supabase Realtime kitchen updates.
4. Add transactional bills, payment records, expenses, attendance and reporting.
5. Run security, concurrency and backup tests before live service.
