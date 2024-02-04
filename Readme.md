# 🖥️ Muxtela Compiler 

O projeto envolve a criação de um compilador capaz de reconhecer uma gramática para uma linguagem simples. 
Esta linguagem incluirá análise léxica, sintática e semântica. As estruturas da linguagem devem abranger declarações, 
expressões aritméticas, atribuições, estruturas condicionais, estruturas de repetição e funções.

# 🛠️ Tecnologias Utilizadas

* [Flex](https://www.gnu.org/software/flex/): Ferramenta para gerar analisadores léxicos.
* [Bison](https://www.gnu.org/software/bison/): Ferramenta para gerar analisadores sintáticos.
* [GCC](https://gcc.gnu.org/): Compilador de código fonte.
* [C](https://www.gnu.org/software/gnu-c-manual/gnu-c-manual.html): Linguagem de programação utilizada para a implementação do compilador.

## 📚 Requisitos da Linguagem

A linguagem a ser compilada deverá aderir às seguintes convenções para a definição de nomes de variáveis e funções:

* Variáveis globais devem ser nomeadas utilizando letras maiúsculas (ex: `VARIAVEL_GLOBAL`).

* Variáveis locais devem ser nomeadas utilizando letras minúsculas (ex: `variavel_local`).

* Nomes de funções devem ser escolhidos com um verbo concatenado a um significado que se inicia com letra maiúscula (ex: `calcularSoma()`, `exibirResultado()`, etc.).

## 🧬 Estrutura do Projeto

O projeto foi dividido em 3 partes, separadas em analisador léxico, analisador sintático e semântico, e gerador de código intermediário.

### 🔍 Analisador Léxico

O analisador léxico é responsável por analisar a sequência de caracteres do código fonte e transformá-la em uma sequência de tokens.
Os tokens são estruturas que representam os elementos da linguagem, como palavras reservadas, identificadores, números, operadores, etc.
Em nossa implementação essa etapa é realizada pelo arquivo `mxutela.l`.

### 🧩 Analisador Sintático e Semântico
Essa etapa é responsável por analisar a sequência de tokens gerada pelo analisador léxico e verificar se ela está de acordo com a gramática da linguagem.
Além disso, o analisador semântico verifica se as operações realizadas no código são válidas.
Em nossa implementação essa etapa é realizada pelo arquivo `mxutela.y`.

### 🔄 Gerador de Código Intermediário
Essa etapa é responsável por gerar um código intermediário que será utilizado para a geração do código final.
O código intermediário é uma representação simplificada do código fonte, que é mais fácil de ser manipulada.
Por fim, o código intermediário é utilizado para a geração do código final.
Além disso, esta etapa também é gerada automaticamente pelo arquivo `mxutela.y`, devido a utilização do YACC.

## 🧪 Testes Personalizados

Para testar o compilador, foram criados alguns arquivos de teste que estão localizados na pasta raíz do projeto.
Porém é possível criar novos arquivos de teste e executá-los utilizando o compilador.
Devemos selecionar qual arquivo `.txt` será utilizado para a execução do compilador, e em seguida executar o comando `./mxutela.exe < arquivo_de_teste.txt`.

## 🚀 Executando o Projeto

Para executar o projeto, é necessário ter o `flex` e o `bison` instalados em sua máquina.
Após a instalação, basta executar os seguintes comandos:

```bash
flex mxutela.l
bison -d mxutela.y
gcc -o mxutela mxutela.tab.c lex.yy.c
./mxutela.exe < arquivo_de_teste.txt
```

Obs: É interessante ressaltar que os comandos geram arquivos interdependentes, e por isso é necessário executá-los na ordem correta 
e com um tempo de espera entre eles.

## 🤝 Contribuições

Sinta-se à vontade para contribuir com este projeto criando solicitações de pull (pull requests) ou relatando problemas por meio de issues, caso encontre algum.







