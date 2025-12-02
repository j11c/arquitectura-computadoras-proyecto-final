import re
import sys

# Mapeo de nemónicos a COOP (4 bits)
COOP = {
    'HALT': '0000',
    'ADD':  '0001',
    'SUB':  '0010',
    'MUL':  '0011',
    'DIV':  '0100',
    'AND':  '0101',
    'OR':   '0110',
    'NOT':  '0111',
    'CMP':  '1000',
    'LOAD': '1001',
    'INC':  '1010',
    'DEC':  '1010',
    'SHL':  '1011',
    'SHR':  '1011',
    'IN':   '1100',
    'OUT':  '1100',
    'JMP':  '1101',
    'ILOAD':'1110',
    'NOP':  '1111',
    'JGT':  '1101',
    'JEQ':  '1101',
    'JLT':  '1101'
}

# Mapeo de registros a código (2 bits)
REGISTERS = {
    'A': '00',
    'B': '01',
    'C': '10',
    'D': '11'
}

def parse_operand(operand):
    """
    Analiza un operando y retorna (tipo, valor)
    Tipos: 'reg', 'mem', 'imm', 'none'
    """
    operand = operand.strip().upper()
    
    if not operand:
        return ('none', 0)
    
    # Registro (A, B, C, D)
    if operand in REGISTERS:
        return ('reg', REGISTERS[operand])
    
    # Dirección de memoria (0x...)
    if operand.startswith('0X'):
        try:
            addr = int(operand, 16)
            if 0 <= addr <= 0x3FF:
                return ('mem', format(addr, '010b'))
            else:
                raise ValueError(f"Dirección de memoria fuera de rango: {operand}")
        except ValueError as e:
            raise ValueError(f"Dirección de memoria inválida: {operand}")
    
    # Inmediato (#...)
    if operand.startswith('#'):
        try:
            imm = int(operand[1:])
            if 0 <= imm <= 4095:
                return ('imm', format(imm, '012b'))
            else:
                raise ValueError(f"Inmediato fuera de rango: {operand}")
        except ValueError:
            raise ValueError(f"Inmediato inválido: {operand}")
    
    raise ValueError(f"Operando no reconocido: {operand}")

def get_modo_bits(mnemonic, dest_type, src_type):
    """
    Determina los bits de modo (2 bits) según el tipo de operandos
    """
    # Instrucciones especiales con modo fijo
    if mnemonic == 'DEC':
        return '11'  # DEC usa modo 11
    elif mnemonic == 'INC':
        return '00'  # INC usa modo 00
    elif mnemonic == 'SHR':
        return '11'  # SHR usa modo 11
    elif mnemonic == 'SHL':
        return '00'  # SHL usa modo 00
    elif mnemonic == 'OUT':
        return '10'  # OUT usa modo 10 (bit izquierdo = 1)
    elif mnemonic == 'IN':
        return '00'  # IN usa modo 00 (bit izquierdo = 0)
    elif mnemonic == 'ILOAD':
        return '00'  # ILOAD usa modo 00 para reg-reg indirecto
    
    # Formato estándar de 2 parámetros
    if dest_type == 'reg' and src_type == 'reg':
        return '00'  # reg-reg
    elif dest_type == 'reg' and src_type == 'mem':
        return '01'  # reg-mem
    elif dest_type == 'mem' and src_type == 'reg':
        return '10'  # mem-reg
    elif dest_type == 'reg' and src_type == 'imm':
        return '11'  # reg-inmediato
    elif dest_type == 'reg' and src_type == 'none':
        return '00'  # 1 parámetro (NOT, INC, DEC, etc.)
    else:
        return '00'  # Default

def assemble_instruction(line, line_num):
    """
    Ensambla una línea de instrucción a código binario de 10 bits
    Retorna una lista de instrucciones (puede ser 1 o 2 palabras)
    """
    # Limpiar comentarios
    if '--' in line:
        line = line.split('--')[0]
    
    line = line.strip()
    
    # Línea vacía
    if not line:
        return []
    
    # Separar por comas primero
    parts = [p.strip() for p in line.split(',')]
    
    # Separar mnemónico del primer operando
    tokens = parts[0].split()
    mnemonic = tokens[0].upper()
    
    # Validar mnemónico
    if mnemonic not in COOP:
        raise ValueError(f"Línea {line_num}: Mnemónico desconocido: {mnemonic}")
    
    coop = COOP[mnemonic]
    
    # Obtener operandos
    dest = tokens[1] if len(tokens) > 1 else ''
    src = parts[1] if len(parts) > 1 else ''
    
    dest_type, dest_val = parse_operand(dest)
    src_type, src_val = parse_operand(src)
    
    modo = get_modo_bits(mnemonic, dest_type, src_type)
    
    # Lista de palabras de memoria (1 o 2)
    instructions = []
    
    # Construir instrucción según el formato
    # COOP (4) | modo (2) | destino (2) | fuente/dato_alto (2) = 10 bits
    
    if dest_type == 'none' and src_type == 'none':
        # Instrucción sin operandos (HALT, NOP)
        instruction = coop + '000000'
        instructions.append(instruction)
        
    elif src_type == 'none':
        # Instrucción con 1 operando (NOT, INC, DEC, IN, OUT)
        if dest_type == 'reg':
            instruction = coop + modo + dest_val + '00'
            instructions.append(instruction)
        else:
            raise ValueError(f"Línea {line_num}: Formato inválido para {mnemonic}")
            
    elif dest_type == 'reg' and src_type == 'imm':
        # *** FORMATO DE 2 PALABRAS PARA INMEDIATOS ***
        # Palabra 1: COOP (4) | modo (2) | destino (2) | dato_alto[11:10] (2)
        # Palabra 2: dato_bajo[9:0] (10 bits)
        
        imm_12bits = src_val  # Ya es string binario de 12 bits
        dato_alto = imm_12bits[:2]   # Bits [11:10]
        dato_bajo = imm_12bits[2:]   # Bits [9:0]
        
        instruction1 = coop + modo + dest_val + dato_alto
        instruction2 = dato_bajo
        
        instructions.append(instruction1)
        instructions.append(instruction2)
        
    elif dest_type == 'reg' and src_type == 'mem':
        # *** FORMATO DE 2 PALABRAS PARA LOAD reg, mem ***
        # Palabra 1: COOP (4) | modo(01) (2) | destino (2) | 00 (2)
        # Palabra 2: dirección_memoria (10 bits)
        
        instruction1 = coop + modo + dest_val + '00'
        instruction2 = src_val  # Ya es string binario de 10 bits
        
        instructions.append(instruction1)
        instructions.append(instruction2)
        
    elif dest_type == 'mem' and src_type == 'reg':
        # *** FORMATO DE 2 PALABRAS PARA LOAD mem, reg (mem←reg) ***
        # Palabra 1: COOP (4) | modo(10) (2) | 00 (2) | fuente (2)
        # Palabra 2: dirección_memoria (10 bits)
        
        instruction1 = coop + modo + '00' + src_val
        instruction2 = dest_val  # Ya es string binario de 10 bits
        
        instructions.append(instruction1)
        instructions.append(instruction2)
        
    else:
        # reg-reg estándar
        instruction = coop + modo + dest_val + src_val
        instructions.append(instruction)
    
    # Asegurar que cada instrucción sea exactamente 10 bits
    instructions = [instr[:10].ljust(10, '0') for instr in instructions]
    
    return instructions

def compile_program(input_file, output_file):
    """
    Lee el archivo de entrada, ensambla las instrucciones y escribe la salida en formato VHDL
    """
    try:
        with open(input_file, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        
        binary_instructions = []
        
        for i, line in enumerate(lines, start=1):
            try:
                instructions = assemble_instruction(line, i)
                binary_instructions.extend(instructions)  # Puede agregar 1 o 2 palabras
            except ValueError as e:
                print(f"Error: {e}")
                return False
        
        # Generar salida en formato VHDL
        with open(output_file, 'w', encoding='utf-8') as f:
            for i, instr in enumerate(binary_instructions):
                f.write(f'"{instr}", -- linea {i+1} / direccion {i}\n')
            
            # Rellenar con NOPs hasta 1024 si es necesario
            remaining = 1024 - len(binary_instructions)
            if remaining > 0:
                for i in range(remaining):
                    addr = len(binary_instructions) + i
                    f.write(f'"{"1111000000"}", -- linea {addr+1} / direccion {addr} (NOP)\n')
        
        print(f"   Compilación exitosa!")
        print(f"   Entrada: {input_file}")
        print(f"   Salida: {output_file}")
        print(f"   Instrucciones: {len(binary_instructions)}")
        
        return True
        
    except FileNotFoundError:
        print(f"Error: No se encontró el archivo {input_file}")
        return False
    except Exception as e:
        print(f"Error inesperado: {e}")
        return False

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Uso: python assembler.py <archivo_entrada> [archivo_salida]")
        print("Ejemplo: python assembler.py programa.txt programa_bin.txt")
        sys.exit(1)
    
    input_file = sys.argv[1]
    output_file = sys.argv[2] if len(sys.argv) > 2 else 'output.txt'
    
    compile_program(input_file, output_file)
