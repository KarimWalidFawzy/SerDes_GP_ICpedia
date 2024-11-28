import enums::*;
interface piso_if (BitCLK);
    input BitCLK;
    bit Reset;
    bit Serial;
    bit [9:0] TxParallel_10;
endinterface