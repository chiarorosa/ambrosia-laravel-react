# Stack de Tecnologias

Este projeto utiliza uma combinação de tecnologias modernas para desenvolvimento full-stack, aproveitando o poder do PHP no backend e do React no frontend.

## Backend

- **PHP:** Linguagem de script do lado do servidor.
- **Laravel:** Framework PHP robusto e elegante, utilizado para construir a base da aplicação. ([composer.json](composer.json))
- **Inertia.js (Adapter Laravel):** Permite criar aplicações de página única (SPA) usando componentes de frontend do lado do servidor, conectando o backend Laravel com o frontend React. ([composer.json](composer.json))
- **Ziggy:** Gera rotas do Laravel para serem usadas no JavaScript, facilitando a navegação no frontend. ([composer.json](composer.json), [vite.config.ts](vite.config.ts))
- **Pest:** Framework de teste focado na simplicidade e elegância para testes em PHP. ([composer.json](composer.json))

## Frontend

- **React:** Biblioteca JavaScript para construir interfaces de usuário interativas. ([package.json](package.json), [vite.config.ts](vite.config.ts))
- **TypeScript:** Superset do JavaScript que adiciona tipagem estática, melhorando a manutenibilidade e a robustez do código frontend. ([package.json](package.json), [tsconfig.json](tsconfig.json))
- **Inertia.js (Adapter React):** Integra o React com o backend Laravel através do Inertia. ([package.json](package.json), [resources/js/ssr.tsx](resources/js/ssr.tsx))
- **Vite:** Ferramenta de build moderna e rápida para o frontend, oferecendo um desenvolvimento ágil com Hot Module Replacement (HMR). ([package.json](package.json), [vite.config.ts](vite.config.ts))
- **Tailwind CSS:** Framework CSS utility-first para estilização rápida e customizável. ([vite.config.ts](vite.config.ts), [package.json](package.json))
- **Radix UI & Headless UI:** Coleções de componentes de UI acessíveis e não estilizados, que servem como base para a construção de uma interface de usuário customizada. ([package.json](package.json))

## Ferramentas de Desenvolvimento

- **ESLint:** Ferramenta de linting para JavaScript e TypeScript, ajudando a manter a qualidade e o padrão do código. ([package.json](package.json), [eslint.config.js](eslint.config.js))
- **Prettier:** Formatador de código opinativo que garante um estilo de código consistente em todo o projeto. ([package.json](package.json), [.prettierrc](.prettierrc))
- **Composer:** Gerenciador de dependências para PHP. ([composer.json](composer.json))
- **NPM/Yarn:** Gerenciador de pacotes para JavaScript/Node.js. ([package.json](package.json))
