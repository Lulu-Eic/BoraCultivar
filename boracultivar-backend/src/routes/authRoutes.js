// src/routes/authRoutes.js

import { Router } from 'express';

import {
  registrar,
  login,
  atualizarPerfil,
} from '../controllers/authController.js';

const router = Router();

router.post('/auth/registrar', registrar);
router.post('/auth/login', login);
router.put('/auth/perfil', atualizarPerfil);

export default router;