/**
 * Middleware global de tratamento de erros.
 * Captura qualquer erro não tratado que passe pelo Express.
 *
 * Para usar, adicione ao final do server.js:
 *   app.use(errorHandler);
 */
export function errorHandler(err, _req, res, _next) {
  console.error("[errorHandler]", err);

  const status = err.status || 500;
  const message = err.message || "Erro interno do servidor.";

  res.status(status).json({ error: message });
}
