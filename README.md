# Projet compilateur cmat
## Rapport



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
