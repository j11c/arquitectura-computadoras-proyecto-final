# Compilador/Ensamblador para CPU

Este compilador convierte instrucciones en texto a código binario en formato VHDL.

## Uso

```bash
python assembler.py <archivo_entrada.txt> [archivo_salida.txt]
```

**Ejemplo:**
```bash
python assembler.py ejemplo_programa.txt programa_compilado.txt
```

## Formato de Instrucciones

### Tres formatos soportados:

1. **COOP destino, fuente** (2 operandos)
   ```
   ADD A, B
   LOAD A, #10
   ```

2. **COOP destino** (1 operando)
   ```
   NOT A
   INC B
   OUT C
   ```

3. **COOP** (sin operandos)
   ```
   HALT
   NOP
   ```

## Tipos de Operandos

### Registros
- `A`, `B`, `C`, `D`
- Ejemplo: `ADD A, B`

### Dirección de Memoria (Hexadecimal)
- Formato: `0x000` a `0x3FF`
- Ejemplo: `LOAD A, 0x100`

### Inmediato
- Formato: `#0` a `#4095`
- Ejemplo: `LOAD A, #255`

## Modos de Direccionamiento

| Modo | Bits | Formato | Ejemplo |
|------|------|---------|---------|
| reg-reg | 00 | `COOP letra, letra` | `ADD A, B` |
| reg-mem | 01 | `COOP letra, 0x3FF` | `LOAD A, 0x100` |
| mem-reg | 10 | `COOP 0x3FF, letra` | `LOAD 0x100, A` |
| reg-imm | 11 | `COOP letra, #1023` | `LOAD A, #10` |

## Lista de Instrucciones

### Operaciones Aritméticas (2 parámetros)
- `ADD destino, fuente` - Suma
- `SUB destino, fuente` - Resta
- `MUL destino, fuente` - Multiplicación
- `DIV destino, fuente` - División

### Operaciones Lógicas (2 parámetros)
- `AND destino, fuente` - AND bitwise
- `OR destino, fuente` - OR bitwise

### Operaciones Lógicas (1 parámetro)
- `NOT registro` - NOT bitwise

### Operaciones de Comparación
- `CMP destino, fuente` - Compara y actualiza flags

### Carga/Almacenamiento
- `LOAD destino, fuente` - Carga directa
- `ILOAD destino, [fuente]` - Carga indirecta

### Incremento/Decremento (1 parámetro)
- `INC registro` - Incrementar
- `DEC registro` - Decrementar

### Desplazamientos (1 parámetro)
- `SHL registro` - Shift left
- `SHR registro` - Shift right

### Entrada/Salida (1 parámetro)
- `IN registro` - Leer del puerto de entrada
- `OUT registro` - Escribir al puerto de salida

### Control de Flujo
- `JMP dirección` - Salto incondicional
- `JGT dirección` - Saltar si mayor (flags)
- `JEQ dirección` - Saltar si igual (flags)
- `JLT dirección` - Saltar si menor (flags)

### Control
- `HALT` - Detener ejecución
- `NOP` - No operation

## Formato de Salida

El programa genera código binario en formato VHDL listo para copiar y pegar:

```vhdl
"1001110010", -- linea 1 / direccion 0
"1001010100", -- linea 2 / direccion 1
...
```

Cada línea contiene:
- 10 bits en formato binario
- Comentario con número de línea y dirección
