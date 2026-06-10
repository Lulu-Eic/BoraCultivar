# 🌱 Bora Cultivar — Backend

Backend da aplicação **Bora Cultivar**, desenvolvido em Node.js com Express.
Preparado para integração futura com Inteligência Artificial.

---

## 📁 Estrutura de pastas

```
boracultivar-backend/
├── src/
│   ├── server.js               → Ponto de entrada: configura Express, CORS e JSON
│   ├── routes/
│   │   └── chatRoutes.js       → Define a rota POST /chat
│   ├── controllers/
│   │   └── chatController.js   → Valida a requisição e orquestra a resposta
│   ├── services/
│   │   └── aiService.js        → ⭐ Lógica da IA (isolada aqui para fácil troca)
│   └── middlewares/
│       └── errorHandler.js     → Middleware global de erros
├── .env.example                → Variáveis de ambiente (copie para .env)
├── .gitignore
├── package.json
└── README.md
```

---

## 🚀 Como rodar

### 1. Instale as dependências

```bash
npm install
```

### 2. Configure o ambiente

```bash
cp .env.example .env
```

### 3. Inicie o servidor

```bash
# Produção
npm start

# Desenvolvimento (reinicia automaticamente ao salvar)
npm run dev
```

O servidor estará disponível em `http://localhost:3000`.

---

## 📡 Endpoints

### `POST /chat`

Recebe uma mensagem do frontend e retorna a resposta da IA.

**Request body:**
```json
{
  "message": "Como plantar tomate em apartamento?"
}
```

**Response (200):**
```json
{
  "reply": "Resposta da IA aqui..."
}
```

**Response (400 — mensagem ausente ou inválida):**
```json
{
  "error": "O campo \"message\" é obrigatório e deve ser uma string não vazia."
}
```

### `GET /health`

Verifica se o servidor está no ar.

```json
{ "status": "ok", "message": "Bora Cultivar API está rodando!" }
```

---

## 🤖 Como integrar a IA real

Todo o código de IA está isolado em **`src/services/aiService.js`**.

Para integrar a IA real, **só é necessário editar esse único arquivo**:

1. Abra `src/services/aiService.js`
2. Substitua o bloco `RESPOSTA SIMULADA` pela chamada à IA desejada
3. Mantenha a assinatura da função:
   - **Entrada:** `message` (string)
   - **Saída:** `Promise<string>`

Há um exemplo comentado de integração com a OpenAI dentro do próprio arquivo.

---

## 🔗 Frontend

O frontend (React + Vite + TypeScript) deve apontar para `http://localhost:3000`.

Exemplo de chamada no frontend:

```typescript
const response = await fetch("http://localhost:3000/chat", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({ message: inputDoUsuario }),
});

const data = await response.json();
console.log(data.reply);
```
