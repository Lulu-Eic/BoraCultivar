import dotenv from "dotenv";
dotenv.config();
import express from "express";
import cors from "cors";
import path from "path";
import chatRoutes from "./routes/chatRoutes.js";
import soloRoutes from "./routes/soloRoutes.js";
import { errorHandler } from "./middlewares/errorHandler.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.use("/uploads", express.static(path.resolve("uploads")));

// Apenas rotas de IA (a autenticação agora é via Supabase direto)
app.use("/api/chat", chatRoutes);
app.use("/api/solo", soloRoutes);

app.get("/health", (req, res) => res.json({ status: "ok" }));
app.use(errorHandler);

app.listen(PORT, () => console.log(`Servidor rodando na porta ${PORT}`));
