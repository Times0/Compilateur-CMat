import re
import sys

def replace_print_with_printf(input_file, output_file):
    with open(input_file, 'r') as file:
        content = file.read()

    # for each occurence of print. Find the type of the argument (int or float) and transform it to printf using the type %d or %f
    pattern = re.compile(r'print\((.*)\)')
    matches = pattern.findall(content)
    
    for match in matches:
        if '.' in match:
            tp = '%f'
        else:
            tp = '%d'
        content = content.replace(f'print({match})', f'printf("{tp}", {match})')
    replaced_content = content

    with open(output_file, 'w') as file:
        file.write(replaced_content)


def add_libs(input_file, output_file):
    with open(input_file, 'r') as file:
        content = file.read()

    replaced_content = '#include <stdio.h>\n' + content

    with open(output_file, 'w') as file:
        file.write(replaced_content)


def add_return_to_main(input_file, output_file):
    # find last }
    # add return 0;
    
    with open(input_file, 'r') as file:
        content = file.read()
        
    last_bracket = content.rfind('}')
    if last_bracket == -1:
        print("Error: no closing bracket found")
        exit(1)
        
    replaced_content = content[:last_bracket] + '\treturn 0;\n' + content[last_bracket:]
    
    with open(output_file, 'w') as file:
        file.write(replaced_content)
        

if __name__ == '__main__':
    if len(sys.argv) < 3:
        print("Usage: python3 c2cmat.py <input_file> <output_file>")
        exit(1)
    input_path = sys.argv[1]
    output_path = sys.argv[2]

    add_libs(input_path, output_path)
    replace_print_with_printf(output_path, output_path)
    add_return_to_main(output_path, output_path)

