; Maxstation Game Boy Clone Boot ROM


        ; $0000  Set up the Stack
        ld   sp, $FFFE

        ; $0003  Clear VRAM
        xor  a
        ld   hl, $9FFF
Addr_0007:
        ld   [hld], a
        bit  7,h
        jr   nz, Addr_0007

        ; $000C Set up Audio
        ld   hl, $FF26
        ld   c, $11
        ld   a, $80
        ld   [hld], a
        ld   [c], a
        inc  c
        ld   a, $F3
        ld   [c], a
        ld   [hld], a
        ld   a, $77
        ld   [hl], a

        ; $001D Set up Background Palette
        ld   a, $FC
        ldh  [$47], a   ; bgp


        ; $0021 Load the Boot Logo Image
        ;
        ; In the Maxstation it loads the image from the boot rom itself (at $00A8)
        ; instead of from the cart header (at $0104) as the DMG does
        ;
        ; Since it's reading from the boot rom instead of the cart header
        ; the ending address is $00D8 instead of $0134
        ;
        ld   de, $00A8 ; *DIFF* vs DMG bootrom: load logo data from bootrom instead of cart
        ld   hl, $8010
Addr_0027:
        ld   a, [de]
        call Sub_0095
        call Sub_0096
        inc  de
        ld   a,e
        cp   $D8       ; *DIFF* vs DMG bootrom: (DMG uses $34)
        jr   nz, Addr_0027

        ; $0034 Load blanked out "(R)" tile (converts to 2bpp)
        ;
        ; On the DMG boot rom this loads the "(R)" logo tile
        ; but here it's just blank tile data
        ld   de, $00D8
        ld   b, $08
Addr_0039:
        ld   a, [de]
        inc  de
        ld   [hli], a
        inc  hl
        dec  b
        jr   nz, Addr_0039


        ; $0040 Build Background Tile Map for the logo in VRAM
        ld   a, $19
        ld   [$9910], a
        ld   hl, $992F
Addr_0048:
        ld   c, $0C
Addr_004a:
        dec  a
        jr   z, Addr_0055
        ld   [hld], a
        dec  c
        jr   nz, Addr_004a
        ld   l, $0F
        jr   Addr_0048


        ; $0055 Logo Scroll down + Boot Sound
Addr_0055:
        ld   h, a
        ld   a, $64
        ld   d, a
        ldh  [$42], a ; scy
        ld   a, $91
        ldh  [$40], a ; lcdc
        inc  b
Addr_0060:
        ld   e, $02
Addr_0062:
        ld   c, $0C
Addr_0064:
        ldh  a, [$44] ; ly
        cp   $90
        jr   nz, Addr_0064
        dec  c
        jr   nz, Addr_0064
        dec  e
        jr   nz, Addr_0062
        ld   c, $13
        inc  h
        ld   a,h
        ld   e, $83
        cp   $62
        jr   z, Addr_0080
        ld   e, $C1
        cp   $64
        jr   nz, Addr_0086
Addr_0080:
        ld   a,e
        ld   [c], a
        inc  c
        ld   a, $87
        ld   [c], a
Addr_0086:
        ldh  a, [$42] ; scy
        sub  b
        ldh  [$42], a ; scy
        dec  d
        jr   nz, Addr_0060
        dec  b
        jr   nz, Addr_00e0
        ld   d, $20
        jr   Addr_0060


        ; $0095 Converts logo data to 2bpp and loads it into destination (VRAM)
Sub_0095:
        ld   c, a
Sub_0096:
        ld   b, $04
Addr_0098:
        push bc
        rl   c
        rla
        pop  bc
        rl   c
        rla
        dec  b
        jr   nz, Addr_0098
        ld   [hli], a
        inc  hl
        ld   [hli], a
        inc  hl
        ret

; $00A8
;"LOADING..." boot logo
.db $08,$88,$01,$22,$0C,$22,$02,$58,$03,$2A,$08,$42,$0E,$44,$08,$8C
.db $09,$AA,$0C,$20,$00,$00,$00,$00,$88,$8F,$22,$29,$22,$2C,$8F,$88
.db $AA,$AB,$22,$48,$44,$4E,$A9,$88,$AA,$A9,$E2,$2E,$00,$DD,$00,$BB

; $00D8
; Empty tile data where "(r)" symbol would be
.db $00,$00,$00,$00,$00,$00,$00,$00

        ; $00E0 Logo Check
        ;
        ; The Maxstation performs the calculations of the logo comparison test
        ; but skips over the results and does not lock up if there is no match.
        ;
Addr_00e0:
        ld   hl, $0104
        ld   de, $00A8
Addr_00e6:
        ld   a, [de]
        inc  de
        cp   [hl]
        nop       ; *DIFF* vs DMG bootrom: don't lockup here if logo doesn't match
        nop
        inc  hl
        ld   a,l
        cp   $34
        jr   nz, Addr_00e6

        ld   b, $19
        ld   a,b
Addr_00f4:
        add  a, [hl]
        inc  hl
        dec  b
        jr   nz, Addr_00f4
        add  a, [hl]
        nop       ; *DIFF* vs DMG bootrom: don't lockup if header checksum doesn't match
        nop

    ; $00FC Disable the boot rom and hand over control to the game cartridge
        ld   a, $01
        ldh  [$50], a
