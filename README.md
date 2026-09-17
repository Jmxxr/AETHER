# AETHER Electronics

A public electronics storefront (`/`) and a private business dashboard (`/app`) built with Vinext on Cloudflare Workers. Dashboard records live in Cloudflare D1.

## Migration status

The project is configured for the new `aether-production` D1 database in `wrangler.jsonc`. The dashboard and its API now require a **verified Cloudflare Access JWT** and an email on `ADMIN_EMAILS`. Missing or invalid configuration denies access. The public storefront does not require a login.

The new D1 database is separate from the database at the existing ChatGPT Sites deployment. Its existing customer, sales, and supplier records are **not** in this public repository. Keep the old site online until those records are migrated and checked.

## Configure before deployment

1. In Cloudflare Zero Trust, create an Access self-hosted application for the final AETHER domain, with policies covering `/app*` and `/api/*`. Allow only the intended administrators. Cloudflare Access must protect those routes at the edge as well as the JWT verification in the app.
2. Set these Worker variables in Cloudflare (never commit credentials or personal data):
   - `ACCESS_TEAM_DOMAIN`: your full team domain, such as `team.cloudflareaccess.com`.
   - `ACCESS_AUD`: the Access application's application audience (AUD) tag.
   - `ADMIN_EMAILS`: comma-separated email addresses permitted to use the dashboard.
3. Bind D1 as `DB`. The database ID is already in `wrangler.jsonc`. Apply `drizzle/0000_gigantic_hardball.sql` to the empty D1 database once, then separately migrate the existing data after checking the schema and row counts.
4. Install with `corepack pnpm install --frozen-lockfile` and build with `corepack pnpm build`. Deploy the built Worker to your Cloudflare account only after Access and D1 are configured.

The `wrangler.jsonc` file uses the D1 ID supplied for AETHER. Set `CLOUDFLARE_ACCOUNT_ID` in your own environment when deploying; do not place an API token in this repository. Production deployment and data migration have not yet been performed.

## Storefront launch checks

The public storefront currently has sample products, prices, category counts, and marketing claims. The WhatsApp number (`2348000000000`) is a placeholder, and checkout has not been verified for real orders. Replace and verify these details before accepting purchases.
