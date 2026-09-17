# AETHER Electronics

Source for the AETHER electronics storefront and business operations dashboard.

## What is here

- `/` — public storefront and local cart UI.
- `/app` — business dashboard for products, sales, expenses, customers, suppliers, warranties, and automations.
- `/api/data` and `/api/records` — dashboard API backed by Cloudflare D1.

## Current platform dependencies

This is a source export of the ChatGPT Sites version. **It is not yet ready for a working Render or Vercel deployment.**

- The project uses Vinext on Cloudflare Workers rather than a standard Next.js Node server. `npm run build` produces a Cloudflare Worker; `npm start` uses Wrangler locally.
- `db/index.ts` imports `cloudflare:workers` and expects a D1 binding named `DB`. The schema and migration are in `db/` and `drizzle/`. Data already stored in the live Sites database is **not** in this repository.
- `/app` and the dashboard APIs use `app/chatgpt-auth.ts` and dispatch-provided ChatGPT identity headers. A new host needs its own authentication and server-side authorization before the dashboard can be used. Do not replace this with a client-only password or trust user-supplied identity headers.
- The storefront currently contains sample products, category counts, prices, and marketing claims. The WhatsApp link is a placeholder (`2348000000000`); verify contact details and checkout before accepting orders.

For a standalone deployment, migrate the runtime, database and authentication together, then test product management, the cart, checkout, and the dashboard on the new host. The existing public Sites deployment remains separate.

## Local development

Requires Node.js >=22.13.0 and pnpm 11.25.0. Install with `corepack enable && pnpm install --frozen-lockfile`, then run `pnpm dev`. This starts Vinext with local mock authentication and a local D1 simulation. The local D1 schema may need the SQL in `drizzle/0000_gigantic_hardball.sql` applied before dashboard data operations work.

No production credentials or database contents are included.
