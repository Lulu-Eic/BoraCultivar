// src/routes/soloRoutes.js
import { Router } from 'express';
import { analisarSoloController } from '../controllers/soloController.js'; // 🆕 Atualizado para o nome correto
import multer from 'multer'; // Ou o seu middleware de upload configurado

const router = Router();
const upload = multer({ dest: 'uploads/' }); // Certifique-se de usar a sua configuração do multer aqui

// Rota ajustada para chamar o controlador correto
router.post('/analisar', upload.single('imagem'), analisarSoloController);

export default router;