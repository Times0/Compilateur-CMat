# Projet compilateur cmat
## Rapport
Ce projet concrétise la réalisation d'un compilateur pour le langage cmat décrit dans `projet_sujet.pdf`.
C'est un compilateur éco-friendly (il n'est pas écrit en Python) qui génère du code assembleur MIPS. 

Il utilise les outils flex et bison pour générer un analyseur lexical et syntaxique. 
Des efforts ont été faits pour assurer la modularité et la lisibilité du code. 

Le code est totalement testé et fonctionnel pour les fonctionnalités décrites si dessous.

Le process de tests est décrit dans le fichier `tests.md`

## Suivi

✅ = Testé et fonctionnel

🟨 = Pas de tests avancés

🟥 = Testé, non fonctionnel

### C restriction
| Feature | Status | Notes |
|---------|--------|-------|
| Basic operations (+, -, *, /) on integers | ✅ | |
| Basic operations (+, -, *, /) on floats | 🟨 | |
| Multiple variable declaration (eg: int a, b, c;) | ✅ | |
| Affectation of variables (int, float and operations of ints and floats) | ✅ | |
| Affectation of int on float and float on int | ✅ | |
| Minus unary operator | ✅ | |
| ++ and -- operators | ✅ | |
| \|\| and && operators | ✅ | |
| `print` to print a variable | ✅ | |
| `printf` to print a string | ✅ | |
| if alone statement | ✅ | |
| if else statement | ✅ | |
| while loop | ✅ | |
| for loop | 🟥 | Weird behaviors with nested for loops |
| Handle return keyword | ✅ | |
| Fonctions without parameters | ✅ | |
| Fonctions with parameters | ✅ | |
| Fonction recursive |🟥 | Not implemented |


### Matrices

| Feature | Status | Notes |
|---------|--------|-------|
| Matrix declaration (multidimensional) | ✅ | |
| Matrix affectation | ✅ | |
| Matrix access | ✅ | |
| Matrix slices (eg: A[0..2][*]) | ✅ |  |
| Slices good error handling |✅ | |
| printmat | ✅ | |
| Matrices ++ and -- | ✅ | |
| Transpose |✅ | |
| Matrix Matrix multiplication | ✅ | |
| Matrix Matrix addition | ✅ | |
| Matrix Matrix subtraction | ✅ | |
| Matrix Matrix division | ✅ | |
| Matrix operations with scalars |✅ | |

### Other

- [x] -o ✅
- [x] -tos ✅
- [x] -version ✅
- [ ] Optimisations 🟥