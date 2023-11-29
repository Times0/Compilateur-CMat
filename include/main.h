#pragma once

#include <unistd.h> // for getopt
#include <stdio.h>
#include <stdlib.h>

#include "symbol_table.h"
#include "cmat.lex.h"
#include "cmat.tab.h"
#include "ast.h"

tree_t *root;