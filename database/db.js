const Database = require('better-sqlite3');
const fs = require('fs');
const path = require('path');

// Abre (ou cria) o arquivo do banco de dados
const db = new Database(path.join(__dirname, 'garagebuild.db'));

// O SQLite só respeita chaves estrangeiras se isso for ligado em cada conexão
db.pragma('foreign_keys = ON');

// Lê um arquivo .sql desta pasta e devolve o texto
function lerSql(nomeDoArquivo) {
  return fs.readFileSync(path.join(__dirname, nomeDoArquivo), 'utf8');
}

// 1) Cria as tabelas (se ainda não existirem)
db.exec(lerSql('schema.sql'));

// 2) Se não existe nenhum usuário, popula com os dados de exemplo
const { total } = db.prepare('SELECT COUNT(*) AS total FROM users').get();
if (total === 0) {
  db.exec(lerSql('seed.sql'));
  console.log('Banco populado com dados de exemplo.');
}

module.exports = db;