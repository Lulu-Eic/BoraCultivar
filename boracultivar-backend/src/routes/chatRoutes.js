// src/routes/chatRoutes.js
import { Router } from 'express';
import { chat } from '../controllers/chatController.js';
 
const router = Router();
 
// Rota consumida pelo chat_service.dart do Flutter
// POST http://localhost:3000/chat
// Body: { "message": "texto do usuário" }
// Response: { "reply": "resposta da Flora" }
router.post('/chat', chat);
 
export default router;
 