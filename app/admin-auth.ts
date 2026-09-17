import { env } from "cloudflare:workers";
import { headers } from "next/headers";
import { createRemoteJWKSet, jwtVerify } from "jose";

export type AdminUser = { id: string; email: string };

const keySets = new Map<string, ReturnType<typeof createRemoteJWKSet>>();

export async function getAdminUser(): Promise<AdminUser | null> {
  const teamDomain = env.ACCESS_TEAM_DOMAIN?.trim().toLowerCase();
  const audience = env.ACCESS_AUD?.trim();
  const allowedEmails = env.ADMIN_EMAILS?.split(",").map((email) =>
    email.trim().toLowerCase(),
  );

  // An incomplete Access setup must never authorize dashboard requests.
  if (
    !teamDomain ||
    !/^[a-z0-9-]+(?:\.[a-z0-9-]+)*\.cloudflareaccess\.com$/.test(teamDomain) ||
    !audience ||
    !allowedEmails?.some(Boolean)
  ) {
    return null;
  }

  const requestHeaders = await headers();
  const token = requestHeaders.get("cf-access-jwt-assertion");
  if (!token) return null;

  try {
    let keys = keySets.get(teamDomain);
    if (!keys) {
      keys = createRemoteJWKSet(new URL(`https://${teamDomain}/cdn-cgi/access/certs`));
      keySets.set(teamDomain, keys);
    }

    const { payload } = await jwtVerify(token, keys, {
      issuer: `https://${teamDomain}`,
      audience,
      algorithms: ["RS256"],
    });
    const email = typeof payload.email === "string" ? payload.email.toLowerCase() : "";
    if (!allowedEmails.includes(email) || typeof payload.sub !== "string") {
      return null;
    }
    return { id: payload.sub, email };
  } catch {
    return null;
  }
}
