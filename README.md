# Deadpool-vs-IronMan
Trabalho de compiladores

Arquivos que serão modificados: lexico.l e sintatico.y

Arquivos gerados automaticamente pelo Bison/Flex: lex.yy.c, sintatico.tab.c e sintatico.tab.h

#---compilando---
#-> bison -d sintatico.y
#-> flex lexico.l
#-> g++ sintatico.tab.c lex.yy.c -lfl- o batalha.exe
