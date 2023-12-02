#include "../include/mips.h"
#include <stdio.h>
#include "../include/quad.h"
#include "../include/symbol_table.h"
#include "cmat.tab.h"

//////////////////////////
//  On suppose que le programme est une suite de declarations de fonctions
//  suivie d'une fonction main
//////////////////////////

__uint32_t current_register_int = 0;
__uint32_t current_register_float = 0;

// Voir code pour modification 
void gencode_mips_global_variable(FILE * f, SymbolTable * s)
{
    fprintf (f, ".data\n");
    
    for (__uint32_t i=0 ; i < s->size; i++)
    {
        if(s->symbols[i].class == VARIABLE && s->symbols[i].attribute.variable.offset == -1)
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

    // parcours de tous les quads apres le main
    for (size_t i = code->main_quad; i < code->nextquad; i ++)
    {
        if(&(code->quads[i]) != NULL) // Peut etre inutile
        {
            gencode_mips_quad(f, &(code->quads[i]));
        }
    }
    
    // fprintf (f, "\tlw $a0, a\n\tli $v0, 1\n\tsyscall\n");
    fprintf (f, "\tl.s $f12, a\n\tli $v0, 2\n\tsyscall\n");

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
            gencode_arith_binary_op(f, quad);
            break;
        case BOP_MINUS:
            gencode_arith_binary_op(f, quad);
            break;
        case UOP_MINUS:
            gencode_arith_unary_op(f, quad);
            break;
        case COPY:
            gencode_affect(f, quad);
            break;
        /*case Q_SUB:
        case Q_MULT:
        case Q_DIV:
        case Q_MOD:
            gencode_arith_binary_op (f, global_code[quad_num]);
            break;
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
                printf ("Error : quad type not recognized\n");
                break;
        }
}

void gencode_arith_unary_op (FILE * f, Quad *quad)
{
    if(quad->kind == UOP_MINUS)
    {
        load_operator(f, quad->sym2, NULL);
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
}

void gencode_arith_binary_op (FILE * f, Quad *quad)
{
    __uint32_t unsigned_operators = 0;
    
    // récupérer la valeur de op1 dans un registre temp
    load_operator(f, quad->sym2, &unsigned_operators);
    // récupérer la valeur de op2 dans un autre registre temp
    load_operator(f, quad->sym3, &unsigned_operators);

    if (quad->kind == BOP_PLUS)
    {
        if(quad->sym1->type == INT)
        {
            if(unsigned_operators == 2)
                fprintf (f, "\taddu ");
            else
                fprintf (f, "\tadd ");
            fprintf (f, "$t%d, $t%d, $t%d\n", current_register_int, current_register_int - 2, current_register_int - 1);
        }
        else if(quad->sym1->type == FLOAT)
        {
            fprintf (f, "\tadd.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
        }
    }
    else if (quad->kind == BOP_MINUS)
    {
        if(quad->sym1->type == INT)
        {
            if(unsigned_operators == 2)
                fprintf (f, "\tsubu ");
            else
                fprintf (f, "\tsub ");
            fprintf (f, "$t%d, $t%d, $t%d\n", current_register_int, current_register_int - 2, current_register_int - 1);
        }
        else if(quad->sym1->type == FLOAT)
        {
            fprintf (f, "\tsub.s $f%d, $f%d, $f%d\n", current_register_float, current_register_float - 2, current_register_float - 1);
        }
    }
    /*else if (quad->type == Q_MULT) {
        // stocker le résultat de (op1 * op2) dans un autre registre temp
        if (unsigned_operators == 2)
            fprintf (f, "\tmultu ");
        else
            fprintf (f, "\tmult ";
        fprintf (f, "\t$t%zu, $t%zu\n", nb_reg_temp - 2, nb_reg_temp - 1);

        // mult $s,$t ⇐⇒ [Hi ← pref_32($s * $t)] & [Lo ← suff_32($s * $t)]
        fprintf (f, "\tmflo $t%zu\n", nb_reg_temp);
    }
    else if (quad->type == Q_DIV || quad->type == Q_MOD) {
        // stocker le résultat de (op1 / op2) dans un autre registre temp
        if (unsigned_operators == 2)
            fprintf (f, "\tdivu ");
        else
            fprintf (f, "\tdiv ");
        fprintf (f, "$t%zu, $t%zu\n", nb_reg_temp - 2, nb_reg_temp - 1);

        // div $s,$t ⇐⇒ [Hi ← ($s % $t)] & [Lo ← ($s / $t)]
        if (quad->type == Q_DIV)
            fprintf (f, "\tmflo $t%zu\n", nb_reg_temp);
        
        else if (quad->type == Q_MOD)
            fprintf (f, "\tmfhi $t%zu\n", nb_reg_temp);
    }*/

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

void gencode_affect (FILE * f, Quad *quad)
{
    load_operator(f, quad->sym2, NULL);

    store_result (f, quad->sym1, 0);
}

void load_operator (FILE * f, SymbolTableElement *elem, __uint32_t *unsigned_operator)
{
    // récupérer la valeur de op1 dans un registre temp
    if (elem->class == VARIABLE)
    {
        if(elem->type == INT)
        {
            fprintf (f, "\tlw $t%d, ", current_register_int);
            if (elem->attribute.variable.offset == -1)
                fprintf(f, "%s\n", elem->attribute.variable.name);
            else
                fprintf(f, "%d($fp)\n", -4 * (elem->attribute.variable.offset + 1));   
            current_register_int++;    
        }
        else if (elem->type == FLOAT)
        {
            fprintf (f, "\tl.s $f%d, ", current_register_float);
            if (elem->attribute.variable.offset == -1)
                fprintf(f, "%s\n", elem->attribute.variable.name);
            else
                fprintf(f, "%d($fp)\n", -4 * (elem->attribute.variable.offset + 1));
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
    //         if (quadop->content.bool_expr->bool_content.temp->offset == -1)
    //             fprintf (f, "%s\n", quadop->content.bool_expr->bool_content.temp->label);
    //         else
    //             fprintf (f, "%d($fp)\n", -4 * (quadop->content.bool_expr->bool_content.temp->offset + 1));   
    //     }
    //     else if (quadop->flag == CST) {
    //         fprintf (f, "\tli $t%zu, %d\n", nb_reg_temp, quadop->content.bool_expr->bool_content.constant);
    //         // toujours de type bool
    //         // donc on ne va pas actualiser la valeur de unsigned_operator
    //     }
    //     nb_reg_temp ++;
    // }
}

void store_result (FILE * f, SymbolTableElement *res, __uint32_t offset_res)
{
    if (res != NULL)
    {
        if (res->class == VARIABLE)
        {
            if(res->type == INT)
            {
                // variable non temporaire ie declarée dans .data
                if(res->attribute.variable.offset == -1)
                {
                    // get the address of the variable
                    fprintf (f, "\tla $t%d, %s\n", current_register_int, res->attribute.variable.name);
                    // save the value in this address
                    fprintf (f, "\tsw $t%d, 0($t%d)\n", current_register_int - 1, current_register_int);

                    // current_register_int--;
                }
                else
                    fprintf (f, "\tsw $t%d, %d($fp)\n", current_register_int - 1, -4 * (res->attribute.variable.offset + 1));
                current_register_int--;
            }
            else if(res->type == FLOAT)
            {
                // variable non temporaire ie declarée dans .data
                if(res->attribute.variable.offset == -1)
                {
                    // get the address of the variable
                    fprintf (f, "\tla $t%d, %s\n", current_register_int, res->attribute.variable.name);
                    // save the value in this address
                    fprintf (f, "\ts.s $f%d, 0($t%d)\n", current_register_float-1, current_register_int);
                    // current_register_float--;
                }
                else
                    fprintf (f, "\ts.s $f%d, %d($fp)\n", current_register_float - 1, -4 * (res->attribute.variable.offset + 1));
                current_register_float--;
            }
        }
    }
    else
    {
        if(res->type == INT)
        {
            fprintf (f, "\tsw $t%d, %d($fp)\n", current_register_int - 1, offset_res);
            current_register_int--;
        }
        else if(res->type == FLOAT)
        {
            fprintf (f, "\ts.s $f%d, %d($fp)\n", current_register_float - 1, offset_res);
            current_register_float--;
        }
    }
}
