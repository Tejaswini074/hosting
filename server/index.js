import express from "express";
import cors from "cors";
import morgan from "morgan";

const app = express();

app.use(express.json());
app.use(morgan("dev"));

app.use(cors({ origin: "*", credentials: true }));

// routes
// app.get("/", (req, res) => {
//   res.send("Server is running 🚀");
// });

app.get("/api/msg", (req, res) => {
  res.json({ message: "Hello from VS code" });
});

app.get("/api/test", (req, res) => {
  res.json({ status: "OK" });
});

// error handler
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({ error: "Something went wrong" });
});

const PORT = process.env.PORT || 4000;

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
});