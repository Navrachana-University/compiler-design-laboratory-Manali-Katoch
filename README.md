Project Title: LoopLang Compiler

Description:
This project is a simple compiler for a custom programming language named "LoopLang". It supports basic loop constructs like `while` and `do-while`. The compiler uses Lex and Yacc to parse the code and generate intermediate outputs.

The project contains:
- Lex file: looplang.l
- Yacc file: looplang.y
- Executable files: a.exe, looplang.exe
- Input file: Input.txt
- Generated files: lex.yy.c, looplang.tab.c, looplang.tab.h

Developer:
Your Name: Manali Kullbhushan Katoch
Roll Number: 22001009

Instructions to Run the Code:
1. Install Lex and Yacc (if not already installed) or use compatible tools like Flex and Bison.
2. Use the following commands to compile:

   bison -d looplang.y
   flex looplang.l
   gcc lex.yy.c looplang.tab.c -o looplang.exe

3. Run the compiled executable:

   ./looplang.exe < Input.txt

4. The program will process the input based on defined grammar rules and display the output accordingly.

Note:
- Make sure all files are in the same directory before compiling.
- Input.txt should contain the source code written in LoopLang syntax.
