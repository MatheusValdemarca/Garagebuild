// Carrega as variáveis do arquivo .env para process.env
require('dotenv').config();

const express = require('express');
const path = require('path');
const db = require('./database/db'); // abre o banco e cria/popula as tabelas

const app = express();
const PORT = process.env.PORT || 3000;

// Permite que o servidor entenda JSON enviado no corpo das requisições
app.use(express.json());

// Serve os arquivos da pasta public/ (HTML, CSS, JS do frontend)
app.use(express.static(path.join(__dirname, 'public')));

// Rota de verificação (health check): confirma que a API e o banco estão no ar
app.get('/api/health', (req, res) => {
  const { total: usuarios } = db.prepare('SELECT COUNT(*) AS total FROM users').get();
  const { total: pecas } = db.prepare('SELECT COUNT(*) AS total FROM parts').get();

  res.status(200).json({
    status: 'ok',
    app: 'GarageBuild',
    banco: { usuarios, pecas },
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`GarageBuild rodando em http://localhost:${PORT}`);
});