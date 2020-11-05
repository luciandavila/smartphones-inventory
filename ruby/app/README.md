[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop)

# Teste Técnico para Alive App

Este projeto foi desenvolvido para atender os requisitos do teste técnico de ruby do Alive App.

## Setup

Antes de rodar o app, você precisará: 
```bash

# usar a versão ruby esperada (2.6.6)
$ rmv use

# instalar dependencias
$ bundle install

# subir os bancos de dados
$ rake db:create
$ rake db:schema:load
$ rake db:seed
```

## Como rodar?

```bash

# serve app to localhost:3000
$ rails s
```

## Linting and Testing

```bash

# running rubocop
$ rubocop

# running specs
$ rspec
```

## Considerações finais

Mencionar aqui o que poderia ser melhorado a partir da versão final.