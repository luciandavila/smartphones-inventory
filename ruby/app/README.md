[![Ruby Style Guide](https://img.shields.io/badge/code_style-rubocop-brightgreen.svg)](https://github.com/rubocop-hq/rubocop) <a href="https://github.com/luciandavila/hiring/actions?query=workflow%3Aci"><img alt="ci status" src="https://github.com/luciandavila/hiring/workflows/ci/badge.svg"></a>

# Teste Técnico para Alive App

Este projeto foi desenvolvido para atender os requisitos do teste técnico de ruby do Alive App.

## Setup

Após clonar este repo, antes de rodar o app, você precisará:
```bash

# navegar até a pasta correta
$ cd ruby/app

# usar a versão ruby esperada (2.6.6) (você pode instalar a versão manualmente caso deseje)
$ rmv use

# instalar as dependencias
$ bundle install

# inciar o banco
$ rake db:setup

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