import { Router } from "express";
import { handleChat } from "../controllers/chatController.js";

const router = Router();

/**
 * POST /chat
 * Recebe uma mensagem do frontend e retorna a resposta da IA.
 *
 * Body esperado:
 * {
 *   "message": "Olá, como planto tomate?"
 * }
 */
router.post("/chat", handleChat);

export default router;
