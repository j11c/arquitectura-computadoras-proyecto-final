# Compilador/Ensamblador para CPU

## Uso

```bash
python assembler.py archivo_entrada.txt archivo_salida.txt
```

**Ejemplo:**
```bash
python assembler.py ejemplo_programa.txt programa_compilado.txt
```

## Formato de Instrucciones

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

### Dirección de Memoria (Hexadecimal)
- Formato: `0x000` a `0x3FF`

### Inmediato
- Formato: `#0` a `#4095`

## Modos de Direccionamiento

| Modo | Bits | Formato | Ejemplo |
|------|------|---------|---------|
| reg-reg | 00 | `COOP letra, letra` | `ADD A, B` |
| reg-mem | 01 | `COOP letra, 0x3FF` | `LOAD A, 0x100` |
| mem-reg | 10 | `COOP 0x3FF, letra` | `LOAD 0x100, A` |
| reg-imm | 11 | `COOP letra, #1023` | `LOAD A, #10` |

## Lista de Instrucciones

- `ADD destino, fuente` - Suma
- `SUB destino, fuente` - Resta
- `MUL destino, fuente` - Multiplicación
- `DIV destino, fuente` - División

- `AND destino, fuente` - AND bitwise
- `OR destino, fuente` - OR bitwise

- `NOT registro` - NOT bitwise

- `CMP destino, fuente` - Compara y actualiza flags

- `LOAD destino, fuente` - Carga directa
- `ILOAD destino, [fuente]` - Carga indirecta

- `INC registro` - Incrementar
- `DEC registro` - Decrementar

- `SHL registro` - Shift left
- `SHR registro` - Shift right

- `IN registro` - Leer del puerto de entrada
- `OUT registro` - Escribir al puerto de salida

- `JMP dirección` - Salto incondicional
- `JGT dirección` - Saltar si mayor (flags)
- `JEQ dirección` - Saltar si igual (flags)
- `JLT dirección` - Saltar si menor (flags)

- `HALT` - Detener ejecución
- `NOP` - No operation

## Formato de Salida

El programa genera código binario en formato VHDL listo para copiar y pegar:

```vhdl
"1001110010", -- linea 1 / direccion 0
"1001010100", -- linea 2 / direccion 1
...
