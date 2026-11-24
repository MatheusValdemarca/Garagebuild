// Carrega as variáveis do arquivo .env para process.env
require('dotenv').config();

const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 3000;

// Permite que o servidor entenda JSON enviado no corpo das requisições
app.use(express.json());

// Serve os arquivos da pasta public/ (HTML, CSS, JS do frontend)
app.use(express.static(path.join(__dirname, 'public')));

// Rota de verificação (health check): confirma que a API está no ar
app.get('/api/health', (req, res) => {
  res.status(200).json({
    status: 'ok',
    app: 'GarageBuild',
    timestamp: new Date().toISOString()
  });
});

app.listen(PORT, () => {
  console.log(`GarageBuild rodando em http://localhost:${PORT}`);
});