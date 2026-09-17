import { getAdminUser } from "../../admin-auth";
import { getDb } from "../../../db";
import {
  products,
  sales,
  expenses,
  customers,
  suppliers,
  warranties,
  automations,
} from "../../../db/schema";

const tables = { products, sales, expenses, customers, suppliers, warranties, automations } as const;

export async function POST(req: Request) {
  const user = await getAdminUser();
  if (!user) return Response.json({ error: "Authentication required" }, { status: 401 });

  try {
    const { type, data } = (await req.json()) as {
      type: keyof typeof tables;
      data: Record<string, unknown>;
    };
    if (!tables[type] || !data || typeof data !== "object" || Array.isArray(data)) {
      return Response.json({ error: "Invalid record" }, { status: 400 });
    }

    const db = getDb();
    // The selected table varies at runtime, so Drizzle cannot infer one insert shape.
    // eslint-disable-next-line @typescript-eslint/no-explicit-any
    const result = await db.insert(tables[type] as any).values(data).returning();
    const record = Array.isArray(result) ? result[0] : null;
    if (!record) throw new Error("No record was returned");
    return Response.json({ record }, { status: 201 });
  } catch (error) {
    return Response.json(
      { error: error instanceof Error ? error.message : "Could not save" },
      { status: 400 },
    );
  }
}
