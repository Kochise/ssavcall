 RYES_PNO.S assembled in PC-relative mode

05A1E6 207A002E      MOVEA.L $5A216(PC),A0
05A1EA 2F3C0000002C  MOVE.L #$2C,-(A7)
05A1F0 207C0000002C  MOVEA.L #$2C,A0
05A1F6 2F3C00000034  MOVE.L #$34,-(A7)
05A1FC 227C00000034  MOVEA.L #$34,A1
05A202 487A000E      PEA $5A212(PC)
05A206 41FA000A      LEA $5A212(PC),A0
05A20A 487A000E      PEA $5A21A(PC)
05A20E 43FA000A      LEA $5A21A(PC),A1
05A212 00000001      ORI.B #1,D0
05A216 00000038      ORI.B #$38,D0
05A21A 542E5300      ADDQ.B #2,$5300(A6)
05A21E 4620          NOT.B -(A0)
05A220 5259          ADDQ.W #1,(A1)+
