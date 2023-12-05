#include "../include/mips.h"
#include <stdio.h>
#include "../include/quad.h"
#include "../include/symbol_table.h"
#include "cmat.tab.h"

//////////////////////////
//  On suppose que le programme est une suite de declarations de fonctions
//  suivie d'une fonction main
//////////////////////////

__uint32_t current_register_int = 0;        // registre pour les int
__uint32_t current_register_float = 0;      // registre pour les float
__uint32_t fp_type[MAXFPSIZE];              // tableau qui contient le type des variables du stack frame
__uint32_t label_counter = 0;               // compteur pour les labels

// Voir code pour modification 
void gencode_mips_global_variable(FILE * f, SymbolTable * s)
{
    fprintf (f, ".data\n");
    
    for (__uint32_t i=0 ; i < s->size; i++)
    {
        if(s->symbols[i].class == VARIABLE && s->symbols[i].attribute.variable.frame_pointer == -1)
        {
            if(s->symbols[i].type == INT)
                fprintf (f, "\t%s:\t.word 0\n", s->symbols[i].attribute.variable.name);
            else if(s->symbols[i].type == FLOAT)
                fprintf (f, "\t%s:\t.float 0.0\n", s->symbols[i].attribute.variable.name);
        }
    }
    fprintf (f, "\n");
}


void gencode_mips(QuadTable *code, FILE * f)
{
    // main 
    fprintf (f, ".globl main\n");
    fprintf (f, ".text\n");

    fprintf (f, "main:\n"); // temporaire
    fprintf (f, "\tmove $fp, $sp\n");

    code->main_quad = 0;

    // parcours de tous les quads apres le main
    for (size_t i = code->main_quad; i < code->nextquad; i ++)
    {
        if(&(code->quads[i]) != NULL) // Peut etre inutile
        {
            gencode_mips_quad(f, &(code->quads[i]));
        }
    }

    // fin du main et du code
    fprintf (f, "\tli $v0, 10\n\tsyscall\n");

    // parcours de tous les quads avant le main
    for (size_t i = 0 ; i < code->main_quad ; i++)
    {
        if (&(code->quads[i]) != NULL)
        {
            gencode_mips_quad(f, &(code->quads[i]));
        }
    }
}

void gencode_mips_quad(FILE *f, Quad *quad)
{
    /*if (global_code[quad_num]->brenched == TRUE)
    {
        char * label = new_label_quad_num (quad_num);
        fprintf (f, "\n%s:\n", label);
        free (label);
    }*/
        
    switch(quad->kind)
    {
        case BOP_PLUS:
        case BOP_MINUS:
        case BOP_MULT:
        case BOP_DIV:
        case BOP_MOD:
            gencode_arith_binary_op(f, quad);
            break;
        case BOP_OR:
        case BOP_AND:
        case BOP_EQ:
        case BOP_NEQ:
            gencode_arith_binary_op(f, quad);
            break;
        case UOP_MINUS:
            gencode_arith_unary_op(f, quad);
            break;
        case UOP_NOT:
            gencode_arith_unary_op(f, quad);
            break;
        case COPY:
            gencode_affect(f, quad);
            break;
        case CALL_PRINT:
            gencode_print(f, quad);
            break;
        case CALL_PRINTF:
            gencode_print(f, quad);
            break;
        /*
        case Q_IF:
            gencode_if (f, global_code[quad_num]);
            break;
        case Q_GOTO:
            global_code[quad_num+1]->brenched = TRUE;
            int goto_quad_num = global_code[quad_num]->op1->content.goto_quad_num;
            if (goto_quad_num >= 0 && goto_quad_num < (int)next_quad) {
                    fprintf (f, "\tb %d_label:\n", goto_quad_num);
            }
            break;
            case Q_AFFECT:
                gencode_affect (f, global_code[quad_num]);
                break;
            case Q_SUP:
            case Q_INF:
            case Q_SUP_EQ:
            case Q_INF_EQ:
                gencode_sup_inf (f, global_code[quad_num]);
                break;
            case Q_PRE_CALL :
                methode_pre_call (f, global_code[quad_num]->op1->content.entry);
                break;
            case Q_PUSH_ARG :
                methode_push_arg (f, global_code[quad_num]->res->content.entry->size_param, global_code[quad_num]->op1, global_code[quad_num]->op2->content.cst->value);
                break;
            case Q_CALL :
                methode_call (f, global_code[quad_num]->op1->content.entry);
                break;
            case Q_METH_DECL:
                methode_decl (f, global_code[quad_num]->op1->content.entry);
                break;
            case Q_METH_JR:
                methode_jr (f, global_code[quad_num]->op1->content.entry);
                break;*/
                                
            default:
                printf ("Error : Quad type not recognized\n");
                break;
        }
}

void gencode_arith_unary_op (FILE * f, Quad *quad)
{
    if(quad->kind == UOP_MINUS)
    {
        load_operator(f, quad->sym2);
        if(quad->sym1->type == INT)
        {
            fprintf (f, "\tneg $t%d, $t%d\n", current_register_int, current_register_int - 1);
            current_register_int++;
        }
        else if(quad->sym1->type == FLOAT)
        {
            fprintf (f, "\tneg.s $f%d, $f%d\n", current_register_float, current_register_float - 1);
            current_register_float++;
        }
        store_result(f, quad->sym1, 0);
        return;
    }
    else if(quad->kind == UOP_NOT)
    {
        load_operator(f, quad->sym2);

        fprintf (f, "\tnor $t%d, $t%d, $zero\n", current_register_int, current_register_int - 1);
        current_register_int++;
        store_result(f, quad->sym1, 0);
        return;
    }
}

void gencode_arith_binary_op (FILE * f, Quad *quad)
{
    //////////////////////////////////////////////////////////////
    // convertir les opérandes en int ou float selon le type du résultat

    __uint32_t type_change_sym2=0;
    __uint32_t type_change_sym3=0;
    if(quad->sym1->type == INT)
    {
        type_change_sym2 = convert_float_to_int(quad->sym2);
        type_change_sym3 = convert_float_to_int(quad->sym3);
    }
    else if(quad->sym1->type == FLOAT)
    {
        type_change_sym2 = convert_int_to_float(quad->sym2);
        type_change_sym3 = convert_int_to_float(quad->sym3);
    }
    
    // récupérer la valeur de op1 dans un registre temp
    load_operator(f, quad->sym2);
    // récupérer la valeur de op2 dans un autre registre temp
    load_operator(f, quad->sym3);

    if (quad->kind == BOP_PLUS)
    {
        if(quad->sym1->type == INT)
            fprintf (f, "\tadd $t%d, $t%d, $t%d\n", current_register_int, current_register_int - 2, current_register_int - 1);
        else if(quad->sym1->type == FLOAT)
            fprintf (f, "\tadd.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }
    else if (quad->kind == BOP_MINUS)
    {
        if(quad->sym1->type == INT)
            fprintf (f, "\tsub $t%d, $t%d, $t%d\n", current_register_int, current_register_int - 2, current_register_int - 1);
        else if(quad->sym1->type == FLOAT)
            fprintf (f, "\tsub.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }
    else if (quad->kind == BOP_MULT)
    {
        if(quad->sym1->type == INT)
        {
            fprintf (f, "\tmult $t%d, $t%d\n", current_register_int - 2, current_register_int - 1);
            fprintf (f, "\tmflo $t%d\n", current_register_int);
        }
        else if(quad->sym1->type == FLOAT)
            fprintf (f, "\tmul.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }
    else if(quad->kind == BOP_DIV)
    {
        if(quad->sym1->type == INT)
        {
            fprintf (f, "\tdiv $t%d, $t%d\n", current_register_int - 2, current_register_int - 1);
            fprintf (f, "\tmflo $t%d\n", current_register_int);
        }
        else if(quad->sym1->type == FLOAT)
            fprintf (f, "\tdiv.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }
    else if(quad->kind == BOP_MOD)
    {
        if(quad->sym1->type == INT)
        {
            fprintf (f, "\tdiv $t%d, $t%d\n", current_register_int - 2, current_register_int - 1);
            fprintf (f, "\tmfhi $t%d\n", current_register_int);
        }
        else if(quad->sym1->type == FLOAT)
            fprintf (f, "\tdiv.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
    }
    else if(quad->kind == BOP_OR)
    {
        fprintf (f, "\tor $t%d, $t%d, $t%d\n", current_register_int, current_register_int - 2, current_register_int - 1);
    }
    else if(quad->kind == BOP_AND)
    {
        fprintf (f, "\tand $t%d, $t%d, $t%d\n", current_register_int, current_register_int - 2, current_register_int - 1);
    }

    //////////////////////////////////////////////////////////////
    // stocker le résultat dans un registre
    if(quad->sym1->type == INT)
        current_register_int++;
    else if(quad->sym1->type == FLOAT)
        current_register_float++;

    store_result(f, quad->sym1, 0);

    if(quad->sym1->type == INT)
        current_register_int-=2;
    else if(quad->sym1->type == FLOAT)
        current_register_float-=2;

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
    if(quad->sym1->type == INT)
    {
        type_change_sym2 = convert_float_to_int(quad->sym2);
        
        load_operator(f, quad->sym2);
        store_result (f, quad->sym1, 0);

        if(type_change_sym2)
            convert_int_to_float(quad->sym2);
    }
    else if(quad->sym1->type == FLOAT)
    {
        type_change_sym2 = convert_int_to_float(quad->sym2);
        
        load_operator(f, quad->sym2);
        store_result (f, quad->sym1, 0);
        
        if(type_change_sym2)
            convert_float_to_int(quad->sym2);
    }   
}

void gencode_print(FILE *f, Quad *quad)
{
    if(quad->kind == CALL_PRINT)
    {
        if(quad->function_parameters[0]->type == INT)
        {
            load_operator(f, quad->function_parameters[0]);
            fprintf (f, "\tli $v0, 1\n");
            fprintf (f, "\tmove $a0, $t%d\n", current_register_int - 1);
            fprintf (f, "\tsyscall\n");
            current_register_int--;
        }
        else if(quad->function_parameters[0]->type == FLOAT)
        {
            load_operator(f, quad->function_parameters[0]);
            fprintf (f, "\tli $v0, 2\n");
            fprintf (f, "\tmov.s $f12, $f%d\n", current_register_float - 1);
            fprintf (f, "\tsyscall\n");
            current_register_float--;
        }
    }
    else if(quad->kind == CALL_PRINTF)
    {
        // caractere d'échappement : \n, \t, \\, \"
        if(quad->function_parameters[0]->type == STRING)
        {
            fprintf(f, "\tli $v0, 4\n");
            fprintf(f, "\tla $a0, %d($fp)\n", -4*quad->function_parameters[0]->attribute.string.frame_pointer);
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
                            printf("Error : unknown special character\n");
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
    else if(quad->kind == CALL_PRINTMAT)
    {
    }
}

void load_operator (FILE * f, SymbolTableElement *elem)
{
    // récupérer la valeur de op1 dans un registre temp
    if (elem->class == VARIABLE)
    {
        if(elem->type == INT)
        {
            // Pour charger un int, on le charge dans un registre float puis on le convertit en int
            // si variable globale
            if(elem->attribute.variable.frame_pointer == -1)
            {
                if(fp_type[elem->attribute.variable.frame_pointer] == FLOAT)
                {
                    fprintf (f, "\tl.s $f%d, %s\n", current_register_float, elem->attribute.variable.name);
                    fprintf(f, "\tcvt.w.s $f%d, $f%d\n", current_register_float, current_register_float);
                    fprintf(f, "\tmfc1 $t%d, $f%d\n", current_register_int, current_register_float);
                }
                else
                {
                    fprintf (f, "\tlw $t%d, %s\n", current_register_int, elem->attribute.variable.name);
                }
            }
            else
            {
                if(fp_type[elem->attribute.variable.frame_pointer] == FLOAT)
                {
                    fprintf (f, "\tl.s $f%d, %d($fp)\n", current_register_float, -4 * (elem->attribute.variable.frame_pointer + 1));
                    fprintf(f, "\tcvt.w.s $f%d, $f%d\n", current_register_float, current_register_float);
                    fprintf(f, "\tmfc1 $t%d, $f%d\n", current_register_int, current_register_float);
                }
                else
                {
                    fprintf (f, "\tlw $t%d, %d($fp)\n", current_register_int, -4 * (elem->attribute.variable.frame_pointer + 1));
                }
            }
            current_register_int++;
        }
        else if (elem->type == FLOAT)
        {
            if(elem->attribute.variable.frame_pointer == -1)
            {
                if(fp_type[elem->attribute.variable.frame_pointer] == INT)
                {
                    fprintf (f, "\tlw $t%d, %s\n", current_register_int, elem->attribute.variable.name);
                    fprintf(f, "\tmtc1 $t%d, $f%d\n", current_register_int, current_register_float);
                    fprintf(f, "\tcvt.s.w $f%d, $f%d\n", current_register_float, current_register_float);
                }
                else
                {
                    fprintf (f, "\tl.s $f%d, %s\n", current_register_float, elem->attribute.variable.name);
                }
            }
            else
            {
                if(fp_type[elem->attribute.variable.frame_pointer] == INT)
                {
                    fprintf (f, "\tlw $t%d, %d($fp)\n", current_register_int, -4 * (elem->attribute.variable.frame_pointer + 1));
                    fprintf(f, "\tmtc1 $t%d, $f%d\n", current_register_int, current_register_float);
                    fprintf(f, "\tcvt.s.w $f%d, $f%d\n", current_register_float, current_register_float);
                }
                else
                {
                    fprintf (f, "\tl.s $f%d, %d($fp)\n", current_register_float, -4 * (elem->attribute.variable.frame_pointer + 1));
                }
            }
            current_register_float++;
        }
    }
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
        //if((unsigned_operator != NULL) && (quadop->content.cst->type == TYPE_INT) && (quadop->content.cst->value > 0))
            // (*unsigned_operator) ++;
    }
    // else if (quadop->flag == BOOL_EXPR) {
    //     if (quadop->content.bool_expr->bool_flag == IDENT) {
    //         fprintf (f, "\tlw $t%zu, ", nb_reg_temp);
    //         if (quadop->content.bool_expr->bool_content.temp->frame_pointer == -1)
    //             fprintf (f, "%s\n", quadop->content.bool_expr->bool_content.temp->label);
    //         else
    //             fprintf (f, "%d($fp)\n", -4 * (quadop->content.bool_expr->bool_content.temp->frame_pointer + 1));   
    //     }
    //     else if (quadop->flag == CST) {
    //         fprintf (f, "\tli $t%zu, %d\n", nb_reg_temp, quadop->content.bool_expr->bool_content.constant);
    //         // toujours de type bool
    //         // donc on ne va pas actualiser la valeur de unsigned_operator
    //     }
    //     nb_reg_temp ++;
    // }
}

void store_result (FILE * f, SymbolTableElement *res, __uint32_t frame_pointer_res)
{
    if (res != NULL)
    {
        if (res->class == VARIABLE)
        {
            if(res->type == INT)
            {
                // variable non temporaire ie declarée dans .data
                if(res->attribute.variable.frame_pointer == -1)
                {
                    // get the address of the variable
                    fprintf (f, "\tla $t%d, %s\n", current_register_int, res->attribute.variable.name);
                    // save the value in this address
                    fprintf (f, "\tsw $t%d, 0($t%d)\n", current_register_int - 1, current_register_int);

                    // current_register_int--;
                }
                else
                {
                    fprintf(f, "\tsw $t%d, %d($fp)\n", current_register_int - 1, -4 * (res->attribute.variable.frame_pointer + 1));
                    fp_type[res->attribute.variable.frame_pointer] = res->type;
                }
                current_register_int--;
            }
            else if(res->type == FLOAT)
            {
                // variable non temporaire ie declarée dans .data
                if(res->attribute.variable.frame_pointer == -1)
                {
                    // get the address of the variable
                    fprintf (f, "\tla $t%d, %s\n", current_register_int, res->attribute.variable.name);
                    // save the value in this address
                    fprintf (f, "\ts.s $f%d, 0($t%d)\n", current_register_float-1, current_register_int);
                    // current_register_float--;
                }
                else
                {
                    fprintf (f, "\ts.s $f%d, %d($fp)\n", current_register_float - 1, -4 * (res->attribute.variable.frame_pointer + 1));
                    fp_type[res->attribute.variable.frame_pointer] = res->type;
                }
                current_register_float--;
            }
        }
    }
    else
    {
        if(res->type == INT)
        {
            fprintf (f, "\tsw $t%d, %d($fp)\n", current_register_int - 1, frame_pointer_res);
            current_register_int--;
        }
        else if(res->type == FLOAT)
        {
            fprintf (f, "\ts.s $f%d, %d($fp)\n", current_register_float - 1, frame_pointer_res);
            current_register_float--;
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

char* generate_label()
{
    char* label = (char*)malloc(20);
    sprintf(label, "Label_%d", label_counter);
    label_counter++;

    return label;
}
