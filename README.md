
# Pac-Man em Assembly 👾🥠

Este projeto consiste na implementação do jogo Pac-Man em linguagem Assembly para o processador P3. O jogo foi desenvolvido como parte essencial da disciplina de Arquitetura de Computadores, componente obrigatório do curso de Engenharia de Computação no **Centro Federal de Educação Tecnológica Celso Suckow da Fonseca (CEFET-RJ)**.

### 🔧 O que é o processador P3?
O programa foi desenvolvido utilizando o simulador de processador P3. O simulador baseia-se no processador descrito nos Capítulos 11 e 12 do livro:

> **Introdução aos Sistemas Digitais e Microprocessadores**
> G. Arroz, J. Monteiro e A. Oliveira
> IST Press, 1ª Edição, 2005

O simulador P3 é um simulador com finalidades pedagógicas afim de capacitar e instruir estudantes ao entendimento do processador e suas fases, ainda que de maneira simplificada.

O processador P3 conta com:
- **8 registradores de uso geral**: `R0` a `R7`
- **Registradores especiais**:
  - `PC` – Program Counter (Contador de Programa)
  - `SP` – Stack Pointer (Pilha)
  - `RE` – Registro de Estado (flags de condição)

Ele possui um conjunto de instruções reduzido, com operações aritméticas, lógicas, de controle, transferência e manipulação de bits, como mostrado abaixo.
#### 📘 Conjunto de Intruções processador P3
| Pseudo | Aritméticas | Lógicas | Deslocamento | Controlo         | Transfer. | Genéricas |
|--------|-------------|---------|--------------|------------------|-----------|-----------|
| ORIG   | NEG         | COM     | SHR          | BR               | MOV       | NOP       |
| EQU    | INC         | AND     | SHL          | BR. *cond*       | MVBH      | ENI       |
| WORD   | DEC         | OR      | SHRA         | JMP              | MVBL     | DSI       |
| STR    | ADD         | XOR     | SHLA         | JMP. *cond*      | XCH       | STC       |
| TAB    | ADDC        | TEST    | ROR          | CALL             | PUSH      | CLC       |
|        | SUB         |         | ROL          | CALL. *cond*     | POP       | CMC       |
|        | SUBB        |         | RORC         | RET              |           |           |
|        | CMP         |         | ROLC         | RETN             |           |           |
|        | MUL         |         |              | RIT              |           |           |
|        | DIV         |         |              | INT              |           |           |

## 🎮 Sobre o Jogo

O jogo é uma versão simplificada e inspirada no clássico **Pac-Man**, desenvolvido por **Tōru Iwatani** e lançado em 1980 pela **Namco**. Devido às restrições da plataforma e do processador, o jogo foi adaptado com algumas simplificações, preservando o objetivo principal: **coletar pontos no mapa enquanto desvia de um inimigo (fantasma)**.

### ✨ Funcionalidades Implementadas
- Mapa com paredes, pontos e portais nas bordas
- Movimentação contínua do Pac-Man com controle por interrupções
- Fantasma com IA simples baseada na **distância de Manhattan**
- Sistema de **pontuação** que incrementa ao coletar pontos
- Detecção de **colisão com parede** e com o fantasma
- Encerramento do jogo em caso de derrota
- Uso de **rotinas de interrupção para controle de input**
- Representação visual via janela de texto no simulador P3

## 🚀 Como rodar o programa?

Antes de tudo, certifique-se de ter os seguintes arquivos no mesmo diretório:

- `trabalho.as` – código-fonte em Assembly do jogo
- `p3as-linux` ou `p3as-mac` – montador compatível com seu sistema
- `p3sim.jar` – simulador do processador P3 (Java)

### 1. Dar permissão de execução ao montador:

```bash
chmod +x p3as-linux
```

> *Esse comando permite que o sistema reconheça o montador como executável.*

### 2. Montar o código Assembly:

```bash
./p3as-linux trabalho.as
```

> *Converte o código `.as` em um arquivo executável `.exe` para o simulador.*

### 3. Executar o simulador:

```bash
java -jar p3sim.jar trabalho.exe
```

> *Abre o simulador gráfico. Dentro dele, selecione:*
> - **Teclado**: Atribua as interrupções (Ex: W, A, S, D para movimentação)
> - **Janela Texto**: Ative para ver o mapa do jogo
> - **Run**: Inicie o programa

## 🧠 Conclusão

Desenvolver um jogo em linguagem Assembly para um processador didático foi uma experiência profunda e enriquecedora. Ao sair da abstração proporcionada por linguagens de alto nível, foi possível entender com mais clareza:

- Como dados são movidos e manipulados na memória
- Como o controle de fluxo é feito por **saltos e interrupções**
- A importância de cada registrador na execução de tarefas
- A dificuldade (e valor) de implementar lógicas complexas com instruções simples

Além de reforçar o conteúdo teórico da disciplina de Arquitetura de Computadores, o projeto proporcionou uma vivência prática rara: **programar quase diretamente sobre o hardware**.

🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠 🟡 🥠
