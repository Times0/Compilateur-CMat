#include "../include/mips.h"
#include <stdio.h>
#include "../include/quad.h"
#include "../include/symbol_table.h"
#include "cmat.tab.h"


//////////////////////////
//  On suppose que le programme est une suite de declarations de fonctions
//  suivie d'une fonction main
//////////////////////////
extern __uint32_t lineno;
extern SymbolTable *symbol_table;


__uint32_t current_register_int = 0;        // registre pour les int
__uint32_t current_register_float = 0;      // registre pour les float
__uint32_t fp_type[MAXFPSIZE];              // tableau qui contient le type des variables du stack frame


void gencode_mips_global_variable(FILE * f, SymbolTable * s)
{
    fprintf (f, ".data\n");
    
    for (__uint32_t i=0 ; i < s->size; i++)
    {
        SymbolTableElement *t = get_symbol(s, i);
        if(t->class == VARIABLE && t->attribute.variable.adress == -1)
        {
            if(strcmp(t->attribute.variable.name, "$fp"))
            {
                if(t->type == INT)
                    fprintf (f, "\t%s:\t.word 0\n", t->attribute.variable.name);
                else if(t->type == FLOAT)
                    fprintf (f, "\t%s:\t.float 0.0\n", t->attribute.variable.name);
            }
        }
    }
    fprintf (f, "\n");
}

void gencode_mips(QuadTable *code, FILE * f)
{
    SymbolTableElement *mainn = lookup_function(symbol_table, "main");
    // le nombre de parametre doit etre 0 sinon la grammaire ne detecte pas
    if(mainn == NULL)
    {
        printf("main is undefined\n");
        exit(1);
    }
    else if(mainn->type != INT)
    {
        printf("main should have int type\n");
        exit(1);
    }

    
    // main 
    fprintf (f, ".globl main\n");
    fprintf (f, ".text\n");

    fprintf (f, "main:\n"); // temporaire
    fprintf (f, "\tmove $fp, $sp\n");


    // parcours de tous les quads apres le main
    for (size_t i = 0; i < code->nextquad; i ++)
    {
        if(&(code->quads[i]) != NULL) // Peut etre inutile
        {
            gencode_mips_quad(f, &(code->quads[i]));
        }
    }

    // fin du main et du code
    // si le dernier quad (pas généré) a un label
    if(code->quads[code->nextquad].label != -1)
    {
        char *label = generate_label_with_nb(code->quads[code->nextquad].label);
        fprintf(f, "\n%s:\n", label);
        free(label);
    }
    fprintf (f, "\tli $v0, 10\n\tsyscall\n");
}

void gencode_mips_quad(FILE *f, Quad *quad)
{
    if(quad->label != -1)
    {
        char *l = generate_label_with_nb(quad->label);
        fprintf (f, "\n%s:\n", l);
        free(l);
    }
        
    switch(quad->kind)
    {
        case BOP_PLUS:
        case BOP_MINUS:
        case BOP_MULT:
        case BOP_DIV:
        case BOP_MOD:
            gencode_arith_binary_op(f, quad);
            break;
        case UOP_MINUS:
            gencode_arith_unary_op(f, quad);
            break;
        case K_COPY:
            gencode_affect(f, quad);
            break;
        case K_CALL_PRINT:
        case K_CALL_PRINTF:
        case K_CALL_PRINTMAT:
            gencode_print(f, quad);
            break;
        case K_GOTO:
        case K_IF:
        case K_IFNOT:
        case K_IFLT:
        case K_IFGT:
        case K_IFLE:
        case K_IFGE:
            gencode_goto(f, quad);
            break;
                                
            default:
                printf ("Error : Quad type not recognized\n");
                break;
        }
}

void gencode_arith_unary_op (FILE * f, Quad *quad)
{
    __uint32_t type = quad->sym1->type;
    // l'opérande a quache est une variable temporaire
    /*__uint32_t type_change_sym2=0;
    if(quad->sym1->type == FLOAT)
        type_change_sym2 = convert_int_to_float(quad->sym2);
    else
        type_change_sym2 = convert_float_to_int(quad->sym2);*/

    if(quad->by_adress[0] != 0)
    {
        load_operator(f, quad->sym1, quad->by_adress[0], 0);
        type = quad->by_adress[0];   
    }

    if(quad->kind == UOP_MINUS)
    {
        load_operator(f, quad->sym2, quad->by_adress[1], 1);
        if(type == INT)
        {
            fprintf (f, "\tneg $t%d, $t%d\n", current_register_int, current_register_int - 1);
            current_register_int++;
        }
        else if(type == FLOAT)
        {
            fprintf (f, "\tneg.s $f%d, $f%d\n", current_register_float, current_register_float - 1);
            current_register_float++;
        }
        
        if(quad->by_adress[0] == 0)
            store_result(f, quad->sym1, 0);
        else
        {
            SymbolTableElement t;
            t.type = quad->by_adress[0];
            
            current_register_int--;
            store_result (f, &t, quad->sym1->attribute.constant.int_value);   
        }
    }

    /*if(quad->sym1->type == FLOAT)
        if(type_change_sym2)
            convert_float_to_int(quad->sym2);
    else
        if(type_change_sym2)
            convert_int_to_float(quad->sym2);*/
}

void gencode_arith_binary_op (FILE * f, Quad *quad)
{
    //////////////////////////////////////////////////////////////
    // convertir les opérandes en int ou float selon le type du résultat
    __uint32_t type = quad->sym1->type;
    __uint32_t type_change_sym2=0;
    __uint32_t type_change_sym3=0;

    if(quad->by_adress[0] == 0)
    {
        if(quad->sym1->type == INT || quad->by_adress[0] == INT)
        {
            type_change_sym2 = convert_float_to_int(quad->sym2);
            type_change_sym3 = convert_float_to_int(quad->sym3);
        }
        else if(quad->sym1->type == FLOAT)
        {
            type_change_sym2 = convert_int_to_float(quad->sym2);
            type_change_sym3 = convert_int_to_float(quad->sym3);
        }
    }

    if(quad->by_adress[0] != 0)
    {
        // si le resultat est un tableau indicé et une des operandes est une constante
        if(quad->by_adress[1] == 0)
        {
            if(quad->by_adress[0] == INT)
                type_change_sym2 = convert_float_to_int(quad->sym2);
            else
                type_change_sym2 = convert_int_to_float(quad->sym2);
        }
        if(quad->by_adress[2] == 0)
        {
            if(quad->by_adress[0] == INT)
                type_change_sym3 = convert_float_to_int(quad->sym3);
            else
                type_change_sym3 = convert_int_to_float(quad->sym3);
        }
        
        load_operator(f, quad->sym1, quad->by_adress[0], 0);
        type = quad->by_adress[0];
    }

    // récupérer la valeur de op1 dans un registre temp
    load_operator(f, quad->sym2, quad->by_adress[1], 1);
    // récupérer la valeur de op2 dans un autre registre temp
    load_operator(f, quad->sym3, quad->by_adress[2], 1);


    if (quad->kind == BOP_PLUS)
    {
        // on autorise les additions avec $fp
        if(strcmp(quad->sym3->attribute.variable.name, "$fp") == 0)
        {
            fprintf (f, "\tadd $t%d, $t%d, $fp\n", current_register_int, current_register_int-2);
        }
        else
        {
            if(type == INT)
                fprintf (f, "\tadd $t%d, $t%d, $t%d\n", current_register_int, current_register_int - 2, current_register_int - 1);
            else if(type == FLOAT)
                fprintf (f, "\tadd.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
        }
    }
    else if (quad->kind == BOP_MINUS)
    {
        if(type == INT)
            fprintf (f, "\tsub $t%d, $t%d, $t%d\n", current_register_int, current_register_int - 2, current_register_int - 1);
        else if(type == FLOAT)
            fprintf (f, "\tsub.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }
    else if (quad->kind == BOP_MULT)
    {
        if(type == INT)
        {
            fprintf (f, "\tmult $t%d, $t%d\n", current_register_int - 2, current_register_int - 1);
            fprintf (f, "\tmflo $t%d\n", current_register_int);
        }
        else if(type == FLOAT)
            fprintf (f, "\tmul.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }
    else if(quad->kind == BOP_DIV)
    {
        if(type == INT)
        {
            fprintf (f, "\tdiv $t%d, $t%d\n", current_register_int - 2, current_register_int - 1);
            fprintf (f, "\tmflo $t%d\n", current_register_int);
        }
        else if(type == FLOAT)
            fprintf (f, "\tdiv.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }
    else if(quad->kind == BOP_MOD)
    {
        if(type == INT)
        {
            fprintf (f, "\tdiv $t%d, $t%d\n", current_register_int - 2, current_register_int - 1);
            fprintf (f, "\tmfhi $t%d\n", current_register_int);
        }
        else if(type == FLOAT)
            fprintf (f, "\tdiv.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }

    //////////////////////////////////////////////////////////////
    // stocker le résultat dans la stack
    if(quad->by_adress[0] == 0)
    {        
        if(quad->sym1->type == INT)
            current_register_int++;
        else if(quad->sym1->type == FLOAT)
            current_register_float++;

        store_result(f, quad->sym1, 0);

        if(quad->sym1->type == INT)
            current_register_int-=2;
        else if(quad->sym1->type == FLOAT)
            current_register_float-=2;
    }
    else
    {
        SymbolTableElement t;
        t.type = quad->by_adress[0];

        current_register_float++;
        if(!quad->by_adress[1] || !quad->by_adress[2])
            current_register_float++;

        if(quad->by_adress[1] == 0)
        {
            if(quad->by_adress[0] == INT)
                current_register_int--;
            else
                current_register_float--;
        }
        else
            current_register_int--;
            
        if(quad->by_adress[2] == 0)
        {
            if(quad->by_adress[0] == INT)
                current_register_int--;
            else
                current_register_float--;
        }
        else
            current_register_int--;
    
        store_result (f, &t, quad->sym1->attribute.constant.int_value);
        
        current_register_float -=2;
    }

    //////////////////////////////////////////////////////////////
    // remettre les types des opérandes à leur type initial
    if(quad->sym1->type == INT)
    {
        if(type_change_sym2)
            convert_int_to_float(quad->sym2);
        if(type_change_sym3)
            convert_int_to_float(quad->sym3);
    }
    else if(quad->sym1->type == FLOAT)
    {
        if(type_change_sym2)
            convert_float_to_int(quad->sym2);
        if(type_change_sym3)
            convert_float_to_int(quad->sym3);
    }

}

void gencode_affect (FILE * f, Quad *quad)
{
    __uint32_t type_change_sym2=0;
    // Si passage classique par valeur
    if(!quad->by_adress[0])
    {
        if(quad->sym1->type == INT)
        {
            if(!quad->by_adress[1])
            {
                type_change_sym2 = convert_float_to_int(quad->sym2);
        
                load_operator(f, quad->sym2, 0, 0);
                store_result (f, quad->sym1, 0);

                if(type_change_sym2)
                    convert_int_to_float(quad->sym2);
            }
            else //si le deuxieme élément est une référence
            {
                load_operator(f, quad->sym2, quad->by_adress[1], 1);
                store_result (f, quad->sym1, 0);
            }
        }
        else if(quad->sym1->type == FLOAT)
        {
            if(!quad->by_adress[1])
            {
                type_change_sym2 = convert_int_to_float(quad->sym2);
        
                load_operator(f, quad->sym2, 0, 0);
                store_result (f, quad->sym1, 0);
        
                if(type_change_sym2)
                    convert_float_to_int(quad->sym2);
            }
            else
            {
                load_operator(f, quad->sym2, quad->by_adress[1], 1);
                store_result (f, quad->sym1, 0);
            }
        }
    }
    // Si passage par adresse
    else
    {
        // on charge le type de l'élément référencé
        SymbolTableElement t;
        t.type = quad->by_adress[0];
        // t contient seulement le type de la cible
        if(t.type == FLOAT)
        {
            type_change_sym2 = convert_int_to_float(quad->sym2);
        
            load_operator(f, quad->sym2, quad->by_adress[1], 1); // le 4eme parametre indique si on charge la valeur pointé par l'adresse ou seulement l'addresse
            load_operator(f, quad->sym1, quad->by_adress[0], 0);
            
            store_result (f, &t, quad->sym1->attribute.constant.int_value);

            // if(quad->by_adress[1])
                // current_register_int--;

            if(type_change_sym2)
                convert_float_to_int(quad->sym2);
        }
        else if(t.type == INT)
        {
            type_change_sym2 = convert_float_to_int(quad->sym2);
        
            load_operator(f, quad->sym2, quad->by_adress[1], 1);
            load_operator(f, quad->sym1, quad->by_adress[0], 0);
            
            store_result (f, &t, quad->sym1->attribute.constant.int_value);

            if(type_change_sym2)
                convert_int_to_float(quad->sym2);
        }
    }
}

void gencode_print(FILE *f, Quad *quad)
{
    if(quad->kind == K_CALL_PRINT)
    {
        // Si passage par adresse
        if(quad->by_address_list[0] == INT)
        {
            load_operator(f, quad->function_parameters[0], quad->by_address_list[0], 1);
            fprintf (f, "\tli $v0, 1\n");
            fprintf (f, "\tmove $a0, $t%d\n", current_register_int - 1);
            fprintf (f, "\tsyscall\n");
            current_register_int--;
        }
        else if(quad->by_address_list[0] == FLOAT)
        {
            load_operator(f, quad->function_parameters[0], quad->by_address_list[0], 1);
            fprintf (f, "\tli $v0, 2\n");
            fprintf (f, "\tmov.s $f12, $f%d\n", current_register_float - 1);
            fprintf (f, "\tsyscall\n");
            current_register_float--;
        }
        // Passage par valeur on doit l'evaluer apres car il peyt y avoir des conflits entre les 2 types
        else if(quad->function_parameters[0]->type == INT)
        {
            load_operator(f, quad->function_parameters[0], quad->by_address_list[0], 1);
            fprintf (f, "\tli $v0, 1\n");
            fprintf (f, "\tmove $a0, $t%d\n", current_register_int - 1);
            fprintf (f, "\tsyscall\n");
            current_register_int--;
        }
        else if(quad->function_parameters[0]->type == FLOAT)
        {
            load_operator(f, quad->function_parameters[0], quad->by_address_list[0], 1);
            fprintf (f, "\tli $v0, 2\n");
            fprintf (f, "\tmov.s $f12, $f%d\n", current_register_float - 1);
            fprintf (f, "\tsyscall\n");
            current_register_float--;
        }
    }
    else if(quad->kind == K_CALL_PRINTF)
    {
        // caractere d'échappement : \n, \t, \\, \"
        fprintf(f, "\tli $v0, 4\n");
        fprintf(f, "\tla $a0, %d($fp)\n", -4*(quad->function_parameters[0]->attribute.string.adress+1));
        __uint32_t str_size = strlen(quad->function_parameters[0]->attribute.string.string)-2;
        __uint32_t char_ptr = 0;
        for(__uint32_t i = 0; i<str_size; i++)
        {
            __uint32_t char_special=0;
            if(quad->function_parameters[0]->attribute.string.string[i+1] == '\\')
            {
                __uint32_t car;
                switch(quad->function_parameters[0]->attribute.string.string[i+2])
                {
                    case 'n':
                        car = 10;
                        char_special = 1;
                        break;
                    case 't':
                        car = 9;
                        char_special = 1;
                        break;
                    case '\\':
                        car = 92;
                        char_special = 1;
                        break;
                    case '"':
                        car = 34;
                        char_special = 1;
                        break;
                    default:
                        printf("Error at line %d : unknown special character\n", lineno);
                        exit(1);
                }
                
                fprintf(f, "\tli $t%d, %d\n", current_register_int, car);
                fprintf(f, "\tsb $t%d, %d($a0)\n", current_register_int, char_ptr);
                i++;
            }
            else if(!char_special)
            {
                fprintf(f, "\tli $t%d, %d\n", current_register_int, quad->function_parameters[0]->attribute.string.string[i+1]);
                fprintf(f, "\tsb $t%d, %d($a0)\n", current_register_int, char_ptr);
            }
            char_ptr++;
        }
        // caractere de fin de chaine
        fprintf(f, "\tli $t%d, %d\n", current_register_int, 0);
        fprintf(f, "\tsb $t%d, %d($a0)\n", current_register_int, char_ptr);
        fprintf(f, "\tsyscall\n");
    }
}

void gencode_goto(FILE *f, Quad *quad)
{
    if(quad->kind == K_GOTO)
    {
        char *l = generate_label_with_nb(quad->branch_label);
        fprintf(f, "\tj %s\n", l);
        free(l);
    }
    else
    {
        __uint32_t type_change_sym2=0;
        __uint32_t type_change_sym3=0;
        if(quad->sym2->type == FLOAT || quad->sym3->type == FLOAT || quad->by_adress[1] || quad->by_adress[2])
        {
            type_change_sym2 = convert_int_to_float(quad->sym2);
            type_change_sym3 = convert_int_to_float(quad->sym3);
        }
        else
        {
            type_change_sym2 = convert_float_to_int(quad->sym2);
            type_change_sym3 = convert_float_to_int(quad->sym3);
        }
        
        load_operator(f, quad->sym2, quad->by_adress[1], 1);
        load_operator(f, quad->sym3, quad->by_adress[2], 1);

        char *l = generate_label_with_nb(quad->branch_label);
        
        if(quad->kind == K_IF)
        {
            if(quad->sym2->type == INT)
                fprintf(f, "\tbeq $t%d, $t%d, %s\n", current_register_int - 2, current_register_int-1, l);
            else if(quad->sym2->type == FLOAT)
                fprintf(f, "\tc.eq.s $f%d, $f%d\n\tbc1t %s\n", current_register_float - 2, current_register_float-1, l);
        }
        else if(quad->kind == K_IFNOT)
        {
            if(quad->sym2->type == INT)
                fprintf(f, "\tbne $t%d, $t%d, %s\n", current_register_int - 2, current_register_int-1, l);
            else if(quad->sym2->type == FLOAT)
                fprintf(f, "\tc.eq.s $f%d, $f%d\n\tbc1f %s\n", current_register_float - 2, current_register_float-1, l);
        }
        else if(quad->kind == K_IFLT)
        {
            if(quad->sym2->type == INT)
                fprintf(f, "\tblt $t%d, $t%d, %s\n", current_register_int - 2, current_register_int-1, l);
            else if(quad->sym2->type == FLOAT)
                fprintf(f, "\tc.lt.s $f%d, $f%d\n\tbc1t %s\n", current_register_float - 2, current_register_float-1, l);
        }
        else if(quad->kind == K_IFGT)
        {
            if(quad->sym2->type == INT)
                fprintf(f, "\tbgt $t%d, $t%d, %s\n", current_register_int - 2, current_register_int-1, l);
            else if(quad->sym2->type == FLOAT)
                fprintf(f, "\tc.lt.s $f%d, $f%d\n\tbc1f %s\n", current_register_float - 2, current_register_float-1, l);
        }
        else if(quad->kind == K_IFLE)
        {
            if(quad->sym2->type == INT)
                fprintf(f, "\tble $t%d, $t%d, %s\n", current_register_int - 2, current_register_int-1, l);
            else if(quad->sym2->type == FLOAT)
                fprintf(f, "\tc.le.s $f%d, $f%d\n\tbc1t %s\n", current_register_float - 2, current_register_float-1, l);
        }
        else if(quad->kind == K_IFGE)
        {
            if(quad->sym2->type == INT)
                fprintf(f, "\tbge $t%d, $t%d, %s\n", current_register_int - 2, current_register_int-1, l);
            else if(quad->sym2->type == FLOAT)
                fprintf(f, "\tc.le.s $f%d, $f%d\n\tbc1f %s\n", current_register_float - 2, current_register_float-1, l);
        }
        
        if(quad->sym2->type == INT)
            current_register_int-=2;
        else if(quad->sym2->type == FLOAT)
            current_register_float-=2;
        free(l);

        if(quad->sym2->type == FLOAT || quad->sym3->type == FLOAT)
        {
            if(type_change_sym2)
                convert_float_to_int(quad->sym2);
            if(type_change_sym3)
                convert_float_to_int(quad->sym3);
        }
        else
        {
            if(type_change_sym2)
                convert_int_to_float(quad->sym2);
            if(type_change_sym3)
                convert_int_to_float(quad->sym3);
        }
    }
}

void load_operator (FILE * f, SymbolTableElement *elem, __uint32_t address, __uint32_t load_address)
{
    if(strcmp(elem->attribute.variable.name, "$fp") == 0)
    {
        current_register_int++;
        return;
    }
    
    if(elem->class == VARIABLE)
    {
        // si passage par addresse, on charge la valeur pointé par le registre
        if(address == FLOAT)
        {
            fprintf (f, "\tlw $t%d, %d($fp)\n", current_register_int, -4 * (elem->attribute.variable.adress + 1));
            
            // Indique si on doit charger la valeur pointé par l'addresse
            if(load_address)
            {
                fprintf (f, "\tl.s $f%d, 0($t%d)\n", current_register_float, current_register_int);
                current_register_float++;
            }
            else
                current_register_int++;
            
        }
        else if(address == INT)
        {
            fprintf (f, "\tlw $t%d, %d($fp)\n", current_register_int, -4 * (elem->attribute.variable.adress + 1));
            
            // Indique si on doit charger la valeur pointé par l'addresse
            if(load_address)
            {
                fprintf (f, "\tlw $t%d, 0($t%d)\n", current_register_int, current_register_int);
            }
            current_register_int++;
        }
        else if(elem->type == INT)
        {   
            // Pour charger un int, on le charge dans un registre float puis on le convertit en int
            // si variable globale
            if(elem->attribute.variable.adress == -1)
            {
                if(fp_type[elem->attribute.variable.adress] == FLOAT)
                {
                    fprintf (f, "\tl.s $f%d, %s\n", current_register_float, elem->attribute.variable.name);
                    fprintf(f, "\tcvt.w.s $f%d, $f%d\n", current_register_float, current_register_float);
                    fprintf(f, "\tmfc1 $t%d, $f%d\n", current_register_int, current_register_float);
                    current_register_int++;
                }
                else
                {
                    fprintf (f, "\tlw $t%d, %s\n", current_register_int, elem->attribute.variable.name);
                    current_register_int++;
                }
            }
            else
            {
                if(fp_type[elem->attribute.variable.adress] == FLOAT)
                {
                    fprintf (f, "\tl.s $f%d, %d($fp)\n", current_register_float, -4 * (elem->attribute.variable.adress + 1));
                    fprintf(f, "\tcvt.w.s $f%d, $f%d\n", current_register_float, current_register_float);
                    fprintf(f, "\tmfc1 $t%d, $f%d\n", current_register_int, current_register_float);
                    current_register_int++;
                }
                else
                {
                    fprintf (f, "\tlw $t%d, %d($fp)\n", current_register_int, -4 * (elem->attribute.variable.adress + 1));
                    current_register_int++;
                }
            }
        }
        else if (elem->type == FLOAT)
        {
            if(elem->attribute.variable.adress == -1)
            {
                if(fp_type[elem->attribute.variable.adress] == INT)
                {
                    fprintf (f, "\tlw $t%d, %s\n", current_register_int, elem->attribute.variable.name);
                    fprintf(f, "\tmtc1 $t%d, $f%d\n", current_register_int, current_register_float);
                    fprintf(f, "\tcvt.s.w $f%d, $f%d\n", current_register_float, current_register_float);
                    current_register_float++;
                }
                else
                {
                    fprintf (f, "\tl.s $f%d, %s\n", current_register_float, elem->attribute.variable.name);
                    current_register_float++;
                }
            }
            else
            {
                if(fp_type[elem->attribute.variable.adress] == INT)
                {
                    fprintf (f, "\tlw $t%d, %d($fp)\n", current_register_int, -4 * (elem->attribute.variable.adress + 1));
                    fprintf(f, "\tmtc1 $t%d, $f%d\n", current_register_int, current_register_float);
                    fprintf(f, "\tcvt.s.w $f%d, $f%d\n", current_register_float, current_register_float);
                    current_register_float++;
                }
                else
                {
                    fprintf (f, "\tl.s $f%d, %d($fp)\n", current_register_float, -4 * (elem->attribute.variable.adress + 1));
                    current_register_float++;
                }
            }
        }
    }
    // dans le cas ou on lit une addresse
    else if (elem->class == CONSTANT)
    {
        if(elem->type == INT)
        {
            fprintf (f, "\tli $t%d, %d\n", current_register_int, elem->attribute.constant.int_value);
            current_register_int++;
        }
        else if (elem->type == FLOAT)
        {
            fprintf (f, "\tli.s $f%d, %f\n", current_register_float, elem->attribute.constant.float_value);
            current_register_float++;
        }
    }
}

void store_result (FILE * f, SymbolTableElement *res, __uint32_t adress)
{
    // si stockage classique
    if(adress == 0)
    {
        if(res->class == VARIABLE)
        {
            if(res->type == INT)
            {
                // variable non temporaire ie declarée dans .data
                if(res->attribute.variable.adress == -1)
                {
                    // get the address of the variable
                    fprintf (f, "\tla $t%d, %s\n", current_register_int, res->attribute.variable.name);
                    // save the value in this address
                    fprintf (f, "\tsw $t%d, 0($t%d)\n", current_register_int - 1, current_register_int);
                    current_register_int--;
                }
                else
                {
                    fprintf(f, "\tsw $t%d, %d($fp)\n", current_register_int - 1, -4 * (res->attribute.variable.adress + 1));
                    fp_type[res->attribute.variable.adress] = res->type;
                    current_register_int--;
                }
            }
            else if(res->type == FLOAT)
            {
                // variable non temporaire ie declarée dans .data
                if(res->attribute.variable.adress == -1)
                {
                    // get the address of the variable
                    fprintf (f, "\tla $t%d, %s\n", current_register_int, res->attribute.variable.name);
                    // save the value in this address
                    fprintf (f, "\ts.s $f%d, 0($t%d)\n", current_register_float-1, current_register_int);
                    current_register_float--;
                }
                else
                {
                    fprintf (f, "\ts.s $f%d, %d($fp)\n", current_register_float - 1, -4 * (res->attribute.variable.adress + 1));
                    fp_type[res->attribute.variable.adress] = res->type;
                    current_register_float--;
                }
            }
        }
    }
    else
    {
        if(res->type == FLOAT)
        {
            fprintf (f, "\ts.s $f%d, 0($t%d)\n", current_register_float-1, current_register_int-1);
            fp_type[adress] = FLOAT;
            current_register_int--;
            current_register_float--;
        }
        else if(res->type == INT)
        {
            fprintf (f, "\tsw $t%d, 0($t%d)\n", current_register_int-2, current_register_int-1);
            fp_type[adress] = INT;
            current_register_int-=2;
        }
    }
}

__uint32_t convert_int_to_float(SymbolTableElement *s)
{
    if(s->type == FLOAT)
        return 0;
    s->type = FLOAT;
    return 1;
}

__uint32_t convert_float_to_int(SymbolTableElement *s)
{
    if(s->type == INT)
        return 0;
    s->type = INT;
    return 1;
}
