// src/middlewares/upload.js
import multer from 'multer';
import path from 'path';

// Configura o armazenamento do arquivo físico no disco do servidor
const storage = multer.diskStorage({
  destination: (req, file, callback) => {
    // Aponta para a pasta uploads que criamos na raiz
    callback(null, 'uploads/');
  },
  filename: (req, file, callback) => {
    // Cria um nome único: data_atual-nome_original.extensao
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    const fileExtension = path.extname(file.originalname);
    callback(null, `solo-${uniqueSuffix}${fileExtension}`);
  }
});

// Filtro de segurança para aceitar apenas imagens (PNG, JPG, JPEG)
const fileFilter = (req, file, callback) => {
  const allowedMimeTypes = ['image/jpeg', 'image/jpg', 'image/png'];
  
  if (allowedMimeTypes.includes(file.mimetype)) {
    callback(null, true); // Aceita o arquivo
  } else {
    callback(new Error('Formato de arquivo inválido. Envie apenas imagens (PNG, JPG ou JPEG).'), false);
  }
};

// Inicializa o multer com as nossas regras e limite de tamanho (ex: até 5MB)
const upload = multer({
  storage: storage,
  fileFilter: fileFilter,
  limits: {
    fileSize: 5 * 1024 * 1024 // 5 Megabytes
  }
});

export default upload;