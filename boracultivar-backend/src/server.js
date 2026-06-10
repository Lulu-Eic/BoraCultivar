// src/server.js
import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import path from "path";
import chatRoutes from "./routes/chatRoutes.js";
import authRoutes from "./routes/authRoutes.js";
import soloRoutes from "./routes/soloRoutes.js"; // 🆕 Importando as novas rotas do solo
import { errorHandler } from "./middlewares/errorHandler.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors({ origin: "*" }));
app.use(express.json());

// 🆕 Torna a pasta 'uploads' pública para que as imagens fiquem acessíveis via URL
// Exemplo: http://localhost:3000/uploads/solo-12345.jpg
app.use("/uploads", express.static(path.resolve("uploads")));

// ─── Definição de Rotas do Sistema ───────────────────────────────────────────
app.use("/api", chatRoutes);
app.use("/api", authRoutes);
app.use("/api", soloRoutes); // 🆕 Injetando a rota de análise de solos

app.get("/health", (_req, res) => {
  res.json({
    status: "ok",
    message: "Bora Cultivar API está rodando perfeitamente!",
  });
});

app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`=======================================================`);
  console.log(`✅ Servidor Bora Cultivar rodando em: http://localhost:${PORT}`);
  console.log(`=======================================================`);
});

