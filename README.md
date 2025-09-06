# 42SP_Advanced_libsasm

**General purpose registers (GRPs)**

Thinking about CPU registers, we have someones that are considered GRPs, for example, three of that are eax,
edx and ecx.

The difference between them is:

### **EAX: The 'accumulator' register:**

The **'A'** in EAX stands for **Accumulator**. This is the most important register for aritmetic and
function results.

* **Primary job:** Storing the return value of a function. When a function in C or C++ finishes, the computer's
final instuction (before ret) is almost always mov eax, [your result]. The code that called the function knows 
to look in EAX for the answer

* **Special math:** Many math instructions are optimized for, or equire, EAX. For example, the mul (multiply) and
div (divide) instructions automatically assume that one of the operands is already in EAX.

----

### **EXC: The 'counter' register:**

The **'C'** in EXC stands for Counter

* **Primary job:** This register is the default counter for loops.

* **Special instructions:** CPU instructions like LOOPre hard-wired to use ECX. When you use the LOOP instruction,
the CPU automatically subtracts 1 from ECX and then checks if ECX is zero. If it's not zero, it automatically
jumps back to the start of the loop.

* **Other uses:** It's also used by shift/rotate instructions (like SHL and ROR) to specify how many bits to shift,
* where the shift count is placed in CL (the lowest 8 bits of ECX).

----

### **EDX: The 'data' register:**

The **'D'** in EDX stands for **Data**, it's the dedicated partner to EAX for complex math.

* **Primary job:** it holds the 'other half' of very large numbers when doing multiplication or division

* **Example (multiplication/division):** A 32-bit CPU register can only hold a 32-bit number. What happens if you
multiply two 32-bits number? The result can be up to 64 bits long!

The CPU automatically handles this by splitting the 64-bit result into two 32-bit pieces. The 'high' (most significant)
32 bits are placed in EDX, and the 'low' (least significant) 32 bits are placed in EAX.

In division, the reverse is also true. To divide a giant 64-bit number, you must first load the 'high' part into
EDX and the 'low' part into EAX before you can run the div instruction

### **EBX: the base pointer:**

The **'B'** indicates it's part of the Base register family. In older 16-bit systems, the corresponding register was
BX. On modern 64-bit systems, the full 64-bit version is RBX with EBX representing its lower 32 bits.

* **Primary job:** EBX is frequently used as a base pointer for memory addressing, particularly when accsessing data
withing arrays or data structures. For example, mov eax, [ebx] would load the value at the memory address stored in
EBX into EAX.

* **Function arguments, return values and temporary data**: In some calling conventions or specific program designs,
EBX might be used to pass function arguments or store return values, though EAX is more commonly associated with
return values.