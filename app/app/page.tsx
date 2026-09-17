import { getAdminUser } from "../admin-auth";
import BusinessApp from "./business-app";

export const dynamic = "force-dynamic";

export default async function Page() {
  const user = await getAdminUser();
  if (!user) {
    return (
      <main style={{ padding: "4rem 2rem", maxWidth: 720, margin: "auto" }}>
        <h1>Admin access unavailable</h1>
        <p>Open the dashboard through your Cloudflare Access protected address.</p>
      </main>
    );
  }

  return <BusinessApp userName={user.email} />;
}
