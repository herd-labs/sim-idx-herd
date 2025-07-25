import { creationsBase } from "./db/schema/Listener"; // Adjust the import path as necessary
import { db, App, middlewares } from "@duneanalytics/sim-idx"; // Import schema to ensure it's registered

const app = App.create();
app.use("*", middlewares.authentication);

app.get("/*", async (c) => {
  try {
    const result = await db
      .client(c)
      .select()
      .from(creationsBase)
      .limit(5);

    return Response.json({
      result: result,
    });
  } catch (e) {
    console.error("Database operation failed:", e);
    return Response.json({ error: (e as Error).message }, { status: 500 });
  }
});

export default app;
