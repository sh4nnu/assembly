BITS 32
 
section .bss
    sinput: resb 255

section .data
    msg1 db 'Hello world!',10, 0
    msg2 db 'This is manikishan G',10, 0

section .text 

    global main

    main:
        
        mov ecx, 0
    
    nextnumber:
        inc ecx
        
        mov eax, ecx
        call iprintLN
        cmp ecx, 20
        jne nextnumber
        call quit

; functions

    atoi:
        push ebp
        mov ebp, esp
        
        push ebx
        push ecx
        push edx
        push esi
        mov esi, eax
        mov eax, 0
        mov ecx, 0
        
    .multiplyloop:
        xor ebx, ebx
        mov bl, [esi+ecx]
        cmp bl, 48
        jl .finished
        cmp bl, 57
        jg .finished
        cmp bl, 10 
        je .finished
        cmp bl, 0
        je .finished
        
        sub bl, 48
        add eax, ebx
        mov ebx, 10
        mul ebx
        inc ecx
        jmp .multiplyloop
        
    .finished:
        mov ebx, 10
        div ebx
        pop esi
        pop edx
        pop ecx
        pop ebx
        
        mov esp, ebp
        pop ebp
        ret
        
        
    
        
    slen:
        push ebp
        mov ebp, esp
        
        push ebx
        mov ebx, eax
        
        
    
    nextchar:
        
        cmp byte [eax], 0
        jz finished
        inc eax
        jmp nextchar
        
    finished:
        sub eax, ebx
        pop ebx
        
        mov esp, ebp
        pop ebp
        ret
        
    
    sprint:
        push ebp
        mov ebp, esp
        
        
        push edx
        push ecx
        push ebx
        push eax
        call slen
        
        mov edx, eax
        pop eax
        
        mov ecx, eax
        mov ebx, 1
        mov eax, 4
        int 80h
        
        pop ebx
        pop ecx
        pop edx
        
        mov esp, ebp
        pop ebp
        ret
        
        
    sprintLN:
        push ebp
        mov ebp, esp
        
        call sprint
        
        push eax
        mov eax, 0Ah
        push eax
        mov eax, esp
        call sprint
        pop eax
        pop eax
        
        mov esp, ebp
        pop ebp
        ret
    
    
    iprint:
        push ebp
        mov ebp,esp
        
        push eax
        push ecx
        push edx
        push esi
        mov ecx, 0
    
    divideloop:
        inc ecx
        mov edx, 0
        mov esi, 10
        idiv esi
        add edx, 48
        push edx
        cmp eax,0
        jnz divideloop
        
    printloop:
        dec ecx
        mov eax, esp
        call sprint
        pop eax
        cmp ecx, 0
        jnz printloop
        
        pop esi
        pop edx
        pop ecx
        pop eax
        
        
        mov esp, ebp
        pop ebp
        ret
    iprintLN:
        push ebp
        mov ebp, esp
        
        
        call iprint
        
        push eax
        mov eax, 0Ah
        push eax
        mov eax, esp
        call sprint
        pop eax
        pop eax
        
        mov esp, ebp
        pop ebp
        ret
        
        
    quit:
        mov ebx, 0
        mov eax, 1
        int 80h
        ret
        
