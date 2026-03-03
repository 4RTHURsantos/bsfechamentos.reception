# 📥 XML Request Receiver

Serviço backend desenvolvido em **NestJS** responsável por receber requisições **XML** enviadas por um serviço instalado nas máquinas dos clientes.

A aplicação atua como um **concentrador centralizado de arquivos**, organizando e armazenando os XMLs automaticamente por **empresa** e **data**, garantindo estruturação, rastreabilidade e padronização no armazenamento.

## 🏗️ Funcionamento

1. O serviço do cliente envia um XML via requisição HTTP.
2. A API recebe e processa o conteúdo.
3. O arquivo é salvo no servidor.
4. A estrutura de diretórios é criada dinamicamente no formato: `{ROOT_FOLDER}\{documento}\{mod}\{ano}\{mes}\{dia}`

## 🎯 Objetivo

Centralizar e organizar documentos XML provenientes de múltiplos clientes em um único ponto, facilitando integração com outros sistemas e controle por empresa.
